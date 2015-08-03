From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 6/9] Input: atmel_mxt_ts - improve device tree parsing
Date: Mon,  3 Aug 2015 16:23:14 +0100
Message-ID: <1438615397-17112-7-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:27427 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754244AbbHCPct (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:49 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Use function rather than loop, define np to reduce wrapping.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b83e8a0..7c14faa 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2420,19 +2420,18 @@ static void mxt_input_close(struct input_dev *dev)
 static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 {
 	struct mxt_platform_data *pdata;
+	struct device_node *np = client->dev.of_node;
 	u32 *keymap;
-	u32 keycode;
-	int proplen, i, ret;
+	int proplen, ret;
 
-	if (!client->dev.of_node)
+	if (!np)
 		return ERR_PTR(-ENOENT);
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_find_property(client->dev.of_node, "linux,gpio-keymap",
-			     &proplen)) {
+	if (of_find_property(np, "linux,gpio-keymap", &proplen)) {
 		pdata->t19_num_keys = proplen / sizeof(u32);
 
 		keymap = devm_kzalloc(&client->dev,
@@ -2441,20 +2440,16 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 		if (!keymap)
 			return ERR_PTR(-ENOMEM);
 
-		for (i = 0; i < pdata->t19_num_keys; i++) {
-			ret = of_property_read_u32_index(client->dev.of_node,
-					"linux,gpio-keymap", i, &keycode);
-			if (ret)
-				keycode = KEY_RESERVED;
-
-			keymap[i] = keycode;
-		}
+		ret = of_property_read_u32_array(np, "linux,gpio-keymap",
+						 keymap, pdata->t19_num_keys);
+		if (ret)
+			dev_warn(&client->dev,
+				"Couldn't read linux,gpio-keymap: %d\n", ret);
 
 		pdata->t19_keymap = keymap;
 	}
 
-	of_property_read_u32(client->dev.of_node, "atmel,suspend-mode",
-			     &pdata->suspend_mode);
+	of_property_read_u32(np, "atmel,suspend-mode", &pdata->suspend_mode);
 
 	return pdata;
 }
-- 
2.4.6

