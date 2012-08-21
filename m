From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/2] input: samsung-keypad: Use of_get_child_count() helper
Date: Tue, 21 Aug 2012 12:42:13 +0200
Message-ID: <1345545733-27503-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:44577 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756716Ab2HUKuJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Aug 2012 06:50:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Use of_get_child_count() instead of custom implementation.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/keyboard/samsung-keypad.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index e2f31c8..277e26d 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -256,7 +256,7 @@ static struct samsung_keypad_platdata *samsung_keypad_parse_dt(
 	struct matrix_keymap_data *keymap_data;
 	uint32_t *keymap, num_rows = 0, num_cols = 0;
 	struct device_node *np = dev->of_node, *key_np;
-	unsigned int key_count = 0;
+	unsigned int key_count;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
@@ -280,9 +280,7 @@ static struct samsung_keypad_platdata *samsung_keypad_parse_dt(
 	}
 	pdata->keymap_data = keymap_data;
 
-	for_each_child_of_node(np, key_np)
-		key_count++;
-
+	key_count = of_get_child_count(np);
 	keymap_data->keymap_size = key_count;
 	keymap = devm_kzalloc(dev, sizeof(uint32_t) * key_count, GFP_KERNEL);
 	if (!keymap) {
-- 
1.7.5.4

