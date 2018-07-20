From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 07/10] Input: atmel_mxt_ts - zero terminate config firmware file
Date: Fri, 20 Jul 2018 22:51:19 +0100
Message-ID: <20180720215122.23558-7-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

We use sscanf to parse the configuration file, so it's necessary to zero
terminate the configuration otherwise a truncated file can cause the
parser to run off into uninitialised memory.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 36 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0ce126e918f1..2d1fddafb7f9 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -279,7 +279,7 @@ enum mxt_suspend_mode {
 
 /* Config update context */
 struct mxt_cfg {
-	const u8 *raw;
+	u8 *raw;
 	size_t raw_size;
 	off_t raw_pos;
 
@@ -1451,14 +1451,21 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	u32 info_crc, config_crc, calculated_crc;
 	u16 crc_start = 0;
 
-	cfg.raw = fw->data;
+	/* Make zero terminated copy of the OBP_RAW file */
+	cfg.raw = kzalloc(fw->size + 1, GFP_KERNEL);
+	if (!cfg.raw)
+		return -ENOMEM;
+
+	memcpy(cfg.raw, fw->data, fw->size);
+	cfg.raw[fw->size] = '\0';
 	cfg.raw_size = fw->size;
 
 	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
 
 	if (strncmp(cfg.raw, MXT_CFG_MAGIC, strlen(MXT_CFG_MAGIC))) {
 		dev_err(dev, "Unrecognised config file\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	cfg.raw_pos = strlen(MXT_CFG_MAGIC);
@@ -1470,7 +1477,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 			     &offset);
 		if (ret != 1) {
 			dev_err(dev, "Bad format\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto release_raw;
 		}
 
 		cfg.raw_pos += offset;
@@ -1478,26 +1486,30 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 
 	if (cfg.info.family_id != data->info->family_id) {
 		dev_err(dev, "Family ID mismatch!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	if (cfg.info.variant_id != data->info->variant_id) {
 		dev_err(dev, "Variant ID mismatch!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	/* Read CRCs */
 	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &info_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Info CRC\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 	cfg.raw_pos += offset;
 
 	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &config_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Config CRC\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 	cfg.raw_pos += offset;
 
@@ -1530,8 +1542,10 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 			MXT_INFO_CHECKSUM_SIZE;
 	cfg.mem_size = data->mem_size - cfg.start_ofs;
 	cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);
-	if (!cfg.mem)
-		return -ENOMEM;
+	if (!cfg.mem) {
+		ret = -ENOMEM;
+		goto release_raw;
+	}
 
 	ret = mxt_prepare_cfg_mem(data, &cfg);
 	if (ret)
@@ -1570,6 +1584,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	/* T7 config may have changed */
 	mxt_init_t7_power_cfg(data);
 
+release_raw:
+	kfree(cfg.raw);
 release_mem:
 	kfree(cfg.mem);
 	return ret;
-- 
2.17.1
