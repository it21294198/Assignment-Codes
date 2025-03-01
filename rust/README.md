1. Run to build the server
    ```
    docker-compose up --build
    ```

2. Run to check status on another terminal
   ```
   docker ps
   ```

3. Access the server by [this](http://0.0.0.0:8000/)

4. To stop running container
   ```
   docker stop <container_id_or_name>
   ```

5. Remove the container
   ```
   docker rm -f <container_id_or_name>
   ```