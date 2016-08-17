From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: Change Krzysztof Kozlowski's email to kernel.org" to the regulator tree
Date: Wed, 17 Aug 2016 13:41:33 +0100
Message-ID: <E1ba0A1-0006Ch-RF@debutante>
References: <1471435666-11880-6-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50524 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbcHQMl4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2016 08:41:56 -0400
In-Reply-To: <1471435666-11880-6-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

The patch

   regulator: Change Krzysztof Kozlowski's email to kernel.org

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cea8aa3a93d1734816e1e3f7b118e1dddf3f4aaa Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Wed, 17 Aug 2016 14:07:46 +0200
Subject: [PATCH] regulator: Change Krzysztof Kozlowski's email to kernel.org

Change my email address to kernel.org instead of Samsung one for the
purpose of any future contact.  The copyrights remain untouched and are
attributed to Samsung.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1

