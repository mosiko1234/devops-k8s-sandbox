import subprocess
import sys


def ensure_module_installed(module_name):
    try:
        __import__(module_name)
    except ImportError:
        print(f"Module '{module_name}' is missing. Installing...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", module_name])
        print(f"Module '{module_name}' installed successfully.")


REQUIRED_MODULES = {
    "yaml": "pyyaml"
}

for module, pip_name in REQUIRED_MODULES.items():
    ensure_module_installed(pip_name or module)


def yaml_to_tfvars(yaml_file, tfvars_file):
    import yaml
    import json
    with open(yaml_file, 'r') as yf:
        config = yaml.safe_load(yf)

    def write_tfvars(data, prefix=""):
        tfvars = ""
        for key, value in data.items():
            full_key = f"{prefix}{key}" if prefix else key
            if key == "tags" and isinstance(value, list):
                tags_map = {tag["key"]: tag["value"] for tag in value if
                            isinstance(tag, dict) and "key" in tag and "value" in tag}
                tfvars += f'{full_key} = {json.dumps(tags_map)}\n'
            elif isinstance(value, dict):
                tfvars += write_tfvars(value, prefix=f"{full_key}_")
            elif isinstance(value, list):
                tfvars += f'{full_key} = {json.dumps(value)}\n'
            elif isinstance(value, bool):
                tfvars += f'{full_key} = {str(value).lower()}\n'
            else:
                tfvars += f'{full_key} = "{value}"\n'
        return tfvars

    tfvars_content = write_tfvars(config)

    with open(tfvars_file, 'w') as tf:
        tf.write(tfvars_content)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_yaml_file> <output_tfvars_file>")
        sys.exit(1)

    input_yaml = sys.argv[1]
    output_tfvars = sys.argv[2]

    yaml_to_tfvars(input_yaml, output_tfvars)
    print(f"Converted {input_yaml} to {output_tfvars}")