From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv5 5/5] Input: edt-ft5x06: Add support for M09 firmware version
Date: Thu, 20 Mar 2014 14:44:35 +0100
Message-ID: <1395323075-12146-6-git-send-email-LW@KARO-electronics.de>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
 <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

=46rom: Daniel Wagener <daniel.wagener@kernelconcepts.de>

There is a new firmware version for the EDT-FT5x06 chip.
Add support for detecting the firmware version and handle the
differences appropriately.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |  358 ++++++++++++++++++++++++=
--------
 1 file changed, 276 insertions(+), 82 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 565f0cd..936d269 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2012 Simon Budig, <simon.budig@kernelconcepts.de>
+ * Daniel Wagener <daniel.wagener@kernelconcepts.de> (M09 firmware sup=
port)
  * Lothar Wa=C3=9Fmann <LW@KARO-electronics.de> (DT support)
  *
  * This software is licensed under the terms of the GNU General Public
@@ -47,6 +48,14 @@
 #define WORK_REGISTER_NUM_X		0x33
 #define WORK_REGISTER_NUM_Y		0x34
=20
+#define M09_REGISTER_THRESHOLD		0x80
+#define M09_REGISTER_GAIN		0x92
+#define M09_REGISTER_OFFSET		0x93
+#define M09_REGISTER_NUM_X		0x94
+#define M09_REGISTER_NUM_Y		0x95
+
+#define NO_REGISTER			0xff
+
 #define WORK_REGISTER_OPMODE		0x3c
 #define FACTORY_REGISTER_OPMODE		0x01
=20
@@ -61,6 +70,20 @@
 #define EDT_RAW_DATA_RETRIES		100
 #define EDT_RAW_DATA_DELAY		1 /* msec */
=20
+enum edt_ver {
+	M06,
+	M09,
+};
+
+struct edt_reg_addr {
+	int reg_threshold;
+	int reg_report_rate;
+	int reg_gain;
+	int reg_offset;
+	int reg_num_x;
+	int reg_num_y;
+};
+
 struct edt_ft5x06_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
@@ -85,6 +108,9 @@ struct edt_ft5x06_ts_data {
 	int report_rate;
=20
 	char name[EDT_NAME_LEN];
+
+	struct edt_reg_addr reg_addr;
+	enum edt_ver version;
 };
=20
 static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
@@ -142,33 +168,58 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, voi=
d *dev_id)
 {
 	struct edt_ft5x06_ts_data *tsdata =3D dev_id;
 	struct device *dev =3D &tsdata->client->dev;
-	u8 cmd =3D 0xf9;
-	u8 rdbuf[26];
+	u8 cmd;
+	u8 rdbuf[29];
 	int i, type, x, y, id;
+	int offset, tplen, datalen;
 	int error;
=20
+	switch (tsdata->version) {
+	case M06:
+		cmd =3D 0xf9; /* tell the controller to send touch data */
+		offset =3D 5; /* where the actual touch data starts */
+		tplen =3D 4;  /* data comes in so called frames */
+		datalen =3D 26; /* how much bytes to listen for */
+		break;
+
+	case M09:
+		cmd =3D 0x02;
+		offset =3D 1;
+		tplen =3D 6;
+		datalen =3D 29;
+		break;
+
+	default:
+		goto out;
+	}
+
 	memset(rdbuf, 0, sizeof(rdbuf));
=20
 	error =3D edt_ft5x06_ts_readwrite(tsdata->client,
 					sizeof(cmd), &cmd,
-					sizeof(rdbuf), rdbuf);
+					datalen, rdbuf);
 	if (error) {
 		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
 				    error);
 		goto out;
 	}
=20
-	if (rdbuf[0] !=3D 0xaa || rdbuf[1] !=3D 0xaa || rdbuf[2] !=3D 26) {
-		dev_err_ratelimited(dev, "Unexpected header: %02x%02x%02x!\n",
-				    rdbuf[0], rdbuf[1], rdbuf[2]);
-		goto out;
-	}
+	/* M09 does not send header or CRC */
+	if (tsdata->version =3D=3D M06) {
+		if (rdbuf[0] !=3D 0xaa || rdbuf[1] !=3D 0xaa ||
+			rdbuf[2] !=3D datalen) {
+			dev_err_ratelimited(dev,
+					"Unexpected header: %02x%02x%02x!\n",
+					rdbuf[0], rdbuf[1], rdbuf[2]);
+			goto out;
+		}
=20
-	if (!edt_ft5x06_ts_check_crc(tsdata, rdbuf, 26))
-		goto out;
+		if (!edt_ft5x06_ts_check_crc(tsdata, rdbuf, datalen))
+			goto out;
+	}
=20
 	for (i =3D 0; i < MAX_SUPPORT_POINTS; i++) {
-		u8 *buf =3D &rdbuf[i * 4 + 5];
+		u8 *buf =3D &rdbuf[i * tplen + offset];
 		bool down;
=20
 		type =3D buf[0] >> 6;
@@ -176,8 +227,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void =
*dev_id)
 		if (type =3D=3D TOUCH_EVENT_RESERVED)
 			continue;
=20
-		/* ignore TOUCH_DOWN events, might have bogus coordinates */
-		if (type =3D=3D TOUCH_EVENT_DOWN)
+		/* M06 sometimes sends bogus coordinates in TOUCH_DOWN */
+		if (tsdata->version =3D=3D M06 && type =3D=3D TOUCH_EVENT_DOWN)
 			continue;
=20
 		x =3D ((buf[0] << 8) | buf[1]) & 0x0fff;
@@ -207,12 +258,25 @@ static int edt_ft5x06_register_write(struct edt_f=
t5x06_ts_data *tsdata,
 {
 	u8 wrbuf[4];
=20
-	wrbuf[0] =3D tsdata->factory_mode ? 0xf3 : 0xfc;
-	wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
-	wrbuf[2] =3D value;
-	wrbuf[3] =3D wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
-
-	return edt_ft5x06_ts_readwrite(tsdata->client, 4, wrbuf, 0, NULL);
+	switch (tsdata->version) {
+	case M06:
+		wrbuf[0] =3D tsdata->factory_mode ? 0xf3 : 0xfc;
+		wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+		wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+		wrbuf[2] =3D value;
+		wrbuf[3] =3D wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
+		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
+					wrbuf, 0, NULL);
+	case M09:
+		wrbuf[0] =3D addr;
+		wrbuf[1] =3D value;
+
+		return edt_ft5x06_ts_readwrite(tsdata->client, 3,
+					wrbuf, 0, NULL);
+
+	default:
+		return -EINVAL;
+	}
 }
=20
 static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
@@ -221,19 +285,35 @@ static int edt_ft5x06_register_read(struct edt_ft=
5x06_ts_data *tsdata,
 	u8 wrbuf[2], rdbuf[2];
 	int error;
=20
-	wrbuf[0] =3D tsdata->factory_mode ? 0xf3 : 0xfc;
-	wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
-	wrbuf[1] |=3D tsdata->factory_mode ? 0x80 : 0x40;
+	switch (tsdata->version) {
+	case M06:
+		wrbuf[0] =3D tsdata->factory_mode ? 0xf3 : 0xfc;
+		wrbuf[1] =3D tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+		wrbuf[1] |=3D tsdata->factory_mode ? 0x80 : 0x40;
=20
-	error =3D edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2, rdbuf)=
;
-	if (error)
+		error =3D edt_ft5x06_ts_readwrite(tsdata->client,
+						2, wrbuf, 2, rdbuf);
 		return error;
=20
-	if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) !=3D rdbuf[1]) {
-		dev_err(&tsdata->client->dev,
-			"crc error: 0x%02x expected, got 0x%02x\n",
-			wrbuf[0] ^ wrbuf[1] ^ rdbuf[0], rdbuf[1]);
-		return -EIO;
+		if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) !=3D rdbuf[1]) {
+			dev_err(&tsdata->client->dev,
+				"crc error: 0x%02x expected, got 0x%02x\n",
+				wrbuf[0] ^ wrbuf[1] ^ rdbuf[0],
+				rdbuf[1]);
+			return -EIO;
+		}
+		break;
+
+	case M09:
+		wrbuf[0] =3D addr;
+		error =3D edt_ft5x06_ts_readwrite(tsdata->client, 1,
+						wrbuf, 1, rdbuf);
+		if (error)
+			return error;
+		break;
+
+	default:
+		return -EINVAL;
 	}
=20
 	return rdbuf[0];
@@ -244,19 +324,21 @@ struct edt_ft5x06_attribute {
 	size_t field_offset;
 	u8 limit_low;
 	u8 limit_high;
-	u8 addr;
+	u8 addr_m06;
+	u8 addr_m09;
 };
=20
-#define EDT_ATTR(_field, _mode, _addr, _limit_low, _limit_high)		\
+#define EDT_ATTR(_field, _mode, _addr_m06, _addr_m09,			\
+		_limit_low, _limit_high)				\
 	struct edt_ft5x06_attribute edt_ft5x06_attr_##_field =3D {	\
 		.dattr =3D __ATTR(_field, _mode,				\
 				edt_ft5x06_setting_show,		\
 				edt_ft5x06_setting_store),		\
-		.field_offset =3D						\
-			offsetof(struct edt_ft5x06_ts_data, _field),	\
+		.field_offset =3D offsetof(struct edt_ft5x06_ts_data, _field), \
+		.addr_m06 =3D _addr_m06,					\
+		.addr_m09 =3D _addr_m09,					\
 		.limit_low =3D _limit_low,				\
 		.limit_high =3D _limit_high,				\
-		.addr =3D _addr,						\
 	}
=20
 static ssize_t edt_ft5x06_setting_show(struct device *dev,
@@ -271,6 +353,7 @@ static ssize_t edt_ft5x06_setting_show(struct devic=
e *dev,
 	int val;
 	size_t count =3D 0;
 	int error =3D 0;
+	u8 addr;
=20
 	mutex_lock(&tsdata->mutex);
=20
@@ -279,15 +362,33 @@ static ssize_t edt_ft5x06_setting_show(struct dev=
ice *dev,
 		goto out;
 	}
=20
-	val =3D edt_ft5x06_register_read(tsdata, attr->addr);
-	if (val < 0) {
-		error =3D val;
-		dev_err(&tsdata->client->dev,
-			"Failed to fetch attribute %s, error %d\n",
-			dattr->attr.name, error);
+	switch (tsdata->version) {
+	case M06:
+		addr =3D attr->addr_m06;
+		break;
+
+	case M09:
+		addr =3D attr->addr_m09;
+		break;
+
+	default:
+		error =3D -ENODEV;
 		goto out;
 	}
=20
+	if (addr !=3D NO_REGISTER) {
+		val =3D edt_ft5x06_register_read(tsdata, addr);
+		if (val < 0) {
+			error =3D val;
+			dev_err(&tsdata->client->dev,
+				"Failed to fetch attribute %s, error %d\n",
+				dattr->attr.name, error);
+			goto out;
+		}
+	} else {
+		val =3D *field;
+	}
+
 	if (val !=3D *field) {
 		dev_warn(&tsdata->client->dev,
 			 "%s: read (%d) and stored value (%d) differ\n",
@@ -312,6 +413,7 @@ static ssize_t edt_ft5x06_setting_store(struct devi=
ce *dev,
 	u8 *field =3D (u8 *)tsdata + attr->field_offset;
 	unsigned int val;
 	int error;
+	u8 addr;
=20
 	mutex_lock(&tsdata->mutex);
=20
@@ -329,14 +431,29 @@ static ssize_t edt_ft5x06_setting_store(struct de=
vice *dev,
 		goto out;
 	}
=20
-	error =3D edt_ft5x06_register_write(tsdata, attr->addr, val);
-	if (error) {
-		dev_err(&tsdata->client->dev,
-			"Failed to update attribute %s, error: %d\n",
-			dattr->attr.name, error);
+	switch (tsdata->version) {
+	case M06:
+		addr =3D attr->addr_m06;
+		break;
+
+	case M09:
+		addr =3D attr->addr_m09;
+		break;
+
+	default:
+		error =3D -ENODEV;
 		goto out;
 	}
=20
+	if (addr !=3D NO_REGISTER) {
+		error =3D edt_ft5x06_register_write(tsdata, addr, val);
+		if (error) {
+			dev_err(&tsdata->client->dev,
+				"Failed to update attribute %s, error: %d\n",
+				dattr->attr.name, error);
+			goto out;
+		}
+	}
 	*field =3D val;
=20
 out:
@@ -344,12 +461,14 @@ out:
 	return error ?: count;
 }
=20
-static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN, 0, 31);
-static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET, 0, 31=
);
-static EDT_ATTR(threshold, S_IWUSR | S_IRUGO,
-		WORK_REGISTER_THRESHOLD, 20, 80);
-static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO,
-		WORK_REGISTER_REPORT_RATE, 3, 14);
+static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,
+		M09_REGISTER_GAIN, 0, 31);
+static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,
+		M09_REGISTER_OFFSET, 0, 31);
+static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
+		M09_REGISTER_THRESHOLD, 20, 80);
+static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_R=
ATE,
+		NO_REGISTER, 3, 14);
=20
 static struct attribute *edt_ft5x06_attrs[] =3D {
 	&edt_ft5x06_attr_gain.dattr.attr,
@@ -384,6 +503,9 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x0=
6_ts_data *tsdata)
 	}
=20
 	/* mode register is 0x3c when in the work mode */
+	if (tsdata->version =3D=3D M09)
+		goto m09_out;
+
 	error =3D edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x0=
3);
 	if (error) {
 		dev_err(&client->dev,
@@ -416,12 +538,18 @@ err_out:
 	enable_irq(client->irq);
=20
 	return error;
+
+m09_out:
+	dev_err(&client->dev, "No factory mode support for M09\n");
+	return -EINVAL;
+
 }
=20
 static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct i2c_client *client =3D tsdata->client;
 	int retries =3D EDT_SWITCH_MODE_RETRIES;
+	struct edt_reg_addr *reg_addr =3D &tsdata->reg_addr;
 	int ret;
 	int error;
=20
@@ -454,13 +582,14 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06=
_ts_data *tsdata)
 	tsdata->raw_buffer =3D NULL;
=20
 	/* restore parameters */
-	edt_ft5x06_register_write(tsdata, WORK_REGISTER_THRESHOLD,
+	edt_ft5x06_register_write(tsdata, reg_addr->reg_threshold,
 				  tsdata->threshold);
-	edt_ft5x06_register_write(tsdata, WORK_REGISTER_GAIN,
+	edt_ft5x06_register_write(tsdata, reg_addr->reg_gain,
 				  tsdata->gain);
-	edt_ft5x06_register_write(tsdata, WORK_REGISTER_OFFSET,
+	edt_ft5x06_register_write(tsdata, reg_addr->reg_offset,
 				  tsdata->offset);
-	edt_ft5x06_register_write(tsdata, WORK_REGISTER_REPORT_RATE,
+	if (reg_addr->reg_report_rate)
+		edt_ft5x06_register_write(tsdata, reg_addr->reg_report_rate,
 				  tsdata->report_rate);
=20
 	enable_irq(client->irq);
@@ -663,30 +792,60 @@ static int edt_ft5x06_ts_reset(struct i2c_client =
*client,
 }
=20
 static int edt_ft5x06_ts_identify(struct i2c_client *client,
-					    char *model_name,
-					    char *fw_version)
+					struct edt_ft5x06_ts_data *tsdata,
+					char *fw_version)
 {
 	u8 rdbuf[EDT_NAME_LEN];
 	char *p;
 	int error;
+	char *model_name =3D tsdata->name;
=20
+	/* see what we find if we assume it is a M06 *
+	 * if we get less than EDT_NAME_LEN, we don't want
+	 * to have garbage in there
+	 */
+	memset(rdbuf, 0, sizeof(rdbuf));
 	error =3D edt_ft5x06_ts_readwrite(client, 1, "\xbb",
 					EDT_NAME_LEN - 1, rdbuf);
 	if (error)
 		return error;
=20
-	/* remove last '$' end marker */
-	rdbuf[EDT_NAME_LEN - 1] =3D '\0';
-	if (rdbuf[EDT_NAME_LEN - 2] =3D=3D '$')
-		rdbuf[EDT_NAME_LEN - 2] =3D '\0';
+	/* if we find something consistent, stay with that assumption
+	 * at least M09 won't send 3 bytes here
+	 */
+	if (!(strnicmp(rdbuf + 1, "EP0", 3))) {
+		tsdata->version =3D M06;
+
+		/* remove last '$' end marker */
+		rdbuf[EDT_NAME_LEN - 1] =3D '\0';
+		if (rdbuf[EDT_NAME_LEN - 2] =3D=3D '$')
+			rdbuf[EDT_NAME_LEN - 2] =3D '\0';
+
+		/* look for Model/Version separator */
+		p =3D strchr(rdbuf, '*');
+		if (p)
+			*p++ =3D '\0';
+		strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
+		strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
+	} else {
+		/* since there are only two versions around (M06, M09) */
+		tsdata->version =3D M09;
+
+		error =3D edt_ft5x06_ts_readwrite(client, 1, "\xA6",
+						2, rdbuf);
+		if (error)
+			return error;
=20
-	/* look for Model/Version separator */
-	p =3D strchr(rdbuf, '*');
-	if (p)
-		*p++ =3D '\0';
+		strlcpy(fw_version, rdbuf, 2);
=20
-	strlcpy(model_name, rdbuf + 1, EDT_NAME_LEN);
-	strlcpy(fw_version, p ? p : "", EDT_NAME_LEN);
+		error =3D edt_ft5x06_ts_readwrite(client, 1, "\xA8",
+						1, rdbuf);
+		if (error)
+			return error;
+
+		snprintf(model_name, EDT_NAME_LEN, "EP0%i%i0M09",
+			rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+	}
=20
 	return 0;
 }
@@ -705,36 +864,69 @@ static int edt_ft5x06_ts_identify(struct i2c_clie=
nt *client,
 static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
 					struct edt_ft5x06_ts_data *tsdata)
 {
-	EDT_GET_PROP(threshold, WORK_REGISTER_THRESHOLD);
-	EDT_GET_PROP(gain, WORK_REGISTER_GAIN);
-	EDT_GET_PROP(offset, WORK_REGISTER_OFFSET);
+	struct edt_reg_addr *reg_addr =3D &tsdata->reg_addr;
+
+	EDT_GET_PROP(threshold, reg_addr->reg_threshold);
+	EDT_GET_PROP(gain, reg_addr->reg_gain);
+	EDT_GET_PROP(offset, reg_addr->reg_offset);
 }
=20
 static void
 edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
 			   const struct edt_ft5x06_platform_data *pdata)
 {
+	struct edt_reg_addr *reg_addr =3D &tsdata->reg_addr;
+
 	if (!pdata->use_parameters)
 		return;
=20
 	/* pick up defaults from the platform data */
-	EDT_ATTR_CHECKSET(threshold, WORK_REGISTER_THRESHOLD);
-	EDT_ATTR_CHECKSET(gain, WORK_REGISTER_GAIN);
-	EDT_ATTR_CHECKSET(offset, WORK_REGISTER_OFFSET);
-	EDT_ATTR_CHECKSET(report_rate, WORK_REGISTER_REPORT_RATE);
+	EDT_ATTR_CHECKSET(threshold, reg_addr->reg_threshold);
+	EDT_ATTR_CHECKSET(gain, reg_addr->reg_gain);
+	EDT_ATTR_CHECKSET(offset, reg_addr->reg_offset);
+	if (reg_addr->reg_report_rate !=3D NO_REGISTER)
+		EDT_ATTR_CHECKSET(report_rate, reg_addr->reg_report_rate);
 }
=20
 static void
 edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
+	struct edt_reg_addr *reg_addr =3D &tsdata->reg_addr;
+
 	tsdata->threshold =3D edt_ft5x06_register_read(tsdata,
-						     WORK_REGISTER_THRESHOLD);
-	tsdata->gain =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_GAIN)=
;
-	tsdata->offset =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_OFF=
SET);
-	tsdata->report_rate =3D edt_ft5x06_register_read(tsdata,
-						WORK_REGISTER_REPORT_RATE);
-	tsdata->num_x =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_=
X);
-	tsdata->num_y =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_=
Y);
+						     reg_addr->reg_threshold);
+	tsdata->gain =3D edt_ft5x06_register_read(tsdata, reg_addr->reg_gain)=
;
+	tsdata->offset =3D edt_ft5x06_register_read(tsdata, reg_addr->reg_off=
set);
+	if (reg_addr->reg_report_rate !=3D NO_REGISTER)
+		tsdata->report_rate =3D edt_ft5x06_register_read(tsdata,
+						reg_addr->reg_report_rate);
+	tsdata->num_x =3D edt_ft5x06_register_read(tsdata, reg_addr->reg_num_=
x);
+	tsdata->num_y =3D edt_ft5x06_register_read(tsdata, reg_addr->reg_num_=
y);
+}
+
+static void
+edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
+{
+	struct edt_reg_addr *reg_addr =3D &tsdata->reg_addr;
+
+	switch (tsdata->version) {
+	case M06:
+		reg_addr->reg_threshold =3D WORK_REGISTER_THRESHOLD;
+		reg_addr->reg_report_rate =3D WORK_REGISTER_REPORT_RATE;
+		reg_addr->reg_gain =3D WORK_REGISTER_GAIN;
+		reg_addr->reg_offset =3D WORK_REGISTER_OFFSET;
+		reg_addr->reg_num_x =3D WORK_REGISTER_NUM_X;
+		reg_addr->reg_num_y =3D WORK_REGISTER_NUM_Y;
+		break;
+
+	case M09:
+		reg_addr->reg_threshold =3D M09_REGISTER_THRESHOLD;
+		reg_addr->reg_gain =3D M09_REGISTER_GAIN;
+		reg_addr->reg_offset =3D M09_REGISTER_OFFSET;
+		reg_addr->reg_num_x =3D M09_REGISTER_NUM_X;
+		reg_addr->reg_num_y =3D M09_REGISTER_NUM_Y;
+		break;
+	}
 }
=20
 #ifdef CONFIG_OF
@@ -818,12 +1010,14 @@ static int edt_ft5x06_ts_probe(struct i2c_client=
 *client,
 	tsdata->input =3D input;
 	tsdata->factory_mode =3D false;
=20
-	error =3D edt_ft5x06_ts_identify(client, tsdata->name, fw_version);
+	error =3D edt_ft5x06_ts_identify(client, tsdata, fw_version);
 	if (error) {
 		dev_err(&client->dev, "touchscreen probe failed\n");
 		return error;
 	}
=20
+	edt_ft5x06_ts_set_regs(tsdata);
+
 	if (!pdata)
 		edt_ft5x06_ts_get_dt_defaults(client->dev.of_node, tsdata);
 	else
--=20
1.7.10.4
