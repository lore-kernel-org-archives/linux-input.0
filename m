From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/5] Input: tca8418_keypad - use dev_get_platdata() to retrieve platform data
Date: Wed, 14 Nov 2012 08:48:05 -0800
Message-ID: <1352911688-5001-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45862 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423066Ab2KNQsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 11:48:13 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so488529pbc.19
        for <linux-input@vger.kernel.org>; Wed, 14 Nov 2012 08:48:13 -0800 (PST)
In-Reply-To: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

We need to use proper accessor functions instead of directly poking into
various structures.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 4618ce0..7f2869f 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -283,7 +283,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	const struct tca8418_keypad_platform_data *pdata =
-						client->dev.platform_data;
+						dev_get_platdata(dev);
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
 	const struct matrix_keymap_data *keymap_data = NULL;
-- 
1.7.11.7

