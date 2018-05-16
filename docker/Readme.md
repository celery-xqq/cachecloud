Docker 化
===

step1:mvn clean compile install -Ponline

step2:move web war info this folder and rename it into cc-web.war

step3:docker build -t {tag} .

step4:docker run -p 8787:8080 -e DBURL="jdbc:mysql://172.27.25.35:3306/cache_cloud" -e DBUSER="root" -e DBPWD="admin"  -it 49d6a58c7185