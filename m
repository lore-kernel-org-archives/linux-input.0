From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v4 3/4] mfd: max77693: add haptic of_compatible in mfd_cell
Date: Thu, 11 Sep 2014 21:54:21 +0900
Message-ID: <1410440062-19963-4-git-send-email-jaewon02.kim@samsung.com>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57473 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542AbaIKMyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 08:54:31 -0400
In-reply-to: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>

This patch add haptic of_compatible in order to use the haptic
device driver using Devicetree.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/mfd/max77693.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index fbfed56..5b516fe 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -46,7 +46,10 @@ static const struct mfd_cell max77693_devs[] = {
 	{ .name = "max77693-charger", },
 	{ .name = "max77693-flash", },
 	{ .name = "max77693-muic", },
-	{ .name = "max77693-haptic", },
+	{
+		.name = "max77693-haptic",
+		.of_compatible = "maxim,max77693-haptic",
+	},
 };
 
 static const struct regmap_config max77693_regmap_config = {
-- 
1.7.9.5

