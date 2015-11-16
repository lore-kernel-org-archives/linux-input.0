From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v8 0/8] imx25 adc and touchscreen driver
Date: Mon, 16 Nov 2015 13:01:01 +0100
Message-ID: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57561 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbKPMB2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 07:01:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

Hi,

welcome to the next round of the never ending series ;). The last versi=
on v7
was sent roughly 8 months ago. The first version at least 1.5 years ago=
=2E

This series adds two drivers for ADC and TSC of the imx25 and a MFD dri=
ver to
connect these.

Due to the larger changes in this version I had to remove some of the a=
cks
again.

@Hartmut:
Thanks for your comments. I updated the drivers accordingly.

Changes in v8:
 - scale was defined as a shared property of the ADC although the scale=
 can be
   different for each ADC channel. v8 fixes that.
 - Some smaller modifications of the code style in gcq code.
 - Redesign of the regulator handling in the gcq code. The driver does =
now
   handle regulators "vref-ext", "vref-xp" and "vref-yp" as positive vo=
ltage
   reference.  Also the calculation of the scale property based on thes=
e
   voltage reference regulators was fixed. The code now uses
   regulator_get_optional() to avoid dummy regulators.
 - The missing regulator_disable() was added.

 Thanks to J=C3=BCrgen the time behavior of the units is now fixed and =
within specs:
 - Fixed clock rates for the whole unit regarding to the reference manu=
al.
 - Fixed clock/time calculations for settling times in the touchscreen =
driver.

Best Regards,

Markus


Denis Carikli (2):
  ARM: dts: imx25: Add TSC and ADC support
  ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
    support.

Markus Pargmann (6):
  ARM: dt: Binding documentation for imx25 ADC/TSC
  ARM: dt: Binding documentation for imx25 GCQ
  ARM: dt: Binding documentation for imx25 touchscreen controller
  mfd: fsl imx25 Touchscreen ADC driver
  iio: adc: fsl,imx25-gcq driver
  input: touchscreen: imx25 tcq driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  58 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
 arch/arm/boot/dts/imx25.dtsi                       |  30 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   4 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 415 +++++++++++++=
+
 drivers/input/touchscreen/Kconfig                  |   6 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 600 +++++++++++++=
++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 204 +++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
 include/linux/mfd/imx25-tsadc.h                    | 140 +++++
 16 files changed, 1567 insertions(+), 3 deletions(-)
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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
