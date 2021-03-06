FROM java:8
MAINTAINER Jan Schulte jan@janschulte.com

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.11
ENV SCALA_HOME /usr/local/share/scala

ENV SCALA_URL http://downloads.lightbend.com/scala
ENV SCALA_FILE scala-$SCALA_VERSION
ENV SCALA_TGZ $SCALA_FILE.tgz

ENV SBT_URL https://dl.bintray.com/sbt/native-packages/sbt
ENV SBT_FILE sbt-$SBT_VERSION
ENV SBT_TGZ $SBT_FILE.tgz

RUN wget $SCALA_URL/$SCALA_VERSION/$SCALA_TGZ && \
	tar xvzf $SCALA_TGZ && \
	mv $SCALA_FILE /usr/local/share/scala


RUN wget $SBT_URL/$SBT_VERSION/$SBT_TGZ && \
	tar xvzf $SBT_TGZ && \
	mv sbt $SCALA_HOME/sbt && \
	$SCALA_HOME/sbt/bin/sbt

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
	apt-get install -y nodejs && \
	apt-get install -y build-essential && \
	npm install source-map-support

ENV PATH $PATH:$SCALA_HOME/bin:$SCALA_HOME/sbt/bin

WORKDIR /home

CMD ["sbt"]
