From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/5] extcon: max14577: Change Krzysztof Kozlowski's email to
 kernel.org
Date: Wed, 17 Aug 2016 14:07:44 +0200
Message-ID: <1471435666-11880-4-git-send-email-k.kozlowski@samsung.com>
References: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:12862 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbcHQMIW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2016 08:08:22 -0400
In-reply-to: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Change my email address to kernel.org instead of Samsung one for the
purpose of any future contact.  The copyrights remain untouched and are
attributed to Samsung.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/extcon/extcon-max14577.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 852a7112f451..a0cd6522a0ea 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2013,2014 Samsung Electronics
  * Chanwoo Choi <cw00.choi@samsung.com>
- * Krzysztof Kozlowski <k.kozlowski@samsung.com>
+ * Krzysztof Kozlowski <krzk@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -791,6 +791,6 @@ static struct platform_driver max14577_muic_driver = {
 module_platform_driver(max14577_muic_driver);
 
 MODULE_DESCRIPTION("Maxim 14577/77836 Extcon driver");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>");
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:extcon-max14577");
-- 
1.9.1

