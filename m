From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 40/49] Input: Atmel: improve error handling in mxt_initialize()
Date: Tue, 17 Sep 2019 18:42:16 +0900
Message-ID: <20190917094225.18927-2-jiada_wang@mentor.com>
References: <20190917094225.18927-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917094225.18927-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-input@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

Currently mxt_initialize() tries to probe bootloader mode
even if valid bootloader address is not specified.

This commit modifies mxt_initialize() to return error
if Device is not in appmode and bootloader address is
not specified.

This commit also returns error code from mxt_send_bootloader_cmd()
in mxt_initialize().

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 58 +++++++++++++++++-------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2fac43da0a2b..b260ac155b5e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -716,17 +716,13 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data, bool retry)
 	return 0;
 }
 
-static int mxt_probe_bootloader(struct mxt_data *data, bool alt_address)
+static int mxt_probe_bootloader(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
 	int error;
 	u8 buf[3];
 	bool crc_failure, extended_id;
 
-	error = mxt_lookup_bootloader_address(data, alt_address);
-	if (error)
-		return error;
-
 	/* Check bootloader status and version information */
 	error = mxt_bootloader_read(data, buf, sizeof(buf));
 	if (error)
@@ -2923,6 +2919,32 @@ static void mxt_config_cb(const struct firmware *cfg, void *ctx)
 	release_firmware(cfg);
 }
 
+static int mxt_bootloader_status(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+	int error;
+
+	error = mxt_lookup_bootloader_address(data, false);
+	if (error) {
+		dev_info(&client->dev,
+			 "Bootloader address is not specified\n");
+		return error;
+	}
+	/* Check bootloader state */
+	error = mxt_probe_bootloader(data);
+	if (error) {
+		dev_info(&client->dev, "Trying alternate bootloader address\n");
+		mxt_lookup_bootloader_address(data, true);
+		error = mxt_probe_bootloader(data);
+		if (error) {
+			dev_err(&client->dev,
+				"Chip is not in appmode or bootloader mode\n");
+			return error;
+		}
+	}
+	return 0;
+}
+
 static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
@@ -2934,16 +2956,13 @@ static int mxt_initialize(struct mxt_data *data)
 		if (!error)
 			break;
 
-		/* Check bootloader state */
-		error = mxt_probe_bootloader(data, false);
-		if (error) {
-			dev_info(&client->dev, "Trying alternate bootloader address\n");
-			error = mxt_probe_bootloader(data, true);
-			if (error) {
-				/* Chip is not in appmode or bootloader mode */
-				return error;
-			}
-		}
+		dev_info(&client->dev,
+			 "info block read failed (%d), so try bootloader method\n",
+			 error);
+
+		error = mxt_bootloader_status(data);
+		if (error)
+			return error;
 
 		/* OK, we are in bootloader, see if we can recover */
 		if (++recovery_attempts > 1) {
@@ -2957,7 +2976,9 @@ static int mxt_initialize(struct mxt_data *data)
 		}
 
 		/* Attempt to exit bootloader into app mode */
-		mxt_send_bootloader_cmd(data, false);
+		error = mxt_send_bootloader_cmd(data, false);
+		if (error)
+			return error;
 		msleep(MXT_FW_RESET_TIME);
 	}
 
@@ -3649,8 +3670,11 @@ static int mxt_enter_bootloader(struct mxt_data *data)
 
 		msleep(MXT_RESET_TIME);
 
+		ret = mxt_lookup_bootloader_address(data, false);
+		if (ret)
+			return ret;
 		/* Do not need to scan since we know family ID */
-		ret = mxt_probe_bootloader(data, 0);
+		ret = mxt_probe_bootloader(data);
 		if (ret)
 			return ret;
 
-- 
2.19.2
