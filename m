From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v9 0/5] mxs-lradc: Split driver into MFD
Date: Wed,  2 Nov 2016 08:38:21 +0100
Message-ID: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcKBHic (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2016 03:38:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28.

Ksenija Stanojevic (5):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen
  iio: adc: mxs-lradc: Remove driver
  mfd: Move binding document

 .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
 drivers/iio/adc/Kconfig                            |   27 +-
 drivers/iio/adc/Makefile                           |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  845 ++++++++++
 drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
 drivers/input/touchscreen/Kconfig                  |   10 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c           |  743 +++++++++
 drivers/mfd/Kconfig                                |   17 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/mxs-lradc.c                            |  249 +++
 include/linux/mfd/mxs-lradc.h                      |  203 +++
 12 files changed, 2083 insertions(+), 1765 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1

