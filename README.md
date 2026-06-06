Move HL21 folder  to %FlightGearInstallDir%\fgdata_2024_1\Aircraft
Move myRocket.xml to %FlightGearInstallDir%\fgdata_2024_1\Protocol

Run FlightGear with following script

--generic=socket,in,50,127.0.0.1,5500,udp,myRocket

--fdm=null

--altitude=3000

--httpd=8080

Run go.m script
