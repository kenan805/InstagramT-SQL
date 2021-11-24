CREATE DATABASE InstagramDB
GO
USE [InstagramDB]
GO
/****** Object:  UserDefinedFunction [dbo].[CommentsCountPostsForId]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CommentsCountPostsForId](@postid int)
RETURNS int
AS
BEGIN
	DECLARE @totalcomm int;
	SELECT @totalcomm = Total_comments FROM Posts
	WHERE Id = @postid
	RETURN @totalcomm
END
GO
/****** Object:  Table [dbo].[Users]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[DateRegistered] [datetime] NOT NULL,
	[IsOnline] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfiles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](30) NULL,
	[BirthDate] [datetime] NOT NULL,
	[PhoneNumber] [nvarchar](30) NOT NULL,
	[UserId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GenderMaleUsers]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenderMaleUsers]()
RETURNS TABLE
RETURN
SELECT Users.* FROM Users INNER JOIN UserProfiles ON UserProfiles.UserId = Users.Id
WHERE UserProfiles.Gender = 'Male' 
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CommentText] [text] NOT NULL,
	[DateCommented] [datetime] NOT NULL,
	[CommentedBy] [bigint] NOT NULL,
	[PostId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Followers]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Followers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CanFollow] [bit] NULL,
	[DateFollowed] [datetime] NOT NULL,
	[FollowedBy] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateLiked] [datetime] NOT NULL,
	[LikedBy] [bigint] NOT NULL,
	[PostId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MessageText] [text] NOT NULL,
	[IsRead] [bit] NULL,
	[DateMessaged] [datetime] NOT NULL,
	[MessagedBy] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostCategories]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostCategories](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PostId] [bigint] NOT NULL,
	[CategoryId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Content] [text] NULL,
	[DatePosted] [datetime] NOT NULL,
	[Total_likes] [bigint] NULL,
	[Total_comments] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'Advertising / Marketing')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'Album')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (3, N'Amateur Sports Team')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (4, N'Apartment & Condo Building')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (5, N'Appliance Repair Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (6, N'App Page')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (7, N'Architectural Designer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (8, N'Art')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (9, N'Artist')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (10, N'Arts & Entertainment')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (11, N'Athlete')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (12, N'Automotive Repair Shop')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (13, N'Baby & Children’s Clothing Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (14, N'Baby Goods / Kids Goods')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (15, N'Bar')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (16, N'Beauty, Cosmetic & Personal Care')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (17, N'Beauty Salon')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (18, N'Book')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (19, N'Business Center')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (20, N'Business Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (21, N'Camera / Photo')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (22, N'Canoe & Kayak Rental')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (23, N'Chicken Joint')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (24, N'Church of Christ')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (25, N'Church of Jesus Christ of Latter-day Saints')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (26, N'Clothing(Brand)')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (27, N'Clothing Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (28, N'College & University')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (29, N'Commercial & Industrial')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (30, N'Commercial & Industrial Equipment Supplier')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (31, N'Commercial Bank')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (32, N'Commercial Equipment')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (33, N'Commercial Real Estate Agency')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (34, N'Commercial Truck Dealership')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (35, N'Community')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (36, N'Community Organization')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (37, N'Consulting Agency')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (38, N'Contractor')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (39, N'Convenience Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (40, N'Credit Union')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (41, N'Doctor')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (42, N'Deli')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (43, N'Dancer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (44, N'Design & Fashion')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (45, N'Dessert Shop')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (46, N'Discount Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (47, N'Dorm')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (48, N'E - Cigarette Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (49, N'E - commerce Website')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (50, N'Education')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (51, N'Engineering Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (52, N'Entertainment Website')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (53, N'Entrepreneur')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (54, N'Episode')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (55, N'Event')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (56, N'Family Style Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (57, N'Fashion Designer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (58, N'Fashion Model')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (59, N'Fast Food Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (60, N'Financial Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (61, N'Food & Beverage')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (62, N'Food Stand')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (63, N'Footwear Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (64, N'Gamer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (65, N'Games / Toys')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (66, N'Gaming Video Creator')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (67, N'Government Organization')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (68, N'Graphic Designer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (69, N'Grocery Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (70, N'Hardware Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (71, N'Health / Beauty')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (72, N'Heating, Ventilating & Air Conditioning Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (73, N'Home Decor')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (74, N'Home Improvement')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (75, N'Hospital')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (76, N'Hotel')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (77, N'Hotel & Lodging')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (78, N'Ice Cream Shop')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (79, N'In - Home Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (80, N'Industrial Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (81, N'Information Technology Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (82, N'Insurance Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (83, N'Interior Design Studio')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (84, N'Internet Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (85, N'Internet Marketing Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (86, N'Japanese Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (87, N'Jazz & Blues Club')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (88, N'Jewelry / Watches')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (89, N'Jewelry & Watches Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (90, N'Journalist')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (91, N'Just For Fun')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (92, N'Karaoke')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (93, N'Kennel')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (94, N'Kitchen & Bath Contractor')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (95, N'Kitchen / Cooking')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (96, N'Korean Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (97, N'Landmark & Historical Place')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (98, N'Lawyer & Law Firm')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (99, N'Library')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (100, N'Loan Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (101, N'Local Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (102, N'Lumber Yard')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (103, N'Marketing Agency')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (104, N'Media')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (105, N'Media / News Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (106, N'Medical Center')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (107, N'Medical School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (108, N'Men’s Clothing Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (109, N'Mental Health Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (110, N'Movie')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (111, N'Musician / Band')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (112, N'Music Lessons &Instruction School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (113, N'Music Video')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (114, N'News & Media Website')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (115, N'Newspaper')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (116, N'Nonprofit Organization')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (117, N'Non - Governmental Organization(NGO)')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (118, N'Not a Business')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (119, N'Nursing Agency')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (120, N'Obstetrician - Gynecologist(OBGYN)')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (121, N'Office Equipment Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (122, N'Office Supplies')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (123, N'Optician')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (124, N'Optometrist')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (125, N'Outdoor & Sporting Goods Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (126, N'Personal Blog')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (127, N'Petting Zoo')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (128, N'Photographer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (129, N'Product / Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (130, N'Public & Government Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (131, N'Public Figure')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (132, N'Public Utility Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (133, N'Quay')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (134, N'Real Estate')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (135, N'Real Estate Agent')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (136, N'Real Estate Appraiser')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (137, N'Real Estate Company')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (138, N'Real Estate Developer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (139, N'Record Label')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (140, N'Religious Center')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (141, N'Religious Organization')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (142, N'Residence')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (143, N'Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (144, N'Retail Bank')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (145, N'School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (146, N'Science, Technology & Engineering')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (147, N'Shopping & Retail')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (148, N'Shopping District')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (149, N'Shopping Mall')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (150, N'Smoothie & Juice Bar')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (151, N'Song')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (152, N'Specialty School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (153, N'Sports & Recreation')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (154, N'Sports League')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (155, N'Sports Team')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (156, N'Teens & Kids Website')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (157, N'Telemarketing Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (158, N'Tire Dealer & Repair Shop')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (159, N'Trade School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (160, N'Traffic School')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (161, N'Train Station')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (162, N'Tutor / Teacher')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (163, N'TV Channel')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (164, N'TV Network')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (165, N'TV Show')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (166, N'Udon Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (167, N'Ukranian Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (168, N'Unagi Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (169, N'Uniform Supplier')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (170, N'Urban Farm')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (171, N'Vacation Home Rental')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (172, N'Veterinarian')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (173, N'Video Creator')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (174, N'Video Game')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (175, N'Visual Arts')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (176, N'Web Designer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (177, N'Website')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (178, N'Wedding Planning Service')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (179, N'Winery / Vineyard')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (180, N'Women’s Clothing Store')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (181, N'Women’s Health Clinic')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (182, N'Writer')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (183, N'Xinjiang Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (184, N'Yakiniku Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (185, N'Yakitori Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (186, N'Yoga Studio')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (187, N'Yoshoku Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (188, N'Youth Organization')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (189, N'Zhejiang Restaurant')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (190, N'Zoo')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (1, N'cubilia Curae Phasellus ornare. Fusce mollis. Duis', CAST(N'2017-10-20T00:00:00.000' AS DateTime), 5, 6)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (2, N'Nulla aliquet. Proin velit.', CAST(N'2019-08-25T00:00:00.000' AS DateTime), 5, 18)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (3, N'mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.', CAST(N'2018-09-12T00:00:00.000' AS DateTime), 4, 27)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (4, N'Fusce aliquam, enim nec tempus scelerisque, lorem ipsum', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 5, 5)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (5, N'ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel', CAST(N'2018-05-12T00:00:00.000' AS DateTime), 6, 25)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (6, N'nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.', CAST(N'2019-04-16T00:00:00.000' AS DateTime), 6, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (7, N'Curae Phasellus ornare. Fusce mollis. Duis sit amet diam', CAST(N'2019-06-03T00:00:00.000' AS DateTime), 4, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (8, N'bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec', CAST(N'2021-06-19T00:00:00.000' AS DateTime), 5, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (9, N'dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit', CAST(N'2019-10-01T00:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (10, N'tincidunt tempus risus. Donec egestas.', CAST(N'2019-04-03T00:00:00.000' AS DateTime), 7, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (11, N'cubilia Curae Phasellus ornare. Fusce mollis. Duis', CAST(N'2017-10-20T00:00:00.000' AS DateTime), 5, 6)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (12, N'Nulla aliquet. Proin velit.', CAST(N'2019-08-25T00:00:00.000' AS DateTime), 5, 18)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (13, N'mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.', CAST(N'2018-09-12T00:00:00.000' AS DateTime), 4, 27)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (14, N'Fusce aliquam, enim nec tempus scelerisque, lorem ipsum', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 5, 5)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (15, N'ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel', CAST(N'2018-05-12T00:00:00.000' AS DateTime), 6, 25)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (16, N'nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.', CAST(N'2019-04-16T00:00:00.000' AS DateTime), 6, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (17, N'Curae Phasellus ornare. Fusce mollis. Duis sit amet diam', CAST(N'2019-06-03T00:00:00.000' AS DateTime), 4, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (18, N'bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec', CAST(N'2021-06-19T00:00:00.000' AS DateTime), 5, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (19, N'dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit', CAST(N'2019-10-01T00:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (20, N'tincidunt tempus risus. Donec egestas.', CAST(N'2019-04-03T00:00:00.000' AS DateTime), 7, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (21, N'cubilia Curae Phasellus ornare. Fusce mollis. Duis', CAST(N'2017-10-20T00:00:00.000' AS DateTime), 5, 6)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (22, N'Nulla aliquet. Proin velit.', CAST(N'2019-08-25T00:00:00.000' AS DateTime), 5, 18)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (23, N'mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.', CAST(N'2018-09-12T00:00:00.000' AS DateTime), 4, 27)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (24, N'Fusce aliquam, enim nec tempus scelerisque, lorem ipsum', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 5, 5)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (25, N'ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel', CAST(N'2018-05-12T00:00:00.000' AS DateTime), 6, 25)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (26, N'nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.', CAST(N'2019-04-16T00:00:00.000' AS DateTime), 6, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (27, N'Curae Phasellus ornare. Fusce mollis. Duis sit amet diam', CAST(N'2019-06-03T00:00:00.000' AS DateTime), 4, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (28, N'bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec', CAST(N'2021-06-19T00:00:00.000' AS DateTime), 5, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (29, N'dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit', CAST(N'2019-10-01T00:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (30, N'tincidunt tempus risus. Donec egestas.', CAST(N'2019-04-03T00:00:00.000' AS DateTime), 7, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (31, N'cubilia Curae Phasellus ornare. Fusce mollis. Duis', CAST(N'2017-10-20T00:00:00.000' AS DateTime), 5, 6)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (32, N'Nulla aliquet. Proin velit.', CAST(N'2019-08-25T00:00:00.000' AS DateTime), 5, 18)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (33, N'mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.', CAST(N'2018-09-12T00:00:00.000' AS DateTime), 4, 27)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (34, N'Fusce aliquam, enim nec tempus scelerisque, lorem ipsum', CAST(N'2019-05-01T00:00:00.000' AS DateTime), 5, 5)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (35, N'ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel', CAST(N'2018-05-12T00:00:00.000' AS DateTime), 6, 25)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (36, N'nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.', CAST(N'2019-04-16T00:00:00.000' AS DateTime), 6, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (37, N'Curae Phasellus ornare. Fusce mollis. Duis sit amet diam', CAST(N'2019-06-03T00:00:00.000' AS DateTime), 4, 8)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (38, N'bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec', CAST(N'2021-06-19T00:00:00.000' AS DateTime), 5, 26)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (39, N'dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit', CAST(N'2019-10-01T00:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Comments] ([Id], [CommentText], [DateCommented], [CommentedBy], [PostId]) VALUES (40, N'tincidunt tempus risus. Donec egestas.', CAST(N'2019-04-03T00:00:00.000' AS DateTime), 7, 8)
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[Followers] ON 

INSERT [dbo].[Followers] ([Id], [CanFollow], [DateFollowed], [FollowedBy], [UserId]) VALUES (1, 1, CAST(N'2015-12-09T00:00:00.000' AS DateTime), 4, 1)
INSERT [dbo].[Followers] ([Id], [CanFollow], [DateFollowed], [FollowedBy], [UserId]) VALUES (2, 0, CAST(N'2018-11-21T00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[Followers] ([Id], [CanFollow], [DateFollowed], [FollowedBy], [UserId]) VALUES (3, 1, CAST(N'2020-09-19T00:00:00.000' AS DateTime), 6, 1)
INSERT [dbo].[Followers] ([Id], [CanFollow], [DateFollowed], [FollowedBy], [UserId]) VALUES (4, 0, CAST(N'2021-07-12T00:00:00.000' AS DateTime), 7, 3)
INSERT [dbo].[Followers] ([Id], [CanFollow], [DateFollowed], [FollowedBy], [UserId]) VALUES (5, 1, CAST(N'2019-04-15T00:00:00.000' AS DateTime), 5, 4)
SET IDENTITY_INSERT [dbo].[Followers] OFF
GO
SET IDENTITY_INSERT [dbo].[Likes] ON 

INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (1, CAST(N'2020-08-29T00:00:00.000' AS DateTime), 8, 2)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (2, CAST(N'2020-10-30T00:00:00.000' AS DateTime), 3, 1)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (3, CAST(N'2020-08-07T00:00:00.000' AS DateTime), 2, 17)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (4, CAST(N'2019-03-27T00:00:00.000' AS DateTime), 5, 25)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (5, CAST(N'2021-07-23T00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (6, CAST(N'2019-03-25T00:00:00.000' AS DateTime), 6, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (7, CAST(N'2018-07-31T00:00:00.000' AS DateTime), 7, 19)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (8, CAST(N'2019-01-08T00:00:00.000' AS DateTime), 3, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (9, CAST(N'2018-07-20T00:00:00.000' AS DateTime), 4, 15)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (10, CAST(N'2020-12-24T00:00:00.000' AS DateTime), 6, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (11, CAST(N'2018-03-25T00:00:00.000' AS DateTime), 3, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (12, CAST(N'2021-03-15T00:00:00.000' AS DateTime), 3, 9)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (13, CAST(N'2021-05-13T00:00:00.000' AS DateTime), 4, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (14, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 3, 13)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (15, CAST(N'2020-10-02T00:00:00.000' AS DateTime), 7, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (16, CAST(N'2017-12-24T00:00:00.000' AS DateTime), 6, 8)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (17, CAST(N'2021-10-12T00:00:00.000' AS DateTime), 2, 3)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (18, CAST(N'2020-01-31T00:00:00.000' AS DateTime), 6, 9)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (19, CAST(N'2021-07-26T00:00:00.000' AS DateTime), 3, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (20, CAST(N'2019-12-21T00:00:00.000' AS DateTime), 5, 3)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (21, CAST(N'2020-08-07T00:00:00.000' AS DateTime), 3, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (22, CAST(N'2018-11-23T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (23, CAST(N'2018-10-07T00:00:00.000' AS DateTime), 6, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (24, CAST(N'2018-06-03T00:00:00.000' AS DateTime), 4, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (25, CAST(N'2018-08-09T00:00:00.000' AS DateTime), 4, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (26, CAST(N'2021-02-23T00:00:00.000' AS DateTime), 5, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (27, CAST(N'2019-03-24T00:00:00.000' AS DateTime), 3, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (28, CAST(N'2020-08-06T00:00:00.000' AS DateTime), 8, 10)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (29, CAST(N'2018-12-02T00:00:00.000' AS DateTime), 3, 4)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (30, CAST(N'2020-08-08T00:00:00.000' AS DateTime), 1, 21)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (31, CAST(N'2018-10-01T00:00:00.000' AS DateTime), 4, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (32, CAST(N'2020-02-06T00:00:00.000' AS DateTime), 8, 4)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (33, CAST(N'2020-06-26T00:00:00.000' AS DateTime), 2, 4)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (34, CAST(N'2021-02-21T00:00:00.000' AS DateTime), 5, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (35, CAST(N'2019-05-20T00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (36, CAST(N'2019-12-13T00:00:00.000' AS DateTime), 8, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (37, CAST(N'2019-03-10T00:00:00.000' AS DateTime), 6, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (38, CAST(N'2021-02-15T00:00:00.000' AS DateTime), 6, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (39, CAST(N'2021-08-23T00:00:00.000' AS DateTime), 5, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (40, CAST(N'2020-02-27T00:00:00.000' AS DateTime), 7, 9)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (41, CAST(N'2018-05-14T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (42, CAST(N'2018-06-03T00:00:00.000' AS DateTime), 4, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (43, CAST(N'2020-10-05T00:00:00.000' AS DateTime), 5, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (44, CAST(N'2021-11-05T00:00:00.000' AS DateTime), 2, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (45, CAST(N'2021-07-16T00:00:00.000' AS DateTime), 2, 17)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (46, CAST(N'2021-07-16T00:00:00.000' AS DateTime), 6, 19)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (47, CAST(N'2020-12-16T00:00:00.000' AS DateTime), 3, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (48, CAST(N'2018-06-16T00:00:00.000' AS DateTime), 6, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (49, CAST(N'2019-03-23T00:00:00.000' AS DateTime), 5, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (50, CAST(N'2019-06-21T00:00:00.000' AS DateTime), 4, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (51, CAST(N'2019-08-28T00:00:00.000' AS DateTime), 7, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (52, CAST(N'2020-09-01T00:00:00.000' AS DateTime), 4, 19)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (53, CAST(N'2020-02-23T00:00:00.000' AS DateTime), 2, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (54, CAST(N'2020-05-18T00:00:00.000' AS DateTime), 5, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (55, CAST(N'2018-03-01T00:00:00.000' AS DateTime), 7, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (56, CAST(N'2019-09-15T00:00:00.000' AS DateTime), 5, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (57, CAST(N'2019-03-30T00:00:00.000' AS DateTime), 6, 21)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (58, CAST(N'2020-04-01T00:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (59, CAST(N'2021-03-20T00:00:00.000' AS DateTime), 2, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (60, CAST(N'2019-09-10T00:00:00.000' AS DateTime), 2, 2)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (61, CAST(N'2018-05-14T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (62, CAST(N'2018-06-03T00:00:00.000' AS DateTime), 4, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (63, CAST(N'2020-10-05T00:00:00.000' AS DateTime), 5, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (64, CAST(N'2021-11-05T00:00:00.000' AS DateTime), 2, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (65, CAST(N'2021-07-16T00:00:00.000' AS DateTime), 2, 17)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (66, CAST(N'2021-07-16T00:00:00.000' AS DateTime), 6, 19)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (67, CAST(N'2020-12-16T00:00:00.000' AS DateTime), 3, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (68, CAST(N'2018-06-16T00:00:00.000' AS DateTime), 6, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (69, CAST(N'2019-03-23T00:00:00.000' AS DateTime), 5, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (70, CAST(N'2019-06-21T00:00:00.000' AS DateTime), 4, 26)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (71, CAST(N'2019-08-28T00:00:00.000' AS DateTime), 7, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (72, CAST(N'2020-09-01T00:00:00.000' AS DateTime), 4, 19)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (73, CAST(N'2020-02-23T00:00:00.000' AS DateTime), 2, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (74, CAST(N'2020-05-18T00:00:00.000' AS DateTime), 5, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (75, CAST(N'2018-03-01T00:00:00.000' AS DateTime), 7, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (76, CAST(N'2019-09-15T00:00:00.000' AS DateTime), 5, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (77, CAST(N'2019-03-30T00:00:00.000' AS DateTime), 6, 21)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (78, CAST(N'2020-04-01T00:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (79, CAST(N'2021-03-20T00:00:00.000' AS DateTime), 2, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (80, CAST(N'2019-09-10T00:00:00.000' AS DateTime), 2, 2)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (81, CAST(N'2019-05-23T00:00:00.000' AS DateTime), 6, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (82, CAST(N'2018-07-04T00:00:00.000' AS DateTime), 1, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (83, CAST(N'2020-07-27T00:00:00.000' AS DateTime), 2, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (84, CAST(N'2019-12-15T00:00:00.000' AS DateTime), 8, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (85, CAST(N'2020-03-29T00:00:00.000' AS DateTime), 8, 3)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (86, CAST(N'2019-01-18T00:00:00.000' AS DateTime), 7, 25)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (87, CAST(N'2018-12-19T00:00:00.000' AS DateTime), 8, 14)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (88, CAST(N'2020-03-05T00:00:00.000' AS DateTime), 5, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (89, CAST(N'2021-03-23T00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (90, CAST(N'2018-06-21T00:00:00.000' AS DateTime), 6, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (91, CAST(N'2021-01-27T00:00:00.000' AS DateTime), 5, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (92, CAST(N'2019-09-26T00:00:00.000' AS DateTime), 2, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (93, CAST(N'2018-05-06T00:00:00.000' AS DateTime), 5, 12)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (94, CAST(N'2020-09-19T00:00:00.000' AS DateTime), 2, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (95, CAST(N'2018-12-12T00:00:00.000' AS DateTime), 5, 12)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (96, CAST(N'2021-06-23T00:00:00.000' AS DateTime), 2, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (97, CAST(N'2020-08-02T00:00:00.000' AS DateTime), 5, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (98, CAST(N'2021-08-31T00:00:00.000' AS DateTime), 4, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (99, CAST(N'2020-10-15T00:00:00.000' AS DateTime), 3, 11)
GO
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (100, CAST(N'2019-05-17T00:00:00.000' AS DateTime), 4, 14)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (101, CAST(N'2019-05-23T00:00:00.000' AS DateTime), 6, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (102, CAST(N'2018-07-04T00:00:00.000' AS DateTime), 1, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (103, CAST(N'2020-07-27T00:00:00.000' AS DateTime), 2, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (104, CAST(N'2019-12-15T00:00:00.000' AS DateTime), 8, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (105, CAST(N'2020-03-29T00:00:00.000' AS DateTime), 8, 3)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (106, CAST(N'2019-01-18T00:00:00.000' AS DateTime), 7, 25)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (107, CAST(N'2018-12-19T00:00:00.000' AS DateTime), 8, 14)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (108, CAST(N'2020-03-05T00:00:00.000' AS DateTime), 5, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (109, CAST(N'2021-03-23T00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (110, CAST(N'2018-06-21T00:00:00.000' AS DateTime), 6, 5)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (111, CAST(N'2021-01-27T00:00:00.000' AS DateTime), 5, 20)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (112, CAST(N'2019-09-26T00:00:00.000' AS DateTime), 2, 23)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (113, CAST(N'2018-05-06T00:00:00.000' AS DateTime), 5, 12)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (114, CAST(N'2020-09-19T00:00:00.000' AS DateTime), 2, 22)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (115, CAST(N'2018-12-12T00:00:00.000' AS DateTime), 5, 12)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (116, CAST(N'2021-06-23T00:00:00.000' AS DateTime), 2, 16)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (117, CAST(N'2020-08-02T00:00:00.000' AS DateTime), 5, 24)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (118, CAST(N'2021-08-31T00:00:00.000' AS DateTime), 4, 7)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (119, CAST(N'2020-10-15T00:00:00.000' AS DateTime), 3, 11)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (120, CAST(N'2019-05-17T00:00:00.000' AS DateTime), 4, 14)
INSERT [dbo].[Likes] ([Id], [DateLiked], [LikedBy], [PostId]) VALUES (121, CAST(N'2021-11-24T04:42:42.037' AS DateTime), 2, 5)
SET IDENTITY_INSERT [dbo].[Likes] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (1, N'Lorem ipsum dolor sit', 1, CAST(N'2018-10-08T00:00:00.000' AS DateTime), 1, 3)
INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (2, N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curab Ut nec urna et arcu imperdiet', 0, CAST(N'2020-04-05T00:00:00.000' AS DateTime), 2, 5)
INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (3, N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed', 1, CAST(N'2018-05-12T00:00:00.000' AS DateTime), 4, 6)
INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (4, N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing', 0, CAST(N'2018-12-24T00:00:00.000' AS DateTime), 6, 4)
INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (5, N'Lorem ipsum dolor sit amet, consectetuer', 0, CAST(N'2021-07-19T00:00:00.000' AS DateTime), 1, 8)
INSERT [dbo].[Messages] ([Id], [MessageText], [IsRead], [DateMessaged], [MessagedBy], [UserId]) VALUES (6, N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.', 1, CAST(N'2018-06-12T00:00:00.000' AS DateTime), 7, 2)
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[PostCategories] ON 

INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (1, 1, 155)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (2, 2, 105)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (3, 3, 170)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (4, 4, 133)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (5, 5, 99)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (6, 6, 185)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (7, 7, 150)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (8, 8, 152)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (9, 9, 24)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (10, 10, 55)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (11, 11, 103)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (12, 12, 2)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (13, 13, 36)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (14, 14, 131)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (15, 15, 88)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (16, 16, 132)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (17, 17, 33)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (18, 18, 32)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (19, 19, 190)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (20, 20, 19)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (21, 21, 181)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (22, 22, 41)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (23, 23, 127)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (24, 24, 146)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (25, 25, 71)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (26, 26, 78)
INSERT [dbo].[PostCategories] ([Id], [PostId], [CategoryId]) VALUES (27, 27, 53)
SET IDENTITY_INSERT [dbo].[PostCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Posts] ON 

INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (1, N'Quisque tincidunt', CAST(N'2019-05-06T00:00:00.000' AS DateTime), 222, 19, 1)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (2, N'et, eros. Proin', CAST(N'2020-04-16T00:00:00.000' AS DateTime), 89, 21, 8)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (3, N'vitae', CAST(N'2017-12-09T00:00:00.000' AS DateTime), 240, 26, 6)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (4, N'pretium et, rutrum non,', CAST(N'2018-11-10T00:00:00.000' AS DateTime), 497, 23, 5)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (5, N'augue id ante', CAST(N'2019-05-18T00:00:00.000' AS DateTime), 225, 21, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (6, N'lectus.', CAST(N'2019-12-11T00:00:00.000' AS DateTime), 17, 8, 4)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (7, N'pede et risus.', CAST(N'2020-04-28T00:00:00.000' AS DateTime), 118, 26, 4)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (8, N'Quisque imperdiet, erat nonummy', CAST(N'2021-07-04T00:00:00.000' AS DateTime), 473, 8, 5)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (9, N'sagittis felis. Donec tempor, est', CAST(N'2019-04-23T00:00:00.000' AS DateTime), 78, 0, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (10, N'Duis cursus,', CAST(N'2020-12-06T00:00:00.000' AS DateTime), 71, 15, 5)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (11, N'Cras lorem lorem, luctus ut,', CAST(N'2018-05-04T00:00:00.000' AS DateTime), 8, 3, 5)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (12, N'Cras dolor', CAST(N'2018-09-28T00:00:00.000' AS DateTime), 187, 16, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (13, N'ultrices', CAST(N'2019-06-25T00:00:00.000' AS DateTime), 415, 21, 2)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (14, N'enim nisl elementum purus, accumsan', CAST(N'2021-08-09T00:00:00.000' AS DateTime), 384, 10, 2)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (15, N'Nunc pulvinar', CAST(N'2020-08-03T00:00:00.000' AS DateTime), 245, 9, 4)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (16, N'vulputate,', CAST(N'2019-10-12T00:00:00.000' AS DateTime), 43, 18, 7)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (17, N'odio tristique pharetra. Quisque', CAST(N'2019-05-11T00:00:00.000' AS DateTime), 33, 2, 5)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (18, N'mus. Aenean', CAST(N'2021-09-18T00:00:00.000' AS DateTime), 288, 20, 7)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (19, N'a, dui.', CAST(N'2018-06-16T00:00:00.000' AS DateTime), 38, 23, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (20, N'dui. Cras', CAST(N'2021-09-09T00:00:00.000' AS DateTime), 343, 8, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (21, N'ligula. Aenean gravida nunc', CAST(N'2019-12-16T00:00:00.000' AS DateTime), 67, 29, 2)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (22, N'dolor dolor, tempus non,', CAST(N'2018-03-30T00:00:00.000' AS DateTime), 388, 11, 2)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (23, N'laoreet lectus quis massa.', CAST(N'2021-05-22T00:00:00.000' AS DateTime), 365, 6, 7)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (24, N'enim consequat purus.', CAST(N'2018-11-09T00:00:00.000' AS DateTime), 3, 12, 8)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (25, N'et', CAST(N'2020-09-01T00:00:00.000' AS DateTime), 206, 28, 6)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (26, N'mus. Proin vel nisl.', CAST(N'2021-09-10T00:00:00.000' AS DateTime), 317, 9, 3)
INSERT [dbo].[Posts] ([Id], [Content], [DatePosted], [Total_likes], [Total_comments], [UserId]) VALUES (27, N'ipsum nunc id enim.', CAST(N'2020-09-24T00:00:00.000' AS DateTime), 130, 21, 5)
SET IDENTITY_INSERT [dbo].[Posts] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfiles] ON 

INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (1, N'Susan', N'Brockew', NULL, CAST(N'2012-08-10T00:00:00.000' AS DateTime), N'077-231-2322', 2)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (2, N'Carter', N'Mcintyre', N'Male', CAST(N'2009-07-07T00:00:00.000' AS DateTime), N'055-221-3952', 1)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (3, N'Arthur', N'Noblesfd', N'Male', CAST(N'1998-06-20T00:00:00.000' AS DateTime), N'070-561-7823', 3)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (4, N'Vance', N'Moonesdfy', NULL, CAST(N'2001-07-14T00:00:00.000' AS DateTime), N'050-834-6783', 5)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (5, N'Remedios', N'Crasdfft', N'Female', CAST(N'2009-11-18T00:00:00.000' AS DateTime), N'099-579-7788', 7)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (6, N'Erica', N'Doysdfdsle', NULL, CAST(N'2001-11-10T00:00:00.000' AS DateTime), N'099-683-8681', 8)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (7, N'Ross', N'Wardsfe', N'Male', CAST(N'1999-12-20T00:00:00.000' AS DateTime), N'050-234-8781', 6)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Gender], [BirthDate], [PhoneNumber], [UserId]) VALUES (8, N'Cameron', N'Stsdfickland', NULL, CAST(N'2003-02-03T00:00:00.000' AS DateTime), N'050-864-2637', 4)
SET IDENTITY_INSERT [dbo].[UserProfiles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (1, N'mark123', N'adasd12asd', N'a.sollicitudin.orci@google.edu', CAST(N'2018-09-16T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (2, N'Wawawoo', N'Abracadaw_2la', N'nec.tempus@outlook.org', CAST(N'2017-01-25T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (3, N'Veloto', N'avFhas123s', N'et.magnis@hotmail.edu', CAST(N'2019-04-16T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (4, N'CrispyTipsy', N'Much5ToSay', N'blandit@icloud.org', CAST(N'2020-11-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (5, N'Soverino', N'LikeHo2gger', N'suspendisse@google.ca', CAST(N'2017-04-27T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (6, N'Luvita', N'Fashiongram167', N'purus.maecenas@protonmail.edu', CAST(N'2016-08-29T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (7, N'Storywella', N'FollowFo123', N'feugiat@hotmail.edu', CAST(N'2019-11-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [DateRegistered], [IsOnline]) VALUES (8, N'CooCooLoo', N'Su24Man2a', N'amet.ante@hotmail.net', CAST(N'2020-08-09T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UQ__PostCate__AA126019831E32B9]    Script Date: 24.11.2021 04:55:25 ******/
ALTER TABLE [dbo].[PostCategories] ADD UNIQUE NONCLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__UserProf__1788CC4D379681F6]    Script Date: 24.11.2021 04:55:25 ******/
ALTER TABLE [dbo].[UserProfiles] ADD UNIQUE NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E49880F0AF]    Script Date: 24.11.2021 04:55:25 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534486F196E]    Script Date: 24.11.2021 04:55:25 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT (getdate()) FOR [DateCommented]
GO
ALTER TABLE [dbo].[Followers] ADD  DEFAULT ((0)) FOR [CanFollow]
GO
ALTER TABLE [dbo].[Followers] ADD  DEFAULT (getdate()) FOR [DateFollowed]
GO
ALTER TABLE [dbo].[Likes] ADD  DEFAULT (getdate()) FOR [DateLiked]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [DateMessaged]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT (getdate()) FOR [DatePosted]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((0)) FOR [Total_likes]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((0)) FOR [Total_comments]
GO
ALTER TABLE [dbo].[UserProfiles] ADD  DEFAULT ('Prefer not to say') FOR [Gender]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [DateRegistered]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsOnline]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([CommentedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Followers]  WITH CHECK ADD FOREIGN KEY([FollowedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Followers]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([LikedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([MessagedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PostCategories]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PostCategories]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD CHECK  ((len([FirstName])>=(3)))
GO
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD CHECK  ((len([LastName])>=(5)))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  ((len([Password])>=(8)))
GO
/****** Object:  StoredProcedure [dbo].[AddPostLiked]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPostLiked]
	@likedby AS int,
	@postid AS int
AS
BEGIN
	BEGIN TRAN PostLiked

	INSERT INTO Likes(DateLiked, LikedBy, PostId)
	VALUES(GETDATE(), @likedby, @postid)

	IF(@@ERROR != 0)
	BEGIN
		PRINT 'Error in insert'
		ROLLBACK TRAN PostLiked
	END
	ELSE
	BEGIN
		PRINT 'Insert ok'

		UPDATE Posts
		SET Total_likes += 1
		WHERE Posts.Id = @postid

		COMMIT TRAN PostMark
	END
END
GO
/****** Object:  View [dbo].[AllPostsInfo]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllPostsInfo]  
WITH ENCRYPTION
AS
SELECT * FROM dbo.Posts 
GO
/****** Object:  View [dbo].[UsersPostsInfo]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UsersPostsInfo]
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT [dbo].Users.Username, [dbo].Users.Email, [dbo].Users.DateRegistered, dbo.Posts.Content PostContent FROM dbo.Posts INNER JOIN dbo.Users ON dbo.Users.Id = dbo.Posts.UserId
GO
/****** Object:  Trigger [dbo].[UsersEmailFormat]    Script Date: 24.11.2021 04:55:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UsersEmailFormat] 
ON  [dbo].Users
AFTER INSERT
AS
BEGIN 
	DECLARE @email nvarchar(100) 
	SELECT @email = Email FROM inserted
	IF (@email NOT LIKE '%_@_%_.__%')
	BEGIN
		PRINT 'Not a valid email address!'
		ROLLBACK TRAN
	END
END
GO

