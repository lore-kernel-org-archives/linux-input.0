From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 0/6] imx25 adc and touchscreen driver
Date: Sat, 24 Jan 2015 15:01:37 +0100
Message-ID: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbbAXOCw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jan 2015 09:02:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Markus Pargmann <mpa@pengutronix.de>

Hi,

This series adds a driver for the Freescale i.MX25 SoC internal ADC unit which
is used for touchscreen and ADC. The driver consists of three parts, the MFD
driver which handles interrupts and some central configuration registers, the
ADC driver and the touchscreen driver.

The last couple of versions of this series were pushed by Denis, thanks. Now I
tried to work on the comments of the last version v4 of last year.

v5 has a lot of smaller changes, listed below. I also fixed the touchscreen
driver to reduce the number of interrupts. The drivers first version was
designed to start a new conversion whenever we got a conversion done or a
pendown was detected. This lead to a lot of interrupts. Instead we use the
ability of the hardware unit to repeat a conversion queue automatically with a
repeat wait timer. This is done in hardware and configured only once in
software to a constant value.

Best regards,

Markus


Changes in v5:
 - Removed module owner assingments from all drivers
 - Added missing kconfig dependencies
 - Separated DT binding documentation
 - Fixed locking for the gcq driver
 - Fixed a lot of style issues with the newer checkpatch tool, e.g. alignment
   of breaked lines


Denis Carikli (2):
  ARM: dts: imx25: Add TSC and ADC support
  ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
    support.

Markus Pargmann (4):
  mfd: fsl imx25 Touchscreen ADC driver
  ARM: dt: Binding documentation for imx25 ADC/TSC
  iio: adc: fsl,imx25-gcq driver
  input: touchscreen: imx25 tcq driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  51 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
 arch/arm/boot/dts/imx25.dtsi                       |  30 +-
 arch/arm/configs/imx_v4_v5_defconfig               |   4 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 369 +++++++++++++
 drivers/input/touchscreen/Kconfig                  |   6 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 587 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 167 ++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  11 +
 include/linux/mfd/imx25-tsadc.h                    | 140 +++++
 16 files changed, 1458 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
 create mode 100644 include/linux/mfd/imx25-tsadc.h

-- 
2.1.4

