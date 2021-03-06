USE [SPPractice]
GO
/****** Object:  Table [dbo].[Agent]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agent](
	[AgentCode] [int] IDENTITY(1,1) NOT NULL,
	[AgentName] [nvarchar](50) NULL,
	[WorkingArea] [nvarchar](50) NULL,
	[Commission] [nvarchar](50) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
 CONSTRAINT [PK_Agent] PRIMARY KEY CLUSTERED 
(
	[AgentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerCode] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[CustomerCity] [nvarchar](50) NULL,
	[WorkingArea] [nvarchar](50) NULL,
	[CustomerCountry] [nvarchar](50) NULL,
	[Gread] [nvarchar](50) NULL,
	[OpeningAmount] [numeric](18, 0) NULL,
	[RecevingAmount] [numeric](18, 0) NULL,
	[PaymentAmount] [numeric](18, 0) NULL,
	[OutstandingAmount] [numeric](18, 0) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[AgentCode] [int] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderNum] [int] IDENTITY(1,1) NOT NULL,
	[OrderAmount] [numeric](18, 0) NULL,
	[AdvanceAmount] [numeric](18, 0) NULL,
	[OrderDate] [date] NULL,
	[CustomerCode] [int] NOT NULL,
	[OrderDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Agent] FOREIGN KEY([AgentCode])
REFERENCES [dbo].[Agent] ([AgentCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Agent]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerCode])
REFERENCES [dbo].[Customers] ([CustomerCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
/****** Object:  StoredProcedure [dbo].[AddAgent]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAgent]
	-- Add the parameters for the stored procedure here
	@AgentName nvarchar(50),
	@WorkingArea nvarchar(50),
	@Commision nvarchar(50),
	@PhoneNo nvarchar(50),
	@Country nvarchar(50)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Insert Into Agent(AgentName,WorkingArea,Commission,PhoneNo,Country)
values (@AgentName,@WorkingArea,@Commision,@PhoneNo,@Country)
	
END
GO
/****** Object:  StoredProcedure [dbo].[AddCustomer]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddCustomer]
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@CustomerCity nvarchar(50),
	@WorkingArea nvarchar(50),
	@CustomerCountry nvarchar(50),
	@Grade nvarchar(50),
	@OpeningAmount numeric(18,0),
	@RecevingAmount numeric(18,0),
	@PaymentAmount numeric(18,0),
	@OutstandingAmount numeric(18,0),
	@PhoneNo nvarchar(50),
	@AgentCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Customers (FirstName, LastName, CustomerCity, WorkingArea,CustomerCountry, Gread, OpeningAmount, RecevingAmount, PaymentAmount,OutstandingAmount,PhoneNo,AgentCode)
				values(@FirstName,@LastName,@CustomerCity,@WorkingArea,@CustomerCountry,@Grade,@OpeningAmount,@RecevingAmount,@PaymentAmount,@OutstandingAmount,@PhoneNo,@AgentCode)
END
GO
/****** Object:  StoredProcedure [dbo].[AddOrder]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddOrder] 
	@OrderAmount numeric(18,0),
	@AdvanceAmount numeric(18,0),
	@OrderDate date,
	@CustomerCode int,
	@OrderDescription nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert into Orders (OrderAmount,AdvanceAmount,OrderDate,CustomerCode,OrderDescription) 
						values (@OrderAmount,@AdvanceAmount,@OrderDate,@CustomerCode,@OrderDescription)
END
GO
/****** Object:  StoredProcedure [dbo].[AgentList]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AgentList](
@Search varchar(100),  -- Gloabl filter
@PageNumber int,
@PageSize int,
@SortOrder varchar(10),
@SortColumn int
)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @RecordFrom int;
		SET @RecordFrom = (@PageNumber-1)*@PageSize;

		;WITH CTE_Result
		(
			AgentCode,AgentName,WorkingArea,Commission,PhoneNo,Country
		)
		AS
		(
			SELECT * FROM Agent
			WHERE (@Search IS NULL or
									AgentName like '%'+@Search+'%')
		), CTE_Count AS (Select COUNT(AgentCode) AS TotalRecords FROM CTE_Result)

		SELECT * FROM CTE_Result,CTE_Count
			ORDER BY
				CASE WHEN  @SortColumn=2 AND @SortOrder='asc'  THEN AgentName END ASC,
				
				CASE WHEN  @SortColumn=2 AND @SortOrder='desc'  THEN AgentName END DESC

			OFFSET @RecordFrom ROWS 
			FETCH NEXT @PageSize ROWS ONLY

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CustomerList]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CustomerList]
(
@Search varchar(100),  -- Gloabl filter
@PageNumber int,
@PageSize int,
@SortOrder varchar(10),
@SortColumn int
)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @RecordFrom int;
		SET @RecordFrom = (@PageNumber-1)*@PageSize;

		;WITH CTE_Result
		(
			CustomerCode,AgentCode,CustomerName,CustomerCity,WorkingArea,CustomerCountry,Gread , OpeningAmount, RecevingAmount,
			PaymentAmount, OutstandingAmount,PhoneNo,AgentName
		)
		AS
		(
			SELECT CustomerCode,Customers.AgentCode as AgentCode ,FirstName + ' ' + LastName as CustomerName, CustomerCity, Customers.WorkingArea as WorkingArea,
			CustomerCountry, Gread , OpeningAmount, RecevingAmount,
			PaymentAmount, OutstandingAmount, Customers.PhoneNo as PhoneNo, AgentName 
			from Customers inner join Agent on Customers.AgentCode = Agent.AgentCode
			WHERE (@Search IS NULL or
									FirstName like '%'+@Search+'%'
									or LastName like '%'+@Search+'%')
		), CTE_Count AS (Select COUNT(CustomerCode) AS TotalRecords FROM CTE_Result)

		SELECT * FROM CTE_Result,CTE_Count
			ORDER BY
				CASE WHEN  @SortColumn=2 AND @SortOrder='asc'  THEN CustomerName END ASC,
				
				CASE WHEN  @SortColumn=2 AND @SortOrder='desc'  THEN CustomerName END DESC

			OFFSET @RecordFrom ROWS 
			FETCH NEXT @PageSize ROWS ONLY

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAgent]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAgent]
	-- Add the parameters for the stored procedure here
@AgentCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 Delete from Agent where AgentCode = @AgentCode
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteCustomer]
	@CustomerCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete from Customers where CustomerCode = @CustomerCode
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteOrder]
	@OrderNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete from Orders where OrderNum = @OrderNum
END
GO
/****** Object:  StoredProcedure [dbo].[FindAgent]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindAgent]
	-- Add the parameters for the stored procedure here
	@AgentCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Agent Where AgentCode = @AgentCode
END
GO
/****** Object:  StoredProcedure [dbo].[FindCustomer]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindCustomer]
	@CustomerCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Customers where CustomerCode = @CustomerCode
END
GO
/****** Object:  StoredProcedure [dbo].[FindOrder]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindOrder]
	@OrderNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Orders where OrderNum =@OrderNum
END
GO
/****** Object:  StoredProcedure [dbo].[OrderList]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrderList]
(
@Search varchar(100),  -- Gloabl filter
@PageNumber int,
@PageSize int,
@SortOrder varchar(10),
@SortColumn int
)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @RecordFrom int;
		SET @RecordFrom = (@PageNumber-1)*@PageSize;

		;WITH CTE_Result
		(
			OrderNum,CustomerCode,OrderAmount,AdvanceAmount,OrderDate,OrderDescription,CustomerName
		)
		AS
		(
			SELECT  OrderNum,Orders.CustomerCode as CustomerCode,OrderAmount,AdvanceAmount,OrderDate,OrderDescription,FirstName + ' ' + LastName as CustomerName 
			from Orders inner join Customers on Orders.CustomerCode = Customers.CustomerCode
			WHERE (@Search IS NULL or
									FirstName like '%'+@Search+'%'
									or LastName like '%'+@Search+'%')
		), CTE_Count AS (Select COUNT(OrderNum) AS TotalRecords FROM CTE_Result)

		SELECT * FROM CTE_Result,CTE_Count
			ORDER BY
				CASE WHEN  @SortColumn=2 AND @SortOrder='asc'  THEN CustomerName END ASC,
				
				CASE WHEN  @SortColumn=2 AND @SortOrder='desc'  THEN CustomerName END DESC

			OFFSET @RecordFrom ROWS 
			FETCH NEXT @PageSize ROWS ONLY

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[PageAgentList]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[PageAgentList](
@Search varchar(100),  -- Gloabl filter
@PageNumber int,
@PageSize int,
@SortOrder varchar(10),
@SortColumn int
)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @RecordFrom int;
		SET @RecordFrom = (@PageNumber-1)*@PageSize;

		;WITH CTE_Result
		(
			AgentCode,AgentName,WorkingArea,Commission,PhoneNo,Country
		)
		AS
		(
			SELECT * FROM Agent
			WHERE (@Search IS NULL or
									AgentName like '%'+@Search+'%')
		), CTE_Count AS (Select COUNT(AgentCode) AS TotalRecords FROM CTE_Result)

		SELECT * FROM CTE_Result,CTE_Count
			ORDER BY
				CASE WHEN  @SortColumn=2 AND @SortOrder='asc'  THEN AgentName END ASC,
				
				CASE WHEN  @SortColumn=2 AND @SortOrder='desc'  THEN AgentName END DESC

			OFFSET @RecordFrom ROWS 
			FETCH NEXT @PageSize ROWS ONLY

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[ShowList]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShowList]
(
@PageNumber int,
@PageSize int,
@Startdate date,
@EndDate date,
@SortColumn int,
@SortOrder varchar(50)

)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @RecordFrom int;
		SET @RecordFrom = (@PageNumber-1)*@PageSize;

		;WITH CTE_Result
		(
			FirstName,Summation,OrderDate,AgentCode
		)
		AS
		(
			SELECT FirstName,SUM(AdvanceAmount) as Summation,OrderDate,AgentCode
			FROM Orders inner join Customers on Orders.CustomerCode = Customers.CustomerCode
			where (@Startdate IS NULL or @EndDate IS NULL or (OrderDate >= @Startdate and OrderDate <= @EndDate))
			GROUP BY OrderDate,FirstName,AgentCode
		), CTE_Count AS (Select COUNT(OrderDate) AS TotalRecords FROM CTE_Result)

		SELECT * FROM CTE_Result,CTE_Count
			ORDER BY
				CASE WHEN  @SortColumn=2 AND @SortOrder='asc'  THEN FirstName END ASC,
				CASE WHEN  @SortColumn=3 AND @SortOrder='asc'  THEN OrderDate END ASC,
				
				CASE WHEN  @SortColumn=2 AND @SortOrder='desc'  THEN FirstName END DESC,
				CASE WHEN  @SortColumn=3 AND @SortOrder='desc'  THEN OrderDate END DESC

			OFFSET @RecordFrom ROWS 
			FETCH NEXT @PageSize ROWS ONLY

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAgent]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAgent]
	@AgentCode int,
	@AgentName nvarchar(50),
	@WorkingArea nvarchar(50),
	@Commision nvarchar(50),
	@PhoneNo nvarchar(50),
	@Country nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update Agent SET AgentName = @AgentName, 
	WorkingArea = @WorkingArea, Commission = @Commision,PhoneNo =@PhoneNo,Country = @Country 

	where AgentCode = @AgentCode

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCustomer]
	@CustomerCode int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@CustomerCity nvarchar(50),
	@WorkingArea nvarchar(50),
	@CustomerCountry nvarchar(50),
	@Grade nvarchar(50),
	@OpeningAmount numeric(18,0),
	@RecevingAmount numeric(18,0),
	@PaymentAmount numeric(18,0),
	@OutstandingAmount numeric(18,0),
	@PhoneNo nvarchar(50),
	@AgentCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Customers set FirstName = @FirstName, LastName = @LastName, CustomerCity = @CustomerCity, WorkingArea = @WorkingArea,
			CustomerCountry = @CustomerCountry, Gread = @Grade, OpeningAmount = @OpeningAmount, RecevingAmount = @RecevingAmount,
			PaymentAmount = @PaymentAmount, OutstandingAmount = @OutstandingAmount, PhoneNo = @PhoneNo, AgentCode = @AgentCode
			where CustomerCode = @CustomerCode
END
GO
/****** Object:  StoredProcedure [dbo].[UpdeteOrder]    Script Date: 31/03/2021 10:56:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdeteOrder]
	@OrderNum int,
	@OrderAmount numeric(18,0),
	@AdvanceAmount numeric(18,0),
	@OrderDate date,
	@CustomerCode int,
	@OrderDescription nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Orders set OrderAmount = @OrderAmount, AdvanceAmount = @AdvanceAmount, OrderDate = @OrderDate, CustomerCode = @CustomerCode,
									OrderDescription = @OrderDescription where OrderNum = @OrderNum
END
GO
