From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 4/8] Input: tm2-touchkey: Correct initial brightness
Date: Fri,  7 Dec 2018 11:58:07 +0100
Message-ID: <20181207105811.1831-5-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Tm2-touchkey don't have brightness levels, but only on/off states,
so replace LED_FULL with LED_ON.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index cc713b901bf2..a73894b8dede 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -235,7 +235,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 
 	/* led device */
 	touchkey->led_dev.name = touchkey->variant->name;
-	touchkey->led_dev.brightness = LED_FULL;
+	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
 
-- 
2.17.1
