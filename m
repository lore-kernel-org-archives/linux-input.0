From: "jeffrey.lin" <yajohn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] driver: input :touchscreen : Fix calibration area lost as firmware update
Date: Mon, 22 May 2017 17:44:15 +0800
Message-ID: <20170522094415.15018-1-jeffrey.lin@raydium.corp-partner.google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Katherine.Hsieh-nXwZKfITCkNWk0Htik3J/w@public.gmane.org
Cc: jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, ealin.chiu-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, calvin.tseng-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, gorden.chang-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, KP.li-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, albert.shieh-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Touch calibration file will be lost as touch firmware version different from in device when doing firmware update Preious raydium_i2c touch driver. So this modification only select specific flash
partition for firmware update to make sure all the function properly.

Signed-off-by: jeffrey.lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 34 ++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index a99fb5cac5a0..3aa40cfa2334 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -441,21 +441,41 @@ static int raydium_i2c_write_object(struct i2c_client *client,
 	return 0;
 }
 
+static int raydium_i2c_flash_select(struct i2c_client *client)
+{
+	static const u8 cmd[2][2] = {
+		{ 0x06, 0x01 },
+		{ 0x02, 0xA1 },
+	};
+	int i;
+	int error;
+
+	for (i = 0; i < 2; i++) {
+		error = raydium_i2c_write_object(client, cmd[i], sizeof(cmd[i]),
+						 RAYDIUM_WAIT_READY);
+		if (error) {
+			dev_err(&client->dev,
+				"flash select failed at step %d: %d\n", i, error);
+			return error;
+		}
+	}
+
+	return 0;
+}
+
 static bool raydium_i2c_boot_trigger(struct i2c_client *client)
 {
-	static const u8 cmd[7][6] = {
+	static const u8 cmd[5][6] = {
 		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7 },
 		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
 		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0x00 },
 		{ 0x08, 0x04, 0x09, 0x00, 0x50, 0xA5 },
 		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0x00 },
-		{ 0x06, 0x01, 0x00, 0x00, 0x00, 0x00 },
-		{ 0x02, 0xA2, 0x00, 0x00, 0x00, 0x00 },
 	};
 	int i;
 	int error;
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < 5; i++) {
 		error = raydium_i2c_write_object(client, cmd[i], sizeof(cmd[i]),
 						 RAYDIUM_WAIT_READY);
 		if (error) {
@@ -689,6 +709,12 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
 		return error;
 	}
 
+	error = raydium_i2c_flash_select(client);
+	if (error) {
+		dev_err(&client->dev, "send flash select fail: %d\n", error);
+		return error;
+	}
+
 	msleep(RM_BOOT_DELAY_MS);
 
 	data = fw->data;
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
