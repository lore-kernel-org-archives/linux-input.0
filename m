From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/5] mxs-lradc: Split driver into MFD
Date: Wed, 26 Oct 2016 13:46:01 +0100
Message-ID: <20161026124601.GI11267@dell>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On Sun, 02 Oct 2016, Ksenija Stanojevic wrote:

> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28.
> 
> Ksenija Stanojevic (5):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
>   mfd: Move binding document
> 
>  .../devicetree/bindings/iio/adc/mxs-lradc.txt      |   47 -
>  .../devicetree/bindings/mfd/mxs-lradc.txt          |   47 +
>  drivers/iio/adc/Kconfig                            |   27 +-
>  drivers/iio/adc/Makefile                           |    2 +-
>  drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------

I guess you forgot to add the driver?

As much as I like patches with more '-'es than '+'es.

>  drivers/input/touchscreen/Kconfig                  |   10 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  9 files changed, 90 insertions(+), 1812 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
