From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v15 0/5] mxs-lradc: Split driver into MFD
Date: Thu, 16 Mar 2017 13:27:08 +0100
Message-ID: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34333 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdCPM1X (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 08:27:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28

Ksenija Stanojevic (5):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen
  iio: adc: mxs-lradc: Remove driver
  mfd: Move binding document

 .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
 drivers/iio/adc/Kconfig                            |   27 +-
 drivers/iio/adc/Makefile                           |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  843 ++++++++++
 drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
 drivers/input/touchscreen/Kconfig                  |   10 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c           |  714 ++++++++
 drivers/mfd/Kconfig                                |   17 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/mxs-lradc.c                            |  267 +++
 include/linux/mfd/mxs-lradc.h                      |  187 +++
 12 files changed, 2054 insertions(+), 1765 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1

