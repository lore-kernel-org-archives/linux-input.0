From: <michael.hennerich@analog.com>
Subject: [PATCH 1/4] input:touchscreen:ad7879-spi.c: Fix regmap flag_masks
Date: Wed, 22 Feb 2017 17:14:35 +0100
Message-ID: <1487780078-18510-2-git-send-email-michael.hennerich@analog.com>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:37568
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754320AbdBVQOZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 11:14:25 -0500
In-Reply-To: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Mask only applied to the top byte of the register

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index f2c06b5..b995891 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -19,8 +19,8 @@
 
 #define MAX_SPI_FREQ_HZ      5000000
 
-#define AD7879_CMD_MAGIC     0xE000
-#define AD7879_CMD_READ      BIT(10)
+#define AD7879_CMD_MAGIC     0xE0
+#define AD7879_CMD_READ      BIT(2)
 
 static const struct regmap_config ad7879_spi_regmap_config = {
 	.reg_bits = 16,
-- 
2.7.4

