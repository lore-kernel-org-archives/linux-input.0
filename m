From: simon.budig@kernelconcepts.de
Subject: [PATCH 1/3] edt-ft5x06: fix reset pin behaviour
Date: Thu,  5 Oct 2017 17:19:47 +0200
Message-ID: <20171005151947.31694-1-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:35639 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdJEPaw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 11:30:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Simon Budig <simon.budig@kernelconcepts.de>

From: Simon Budig <simon.budig@kernelconcepts.de>

For some reason the reset pin no longer gets toggeled when initializing
the touch. Fix that and restore the old behaviour.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5bf63f7..867a61e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -936,8 +936,12 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	if (tsdata->reset_gpio) {
 		usleep_range(5000, 6000);
-		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+		/* note that the reset pin needs to be registered as
+		 * active low in the devicetree.
+		 */
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
 		msleep(300);
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
 	}
 
 	input = devm_input_allocate_device(&client->dev);
-- 
2.1.4


>From a59aedc01ee3372a45a2028532ca41503d995b40 Mon Sep 17 00:00:00 2001
From: Simon Budig <simon.budig@kernelconcepts.de>
Date: Mon, 30 Nov 2015 15:34:09 +0100
Subject: [PATCH 2/3] input: edt-ft5x06: make distinction between
 m06/m09/generic more clear

Since the driver also is useful for some non-EDT touchscreens based on
the focaltec chips introduce the concept of a "generic" focaltec based
touch.

Use a better heuristics for model detection and be more specific in the
source.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 122 +++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 29 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 867a61e..d128445 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -70,8 +70,9 @@
 #define EDT_RAW_DATA_DELAY		1000 /* usec */
 
 enum edt_ver {
-	M06,
-	M09,
+	EDT_M06,
+	EDT_M09,
+	GENERIC_FT,
 };
 
 struct edt_reg_addr {
@@ -179,14 +180,15 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	int error;
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		cmd = 0xf9; /* tell the controller to send touch data */
 		offset = 5; /* where the actual touch data starts */
 		tplen = 4;  /* data comes in so called frames */
 		crclen = 1; /* length of the crc data */
 		break;
 
-	case M09:
+	case EDT_M09:
+	case GENERIC_FT:
 		cmd = 0x0;
 		offset = 3;
 		tplen = 6;
@@ -210,7 +212,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	}
 
 	/* M09 does not send header or CRC */
-	if (tsdata->version == M06) {
+	if (tsdata->version == EDT_M06) {
 		if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa ||
 			rdbuf[2] != datalen) {
 			dev_err_ratelimited(dev,
@@ -233,7 +235,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 			continue;
 
 		/* M06 sometimes sends bogus coordinates in TOUCH_DOWN */
-		if (tsdata->version == M06 && type == TOUCH_EVENT_DOWN)
+		if (tsdata->version == EDT_M06 && type == TOUCH_EVENT_DOWN)
 			continue;
 
 		x = ((buf[0] << 8) | buf[1]) & 0x0fff;
@@ -264,14 +266,15 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 	u8 wrbuf[4];
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
 		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
 		wrbuf[2] = value;
 		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
 		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
 					wrbuf, 0, NULL);
-	case M09:
+	case EDT_M09:
+	case GENERIC_FT:
 		wrbuf[0] = addr;
 		wrbuf[1] = value;
 
@@ -290,7 +293,7 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 	int error;
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
 		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
 		wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
@@ -309,7 +312,8 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 		}
 		break;
 
-	case M09:
+	case EDT_M09:
+	case GENERIC_FT:
 		wrbuf[0] = addr;
 		error = edt_ft5x06_ts_readwrite(tsdata->client, 1,
 						wrbuf, 1, rdbuf);
@@ -368,11 +372,12 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 	}
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		addr = attr->addr_m06;
 		break;
 
-	case M09:
+	case EDT_M09:
+	case GENERIC_FT:
 		addr = attr->addr_m09;
 		break;
 
@@ -437,11 +442,12 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 	}
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		addr = attr->addr_m06;
 		break;
 
-	case M09:
+	case EDT_M09:
+	case GENERIC_FT:
 		addr = attr->addr_m09;
 		break;
 
@@ -508,7 +514,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	}
 
 	/* mode register is 0x3c when in the work mode */
-	if (tsdata->version == M09)
+	if (tsdata->version != EDT_M06)
 		goto m09_out;
 
 	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
@@ -545,7 +551,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	return error;
 
 m09_out:
-	dev_err(&client->dev, "No factory mode support for M09\n");
+	dev_err(&client->dev, "No factory mode support for M09/GENERIC_FT\n");
 	return -EINVAL;
 
 }
@@ -779,7 +785,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	 * at least M09 won't send 3 bytes here
 	 */
 	if (!(strncasecmp(rdbuf + 1, "EP0", 3))) {
-		tsdata->version = M06;
+		tsdata->version = EDT_M06;
 
 		/* remove last '$' end marker */
 		rdbuf[EDT_NAME_LEN - 1] = '\0';
@@ -793,8 +799,16 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
 		strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
 	} else {
-		/* since there are only two versions around (M06, M09) */
-		tsdata->version = M09;
+		/* if it is not an EDT M06 touchscreen then the model
+		 * detection is a bit hairy. The different ft5x06
+		 * firmares around don't reliably implement the
+		 * identification registers. Well. we'll take a shot.
+		 *
+		 * the main difference between generic focaltec based
+		 * touches and EDT M09 is, that we know how to retrieve
+		 * the max coordinates for the latter
+		 */
+		tsdata->version = GENERIC_FT;
 
 		error = edt_ft5x06_ts_readwrite(client, 1, "\xA6",
 						2, rdbuf);
@@ -808,8 +822,34 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		if (error)
 			return error;
 
-		snprintf(model_name, EDT_NAME_LEN, "EP0%i%i0M09",
-			rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+		/* this "model identification is not exact. Unfortunately
+		 * not all firmwares for the ft5x06 put useful values in
+		 * the identification registers
+		 */
+		switch (rdbuf[0]) {
+		case 0x35:   /* EDT EP0350M09 */
+		case 0x43:   /* EDT EP0430M09 */
+		case 0x50:   /* EDT EP0500M09 */
+		case 0x57:   /* EDT EP0570M09 */
+		case 0x70:   /* EDT EP0700M09 */
+			tsdata->version = EDT_M09;
+			snprintf(model_name, EDT_NAME_LEN, "EP0%i%i0M09",
+				rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+			break;
+		case 0xa1:   /* EDT EP1010ML00 */
+			tsdata->version = EDT_M09;
+			snprintf(model_name, EDT_NAME_LEN, "EP%i%i0ML00",
+				rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+			break;
+		case 0x5a:   /* Solomon Goldentek Display */
+			snprintf(model_name, EDT_NAME_LEN, "GKTW50SCED1R0");
+			break;
+		default:
+			snprintf(model_name, EDT_NAME_LEN,
+				 "generic ft5x06 (%02x)",
+				 rdbuf[0]);
+			break;
+		}
 	}
 
 	return 0;
@@ -853,8 +893,16 @@ edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 	if (reg_addr->reg_report_rate != NO_REGISTER)
 		tsdata->report_rate = edt_ft5x06_register_read(tsdata,
 						reg_addr->reg_report_rate);
-	tsdata->num_x = edt_ft5x06_register_read(tsdata, reg_addr->reg_num_x);
-	tsdata->num_y = edt_ft5x06_register_read(tsdata, reg_addr->reg_num_y);
+	if (tsdata->version == EDT_M06 ||
+	    tsdata->version == EDT_M09) {
+		tsdata->num_x = edt_ft5x06_register_read(tsdata,
+							 reg_addr->reg_num_x);
+		tsdata->num_y = edt_ft5x06_register_read(tsdata,
+							 reg_addr->reg_num_y);
+	} else {
+		tsdata->num_x = -1;
+		tsdata->num_y = -1;
+	}
 }
 
 static void
@@ -863,7 +911,7 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
 
 	switch (tsdata->version) {
-	case M06:
+	case EDT_M06:
 		reg_addr->reg_threshold = WORK_REGISTER_THRESHOLD;
 		reg_addr->reg_report_rate = WORK_REGISTER_REPORT_RATE;
 		reg_addr->reg_gain = WORK_REGISTER_GAIN;
@@ -872,7 +920,7 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 		reg_addr->reg_num_y = WORK_REGISTER_NUM_Y;
 		break;
 
-	case M09:
+	case EDT_M09:
 		reg_addr->reg_threshold = M09_REGISTER_THRESHOLD;
 		reg_addr->reg_report_rate = NO_REGISTER;
 		reg_addr->reg_gain = M09_REGISTER_GAIN;
@@ -880,6 +928,13 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 		reg_addr->reg_num_x = M09_REGISTER_NUM_X;
 		reg_addr->reg_num_y = M09_REGISTER_NUM_Y;
 		break;
+
+	case GENERIC_FT:
+		/* this is guesswork */
+		reg_addr->reg_threshold = M09_REGISTER_THRESHOLD;
+		reg_addr->reg_gain = M09_REGISTER_GAIN;
+		reg_addr->reg_offset = M09_REGISTER_OFFSET;
+		break;
 	}
 }
 
@@ -973,10 +1028,19 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
-	input_set_abs_params(input, ABS_MT_POSITION_X,
-			     0, tsdata->num_x * 64 - 1, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y,
-			     0, tsdata->num_y * 64 - 1, 0, 0);
+	if (tsdata->version == EDT_M06 ||
+	    tsdata->version == EDT_M09) {
+		input_set_abs_params(input, ABS_MT_POSITION_X,
+				     0, tsdata->num_x * 64 - 1, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y,
+				     0, tsdata->num_y * 64 - 1, 0, 0);
+	} else {
+		/* unknown maximum values. Specify via devicetree */
+		input_set_abs_params(input, ABS_MT_POSITION_X,
+				     0, 65535, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y,
+				     0, 65535, 0, 0);
+	}
 
 	touchscreen_parse_properties(input, true, &tsdata->prop);
 
-- 
2.1.4


>From b7782aea189ab1c63ec5102a39d9150d3e261f47 Mon Sep 17 00:00:00 2001
From: Simon Budig <simon.budig@kernelconcepts.de>
Date: Mon, 30 Nov 2015 15:39:35 +0100
Subject: [PATCH 3/3] input: edt-ft5x06: implement support for the EDT-M12
 series.

This adds support for the EDT M12 series of touchscreens.

Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 48 +++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d128445..8f5c2c0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -72,6 +72,7 @@
 enum edt_ver {
 	EDT_M06,
 	EDT_M09,
+	EDT_M12,
 	GENERIC_FT,
 };
 
@@ -188,6 +189,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		break;
 
 	case EDT_M09:
+	case EDT_M12:
 	case GENERIC_FT:
 		cmd = 0x0;
 		offset = 3;
@@ -211,7 +213,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		goto out;
 	}
 
-	/* M09 does not send header or CRC */
+	/* M09/M12 does not send header or CRC */
 	if (tsdata->version == EDT_M06) {
 		if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa ||
 			rdbuf[2] != datalen) {
@@ -274,6 +276,7 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
 					wrbuf, 0, NULL);
 	case EDT_M09:
+	case EDT_M12:
 	case GENERIC_FT:
 		wrbuf[0] = addr;
 		wrbuf[1] = value;
@@ -313,6 +316,7 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 		break;
 
 	case EDT_M09:
+	case EDT_M12:
 	case GENERIC_FT:
 		wrbuf[0] = addr;
 		error = edt_ft5x06_ts_readwrite(tsdata->client, 1,
@@ -377,6 +381,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 		break;
 
 	case EDT_M09:
+	case EDT_M12:
 	case GENERIC_FT:
 		addr = attr->addr_m09;
 		break;
@@ -447,6 +452,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 		break;
 
 	case EDT_M09:
+	case EDT_M12:
 	case GENERIC_FT:
 		addr = attr->addr_m09;
 		break;
@@ -472,14 +478,18 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 	return error ?: count;
 }
 
+/* m06, m09: range 0-31, m12: range 0-5 */
 static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,
 		M09_REGISTER_GAIN, 0, 31);
+/* m06, m09: range 0-31, m12: range 0-16 */
 static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,
 		M09_REGISTER_OFFSET, 0, 31);
+/* m06: range 20 to 80, m09: range 0 to 30, m12: range 1 to 255... */
 static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
-		M09_REGISTER_THRESHOLD, 0, 80);
+		M09_REGISTER_THRESHOLD, 0, 255);
+/* m06: range 3 to 14, m12: (0x64: 100Hz) */
 static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
-		NO_REGISTER, 3, 14);
+		NO_REGISTER, 0, 255);
 
 static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_gain.dattr.attr,
@@ -551,7 +561,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	return error;
 
 m09_out:
-	dev_err(&client->dev, "No factory mode support for M09/GENERIC_FT\n");
+	dev_err(&client->dev, "No factory mode support for M09/M12/GENERIC_FT\n");
 	return -EINVAL;
 
 }
@@ -776,13 +786,14 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	 * to have garbage in there
 	 */
 	memset(rdbuf, 0, sizeof(rdbuf));
-	error = edt_ft5x06_ts_readwrite(client, 1, "\xbb",
+	error = edt_ft5x06_ts_readwrite(client, 1, "\xBB",
 					EDT_NAME_LEN - 1, rdbuf);
 	if (error)
 		return error;
 
-	/* if we find something consistent, stay with that assumption
-	 * at least M09 won't send 3 bytes here
+	/* probe content for something consistent.
+	 * M06 starts with a response byte, M12 gives the data directly.
+	 * M09/Generic does not provide model number information.
 	 */
 	if (!(strncasecmp(rdbuf + 1, "EP0", 3))) {
 		tsdata->version = EDT_M06;
@@ -798,8 +809,22 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 			*p++ = '\0';
 		strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
 		strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
+	} else if (!(strncasecmp(rdbuf, "EP0", 3))) {
+		tsdata->version = EDT_M12;
+
+		/* remove last '$' end marker */
+		rdbuf[EDT_NAME_LEN - 2] = '\0';
+		if (rdbuf[EDT_NAME_LEN - 3] == '$')
+			rdbuf[EDT_NAME_LEN - 3] = '\0';
+
+		/* look for Model/Version separator */
+		p = strchr(rdbuf, '*');
+		if (p)
+			*p++ = '\0';
+		strlcpy(model_name, rdbuf, EDT_NAME_LEN);
+		strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
 	} else {
-		/* if it is not an EDT M06 touchscreen then the model
+		/* if it is not an EDT M06/M12 touchscreen then the model
 		 * detection is a bit hairy. The different ft5x06
 		 * firmares around don't reliably implement the
 		 * identification registers. Well. we'll take a shot.
@@ -894,7 +919,8 @@ edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 		tsdata->report_rate = edt_ft5x06_register_read(tsdata,
 						reg_addr->reg_report_rate);
 	if (tsdata->version == EDT_M06 ||
-	    tsdata->version == EDT_M09) {
+	    tsdata->version == EDT_M09 ||
+	    tsdata->version == EDT_M12) {
 		tsdata->num_x = edt_ft5x06_register_read(tsdata,
 							 reg_addr->reg_num_x);
 		tsdata->num_y = edt_ft5x06_register_read(tsdata,
@@ -921,6 +947,7 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 		break;
 
 	case EDT_M09:
+	case EDT_M12:
 		reg_addr->reg_threshold = M09_REGISTER_THRESHOLD;
 		reg_addr->reg_report_rate = NO_REGISTER;
 		reg_addr->reg_gain = M09_REGISTER_GAIN;
@@ -1029,7 +1056,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input->dev.parent = &client->dev;
 
 	if (tsdata->version == EDT_M06 ||
-	    tsdata->version == EDT_M09) {
+	    tsdata->version == EDT_M09 ||
+	    tsdata->version == EDT_M12) {
 		input_set_abs_params(input, ABS_MT_POSITION_X,
 				     0, tsdata->num_x * 64 - 1, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y,
-- 
2.1.4

