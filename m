From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v12 0/5] mxs-lradc: Split driver into MFD
Date: Sat, 10 Dec 2016 17:48:48 +0000
Message-ID: <a1034bb5-a4e9-dcc4-d082-fe597941eca1@kernel.org>
References: <cover.1481315766.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481315766.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On 09/12/16 21:08, Ksenija Stanojevic wrote:
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28
Hi All,

At first glance it looks like this is over to Dmitry and Lee.
If they are both happy...

Lee, I'm assuming this whole lot will go through MFD.  Please work your
magic with an immutable branch as I guess my Dmitry and I may well want
to pull this in at some point over the coming cycle as well.

If for whatever reason you would prefer I pick it up in the first instance
and do a branch for you and Dmitry, give me a shout.

Coming together very nicely and will be good to finally get this sorted!

Thanks,

Jonathan
> 
> Ksenija Stanojevic (5):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
>   mfd: Move binding document
> 
>  .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
>  drivers/iio/adc/Kconfig                            |   27 +-
>  drivers/iio/adc/Makefile                           |    2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                    |  843 ++++++++++
>  drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
>  drivers/input/touchscreen/Kconfig                  |   10 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/mxs-lradc-ts.c           |  739 +++++++++
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/mxs-lradc.c                            |  264 +++
>  include/linux/mfd/mxs-lradc.h                      |  187 +++
>  12 files changed, 2076 insertions(+), 1765 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
>  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
>  create mode 100644 drivers/mfd/mxs-lradc.c
>  create mode 100644 include/linux/mfd/mxs-lradc.h
> 
