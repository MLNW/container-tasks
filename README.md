<!-- README based on https://github.com/othneildrew/Best-README-Template -->

<a name="readme-top"></a>

<div align="center">

  [![Contributors][contributors-shield]][contributors-url]
  [![Forks][forks-shield]][forks-url]
  [![Stargazers][stars-shield]][stars-url]
  [![Issues][issues-shield]][issues-url]
  [![MIT License][license-shield]][license-url]

</div>

<div align="center">
<!-- PROJECT LOGO
  <a href="https://github.com/mlnw/container-tasks">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
-->

<h3 align="center">Container Tasks</h3>
  <p align="center">
    A collection of generalized tasks for building container images.
    <br />
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#building">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

## About The Project

The idea of this project is to provide generalized tasks for building container images, e.g., for shared development environments.
The tasks are defined in [`podman.tasks.yml`](common/taskfiles/podman.tasks.yml).

An example of how to use these tasks to build, test, and debug container images is available in [`Taskfile.yml`](Taskfile.yml).
It includes and parameterizes the general tasks to build a personal development environment defined in the [`images/dev/`](images/dev/) directory.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

[![Task][task-shield]][task-url]
[![Podman][podman-shield]][podman-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

You may use this repository to build my personal development environment defined in the [`imges/dev/`](images/dev/) directory.
You may also use the tasks defined in [`podman.tasks.yml`](common/taskfiles/podman.tasks.yml) to build your own container images.
For this purpose include the tasks as a [remote taskfile](https://taskfile.dev/experiments/remote-taskfiles/).

### Prerequisites

You will need to have these tools installed on your system:

- [Task][task-url]
- [Podman][podman-url]
- [jq](https://github.com/jqlang/jq)
- [yg](https://github.com/mikefarah/yq)

### Building

Review available tasks via `task --list`.
Build the example development environment via `task image:dev:build`.
Create a WSL ready distribution of the development environment via `task image:dev:wsl`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--
## Usage

Use this space to show useful examples of how a project can be used.
Additional screenshots, code examples and demos work well in this space.
You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
  - [ ] Nested Feature

See the [open issues](https://github.com/mlnw/container-tasks/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create.
Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request.
You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star!
Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT License.
See [`LICENSE`](LICENSE) for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[task-url]: https://taskfile.dev
[task-shield]: https://img.shields.io/badge/Task-20232A?style=for-the-badge&logo=task&logoColor=61DAFB
[podman-url]: https://podman.io
[podman-shield]: https://img.shields.io/badge/Podman-20232A?style=for-the-badge&logo=podman&logoColor=61DAFB
[contributors-shield]: https://img.shields.io/github/contributors/mlnw/container-tasks.svg?style=for-the-badge
[contributors-url]: https://github.com/mlnw/container-tasks/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/mlnw/container-tasks.svg?style=for-the-badge
[forks-url]: https://github.com/mlnw/container-tasks/network/members
[stars-shield]: https://img.shields.io/github/stars/mlnw/container-tasks.svg?style=for-the-badge
[stars-url]: https://github.com/mlnw/container-tasks/stargazers
[issues-shield]: https://img.shields.io/github/issues/mlnw/container-tasks.svg?style=for-the-badge
[issues-url]: https://github.com/mlnw/container-tasks/issues
[license-shield]: https://img.shields.io/github/license/mlnw/container-tasks.svg?style=for-the-badge
[license-url]: https://github.com/mlnw/container-tasks/blob/master/LICENSE
