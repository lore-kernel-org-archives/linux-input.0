From: <michael.hennerich@analog.com>
Subject: [PATCH 4/4] input:touchscreen:ad7879: Update MODULE_AUTHOR email address
Date: Wed, 22 Feb 2017 17:14:38 +0100
Message-ID: <1487780078-18510-5-git-send-email-michael.hennerich@analog.com>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-sn1nam01on0049.outbound.protection.outlook.com ([104.47.32.49]:61621
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754713AbdBVQOZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 11:14:25 -0500
In-Reply-To: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879-i2c.c | 2 +-
 drivers/input/touchscreen/ad7879-spi.c | 2 +-
 drivers/input/touchscreen/ad7879.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 23e04e9..a282d1c 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -75,6 +75,6 @@ static struct i2c_driver ad7879_i2c_driver = {
 
 module_i2c_driver(ad7879_i2c_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen I2C bus driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 904a2c2..ac94cff 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -74,7 +74,7 @@ static struct spi_driver ad7879_spi_driver = {
 
 module_spi_driver(ad7879_spi_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen SPI bus driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:ad7879");
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index b6da5ce..53ab689 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -683,6 +683,6 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL(ad7879_probe);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("AD7879(-1) touchscreen Driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

