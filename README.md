# buildPerl

A simple bash script to help build Perl modules for distribution to CPAN.

## Installation

buildPerl assumes that is it in the `_buildPerl` directory at the root of your Perl project.  The intent is that buildPerl will be included in your project as a [Git Submodule](https://github.com/blog/2104-working-with-submodules).

```bash
git submodule add https://github.com/marmanold/buildPerl.git _buildPerl 
cd _buildPerl
chmod +x buildPerl.sh
```

## Usage

### Testing

When you are testing your module buildPerl will make your project, update your README documentation, and run your test suite in verbose mode.

```bash
./buildPerl test
```

### Distribution

When you are ready to package your module for CPAN or another repository, buildPerl will make your project, update your README documentation, then test and build your distribution tar-ball.

```bash
./buildPerl dist
```

### Updating

If you would like to update your verison of buildPerl in your project run the following Git command at the root of your project.

```bash
git submodule update --remote --merge
```