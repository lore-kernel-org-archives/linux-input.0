From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 48/63] input: atmel_mxt_ts: move bootloader probe from mxt_initialize()
Date: Fri, 16 Aug 2019 17:37:09 +0900
Message-ID: <20190816083724.19341-4-jiada_wang@mentor.com>
References: <20190816083724.19341-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083724.19341-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

Validity of bootloader address is now checked before checking the
bootloader status so mxt_lookup_bootloader_address() was moved
from mxt_probe_bootloader() to mxt_initialize().
Above changes added lot of bootloader mode verification code into
mxt_initialize() which made this function longer and unreadable.
mxt_bootloader_status() moves bootloader mode verification code from
mxt_initialize() to make it cleaner.

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 45 +++++++++++++++---------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dec9f2b2c64d..27b908a50b66 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2917,6 +2917,32 @@ static void mxt_config_cb(const struct firmware *cfg, void *ctx)
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
@@ -2932,24 +2958,9 @@ static int mxt_initialize(struct mxt_data *data)
 			 "info block read failed (%d), so try bootloader method\n",
 			 error);
 
-		error = mxt_lookup_bootloader_address(data, false);
-		if (error) {
-			dev_info(&client->dev,
-				 "Bootloader address is not specified\n");
+		error = mxt_bootloader_status(data);
+		if (error)
 			return error;
-		}
-		/* Check bootloader state */
-		error = mxt_probe_bootloader(data);
-		if (error) {
-			dev_info(&client->dev, "Trying alternate bootloader address\n");
-			mxt_lookup_bootloader_address(data, true);
-			error = mxt_probe_bootloader(data);
-			if (error) {
-				dev_err(&client->dev,
-					"Chip is not in appmode or bootloader mode\n");
-				return error;
-			}
-		}
 
 		/* OK, we are in bootloader, see if we can recover */
 		if (++recovery_attempts > 1) {
-- 
2.19.2
