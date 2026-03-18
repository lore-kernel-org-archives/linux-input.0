Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C7354AC0
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834105; cv=none; b=sUGO/6VIxLgMoTVs/5ZY6AGF9kB9PsktbAXlcUsKnT2BUxlc4J0TUrTM64S4F5F2vY+Af4xb577sFjMxEyl8sAEh8LmbeTSXj6o87CrgvLRbwDJ9TbmPo+jsc9I9YVXyjTJkr6Fuz8+BSBLikZufT5gNmu53IAIKCuLDDuHrYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834105; c=relaxed/simple;
	bh=OHQuX5jVCQIsjbHWnUma6RUYHirPgps/1y+6hev3DQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EteiGDbLV4OTOWVa609ugRvCKogrUJp2X5d41zs8E/xTuFpPOaIQSoZWk7J+jqzEs7+bJQNKvkhjhv5rit4xpMqFvHzn3Ny1hIEY4DB8qT3aC1kX96gDJEGyJ+tdsbF96M8X9weQHcHrFv5lfDdpQQRIbHVQDL+rTsNMW7n/I2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1w2pHR-0001h8-Oj; Wed, 18 Mar 2026 12:41:41 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Wed, 18 Mar 2026 12:41:30 +0100
Subject: [PATCH v2 1/2] Input: st1232 - read firmware version and revision
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-input-st1232-firmware-version-v2-1-e844ee340d36@pengutronix.de>
References: <20260318-input-st1232-firmware-version-v2-0-e844ee340d36@pengutronix.de>
In-Reply-To: <20260318-input-st1232-firmware-version-v2-0-e844ee340d36@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Khalid Talash <ktalash@topcon.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

According to the data sheet, the st1332 contains a firmware, which may
be updated. The version and revision of the firmware may be read from
the registers of the device.

Read the firmware version and revision and report it to the log when
probing the device.

Suggested-by: Khalid Talash <ktalash@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

---
Changes in v2:
- replace get_unaligned_le32() by le32_to_cpup
---
 drivers/input/touchscreen/st1232.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 9b3901eec0a5..cc72d70642b2 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -10,6 +10,7 @@
  *	Copyright (C) 2007 Google, Inc.
  */
 
+#include <asm/byteorder.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -27,6 +28,9 @@
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
 
+#define REG_FIRMWARE_VERSION	0x00
+#define REG_FIRMWARE_REVISION_3	0x0C
+
 #define REG_STATUS		0x01	/* Device Status | Error Code */
 
 #define STATUS_NORMAL		0x00
@@ -61,6 +65,8 @@ struct st1232_ts_data {
 	struct list_head touch_overlay_list;
 	int read_buf_len;
 	u8 *read_buf;
+	u8 fw_version;
+	u32 fw_revision;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts, u8 reg,
@@ -110,6 +116,26 @@ static int st1232_ts_wait_ready(struct st1232_ts_data *ts)
 	return -ENXIO;
 }
 
+static int st1232_ts_read_fw_version(struct st1232_ts_data *ts,
+				     u8 *fw_version, u32 *fw_revision)
+{
+	int error;
+
+	/* select firmware version register */
+	error = st1232_ts_read_data(ts, REG_FIRMWARE_VERSION, 1);
+	if (error)
+		return error;
+	*fw_version = ts->read_buf[0];
+
+	/* select firmware revision register */
+	error = st1232_ts_read_data(ts, REG_FIRMWARE_REVISION_3, 4);
+	if (error)
+		return error;
+	*fw_revision = le32_to_cpup((__le32 *)ts->read_buf);
+
+	return 0;
+}
+
 static int st1232_ts_read_resolution(struct st1232_ts_data *ts, u16 *max_x,
 				     u16 *max_y)
 {
@@ -299,6 +325,17 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
+	/* Read firmware version from the chip */
+	error = st1232_ts_read_fw_version(ts,
+					  &ts->fw_version, &ts->fw_revision);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to read firmware version: %d\n", error);
+		return error;
+	}
+	dev_dbg(&client->dev, "Detected firmware version %u, rev %08x\n",
+		ts->fw_version, ts->fw_revision);
+
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);

-- 
2.47.3

