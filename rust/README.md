1. To Build and Run the server
    ```
    docker build -t rust-axum-app .
    ```
    ```
    docker run -p 8000:8000 --env-file .env -e RUST_BACKTRACE=full rust-axum-app
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