From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH] Input: tm2-touchkey - use LEN_ON as boolean value instead
 of LED_FULL
Date: Mon, 27 Mar 2017 22:29:05 +0900
Message-ID: <20170327132905.23133-1-andi.shyti@samsung.com>
References: <CGME20170327132914epcas1p150dbc9723f4ff06329d3d3486ad666f7@epcas1p1.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45646 "EHLO
        epoutp01.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752257AbdC0N3g (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 09:29:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Commit 4e552c8cb5bc ("leds: add LED_ON brightness as boolean value")
has introduced the LED_ON enumeration value that can be used
instead of LED_FULL which has more of a linear value.

Because the tm2-touchscreen doesn't have brightness levels, but
it's a simple on/off led, use LED_ON instead of LED_FULL.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 485900f953e0..abc266e40e17 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -213,7 +213,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	/* led device */
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
 	touchkey->led_dev.brightness = LED_FULL;
-	touchkey->led_dev.max_brightness = LED_FULL;
+	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
 
 	error = devm_led_classdev_register(&client->dev, &touchkey->led_dev);
-- 
2.11.0

