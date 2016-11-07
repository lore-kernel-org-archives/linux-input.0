From: <hn.chen@weidahitech.com>
Subject: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's issue
Date: Mon, 7 Nov 2016 18:38:58 +0800
Message-ID: <1478515138-1922-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2962 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbcKGKm3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2016 05:42:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, HungNien Chen <hn.chen@weidahitech.com>

From: HungNien Chen <hn.chen@weidahitech.com>

Just modify the set_power function to send the command twice.
It should be ok for other contorllers since it will jump out the loop after
the first command send out. If this is not a proper modification,
please tell me a proper way to fix this kind of issue.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2..d7423d9 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -49,6 +49,8 @@
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
 
+#define	SET_PWR_RETRIES		2
+
 /* debug option */
 static bool debug;
 module_param(debug, bool, 0444);
@@ -343,14 +345,26 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
+	int retry;
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
-	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
-		0, NULL, 0, NULL, 0);
-	if (ret)
-		dev_err(&client->dev, "failed to change power setting.\n");
+       /*
+	* Some Weida's controllers require Set_Power twice on resume.
+	* The 1st cmd wakeup the controller and the 2nd cmd will be executed.
+	* It should be safe to controllers of other vendors.
+	*/
+	for (retry = 0; retry < SET_PWR_RETRIES; retry++) {
+		ret = __i2c_hid_command(client, &hid_set_power_cmd,
+			power_state, 0, NULL, 0, NULL, 0);
+
+		if (!ret)
+			goto set_power_exit;
+	}
+
+	dev_err(&client->dev, "failed to change power setting.\n");
 
+set_power_exit:
 	return ret;
 }
 
-- 
1.9.1

