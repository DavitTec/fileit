#! /usr/bin/env bash
# HEADER fileme default folder creation script
# AUTHOR David Mullins (DAVit) @2021 December
version=0.01

# File directory structure for SMALL Business
# PATH
mkdir  -p 0001_Company/media/audio/music/artist1/
mkdir  -p 0001_Company/media/audio/music/artist2/
mkdir  -p 0001_Company/media/audio/recordings/
mkdir  -p 0001_Company/media/audio/soundtracks/
mkdir  -p 0001_Company/media/images/logos/
mkdir  -p 0001_Company/media/images/icons/
mkdir  -p 0001_Company/media/images/drawings/
mkdir  -p 0001_Company/media/images/graphics/
mkdir  -p 0001_Company/media/pictures/2010/
mkdir  -p 0001_Company/media/pictures/2021/
mkdir  -p 0001_Company/media/video/movies/
mkdir  -p 0001_Company/media/video/discs/
mkdir  -p 0001_Company/media/video/youtube/channel1/
mkdir  -p 0001_Company/media/video/youtube/channel2/
mkdir  -p 0001_Company/media/av-recordings/zoom/
mkdir  -p 0001_Company/media/av-recordings/webcasts/
mkdir  -p 0001_Company/development/articledev/
mkdir  -p 0001_Company/development/audiodev/
mkdir  -p 0001_Company/development/booksdev/
mkdir  -p 0001_Company/development/sriptdev/
mkdir  -p 0001_Company/development/videodev/
mkdir  -p 0001_Company/development/webdev/
mkdir  -p 0001_Company/home/admin1/
mkdir  -p 0001_Company/home/user1/
mkdir  -p 0001_Company/home/user2/
mkdir  -p 0001_Company/sys-library/git-repository/scripts/
mkdir  -p 0001_Company/sys-library/git-repository/applications/
mkdir  -p 0001_Company/sys-library/git-repository/documents/
mkdir  -p 0001_Company/sys-library/systems/apple/
mkdir  -p 0001_Company/sys-library/systems/linux/
mkdir  -p 0001_Company/sys-library/systems/microsoft/
mkdir  -p 0001_Company/sys-library/systems/devices/harddrives/
mkdir  -p 0001_Company/sys-library/systems/devices/phones/
mkdir  -p 0001_Company/sys-library/systems/devices/printers/
mkdir  -p 0001_Company/sys-library/systems/devices/scanner/
mkdir  -p 0001_Company/sys-library/systems/computers/computer1/
mkdir  -p 0001_Company/sys-library/systems/computers/computer2/
mkdir  -p 0001_Company/sys-library/systems/
mkdir  -p 0001_Company/archives/2010/
mkdir  -p 0001_Company/archives/2021/
mkdir  -p 0001_Company/archives/2022/
mkdir  -p 0001_Company/doc-library/pdf/2010/
mkdir  -p 0001_Company/doc-library/pdf/2021/
mkdir  -p 0001_Company/doc-library/pdf/2022/
mkdir  -p 0001_Company/doc-library/topic/bib-library/
mkdir  -p 0001_Company/administration/Directions/
mkdir  -p 0001_Company/administration/Forms/
mkdir  -p 0001_Company/administration/Phone_Lists/
mkdir  -p 0001_Company/administration/Policies_Procedures/
mkdir  -p 0001_Company/administration/Staff_Meetings/2021/20220115_Meeting_topic/
mkdir  -p 0001_Company/administration/Staff_Meetings/2022/
mkdir  -p 0001_Company/business_development/
mkdir  -p 0001_Company/financial/Budgets/2021_Budgets/
mkdir  -p 0001_Company/financial/Budgets/2022_Budgets/
mkdir  -p 0001_Company/financial/Financial_Reports/
mkdir  -p 0001_Company/financial/Sales_Projections/2021_Sales/
mkdir  -p 0001_Company/financial/Sales_Projections/2022_Sales/
mkdir  -p 0001_Company/hr/Benefits/
mkdir  -p 0001_Company/hr/Employees/John_Doe/
mkdir  -p 0001_Company/hr/Policies_Procedures/
mkdir  -p 0001_Company/hr/Intern_Program/
mkdir  -p 0001_Company/hr/Recruitment_and_Selection/Resumes/
mkdir  -p 0001_Company/hr/Performance_Reviews/
mkdir  -p 0001_Company/hr/Retirement_Programs/
mkdir  -p 0001_Company/hr/Telework/
mkdir  -p 0001_Company/hr/Training/
mkdir  -p 0001_Company/hr/Letters/
mkdir  -p 0001_Company/hr/Templates/
mkdir  -p 0001_Company/marketing/Advertising/
mkdir  -p 0001_Company/marketing/Branding/logos/
mkdir  -p 0001_Company/marketing/PR_and_Media/2021_PR/
mkdir  -p 0001_Company/marketing/PR_and_Media/2022_PR/
mkdir  -p 0001_Company/marketing/Promotional_Material/
mkdir  -p 0001_Company/marketing/Website/
mkdir  -p 0001_Company/clients/10001-Client/101-Project_Name/
mkdir  -p 0001_Company/clients/10001-Client/Profile/
mkdir  -p 0001_Company/clients/10001-Client/Correspondence/
mkdir  -p 0001_Company/products/
mkdir  -p 0001_Company/projects/1001-Project_Name/Budget/
mkdir  -p 0001_Company/projects/1001-Project_Name/101-WBS_Statement/
mkdir  -p 0001_Company/projects/1001-Project_Name/Assets/
mkdir  -p 0001_Company/projects/1001-Project_Name/Reports/
mkdir  -p 0001_Company/projects/project-templates/
mkdir  -p 0001_Company/vendors/10001-Vendor/
mkdir  -p 0001_Company/Legal_Documents/
mkdir  -p 0001_Company/Profile/
mkdir  -p 0001_Company/Business_plan/
mkdir  -p 0001_Company/Statement_Reports/2021_Annual/
mkdir  -p 0001_Company/Statement_Reports/2021_Quaterly/
mkdir  -p 0001_Company/Statement_Reports/2021_Monthly/
mkdir  -p 0001_Company/Budgets/2021_Annual/
mkdir  -p 0001_Company/Budgets/2021_Quaterly/
mkdir  -p 0001_Company/Budgets/2021_Monthly/
mkdir  -p 0001_Company/company-templates/


# Create symbolic links to the above Folders
# Some consideration needed here relating to
# LIST, READ, WRITE, DELETE, ARCHIVE permisions
# A basic example of links is for USER1


ln -sr 0001_Company/doc-library/ 0001_Company/home/user1/Documents
ln -sr 0001_Company/archives/ 0001_Company/home/user1/Archives
#ln -sr 0001_Company/companies/0001_Company/ test/home/user1/Company1
ln -sr 0001_Company/media/ 0001_Company/home/user1/Media
ln -sr 0001_Company/projects/ 0001_Company/home/user1/Projects
ln -sr 0001_Company/development/ 0001_Company/home/user1/Development
ln -sr 0001_Company/sys-library/ 0001_Company/home/user1/Sys-Library



