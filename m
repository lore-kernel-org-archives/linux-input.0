From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: snvs_pwrkey - remove duplicated semicolon
Date: Fri, 11 Sep 2015 03:35:39 +0200
Message-ID: <1441935339-8257-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:35518 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbbIKBfs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 21:35:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Robin Gong <b38343@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

Remove the unneded semicolon since it is clearly a typo error.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/keyboard/snvs_pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 78fd24ca3813..a4db65d67e1b 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -110,7 +110,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");;
+	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
 
 	if (!pdata->snvs) {
 		dev_err(&pdev->dev, "Can't get snvs syscon\n");
-- 
2.4.3

