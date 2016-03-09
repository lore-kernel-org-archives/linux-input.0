From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL v2] Immutable branch between MFD, Input and IIO [with fix]
Date: Wed, 9 Mar 2016 12:55:43 +0700
Message-ID: <20160309055543.GQ13692@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <20160211155633.GB20693@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160211155633.GB20693@x1>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Please pull this new tag.  It contains a fix.

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2=
a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-input-iio-v4.6-v2

for you to fetch changes up to 0708677558dd7d03e70292549433f0f6b04a5e00=
:

  iio: adc/imx25-gcq: Move incorrect do_div (2016-03-09 12:50:51 +0700)

----------------------------------------------------------------
Immutable branch between MFD, Input and IIO [with fix] due for v4.6

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: adc/imx25-gcq: Move incorrect do_div

Markus Pargmann (6):
      mfd: Add DT binding documentation for imx25 ADC/TSC
      iio: Add binding documentation for imx25 GCQ
      Input: add binding documentation for imx25 touchscreen controller
      mfd: fsl-imx25-tsadc: Register touchscreen ADC driver
      iio: adc: Add imx25-gcq ADC driver
      Input: touchscreen: Add imx25 TCQ driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  58 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  35 ++
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  47 ++
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 417 +++++++++++++=
+
 drivers/input/touchscreen/Kconfig                  |   9 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 596 +++++++++++++=
++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 203 +++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
 include/linux/mfd/imx25-tsadc.h                    | 140 +++++
 14 files changed, 1543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25=
-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsa=
dc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
 create mode 100644 include/linux/mfd/imx25-tsadc.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
