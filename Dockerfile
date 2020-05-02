FROM nginx

# Remove default index.html
RUN rm /usr/share/nginx/html/index.html

# Copy applications index.html
COPY index.html /usr/share/nginx/html
