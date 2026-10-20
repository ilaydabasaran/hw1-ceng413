# Homework Answers

### 1. Explain the order of the instructions in your Dockerfile. What would happen to build time if you changed the order of two of them?
I copied `requirements.txt` and installed the dependencies before copying the application code. Docker caches each step as a layer, and it reuses the cache if the files haven't changed. Application code changes very often, but dependencies change rarely. If I copied the code first, every small code change would break the cache and pip would download all packages again, making the build much slower.

### 2. What happens to data written inside a container when the container is removed? How would you keep the data, and where should an application keep important state?
When a container is deleted, all data written inside its writable layer is deleted too. To keep the data, we must use a Docker volume or a bind mount (like `-v mydata:/data`). Containers should be disposable, so important data should never be stored only inside the container. It should be kept in a volume or an external database.

### 3. Why is the latest tag a risk for reproducibility? What did you use instead?
The `latest` tag is not safe because it can point to a different image version tomorrow. This means the same Dockerfile could give different results on different days or computers. Instead of `latest`, I used `python:3.12-slim` to fix the specific Python and Debian version.

### Multi-stage Build & Image Size Note
I used a multi-stage build to keep the build process clean. In my test, `docker image ls` showed the final image size is 192MB. Since this is a simple Python project, the size difference is small, but using multi-stage is a good practice to avoid keeping build cache inside the final image.

### AI Assistance Disclosure
I used an AI assistant to review my Dockerfile, check the healthcheck syntax, and help improve the explanations in this document. I ran and tested the commands on my own machine.