From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: axp20x-pek: use devm_add_action_or_reset
Date: Sun, 12 Jun 2016 15:12:30 +0100
Message-ID: <1465740750-4881-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34849 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbcFLOMo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2016 10:12:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

If devm_add_action() fails we are explicitly calling
axp20x_remove_sysfs_group() to free the resources allocated. Lets use
the helper devm_add_action_or_reset() and return directly in case of
error, as we know that the cleanup function has been already called by
the helper if there was any error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/input/misc/axp20x-pek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 1ac898d..419ca97 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -260,10 +260,10 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = devm_add_action(&pdev->dev,
-				axp20x_remove_sysfs_group, &pdev->dev);
+	error = devm_add_action_or_reset(&pdev->dev,
+					 axp20x_remove_sysfs_group,
+					 &pdev->dev);
 	if (error) {
-		axp20x_remove_sysfs_group(&pdev->dev);
 		dev_err(&pdev->dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
-- 
1.9.1

