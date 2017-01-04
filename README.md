# safe_projects
Project management with git

## Configuration

Create a file named `~/.projects` with the path where you'd like your
repositories to be stored. This should ideally be a location that is backed up
regularly.

```bash
vim ~/.projects
```

An example file looks like this:

```bash
export REPOSITORY_ROOT=/net/eichler/vol4/home/jlhudd/projects/repositories
```

Clone safe projects code and add scripts to `$PATH`.

```bash
mkdir -p ~/src
cd ~/src
git clone https://github.com/huddlej/safe_projects.git
PATH=$PATH:$HOME/src/safe_projects
export PATH
```

## Usage

Create a new project.

```bash
create_project.sh 2015-05-23-analyze_copy_number_distributions
```

Change into new project directory.

```bash
cd 2015-05-23-analyze_copy_number_distributions
```

Add environmental configuration to `config.sh`. Add rules for your analyses to
`Snakefile`. Add configuration parameters for
[snakemake](https://bitbucket.org/johanneskoester/snakemake/wiki/Home) to
`config.json`.

Run your analysis.

```bash
snakemake
```

Add your changes to the repository and commit them.

```bash
git add Snakefile config.json config.sh
git commit -m "added initial rules and configuration"
```

Save your changes to the repository root (i.e., your backed up path from the
configuration section above).

```bash
git push origin master
```

If your current working directory is already a git repository without a remote,
you can quickly initialize a remote repository and push all your changes there
by running the following command from the top-level of the working directory.

```bash
initialize_project.sh
```
