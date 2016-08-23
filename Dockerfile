# our base image
FROM perl:5.24.0

# install Carton
RUN cpanm Carton

# install CPAN modules needed by the Perl app
COPY cpanfile* /usr/src/app/
WORKDIR /usr/src/app
RUN carton install --deployment

# copy files required for the app to run
COPY app.psgi /usr/src/app
COPY tmpl/index /usr/src/app/tmpl/

# tell the port number the container should expose
EXPOSE 5000

# run the application
CMD ["carton", "exec", "plackup", "app.psgi"]
