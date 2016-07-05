From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] GPIO_KEYS: If devm_add_action() fails, we are explicitly calling the cleanup to freethe resources allocated. Use the helper devm_add_action_or_reset() and return directly in case of error, since the cleanup function has been already called by the helper if there was any error.
Date: Tue,  5 Jul 2016 21:48:20 +0530
Message-ID: <1467735500-5033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 51.16-broadband.acttv.in ([106.51.16.38]:9284 "EHLO
	arvind-ThinkPad-Edge-E431" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752524AbcGEQ2h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 12:28:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: ldewangan@nvidia.com, linus.walleij@linaro.org, van.freenix@gmail.com, bjorn.andersson@sonymobile.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2909365..a2fa3bb 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
 	 */
-	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
+	error = devm_add_action_or_reset(&pdev->dev, gpio_keys_quiesce_key,
+					bdata);
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to register quiesce action, error: %d\n",
-- 
1.9.1

