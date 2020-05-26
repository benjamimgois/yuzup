# YuzUP

YuzUP is a small GUI app to update the nintendo switch emulator YUZU to the latest binary on github.

## Screenshot

<a href="https://imgbb.com/"><img src="https://i.ibb.co/yPDCgPZ/yuzup-02.png" alt="yuzup-02" border="0"></a><br /><a target='_blank' href='https://pt-br.imgbb.com/'></a><br />


## Prerequisites

Here are the dependencies needed in order to make GOverlay run:

 - [**`xterm`**](https://www.archlinux.org/packages/?name=xterm) 
 - [**`wget`**](https://www.archlinux.org/packages/extra/x86_64/wget/) 
 


## Tarball

1. Download the latest tarball from [Releases](https://github.com/benjamimgois/yuzup/releases).

2. Extract the file by running the following command:

```bash
tar -zxvf yuzup*.tar.gz
```

3. Execute the binary by running the following command:

```bash
./yuzup
```

## Source

### Prerequisites

Before building, you will need to install the following:

 - [Lazarus](https://github.com/graemeg/lazarus) - IDE

### Building

To build NTfix, clone the git repository by running following command:

```bash
git clone https://github.com/benjamimgois/yuzup.git
```


Then, change directory and build ntfix by running the following commands:

```bash
cd yuzup

lazbuild -B yuzup.lpi
```

### Running

To run yuzup, run the following command:

```bash
./yuzup
```

#### Lazarus

This project was built using [Lazarus](https://github.com/graemeg/lazarus).

[![lazarus-ide](https://i.ibb.co/9ykXNtw/Laz-banner.png)](https://www.lazarus-ide.org/)


## Donations

If this project was useful to you, don't hesitate to donate to me :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q5EYYEJ5NSJAU&source=url)


