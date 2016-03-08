From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] input: snvs_pwrkey: fix returned value check of syscon_regmap_lookup_by_phandle()
Date: Tue,  8 Mar 2016 18:51:04 +0200
Message-ID: <1457455864-32077-1-git-send-email-vz@mleia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:47972 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933275AbcCHQvI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2016 11:51:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org

On error syscon_regmap_lookup_by_phandle() returns ERR_PTR() value,
which makes a check for NULL invalid and may lead to oops on error
path.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 9adf13a..9e92206 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -111,9 +111,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->snvs = syscon_regmap_lookup_by_phandle(np, "regmap");
-	if (!pdata->snvs) {
+	if (IS_ERR(pdata->snvs)) {
 		dev_err(&pdev->dev, "Can't get snvs syscon\n");
-		return -ENODEV;
+		return PTR_ERR(pdata->snvs);
 	}
 
 	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
-- 
2.1.4

