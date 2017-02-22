From: <michael.hennerich@analog.com>
Subject: [PATCH 0/4] Input: ad7879 RFC/RFT follow-up
Date: Wed, 22 Feb 2017 17:14:34 +0100
Message-ID: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam03on0044.outbound.protection.outlook.com ([104.47.42.44]:6941
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753699AbdBVQO0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 11:14:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Hi Dmitry,

I reviewed and tested your patch series (posted February 18th).

[RFC/RFT PATCH 1/3] Input: ad7879 - convert to use regmap
[RFC/RFT PATCH 2/3] Input: ad7879 - use more devm interfaces
[RFC/RFT PATCH 3/3] Input: ad7879 - allow exporting AUX/VBAT/GPIO pin via device property

Looks great only one issue fixed.

This little series goes on top of that.

Again thanks for these patches!

Regards,
Michael


Michael Hennerich (4):
  input:touchscreen:ad7879-spi.c: Fix regmap flag_masks
  input:touchscreen:ad7879-spi.c: Remove bits_per_word = 16 enforcement
  Documentation: Add SPI example
  input:touchscreen:ad7879: Update MODULE_AUTHOR email address

 .../devicetree/bindings/input/touchscreen/ad7879.txt   | 18 ++++++++++++++++++
 drivers/input/touchscreen/ad7879-i2c.c                 |  2 +-
 drivers/input/touchscreen/ad7879-spi.c                 | 13 +++----------
 drivers/input/touchscreen/ad7879.c                     |  2 +-
 4 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.7.4

