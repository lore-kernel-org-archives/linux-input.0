From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 5/5] regulator: Change Krzysztof Kozlowski's email to kernel.org
Date: Wed, 17 Aug 2016 14:07:46 +0200
Message-ID: <1471435666-11880-6-git-send-email-k.kozlowski@samsung.com>
References: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Change my email address to kernel.org instead of Samsung one for the
purpose of any future contact.  The copyrights remain untouched and are
attributed to Samsung.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max14577-regulator.c | 4 ++--
 drivers/regulator/max77693-regulator.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index b2daa6641417..c9ff26199711 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -2,7 +2,7 @@
  * max14577.c - Regulator driver for the Maxim 14577/77836
  *
  * Copyright (C) 2013,2014 Samsung Electronics
- * Krzysztof Kozlowski <k.kozlowski@samsung.com>
+ * Krzysztof Kozlowski <krzk@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -331,7 +331,7 @@ static void __exit max14577_regulator_exit(void)
 }
 module_exit(max14577_regulator_exit);
 
-MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:max14577-regulator");
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index de730fd3f8a5..cfbb9512e486 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2013-2015 Samsung Electronics
  * Jonghwa Lee <jonghwa3.lee@samsung.com>
- * Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
+ * Krzysztof Kozlowski <krzk@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -314,5 +314,5 @@ module_exit(max77693_pmic_cleanup);
 
 MODULE_DESCRIPTION("MAXIM 77693/77843 regulator driver");
 MODULE_AUTHOR("Jonghwa Lee <jonghwa3.lee@samsung.com>");
-MODULE_AUTHOR("Krzysztof Kozlowski <k.kozlowski.k@gmail.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_LICENSE("GPL");
-- 
1.9.1

