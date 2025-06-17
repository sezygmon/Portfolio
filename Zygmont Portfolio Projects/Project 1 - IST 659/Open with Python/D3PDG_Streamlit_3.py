import pandas as pd
import pyodbc
import openai
import os
import streamlit as st
from dotenv import load_dotenv
import logging  # Make sure this line is added to import the logging module

# Load environment variables from .env file
load_dotenv()

# Setup logging
logging.basicConfig(level=logging.DEBUG)

# Securely load your API key
openai.api_key = os.getenv('OPENAI_API_KEY')

# CSS Styling

st.markdown("""
    <style>
        body { 
            background: linear-gradient(to right, #dae2f8, #d6a4a4); 
            font-family: 'Arial', sans-serif; 
        }
        .dataTables_wrapper {
            font-size: 0.85em;
        }
        .stImage {
            text-align: center;
            margin-top: 20px;
        }
    </style>
    """, unsafe_allow_html=True)

def connect_to_db():
    # Use the environment variable directly in the connection string with f-string formatting
    db_password = os.getenv('DB_PASSWORD')  # Correctly use the same key as defined in the .env file
    conn_str = f"""
        Driver={{ODBC Driver 18 for SQL Server}};
        Server=tcp:24.database.windows.net,1433;
        Database=First_DB;
        Uid=AT;
        Pwd={db_password};
        Encrypt=yes;
        TrustServerCertificate=no;
        ConnectionTimeout=30;
    """
    try:
        conn = pyodbc.connect(conn_str)
        logging.info("Database connection successful")
        return conn
    except Exception as e:
        logging.error("Error connecting to database", exc_info=True)
        st.error(f"Failed to establish database connection: {e}")
        return None

def create_prompt_from_tags(tags):
    """Generate a detailed prompt from tags using the OpenAI API."""
    try:
        response = openai.completions.create(
            model="gpt-3.5-turbo-instruct",  # Updated to the correct model
            prompt=f"Create a detailed and creative description for an image using these tags: {tags}.",
            max_tokens=150  # Adjusted max_tokens based on your needs
        )
        return response.choices[0].text.strip()
    except Exception as e:
        st.error(f"Failed to create prompt: {str(e)}")
        return None

def generate_image(prompt):
    """Generate an image using DALL-E from a prompt."""
    try:
        response = openai.Image.create(
            model="dall-e-2",  # Assuming DALL-E 2, update this if using a different version
            prompt=prompt,
            n=1,
            size="1024x1024"  # Ensure this aligns with available options for the model
        )
        image_url = response.data[0].url  # Adjust if necessary based on response structure
        return image_url
    except Exception as e:
        st.error(f"Failed to generate image: {str(e)}")
        return None




def generate_prompt_and_image(image_id, keywords):
    prompt = create_prompt_from_tags(keywords)
    if prompt:
        st.text(prompt)  # Display the generated prompt
        image_url = generate_image(prompt)
        if image_url:
            process_generated_image(image_url)

# Function to display and download the image
def process_generated_image(image_url):
    st.image(image_url, caption="Generated Image")



def load_images_and_generate():
    conn = connect_to_db()
    if conn is not None:
        try:
            query = """
            SELECT i.Image_ID, i.Image_Path, p.Prompt_ID, p.Prompt_Description, p.Prompt_Tags
            FROM Images i
            JOIN Prompts p ON i.Image_Prompt_ID = p.Prompt_ID
            """
            images_df = pd.read_sql(query, conn)
            # Create a dictionary for the sidebar selectbox outside the loop
            image_options = {f"ID {row['Image_ID']} - {row['Prompt_Description']}": row for index, row in images_df.iterrows()}
            selected_option = st.sidebar.selectbox("Select an Image", list(image_options.keys()))
            selected_row = image_options[selected_option]

            # Display the selected image details
            st.image(selected_row["Image_Path"], width=300, caption=f"Image ID: {selected_row['Image_ID']} - {selected_row['Description']}")
            
            # Additional functionalities for selected image
            display_average_score(selected_row['Image_ID'])
            display_comments(selected_row['Image_ID'])

            # Generating new prompt and image
            tags = selected_row['Prompt_Tags']
            generate_button = st.button("Generate Prompt and Image", key=f"generate{selected_row['Image_ID']}")
            if generate_button:
                prompt = create_prompt_from_tags(tags)
                if prompt:
                    st.text(prompt)  # Display the generated prompt
                    image_url = generate_image(prompt)
                    if image_url:
                        st.image(image_url, caption="Generated Image")
            
        finally:
            if conn:
                conn.close()


def display_average_score(image_id):
    conn = connect_to_db()
    if conn:
        try:
            score_query = f"SELECT AVG(Feedback_Score) AS AvgScore FROM User_Feedback WHERE Feedback_User_ID = {image_id}"
            score_result = pd.read_sql(score_query, conn)
            avg_score = score_result.iloc[0]['AvgScore']
            st.write(f"Average Score for Image {image_id}: {avg_score:.2f}")
        finally:
            conn.close()

def display_comments(image_id):
    conn = connect_to_db()
    if conn:
        try:
            comment_query = f"SELECT Feedback_Comment FROM User_Feedback WHERE Feedback_Image_ID = {image_id}"
            comments_result = pd.read_sql(comment_query, conn)
            st.write("Comments:")
            for index, row in comments_result.iterrows():
                st.text(row['Feedback_Comment'])
        finally:
            conn.close()

# Main app setup
st.title("DALL·E 3 Prompt Saver")
load_images_and_generate()
print("API Key:", os.getenv("OPENAI_API_KEY"))  # Debugging line to check API key loading
