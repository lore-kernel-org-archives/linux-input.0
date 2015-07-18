From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: ads7846 - change name of wakeup property to "wakeup-source"
Date: Fri, 17 Jul 2015 17:36:17 -0700
Message-ID: <1437179781-21124-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/input/ads7846.txt | 2 +-
 drivers/input/touchscreen/ads7846.c                 | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
index 5f7619c..df8b127 100644
--- a/Documentation/devicetree/bindings/input/ads7846.txt
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -64,7 +64,7 @@ Optional properties:
 					pendown-gpio (u32).
 	pendown-gpio			GPIO handle describing the pin the !PENIRQ
 					line is connected to.
-	linux,wakeup			use any event on touchscreen as wakeup event.
+	wakeup-source			use any event on touchscreen as wakeup event.
 
 
 Example for a TSC2046 chip connected to an McSPI controller of an OMAP SoC::
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index e4eb8a6..0f5f968 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1234,7 +1234,8 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
 	of_property_read_u32(node, "ti,pendown-gpio-debounce",
 			     &pdata->gpio_pendown_debounce);
 
-	pdata->wakeup = of_property_read_bool(node, "linux,wakeup");
+	pdata->wakeup = of_property_read_bool(node, "wakeup-source") ||
+			of_property_read_bool(node, "linux,wakeup");
 
 	pdata->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
 
-- 
2.4.3.573.g4eafbef
