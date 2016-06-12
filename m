From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: gpio-keys - use devm_add_action_or_reset
Date: Sun, 12 Jun 2016 15:28:56 +0100
Message-ID: <1465741736-5166-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33491 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbcFLO3K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2016 10:29:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

If devm_add_action() fails we are printing the error message and
returning but we have already setup a delayed work or a timer.
Lets now use the helper devm_add_action_or_reset() and return and in
case of error the cleanup function will be called by the helper to
cancel the delayed work or to delete the timer.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/input/keyboard/gpio_keys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2909365..2b1d2e9 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
 	 */
-	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
+	error = devm_add_action_or_reset(&pdev->dev,
+					 gpio_keys_quiesce_key, bdata);
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to register quiesce action, error: %d\n",
-- 
1.9.1

