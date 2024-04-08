import subprocess

def run_command(command):
    """
    Runs a shell command and prints its output.
    """
    try:
        # Run command
        process = subprocess.run(command, check=True, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        # Print output and error (if any)
        print(process.stdout)
        if process.stderr:
            print(f"Error: {process.stderr}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to execute command: {e}")

if __name__ == "__main__":
    # List of commands to execute
    commands = [
        "python3 manage.py collectstatic --noinput",
        "python3 manage.py makemigrations --noinput",
        "python3 manage.py migrate --noinput",
        "python3 manage.py runserver 0.0.0.0:8000"
    ]

    # Execute each command
    for command in commands:
        print(f"Executing: {command}")
        run_command(command)
        print("-" * 60)  # Print a separator between commands
