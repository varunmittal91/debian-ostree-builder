# Debian OSTree Builder

This project provides a set of scripts to create an OSTree sysroot image using the Debos image builder. The resulting images can be used for various purposes, including deploying to USB drives or local disks.

## Prerequisites

Before you begin, ensure you have the following tools installed on your system:

- Debos: A Debian OS image builder
- OSTree: A tool for managing bootable, immutable, versioned filesystem trees
- Git: For cloning this repository

### Apt install (debian, ubuntu etc)

```bash
sudo apt-get install debos git ostree -y
```

## Getting Started

Follow these steps to set up your environment and build the OSTree sysroot image.

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/varunmittal91/debian-ostree-builder.git
cd debian-ostree-builder
```

### 2. Initialize a New Sysroot

Initialize the OSTree sysroot using the provided script:

```bash
./init_ostree.sh
```

This script sets up the initial OSTree repository and configures the necessary directories.

### 3. Build the Base Image

Next, build the base image. This image serves as the foundation for the OSTree image:

```bash
./build.sh base
```

### 4. Build the OSTree Image

Create the OSTree image from the base image:

```bash
./build.sh ostree
```

### 5. Build the Final Deployable Image

Finally, build the deployable image that can be written to a disk (such as a USB drive or a local hard drive):

```bash
./build.sh deploy
```

This results in [amd64.img](build/amd64.img).

System boots with default user, username: user and password: user.

## Customization

You can customize the build process by modifying the scripts and configuration files included in this repository. Refer to the Debos and OSTree documentation for more details on how to tailor the images to your specific needs.

## Troubleshooting

If you encounter any issues during the build process, check the following:

- Ensure all prerequisites are installed and properly configured.
- Review the output logs for any error messages and address them accordingly.
- Refer to the official Debos and OSTree documentation for additional guidance.

## Contributing

Contributions are welcome! If you have any improvements or fixes, please submit a pull request. For major changes, please open an issue first to discuss your proposed changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

This project was inspired by the need to streamline the process of creating OSTree sysroot images using Debian-based systems. Special thanks to the developers of Debos and OSTree for their invaluable tools.
