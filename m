From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v15 0/5] mxs-lradc: Split driver into MFD
Date: Mon, 20 Mar 2017 11:31:56 +0000
Message-ID: <20170320113156.qx6ntgporcco5res@dell>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
 <833dd944-f64e-b796-d957-c6a637535a12@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <833dd944-f64e-b796-d957-c6a637535a12@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On Sun, 19 Mar 2017, Jonathan Cameron wrote:

> On 16/03/17 12:27, Ksenija Stanojevic wrote:
> > Split existing driver mxs-lradc into MFD with touchscreen and
> > IIO part.
> > 
> > Tested on I.MX28
> Lee, I've been assuming you will take this one as an immutable branch
> in mfd, but let me know if you want it to go another route.

Yes, I'll get around to it.

> > Ksenija Stanojevic (5):
> >   mfd: mxs-lradc: Add support for mxs-lradc MFD
> >   iio: adc: mxs-lradc: Add support for adc driver
> >   input: touchscreen: mxs-lradc: Add support for touchscreen
> >   iio: adc: mxs-lradc: Remove driver
> >   mfd: Move binding document
> > 
> >  .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
> >  drivers/iio/adc/Kconfig                            |   27 +-
> >  drivers/iio/adc/Makefile                           |    2 +-
> >  drivers/iio/adc/mxs-lradc-adc.c                    |  843 ++++++++++
> >  drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
> >  drivers/input/touchscreen/Kconfig                  |   10 +
> >  drivers/input/touchscreen/Makefile                 |    1 +
> >  drivers/input/touchscreen/mxs-lradc-ts.c           |  714 ++++++++
> >  drivers/mfd/Kconfig                                |   17 +
> >  drivers/mfd/Makefile                               |    1 +
> >  drivers/mfd/mxs-lradc.c                            |  267 +++
> >  include/linux/mfd/mxs-lradc.h                      |  187 +++
> >  12 files changed, 2054 insertions(+), 1765 deletions(-)
> >  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
> >  create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
> >  delete mode 100644 drivers/iio/adc/mxs-lradc.c
> >  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
> >  create mode 100644 drivers/mfd/mxs-lradc.c
> >  create mode 100644 include/linux/mfd/mxs-lradc.h
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
