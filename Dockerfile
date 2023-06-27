# Base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application code
COPY app.py .

# Install pyngrok
RUN pip install pyngrok

# Expose the port on which Flask runs
EXPOSE 5000

# Command to run the Flask application
CMD ["python", "app.py"]
