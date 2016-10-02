From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v7 0/5] mxs-lradc: Split driver into MFD
Date: Sun,  2 Oct 2016 16:15:44 +0200
Message-ID: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
List-Id: linux-input@vger.kernel.org

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28.

Ksenija Stanojevic (5):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen
  iio: adc: mxs-lradc: Remove driver
  mfd: Move binding document

 .../devicetree/bindings/iio/adc/mxs-lradc.txt      |   47 -
 .../devicetree/bindings/mfd/mxs-lradc.txt          |   47 +
 drivers/iio/adc/Kconfig                            |   27 +-
 drivers/iio/adc/Makefile                           |    2 +-
 drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
 drivers/input/touchscreen/Kconfig                  |   10 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/mfd/Kconfig                                |   17 +
 drivers/mfd/Makefile                               |    1 +
 9 files changed, 90 insertions(+), 1812 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt
 delete mode 100644 drivers/iio/adc/mxs-lradc.c

-- 
1.9.1
