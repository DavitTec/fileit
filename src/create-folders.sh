#! /usr/bin/env bash
# HEADER fileme default folder creation script
# AUTHOR David Mullins (DAVit) @2021 December
version=0.01

# TEST
# PATH
mkdir  -p root/projects/project-templates
mkdir  -p root/projects/project1
mkdir  -p root/projects/project2
mkdir  -p root/projects/project3
mkdir  -p root/media/audio/music/artist1
mkdir  -p root/media/audio/music/artist2
mkdir  -p root/media/audio/recordings
mkdir  -p root/media/audio/soundtracks
mkdir  -p root/media/images/logos
mkdir  -p root/media/images/icons
mkdir  -p root/media/images/drawings
mkdir  -p root/media/images/graphics
mkdir  -p root/media/pictures/2010
mkdir  -p root/media/pictures/2021
mkdir  -p root/media/video/movies
mkdir  -p root/media/video/discs
mkdir  -p root/media/video/youtube/channel1
mkdir  -p root/media/video/youtube/channel2
mkdir  -p root/media/av-recordings/zoom
mkdir  -p root/media/av-recordings/webcasts
mkdir  -p root/development/articledev
mkdir  -p root/development/audiodev
mkdir  -p root/development/booksdev
mkdir  -p root/development/sriptdev
mkdir  -p root/development/videodev
mkdir  -p root/development/webdev
mkdir  -p root/users/admin1
mkdir  -p root/users/user1
mkdir  -p root/users/user2
mkdir  -p root/companies/company-templates
mkdir  -p root/companies/company1
mkdir  -p root/companies/company2
mkdir  -p root/sys-library/git-repository/scripts
mkdir  -p root/sys-library/git-repository/applications
mkdir  -p root/sys-library/git-repository/documents
mkdir  -p root/sys-library/systems/apple
mkdir  -p root/sys-library/systems/linux
mkdir  -p root/sys-library/systems/microsoft
mkdir  -p root/sys-library/systems/devices/harddrives
mkdir  -p root/sys-library/systems/devices/phones
mkdir  -p root/sys-library/systems/devices/printers
mkdir  -p root/sys-library/systems/devices/scanner
mkdir  -p root/sys-library/systems/computers/computer1
mkdir  -p root/sys-library/systems/computers/computer2
mkdir  -p root/sys-library/systems
mkdir  -p root/archives/2010
mkdir  -p root/archives/2021
mkdir  -p root/archives/2022
mkdir  -p root/doc-library/pdf/2010
mkdir  -p root/doc-library/pdf/2021
mkdir  -p root/doc-library/pdf/2022
mkdir  -p root/doc-library/topic/bib-library



# Create symbolic links to the above Folders
# Some consideration needed here relating to
# LIST, READ, WRITE, DELETE, ARCHIVE permisions
# A basic example of links is for USER1


ln -sr root/doc-library/ root/users/user1/Documents
ln -sr root/archives/ root/users/user1/Archives
ln -sr root/companies/ root/users/user1/Company
ln -sr root/media/ root/users/user1/Media
ln -sr root/projects/ root/users/user1/Projects
ln -sr root/development/ root/users/user1/Development
ln -sr root/sys-library/ root/users/user1/Sys-Library



