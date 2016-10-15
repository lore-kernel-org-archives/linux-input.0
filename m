From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v7 0/5] mxs-lradc: Split driver into MFD
Date: Sat, 15 Oct 2016 18:41:14 +0200 (CEST)
Message-ID: <417434821.363505.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 2. Oktober 2016 um
> 16:15 geschrieben:
> 
> 
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.

i'm back from holidays and wanted to test your patch series. Unfortunately patch
1-3 looks broken to me. Maybe you should wait for 4.9rc-1 and then resend the
patch series.

Stefan

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
>  drivers/iio/adc/mxs-lradc.c                        | 1750
> --------------------
>  drivers/input/touchscreen/Kconfig                  |   10 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/mfd/Kconfig                                |   17 +
>  drivers/mfd/Makefile                               |    1 +
>  9 files changed, 90 insertions(+), 1812 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt
>  delete mode 100644 drivers/iio/adc/mxs-lradc.c
> 
> -- 
> 1.9.1
>
