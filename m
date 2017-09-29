From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 00/12] use managed devm_device_add_group for all touchscreen drivers
Date: Sat, 30 Sep 2017 05:38:27 +0900
Message-ID: <20170929203839.7010-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:40115 "EHLO
        1.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdI2Urc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 16:47:32 -0400
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 791201128DF
        for <linux-input@vger.kernel.org>; Fri, 29 Sep 2017 22:38:57 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Hi,

this patch series uses Dmitry's patch

  57b8ff070f98 driver core: add devm_device_add_group() and friends

each of the 12 patches replaces the sysfs_create_group() function
with its managed version devm_device_add_group.

Andi

Andi Shyti (12):
  Input: ad7897 - use managed devm_device_add_group
  Input: ad7879 - use managed devm_device_add_group
  Input: ads7846 - use managed devm_device_add_group
  Input: atmel_mxt_ts - use managed devm_device_add_group
  Input: edt-ft5x06 - use managed devm_device_add_group
  Input: elants_i2c - use managed devm_device_add_group
  Input: ili210x - use managed devm_device_add_group
  Input: melfas_mip4 - use managed devm_device_add_group
  Input: raydium_i2c_ts -  use managed devm_device_add_group
  Input: rohm_bu21023 - use managed devm_device_add_group
  Input: tsc200x-core - use managed devm_device_add_group
  Input: wdt87xx_i2c - use managed devm_device_add_group

 drivers/input/touchscreen/ad7877.c         |  8 ++------
 drivers/input/touchscreen/ad7879.c         | 13 +------------
 drivers/input/touchscreen/ads7846.c        |  8 ++------
 drivers/input/touchscreen/atmel_mxt_ts.c   |  3 +--
 drivers/input/touchscreen/edt-ft5x06.c     |  9 ++-------
 drivers/input/touchscreen/elants_i2c.c     | 19 +------------------
 drivers/input/touchscreen/ili210x.c        |  7 ++-----
 drivers/input/touchscreen/melfas_mip4.c    | 17 +----------------
 drivers/input/touchscreen/raydium_i2c_ts.c | 18 +-----------------
 drivers/input/touchscreen/rohm_bu21023.c   | 17 +----------------
 drivers/input/touchscreen/tsc200x-core.c   |  8 ++------
 drivers/input/touchscreen/wdt87xx_i2c.c    |  4 +---
 12 files changed, 17 insertions(+), 114 deletions(-)

-- 
2.14.2

