-- DOWN Metadata
select * from User_Feedback if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where constraint_name = 'fk_Image_Prompt_ID')
    alter table Images drop constraint fk_Image_Prompt_ID
if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where constraint_name = 'fk_Prompt_Creator_User_ID')
    alter table Prompts drop constraint fk_Prompt_Creator_User_ID
if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where constraint_name = 'fk_Feedback_Image_ID')
    alter table User_Feedback drop constraint fk_Feedback_Image_ID
if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where constraint_name = 'fk_Feedback_User_ID')
    alter table User_Feedback drop constraint fk_Feedback_User_ID
drop table if exists Users
drop table if exists Prompts
drop table if exists Images
drop table if exists User_Feedback
GO

--UP Metadata
create table Users (
    User_ID int identity not null,
    Username varchar(50) not null,
    User_Firstname varchar(50) not null,
    User_Lastname varchar(50) not null,
    User_Email varchar(50) not null,
    User_Registration_Date date not null,
    constraint pk_User_ID primary key (User_ID),
    constraint u_User_Email unique (User_Email),
)
GO

create table Prompts (
    Prompt_ID int not null,
    Prompt_Category varchar(250) not null,
    Prompt_Description varchar(1000) not null,
    Prompt_Tags varchar(250) not null,
    Prompt_Creation_Date date not null,
    Prompt_Creator_User_ID int not null,
    constraint pk_Prompt_ID primary key (Prompt_ID),
    constraint fk_Prompt_Creator_User_ID foreign key (Prompt_Creator_User_ID)
        references Users(User_ID),
)
GO

create table Images (
    Image_ID int not null,
    Image_Prompt_ID int not null,
    Image_Path varchar(100) not null,
    constraint pk_Image_ID primary key (Image_ID),
    constraint fk_Image_Prompt_ID foreign key (Image_Prompt_ID)
        references Prompts(Prompt_ID)
)
    GO

create table User_Feedback (
    Feedback_ID int identity not null,
    Feedback_Image_ID int not null,
    Feedback_User_ID int not null,
    Feedback_Score float not null,
    Feedback_Comment varchar(100) not null,
    Feedback_Date date not null,
    constraint pk_Feedback_ID primary key (Feedback_ID),
    constraint fk_Feedback_Image_ID foreign key (Feedback_Image_ID)
        references Images(Image_ID),
    constraint fk_Feedback_User_ID foreign key (Feedback_User_ID)
        references Users(User_ID)
)
GO

--UP Data for Users
insert into Users
    (User_Firstname, User_Lastname, Username, User_Email, User_Registration_Date)
    VALUES
    ('Penny',	'Wise', 'PennyWiseGuy',	'PennyWise@yahoo.com',	'2024-01-12'),
    ('Barry',	'Cade',	'CadeCrusader',	'BarryCade@gmail.com',	'2024-02-23'),
    ('Anna',	'Conda',	'AnaCondaRules',	'Annaconda@hotmail.com',	'2024-03-08'),
    ('Polly',	'Mer',	'PollyMorphic',	'PollyMer@yahoo.com',	'2024-04-17'),
    ('Sandy',	'Beach',	'SandyShores',	'SandyBeach@gmail.com', '2024-05-01'),
    ('Phil', 	'Harmonic',	'PhilharmonicFunk',	'PhilHarmonic@hotmail.com',	'2024-01-19'),
    ('Will',	'Power',	'WillPowered',	'WillPower@yahoo.com',	'2024-02-03'),
    ('Barb',	'Dwyer',	'BarbWireQueen',	'BarbDwyer@gmail.com',	'2024-03-28'),
    ('Justin',	'Thyme',	'JustinTimeTraveler',	'JustinThyme@hotmail.com',	'2024-04-11'),
    ('Al',	'Dente',	'AlDenteDish',	'AlDente@yahoo.com',	'2024-05-15'),
    ('Carrie',	'Oakey',	'CarrieOKaraoke',	'CarrieOakey@gmail.com',	'2024-01-07'),
    ('Beau',	'Vine',	'BeauVineVintage',	'BeauVine@hotmail.com', '2024-02-29'),
    ('Rusty',	'Keys',	'RustyKeymaster',	'RustyKeys@yahoo.com',	'2024-03-20'),
    ('Holly',	'Wood',	'HollywoodDreamer',	'HollyWood@gmail.com',	'2024-04-09'),
    ('Tess',	'Laying',	'TessLayItDown',	'TessLaying@hotmail.com',	'2024-05-22'),
    ('Sam',	'Sung',	'SamSungHero',	'SamSung@yahoo.com',	'2023-01-02'),
    ('Paige',	'Turner',	'PageTurnerTales',	'PaigeTurner@gmail.com',	'2024-02-15'),
    ('Ella',	'Vator',	'ElevatorExpert',	'EllaVator@hotmail.com',	'2024-03-05'),
    ('Crystal',	'Clear',	'CrystalClearMind',	'CrystalClear@yahoo.com',	'2024-04-25'),
    ('Barbie',	'Que',	'BBQKingpin',	'BarbQ@gmail.com',	'2024-05-10'),
    ('Phil', 	'Upmore',	'PhilUpMorePlease',	'PhilUpmore@hotmail.com',	'2024-01-30'),
    ('Jack',	'Pott',	'JackpotWinner',	'JackPott@yahoo.com',	'2024-02-06'),
    ('Anita',	'Bath',	'AnitaBathBomb',	'AnitaBath@gmail.com', '2024-03-14'),
    ('Neil',	'Down',	'NeilDownToEarth',	'NeilDown@hotmail.com',	'2024-04-20'),
    ('Don',	'Keigh',	'DonKeyKong',	'DonKeigh@yahoo.com',	'2024-05-02'),
    ('Bill',	'Board',	'BillBoardBoss',	'BillBoard@gmail.com',	'2024-01-25'),
    ('Brooke',	'Lynn',	'BrookeLynnBridge',	'BrookeLynn@hotmail.com',	'2023-02-08'),
    ('Dee',	'Zaster',	'DeeZasterChef',	'DeeZaster@yahoo.com',	'2024-03-16'),
    ('Polly',	'Esther',	'PollyEstherical',	'PollyEsther@gmail.com',	'2024-04-02'),
    ('Bud',	'Wiser',	'BudWiserGuy',	'BudWiser@hotmail.com',	'2024-05-18'),
    ('Chris',	'Cross',	'ChrisCrossingLines',	'ChrisCross@yahoo.com',	'2024-01-14'),
    ('Ginger',	'Snap',	'GingerSnappingTurtle',	'GingerSnap@gmail.com', '2024-02-19'),
    ('Al',	'Bino',	'AlBinoBlues',	'AlBino@hotmail.com',	'2024-03-27'),
    ('Will',	'Beback',	'WillBebackLater',	'WillBeback@yahoo.com',	'2024-04-07'),
    ('Paige',	'Stroika',	'PageStroikaKeys',	'PaigeStroika@gmail.com',	'2024-05-12'),
    ('Candy',	'Kane',	'CandyKaneCraze',	'CandyKane@hotmail.com',	'2024-01-03'),
    ('Manny',	'Quin',	'MannyQuinMannequin',	'MannyQuin@yahoo.com',	'2024-02-17'),
    ('Dee',	'Lighted',	'DeeLightedDelight',	'DeeLighted@gmail.com',	'2024-03-22'),
    ('Rob', 	'Banks',	'RobTheBanker',	'RobBanks@hotmail.com',    '2024-04-30'),
    ('Gail',	'Force',	'GailForceWinds',	'GailForce@yahoo.com',	'2024-05-05')
    GO

select * from users

--UP data from Prompts
insert into Prompts
    (Prompt_ID, Prompt_Description, Prompt_Category, Prompt_Tags, Prompt_Creation_Date, Prompt_Creator_User_ID)
    VALUES
    (1,	'A professor dog is teaching a class on data and dog bones. The environment is a classroom. The professor dog is holding a laser pointer to point at his PowerPoint.',	'Cartoon Illustration',	'educational, animal teacher, classroom, presentation',		'3/7/2024',	1),
    (2,	'A T-Rex attends a dinosaur Data Science conference. The conference is well-lit with sun beaming out of the windows into the building. The T-Rex has a I love Data shirt on that is a bit too small and some cheap sunglasses on. The art style is Anime with bright contrasting colors.',	'Anime Illustration',	'dinosaur, conference, data science, bright colors',		'4/7/2024',	2),
    (3,	'Dogs surrounding a camp fire where one serious looking dog is telling a war story in a rain forest during a light drizzle. The other dogs have regular people clothes on while the dog telling the story has a soldier outfit on with a cigar in his mouth. The artistic style is cartoonish and has bright contrasting colors.', 	'Cartoon Illustration',	'animals, storytelling, campfire, rainforest',		'1/10/2024',	3),
    (4,	 'A teddy bear stares at his reflection in a puddle in a slightly muddy part of a forest. The teddy bear is holding an umbrella. The art style', 	'Whimsical Art',	'teddy bear, reflection, nature, puddle',		'2/27/2024',	4),
    (5,	'Wheres waldo becoming frantically becoming self-aware of that he is fictional character while staring at a Wheres Waldo book in shock in a coffee shop surrounded by Wheres Waldo books, coffee, and conspiracy cork board complete with red yarn lead one photo of waldo to another. The art style is pop art with bright colors.',	'Pop Art',	'metafiction, character realization, vibrant colors, coffee shop',		'1/22/2024',	5),
    (6,	'A time traveling velociraptor takes a selfie with a George Washington in front of the Delaware river in 1851. George Washington has a scared facial expression. The velociraptor is wearing a shirt saying "I survived time travel". The art style is oil-on-canvas paint. The colors are bright and contrasting and the mood is dark.', 'Oil Painting',	'time travel, historical, vibrant colors, dark mood',		'4/24/2024',	6),
    (7,	'Create a three-fourths angle close-up of a futuristic female character wearing a gas mask, styled as a self-portrait in a video game cover art format. The characters red hair is styled in a flowing ponytail, set against a backdrop of smoke and fire that suggests an apocalyptic scene. The art should incorporate elements of ink paint and watercolor techniques, emphasizing a moody, gothic, and somber aesthetic. The color palette should be dark, utilizing chiaroscuro to highlight the intense and dramatic atmosphere. The silhouette of the character should be prominent, enhancing the overall dark and mysterious mood of the image, without any white space around the character.',	'Video Game Art',	'apocalyptic, futuristic, intense, mixed media',		'3/27/2024',	7),
    (8,	'"A wide landscape-oriented image of a rising phoenix in a desert climate, portrayed with dark contrasting colors for a dramatic and intense effect, ideal for video game cover art. The phoenix is seen with ash falling off of it as it rises powerfully. The art should incorporate elements of ink paint and watercolor techniques, emphasizing a moody, gothic, and somber aesthetic. Add a slight vector graphic look to enhance the modern and stylized feel. Utilize chiaroscuro to enhance the dark and mysterious mood of the scene. The silhouette of the phoenix should be dominant, capturing the essence of rebirth and power.',	'Ink and Watercolor Art',	'mythical creature, rebirth, dramatic, gothic',		'2/25/2024',	8), 
    (9,	'A cartoon anthropomorphic mole, styled in traditional 2D 90s Anime, is intensely playing an arcade game. The mole strikes neon colored plastic human figures emerging from wooden holes on a horizontal arcade cabinet adorned with bright neon lights and buttons, using a comically large soft mallet. The mole wears a shirt with the phrase "I never pause...ever". The scene features bright, contrasting colors with a 90s anime aesthetic, emphasizing the playful and vibrant atmosphere. The mole has large expressive eyes and a cheeky expression, rendered in a flat, 2D style.',	'Anime Illustration',	'anthropomorphic, gaming, vibrant, playful',		'1/28/2024',	9),
    (10,	'A dog in a hoodie and beanie is practicing rapping in front of a dimly lit public bathroom mirror. The art style is vector-based, cartoonish', 	'Vector Art',	'musical, animal character, urban, stylized',		'1/1/2024',	10),
    (11,	'"Children playing among oversized, glowing mushrooms in a dense forest under starlit sky, influenced by Impressionist art, in a palette of deep blues and vibrant greens, using watercolor"',	'Fantasy Impression', 'Art	Impressionism,  Landscapes, Fantasy',		'2/9/2024',	11),
    (12,	'Orange Basketball falling down waterfall in foggy forest, naturalism using earthy tones and vibrant greens',	'Naturalistic Sports Art',	'Surrealism, Naturalism',		'4/16/2024',	12),
    (13,	'"New born pheasants frolicking on water amidst auspicious clouds looming over head, influenced by Salvador Dali, in a palette of vibrant blues, light greys, and light browns"',	'Impressionist Art',	'Surrealism, Avian, Dreamscape, Wildlife',		'2/28/2024',	13),
    (14,	'"Mystical dragon resting on a treasure hoard in a dark cavern illuminated by glowing crystals in a fantasy art style with a cool, dark color palette in digital painting medium."',	'Digital Art',	'Fantasy, Dark Fantasy',		'3/19/2024',	14),
    (15,	'"Serene, Majestic Mountain Peaks Glowing in Moonlight Snow-capped, Pine Trees Alpine Wilderness Impressionist Cool Tones: Blues, Greens, Purples Oil Painting"',	'Oil Painting',	'Mountain, Alpine Nocturne, oil painting',		'1/14/2024',	15),
    (16,	'"Futuristic, Sleek cityscape bustling with flying cars and neon signs, with towering skyscrapers, in a cyberpunk metropolis,influenced by Sci-Fi art, featuring a vibrant color palette of neon blues, pinks, and purples, rendered in digital art."',	'Cyberpunk Digital Art',	'Futuristic, Sci-Fi, CyberPunk',		'2/21/2024',	16),
    (17,	'"Timeless, Elegant Victorian ballroom with chandeliers and elegantly dressed dancers, with ornate decorations, in a historic mansion, inspired by Rococo, using a rich color palette of golds, creams, and burgundies, painted in watercolor."',	'Rococo Watercolor Art',	'Watercolor, Victorian, Rococo',		'2/12/2024',	17),
    (18,	'"Serene, Peaceful Japanese garden with koi ponds and stone lanterns, with cherry blossoms in full bloom, in a zen garden setting, influenced by Ukiyo-e, featuring a soft color palette of pinks, whites, and greens, created in ink and wash."',	'Ukiyo-e Ink and Wash',	'Ukiyo, Japanese Garden, Serene, Peaceful',		'3/26/2024',	18),
    (19,	'"Bold, Dynamic city skyline during a thunderstorm, with lightning striking and rain pouring, in an urban setting, influenced by Expressionism,featuring a dramatic color palette of dark blues, blacks, and flashes of white, created in oil pastel."',	'Oil Pastel Expressionism',	'Stormscapes, Urban, Cityscapes, Dramatic',		'2/9/2024',	19),
    (20,	'Realistic Chimpanzee squatting barbell with 4 plates at Planet fitness, photorealistic, purples, yellows,light brown and black',	'Realistic Animal Art',	'Photorealistic, Surreal, Animal, Human-Like',		'3/19/2024',	20),
    (21,	'A young woman with a determined expression, working at a cluttered desk filled with maps, sketches, and technology. She is wearing a tactical vest and has a robotic arm on her desk. The room is filled with screens and pictures of fantasy landscapes, giving it a strategic planning or game development vibe.',	'Fantasy Art, Game Development, Strategic Planning',	'woman, tactical vest, robotic arm, maps, sketches, technology, fantasy landscapes, strategic planning, game development, determined expression',		'3/20/2024',	21),
    (22,	'A lively street scene featuring a joyful dog leaping through the air next to a flying owl. The backdrop includes multiple stop signs, utility poles, and a neighborhood setting with houses and cars. Birds are flying in the sky, and the overall atmosphere is energetic and whimsical."',	'Animal Photography, Whimsical Art, Urban Scene',	'dog, owl, flying, leaping, stop signs, street, neighborhood, houses, cars, birds, energetic, whimsical, urban scene',		'3/21/2024',	22),
    (23,	'red semi-truck crashing through the large doors of an industrial warehouse. Debris and bricks scatter around as the truck breaks through. The setting is an urban industrial area with brick buildings, crates, barrels, and other warehouse elements. The scene conveys a sense of urgency and action.',	'Industrial Scene, Action Photography, Urban Environment',	'semi-truck, crash, industrial warehouse, debris, bricks, urban, industrial, action, brick building, crates, barrels, dramatic',		'3/22/2024',	23),
    (24,	'An intense moment during a baseball game, capturing the action at home plate. A young player in a white uniform with the number 18 is about to hit the ball, while an adult player swings at the same time. Another player in a blue uniform is also in action, and the crowd in the stadium is watching intently. The scene is vibrant and full of motion, set in a classic baseball stadium.',	'Sports Photography, Action Scene, Baseball',	'baseball, game, action, home plate, young player, adult player, white uniform, blue uniform, stadium, crowd, intense moment, sports',		'3/23/2024',	24),
    (25,	'A captivating underwater scene featuring a man diving into the ocean, viewed from below. Sunlight beams through the waters surface, illuminating the vibrant marine life and coral formations. The divers arms are outstretched as he swims downward, creating a sense of freedom and exploration in this serene underwater environment.',	'Underwater Photography, Nature, Adventure',	'underwater, diving, ocean, marine life, coral, sunlight, exploration, freedom, serene, nature, adventure, swimmer',		'3/24/2024',	25),
    (26,	'A dramatic post-apocalyptic scene where a man with a backpack and two dogs walks down a street amidst the destruction. Buildings are in ruins, and a massive explosion with dark smoke and fire dominates the background. The street is littered with debris, wrecked cars, and a police vehicle, creating an intense and chaotic atmosphere.',	'Post-Apocalyptic Art, Action Scene, Urban Destruction',	'post-apocalyptic, explosion, fire, ruins, man, dogs, backpack, destruction, debris, wrecked cars, urban, chaotic, intense, police vehicle',		'3/25/2024',	26),
    (27,	'A dramatic maritime scene featuring a massive ocean liner navigating through rough seas. A smaller vessel is nearby, with a person on a lifeboat struggling against the powerful waves. The ocean liner has intricate details, and the scene is set against a backdrop of turbulent waters and stormy skies, creating a sense of adventure and peril.',	'Maritime Art, Adventure Scene, Action Photography',	'ocean liner, rough seas, waves, lifeboat, maritime, stormy skies, adventure, peril, ship, ocean, dramatic, action',		'3/26/2024',	27),
    (28, 	'An intense action scene featuring a muscular man in the ocean confronting two enormous great white sharks. The man appears to be ready to fight, while the sharks leap out of the water with jaws wide open. The backdrop includes a ship and more sharks swimming in the distance, set against a cloudy sky, creating a dramatic and dangerous atmosphere.',	'Action Art, Adventure Scene, Wildlife',	'great white sharks, man, ocean, fight, action, adventure, ship, dramatic, dangerous, wildlife, muscular, leaping sharks, cloudy sky',		'3/27/2024',	28),
    (29,	'A serene and picturesque garden scene featuring a young woman in a vintage dress adorned with floral patterns. She has intricate roses woven into her hair and stands among blooming rose bushes and manicured hedges. The garden is lush and well-maintained, with an elegant stone archway in the background, creating a timeless and romantic atmosphere.',	'Portrait Art, Garden Scene, Vintage Fashion',	'woman, vintage dress, floral patterns, roses, garden, rose bushes, hedges, stone archway, romantic, serene, picturesque, intricate hairstyle',		'3/28/2024',	29),
    (30,	'A bustling urban highway scene with heavy traffic. Multiple lanes are filled with a variety of vehicles, including cars, trucks, and buses. The cityscape in the background is filled with tall buildings and advertisements. The overall atmosphere is busy and dynamic, depicting the typical rush hour congestion in a modern city.',	'Urban Photography, Traffic, Cityscape',	'traffic, highway, cars, trucks, buses, urban, cityscape, rush hour, congestion, busy, dynamic, modern city, buildings, advertisements',		'3/29/2024',	30),
    (31,	'artistic animals dancing in flower field with pink and blue pastel colors',	'Modern Painting',	'artistic, animals, dancing, flower field, pink, blue, pastel colors',		'3/28/2024',	31),
    (32,	'blonde haired female with blue eyes typing on a computer in a blue  classroom with classmates',	'Modern Painting',	'blonde haired female, blue eyes, typing, computer, classroom, classmates',		'3/29/2024',	32),
    (33,	 'two friendly dogs with blue and green leashes on a walk in a city near a coffee shop with their blonde haired owner wearing a baseball cap',	'Modern Painting',	'friendly dogs, blue leash, green leash, walk, city, coffee shop, blonde owner, baseball cap',		'3/30/2024',	33),
    (34,	 'football fans in a blue and red football stadium with snow-covered mountains in Switzerland in the background',	'Modern Painting',	'football fans, blue, red, football stadium, snow-covered mountains, Switzerland',		'3/31/2024',	34),
    (35,	 'family of four people at a dinner table at the top of the Eiffel Tower in Paris at nighttime with beautiful sky full of stars',	'Modern Painting',	'family, dinner table, Eiffel Tower, Paris, nighttime, stars',		'4/1/2024',	35),
    (36,	 'ocean scene during the daytime with dolphins and whales jumping out of the water during a rain storm',	'Modern Painting',	'ocean, daytime, dolphins, whales, jumping, rain storm',		'4/2/2024',	36),
    (37,	 'race car driver in a red and black car set in the atmosphere with super heroes in capes flying around',	'Modern Painting',	'race car driver, red, black car, superheroes, capes, flying, atmosphere',		'4/3/2024',	37),
    (38,	 'blue coffee shop with three baristas making multicolor drinks and cases of colorful pastries with customers at tables reading books',	'Modern Painting',	'blue coffee shop, baristas, multicolor drinks, pastries, customers, books',		'4/4/2024',	38),
    (39,	 'whimsical library with many books and students doing work at long wooden tables with green lamps', 	'Modern Painting',	'whimsical library, books, students, wooden tables, green lamps',		'4/5/2024',	39),
    (40,	 'tennis match on the moon with a green tennis court and women with pink and blue rackets and space suits',	'Modern Painting',	'tennis match, moon, green court, women, pink, blue rackets, space suits',		'4/6/2024',	40)
GO

select * from Prompts

--UP data for Images
insert into Images
    (Image_ID, Image_Prompt_ID, Image_Path)
    VALUES
    (1,	1,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_1.jpg'),
    (2,	2,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_2.jpg'),
    (3,	3,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_3.jpg'),
    (4,	4,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_4.jpg'),
    (5,	5,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_5.jpg'),
    (6,	6,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_6.jpg'),
    (7,	7,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_7.jpg'),
    (8,	8,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_8.jpg'),
    (9,	9,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_9.jpg'),
    (10,	10,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_10.jpg'),
    (11,	11,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_11.jpg'),
    (12,	12,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_12.jpg'),
    (13,	13,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_13.jpg'),
    (14,	14,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_14.jpg'),
    (15,	15,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_15.jpg'),
    (16,	16,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_16.jpg'),
    (17,	17,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_17.jpg'),
    (18,	18,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_18.jpg'),
    (19,	19,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_19.jpg'),
    (20,	20,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_20.jpg'),
    (21,	21,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_21.png'),
    (22,	22,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_22.png'),
    (23,	23,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_23.png'),
    (24,	24,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_24.png'),
    (25,	25,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_25.png'),
    (26,	26,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_26.png'),
    (27,	27,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_27.png'),
    (28,	28,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_28.png'),
    (29,	29,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_29.png'),
    (30,	30,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_30.png'),
    (31,	31,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_31.jpeg'),
    (32,	32,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_32.jpeg'),
    (33,	33,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_33.jpeg'),
    (34,	34,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_34.jpeg'),
    (35,	35,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_35.jpeg'),
    (36,	36,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_36.jpeg'),
    (37,	37,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_37.jpeg'),
    (38,	38,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_38.jpeg'),
    (39,	39,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_39.jpeg'),
    (40,	40,	'https://dalle3storage.blob.core.windows.net/2244/Prompt_ID_40.jpeg')
GO

--UP data for User_Feedback
insert into User_Feedback
    (Feedback_Image_ID, Feedback_User_ID, Feedback_Score, Feedback_Comment, Feedback_Date)
    VALUES
    (1, 1, '5', 'What a mesmerizing view!', '2024-06-02'),
    (2, 2, '8', 'This picture speaks volumes.', '2024-06-02'),
    (3, 3, '7.5', 'Absolutely breathtaking!', '2024-06-02'),
    (4, 4,  '9', 'Love the composition in this shot.', '2024-06-02'),
    (5, 5,  '7', 'Such a unique perspective, I love it!', '2024-06-02'),
    (6, 6, '5.9', 'This deserves to be framed.', '2024-06-02'),
    (7, 7, '9.2', 'The colors in this are so vibrant!', '2024-06-02'),
    (8, 8, '8.7', 'A picture-perfect moment captured.', '2024-06-02'),
    (9, 9, '4.7', 'I am in awe of this beauty.', '2024-06-02'),
    (10, 10, '8.8', 'The details in this are incredible.', '2024-06-02'),
    (12, 11, '9.2', 'So much emotion captured here.', '2024-06-02'),
    (11, 12, '9.9', 'This looks straight out of a fairy tale.', '2024-06-02'),
    (13, 13, '8.1', 'You have a great eye for photography!', '2024-06-02'),
    (14, 14, '6.7', 'This evokes a sense of serenity.', '2024-06-02'),
    (15, 15, '4.8', 'I could get lost in this scenery.', '2024-06-02'),
    (16, 16,  '9.3', 'This makes me want to explore.', '2024-06-02'),
    (17, 17, '8.4', 'Absolutely stunning!', '2024-06-02'),
    (18, 18, '5.8', 'The lighting is just perfect.', '2024-06-02'),
    (19, 19, '7.9', 'What a magical shot!', '2024-06-02'),
    (20, 20, '9.5', 'Love the mood in this.', '2024-06-02'),
    (21, 21, '8.9', 'This is art in its purest form.', '2024-06-02'),
    (22, 22, '9.6', 'So much character in this photo.', '2024-06-02'),
    (23, 23, '7.9', 'A moment frozen in time.', '2024-06-02'),
    (24, 24, '8', 'This deserves all the praise.', '2024-06-02'),
    (25, 25, '7.3', 'Natures beauty at its finest.', '2024-06-02'),
    (26, 26, '8.9', 'The simplicity of this is captivating.', '2024-06-02'),
    (27, 27, '9.3', 'This is why I love photography.', '2024-06-02'),
    (28, 28, '8.4', 'Great job capturing the essence.', '2024-06-02'),
    (29, 29, '6.8', 'I am lost for words, this is amazing.', '2024-06-02'),
    (30, 30, '7.7', 'This draws me in instantly.', '2024-06-02'),
    (31, 31, '9.9', 'A true masterpiece.', '2024-06-02'),
    (32, 32, '8.7', 'This feels like a dream.', '2024-06-02'),
    (33, 33, '7.4', 'Stunning composition!', '2024-06-02'),
    (34, 34, '9.1', 'The world needs to see this.', '2024-06-02'),
    (35, 35, '8.4', 'I feel inspired by this photo.', '2024-06-02'),
    (36, 36, '7.9', 'This speaks to my soul.', '2024-06-02'),
    (37, 37, '6.8', 'What a wonderful shot!', '2024-06-02'),
    (38, 38, '7.9', 'Pure perfection.', '2024-06-02'),
    (39, 39, '9.2', 'I could stare at this forever.', '2024-06-02'),
    (40, 40, '8.8', 'Thank you for sharing this beauty.', '2024-06-02')
    GO
