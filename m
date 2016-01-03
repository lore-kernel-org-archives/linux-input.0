From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] input: gpio_keys: Fix check for disabling unsupported key
Date: Sun,  3 Jan 2016 23:21:16 +0200
Message-ID: <1451856076-29045-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35970 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbcACVVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jan 2016 16:21:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: pali.rohar@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Commit 4ea14a53d8f881034fa9e186653821c4e3d9a8fb ("Input: gpio-keys -
report error when disabling unsupported key") tried to prevent an
unsupported key to disabled. Unfortunately it effectively broke the driver
in a way so no key is possible to be disabled. Fix that by providing the
correct verify logic.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bef317f..a371805 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -226,22 +226,32 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 		goto out;
 
 	/* First validate */
-	for (i = 0; i < ddata->pdata->nbuttons; i++) {
-		struct gpio_button_data *bdata = &ddata->data[i];
+	for (i = 0; i < n_events; i++) {
+		int j;
 
-		if (bdata->button->type != type)
+		if (!test_bit(i, bits))
 			continue;
 
-		if (test_bit(bdata->button->code, bits) &&
-		    !bdata->button->can_disable) {
+		for (j = 0; j < ddata->pdata->nbuttons; j++) {
+			struct gpio_button_data *bdata = &ddata->data[j];
+
+			if (bdata->button->type != type)
+				continue;
+
+			if (bdata->button->code == i) {
+				if (!bdata->button->can_disable) {
+					error = -EINVAL;
+					goto out;
+				}
+				break;
+			}
+		}
+
+		if (j == ddata->pdata->nbuttons) {
 			error = -EINVAL;
 			goto out;
 		}
-	}
 
-	if (i == ddata->pdata->nbuttons) {
-		error = -EINVAL;
-		goto out;
 	}
 
 	mutex_lock(&ddata->disable_lock);
-- 
1.9.1

