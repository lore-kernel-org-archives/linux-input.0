From: Charlie Mooney <charliemooney@chromium.org>
Subject: [PATCH] Input: elants_i2c: Append hw_version to FW file
Date: Tue, 10 Mar 2015 12:57:03 -0700
Message-ID: <1426017423-26249-1-git-send-email-charliemooney@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33853 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbbCJT5Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 15:57:16 -0400
Received: by iecsl2 with SMTP id sl2so28350286iec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2015 12:57:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, scott.liu@emc.com.tw, fabf@skynet.be, Charlie Mooney <charliemooney@chromium.org>

Currently the elants_i2c driver simply requests a static filename
/lib/firmware/elants_i2c.bin when it gets firmware updates.  This is
a problem if you have two Elan touchscreens using the same driver.
If both touchscreens have different firmwares, you would need to move
the files around in your filesystem when you're updating them so that
they don't get updated with the other's FW.  If you have a read-only
filesystem then this is impossible, even.

This patch changes the elants_i2c driver to automatically append the
four-hex-digit hw_version of the device onto the name of the FW file
it's requesting for update.  Since different touchscreens should have
a different hw_version's this means the user needs to append the hw
version of the touchscreen he or she intends to update onto the end
of the firmware filename and then the driver will do the rest.

The firmware filenames it looks for now are of the form:

  elants_i2c_${HW_VERSION}.bin

  eg:

  elants_i2c_2a44.bin

Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
---
 drivers/input/touchscreen/elants_i2c.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 926c58e..d34ba57 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -98,7 +98,10 @@
 #define MAX_FW_UPDATE_RETRIES	30
 
 #define ELAN_FW_PAGESIZE	132
-#define ELAN_FW_FILENAME	"elants_i2c.bin"
+#define	ELAN_FW_BASE_FILENAME	"elants_i2c"
+#define ELAN_FW_EXTENSION	"bin"
+#define ELAN_FW_FILENAME_MAX_LEN	(ARRAY_SIZE(ELAN_FW_BASE_FILENAME) + \
+					 ARRAY_SIZE(ELAN_FW_EXTENSION) + 5)
 
 /* calibration timeout definition */
 #define ELAN_CALI_TIMEOUT_MSEC	10000
@@ -697,12 +700,16 @@ static int elants_i2c_fw_update(struct elants_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	const struct firmware *fw;
+	char fw_filename_buffer[ELAN_FW_FILENAME_MAX_LEN];
 	int error;
 
-	error = request_firmware(&fw, ELAN_FW_FILENAME, &client->dev);
+	snprintf(fw_filename_buffer, ELAN_FW_FILENAME_MAX_LEN, "%s_%4x.%s",
+		 ELAN_FW_BASE_FILENAME, ts->hw_version, ELAN_FW_EXTENSION);
+	dev_info(&client->dev, "requesting fw name = %s\n", fw_filename_buffer);
+	error = request_firmware(&p_fw_entry, fw_filename_buffer, &client->dev);
 	if (error) {
 		dev_err(&client->dev, "failed to request firmware %s: %d\n",
-			ELAN_FW_FILENAME, error);
+			fw_filename_buffer, error);
 		return error;
 	}
 
-- 
2.1.2

