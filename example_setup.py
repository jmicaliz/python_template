# Example setup.py to use.
from setuptools import find_packages, setup


def parse_requirements(filename):
    with open(filename) as f:
        lineiter = (line.strip() for line in f)
        return [
            line.replace(" \\", "").strip()
            for line in lineiter
            if (
                line
                and not line.startswith("#")
                and not line.startswith("-e")
                and not line.startswith("--")
            )
        ]


setup(
    name="name_of_project_here",
    package_dir={"": "src"},
    packages=find_packages("src"),
    include_package_data=True,
    install_requires=parse_requirements("deps/requirements.in"),
    extras_require={"dev": parse_requirements("deps/dev-requirements.txt")},
    entry_points={"console_scripts": ["project_tool_example=module:function"]},
)
