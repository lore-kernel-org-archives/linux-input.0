From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/5] power: supply: Change Krzysztof Kozlowski's email to
 kernel.org
Date: Wed, 17 Aug 2016 14:07:43 +0200
Message-ID: <1471435666-11880-3-git-send-email-k.kozlowski@samsung.com>
References: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Change my email address to kernel.org instead of Samsung one for the
purpose of any future contact.  The copyrights remain untouched and are
attributed to Samsung.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-power | 8 ++++----
 drivers/power/supply/max14577_charger.c     | 4 ++--
 drivers/power/supply/max77693_charger.c     | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index fa05719f9981..f85ce9e327b9 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -22,7 +22,7 @@ Description:
 What:		/sys/class/power_supply/max14577-charger/device/fast_charge_timer
 Date:		October 2014
 KernelVersion:	3.18.0
-Contact:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+Contact:	Krzysztof Kozlowski <krzk@kernel.org>
 Description:
 		This entry shows and sets the maximum time the max14577
 		charger operates in fast-charge mode. When the timer expires
@@ -36,7 +36,7 @@ Description:
 What:		/sys/class/power_supply/max77693-charger/device/fast_charge_timer
 Date:		January 2015
 KernelVersion:	3.19.0
-Contact:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+Contact:	Krzysztof Kozlowski <krzk@kernel.org>
 Description:
 		This entry shows and sets the maximum time the max77693
 		charger operates in fast-charge mode. When the timer expires
@@ -50,7 +50,7 @@ Description:
 What:		/sys/class/power_supply/max77693-charger/device/top_off_threshold_current
 Date:		January 2015
 KernelVersion:	3.19.0
-Contact:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+Contact:	Krzysztof Kozlowski <krzk@kernel.org>
 Description:
 		This entry shows and sets the charging current threshold for
 		entering top-off charging mode. When charging current in fast
@@ -65,7 +65,7 @@ Description:
 What:		/sys/class/power_supply/max77693-charger/device/top_off_timer
 Date:		January 2015
 KernelVersion:	3.19.0
-Contact:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+Contact:	Krzysztof Kozlowski <krzk@kernel.org>
 Description:
 		This entry shows and sets the maximum time the max77693
 		charger operates in top-off charge mode. When the timer expires
diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index a36bcaf62dd4..449fc56f09eb 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -2,7 +2,7 @@
  * max14577_charger.c - Battery charger driver for the Maxim 14577/77836
  *
  * Copyright (C) 2013,2014 Samsung Electronics
- * Krzysztof Kozlowski <k.kozlowski@samsung.com>
+ * Krzysztof Kozlowski <krzk@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -643,6 +643,6 @@ static struct platform_driver max14577_charger_driver = {
 };
 module_platform_driver(max14577_charger_driver);
 
-MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 charger driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 060cab5ae3aa..6c78884bad5e 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -2,7 +2,7 @@
  * max77693_charger.c - Battery charger driver for the Maxim 77693
  *
  * Copyright (C) 2014 Samsung Electronics
- * Krzysztof Kozlowski <k.kozlowski@samsung.com>
+ * Krzysztof Kozlowski <krzk@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -766,6 +766,6 @@ static struct platform_driver max77693_charger_driver = {
 };
 module_platform_driver(max77693_charger_driver);
 
-MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 77693 charger driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1
