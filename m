From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/4] Input: goodix - Restructure cfg checksum function
Date: Thu, 20 Oct 2016 14:59:14 -0500
Message-ID: <20161020195917.20051-2-fcooper@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020195917.20051-1-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, hadess@hadess.net, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-input@vger.kernel.org

Split generation of checksum into is own function. Currently it is used
only to determine if the checksum for the user provided configuration file
is valid or not. However, support to dynamically alter the configuration
file will be supported and needs a way to calculate the updated file's
checksum. Therefore, by splitting calculating checksum into its own
function the code can be reused.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/input/touchscreen/goodix.c | 42 +++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index e9d50bc..a43c8ca 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -305,35 +305,45 @@ static int goodix_request_irq(struct goodix_ts_data *ts)
 					 ts->irq_flags, ts->client->name, ts);
 }
 
+static int goodix_calculate_checksum(size_t size, const u8 *data)
+{
+	int i, raw_cfg_len;
+	u8 check_sum = 0;
+
+	raw_cfg_len = size - 2;
+	for (i = 0; i < raw_cfg_len; i++)
+		check_sum += data[i];
+	check_sum = (~check_sum) + 1;
+
+	return check_sum;
+}
 /**
  * goodix_check_cfg - Checks if config fw is valid
  *
  * @ts: goodix_ts_data pointer
  * @cfg: firmware config data
  */
-static int goodix_check_cfg(struct goodix_ts_data *ts,
-			    const struct firmware *cfg)
+static int goodix_check_cfg(struct goodix_ts_data *ts, size_t size,
+			    const u8 *data)
 {
-	int i, raw_cfg_len;
+	int raw_cfg_len;
 	u8 check_sum = 0;
 
-	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
+	if (size > GOODIX_CONFIG_MAX_LENGTH) {
 		dev_err(&ts->client->dev,
 			"The length of the config fw is not correct");
 		return -EINVAL;
 	}
 
-	raw_cfg_len = cfg->size - 2;
-	for (i = 0; i < raw_cfg_len; i++)
-		check_sum += cfg->data[i];
-	check_sum = (~check_sum) + 1;
-	if (check_sum != cfg->data[raw_cfg_len]) {
+	raw_cfg_len = size - 2;
+	check_sum = goodix_calculate_checksum(size, data);
+	if (check_sum != data[raw_cfg_len]) {
 		dev_err(&ts->client->dev,
 			"The checksum of the config fw is not correct");
 		return -EINVAL;
 	}
 
-	if (cfg->data[raw_cfg_len + 1] != 1) {
+	if (data[raw_cfg_len + 1] != 1) {
 		dev_err(&ts->client->dev,
 			"Config fw must have Config_Fresh register set");
 		return -EINVAL;
@@ -348,17 +358,17 @@ static int goodix_check_cfg(struct goodix_ts_data *ts,
  * @ts: goodix_ts_data pointer
  * @cfg: config firmware to write to device
  */
-static int goodix_send_cfg(struct goodix_ts_data *ts,
-			   const struct firmware *cfg)
+static int goodix_send_cfg(struct goodix_ts_data *ts, size_t size,
+			   const u8 *data)
 {
 	int error;
 
-	error = goodix_check_cfg(ts, cfg);
+	error = goodix_check_cfg(ts, size, data);
 	if (error)
 		return error;
 
-	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
-				 cfg->size);
+	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, data,
+				 size);
 	if (error) {
 		dev_err(&ts->client->dev, "Failed to write config data: %d",
 			error);
@@ -670,7 +680,7 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 
 	if (cfg) {
 		/* send device configuration to the firmware */
-		error = goodix_send_cfg(ts, cfg);
+		error = goodix_send_cfg(ts, cfg->size, cfg->data);
 		if (error)
 			goto err_release_cfg;
 	}
-- 
2.10.0
