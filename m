From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v6 0/4] mxs-lradc: Split driver into MFD
Date: Sat, 17 Sep 2016 12:48:54 +0200
Message-ID: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35263 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbcIQKtH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Sep 2016 06:49:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

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
 drivers/iio/adc/mxs-lradc-adc.c          |  845 ++++++++++++++
 drivers/iio/adc/mxs-lradc.c              | 1775 ------------------------------
 drivers/input/touchscreen/Kconfig        |   10 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c |  743 +++++++++++++
 drivers/mfd/Kconfig                      |   17 +
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/mxs-lradc.c                  |  259 +++++
 include/linux/mfd/mxs-lradc.h            |  203 ++++
 11 files changed, 2093 insertions(+), 1790 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1

