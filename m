From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v5 0/4] mxs-lradc: Split driver into MFD
Date: Thu, 18 Aug 2016 15:44:29 +0200
Message-ID: <cover.1471524593.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
List-Id: linux-input@vger.kernel.org

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28.


Ksenija Stanojevic (4):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen
  iio: adc: mxs-lradc: Remove driver

 drivers/iio/adc/Kconfig                  |   27 +-
 drivers/iio/adc/Makefile                 |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c          |  844 ++++++++++++++
 drivers/iio/adc/mxs-lradc.c              | 1775 ------------------------------
 drivers/input/touchscreen/Kconfig        |   10 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c |  742 +++++++++++++
 drivers/mfd/Kconfig                      |   17 +
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/mxs-lradc.c                  |  255 +++++
 include/linux/mfd/mxs-lradc.h            |  194 ++++
 11 files changed, 2078 insertions(+), 1790 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1
