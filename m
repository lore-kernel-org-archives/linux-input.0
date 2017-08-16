From: Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH] auxdisplay: ht16k33: Use generic device properties function
Date: Wed, 16 Aug 2017 12:22:48 +0200
Message-ID: <20170816102248.25498-1-robin@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5048 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPKpz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Aug 2017 06:45:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>

matrix_keypad_parse_of_params() was replaced early this year.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---

Early this year Dmitry Torokhov introduced a switch to using generic
device properties instead of being OF-specific.

Somehow this driver wasn't included in the update.

For reference: https://patchwork.kernel.org/patch/9527095/

 drivers/auxdisplay/ht16k33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index fbfa5b4cc567..99ce9731fc9c 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -354,7 +354,7 @@ static int ht16k33_keypad_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = matrix_keypad_parse_of_params(&client->dev, &rows, &cols);
+	err = matrix_keypad_parse_properties(&client->dev, &rows, &cols);
 	if (err)
 		return err;
 	if (rows > HT16K33_MATRIX_KEYPAD_MAX_ROWS ||
-- 
2.11.0

