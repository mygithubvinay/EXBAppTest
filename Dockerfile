# Serves a downloaded/published ArcGIS Experience Builder app as a static site.
# Put this Dockerfile and nginx.conf next to the downloaded app folder's contents
# (index.html, dist/, widgets/, etc.), then build from that folder.

FROM nginx:1.27-alpine

# Remove default site
RUN rm -rf /usr/share/nginx/html/*

# Custom nginx config (SPA fallback, caching, gzip)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the downloaded app
COPY . /usr/share/nginx/html

# Don't ship the Docker files inside the web root
RUN rm -f /usr/share/nginx/html/Dockerfile /usr/share/nginx/html/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
