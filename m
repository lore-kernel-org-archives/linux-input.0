From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/3] arm imx25 touchscreen/ADC drivers
Date: Thu, 20 Feb 2014 17:21:49 +0100
Message-ID: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48674 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbaBTQXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:23:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Hi,

This series adds 3 drivers to support the i.MX25 Touchscreen/ADC device.
The device has 3 parts. The core controls some generic functions of the
complete device, including the clock and IRQs. A touchscreen specific
conversion queue that works with the central ADC to detect and convert touch
positions. And a generic conversion queue which is the same hardware as the
touchscreen conversion queue but is supposed to be used for generic ADC
conversions.

There are 3 drivers to support all parts. fsl-imx25-tsadc is a MFD driver which
controls the core. fsl-imx25-tcq is the touchscreen conversion queue driver
which registers a touchscreen input device. fsl-imx25-gcq is the generic
conversion queue driver that registers a iio device for all inputs available.

All drivers are initialized using devicetree bindings.

Regards,

Markus Pargmann


Markus Pargmann (3):
  mfd: fsl imx25 Touchscreen ADC driver
  input: touchscreen: imx25 tcq driver
  iio: adc: fsl,imx25-gcq driver

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  54 ++
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
 .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/fsl-imx25-gcq.c                    | 325 ++++++++++++
 drivers/input/touchscreen/Kconfig                  |   6 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          | 589 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/fsl-imx25-tsadc.c                      | 234 ++++++++
 include/linux/mfd/imx25-tsadc.h                    | 138 +++++
 13 files changed, 1441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
 create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
 create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
 create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
 create mode 100644 include/linux/mfd/imx25-tsadc.h

-- 
1.8.5.3

