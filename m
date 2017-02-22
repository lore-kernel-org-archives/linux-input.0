From: <michael.hennerich@analog.com>
Subject: [PATCH 2/4] input:touchscreen:ad7879-spi.c: Remove bits_per_word = 16 enforcement
Date: Wed, 22 Feb 2017 17:14:36 +0100
Message-ID: <1487780078-18510-3-git-send-email-michael.hennerich@analog.com>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam03on0044.outbound.protection.outlook.com ([104.47.42.44]:21760
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754722AbdBVQOZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Feb 2017 11:14:25 -0500
In-Reply-To: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Using regmap this is no longer required.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879-spi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index b995891..904a2c2 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -42,13 +42,6 @@ static int ad7879_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	spi->bits_per_word = 16;
-	err = spi_setup(spi);
-	if (err) {
-		dev_dbg(&spi->dev, "spi master doesn't support 16 bits/word\n");
-		return err;
-	}
-
 	regmap = devm_regmap_init_spi(spi, &ad7879_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.7.4

