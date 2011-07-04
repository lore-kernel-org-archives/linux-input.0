From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 2/3] Input: atmel_mxt_ts - Update objects list
Date: Mon, 04 Jul 2011 12:06:03 +0300
Message-ID: <4E11827B.4010203@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:46722 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab1GDJGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 05:06:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

Update the object list to include new objects, and add unique identifiers so we can
distinguish between old & new generation of the same object.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |  184 +++++++++++++++++-------------
 1 files changed, 102 insertions(+), 82 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 8870e7b..da8c9ca 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -48,41 +48,47 @@
 #define MXT_OBJECT_SIZE		6
 
 /* Object types */
-#define MXT_DEBUG_DIAGNOSTIC	37
-#define MXT_GEN_MESSAGE		5
-#define MXT_GEN_COMMAND		6
-#define MXT_GEN_POWER		7
-#define MXT_GEN_ACQUIRE		8
-#define MXT_TOUCH_MULTI		9
-#define MXT_TOUCH_KEYARRAY	15
-#define MXT_TOUCH_PROXIMITY	23
-#define MXT_PROCI_GRIPFACE	20
-#define MXT_PROCG_NOISE		22
-#define MXT_PROCI_ONETOUCH	24
-#define MXT_PROCI_TWOTOUCH	27
-#define MXT_PROCI_GRIP		40
-#define MXT_PROCI_PALM		41
-#define MXT_SPT_COMMSCONFIG	18
-#define MXT_SPT_GPIOPWM		19
-#define MXT_SPT_SELFTEST	25
-#define MXT_SPT_CTECONFIG	28
-#define MXT_SPT_USERDATA	38
-#define MXT_SPT_DIGITIZER	43
-#define MXT_SPT_MESSAGECOUNT	44
-
-/* MXT_GEN_COMMAND field */
+#define MXT_DEBUG_DIAGNOSTIC_T37	37
+#define MXT_GEN_MESSAGE_T5		5
+#define MXT_GEN_COMMAND_T6		6
+#define MXT_GEN_POWER_T7		7
+#define MXT_GEN_ACQUIRE_T8		8
+#define MXT_GEN_DATASOURCE_T53		53
+#define MXT_TOUCH_MULTI_T9		9
+#define MXT_TOUCH_KEYARRAY_T15		15
+#define MXT_TOUCH_PROXIMITY_T23		23
+#define MXT_TOUCH_PROXKEY_T52		52
+#define MXT_PROCI_GRIPFACE_T20		20
+#define MXT_PROCG_NOISE_T22		22
+#define MXT_PROCI_ONETOUCH_T24		24
+#define MXT_PROCI_TWOTOUCH_T27		27
+#define MXT_PROCI_GRIP_T40		40
+#define MXT_PROCI_PALM_T41		41
+#define MXT_PROCI_TOUCHSUPPRESSION_T42	42
+#define MXT_PROCI_STYLUS_T47		47
+#define MXT_PROCG_NOISESUPPRESSION_T48	48
+#define MXT_SPT_COMMSCONFIG_T18		18
+#define MXT_SPT_GPIOPWM_T19		19
+#define MXT_SPT_SELFTEST_T25		25
+#define MXT_SPT_CTECONFIG_T28		28
+#define MXT_SPT_USERDATA_T38		38
+#define MXT_SPT_DIGITIZER_T43		43
+#define MXT_SPT_MESSAGECOUNT_T44	44
+#define MXT_SPT_CTECONFIG_T46		46
+
+/* MXT_GEN_COMMAND_T6 field */
 #define MXT_COMMAND_RESET	0
 #define MXT_COMMAND_BACKUPNV	1
 #define MXT_COMMAND_CALIBRATE	2
 #define MXT_COMMAND_REPORTALL	3
 #define MXT_COMMAND_DIAGNOSTIC	5
 
-/* MXT_GEN_POWER field */
+/* MXT_GEN_POWER_T7 field */
 #define MXT_POWER_IDLEACQINT	0
 #define MXT_POWER_ACTVACQINT	1
 #define MXT_POWER_ACTV2IDLETO	2
 
-/* MXT_GEN_ACQUIRE field */
+/* MXT_GEN_ACQUIRE_T8 field */
 #define MXT_ACQUIRE_CHRGTIME	0
 #define MXT_ACQUIRE_TCHDRIFT	2
 #define MXT_ACQUIRE_DRIFTST	3
@@ -91,7 +97,7 @@
 #define MXT_ACQUIRE_ATCHCALST	6
 #define MXT_ACQUIRE_ATCHCALSTHR	7
 
-/* MXT_TOUCH_MULTI field */
+/* MXT_TOUCH_MULTI_T9 field */
 #define MXT_TOUCH_CTRL		0
 #define MXT_TOUCH_XORIGIN	1
 #define MXT_TOUCH_YORIGIN	2
@@ -121,7 +127,7 @@
 #define MXT_TOUCH_YEDGEDIST	29
 #define MXT_TOUCH_JUMPLIMIT	30
 
-/* MXT_PROCI_GRIPFACE field */
+/* MXT_PROCI_GRIPFACE_T20 field */
 #define MXT_GRIPFACE_CTRL	0
 #define MXT_GRIPFACE_XLOGRIP	1
 #define MXT_GRIPFACE_XHIGRIP	2
@@ -151,11 +157,11 @@
 #define MXT_NOISE_FREQ4		15
 #define MXT_NOISE_IDLEGCAFVALID	16
 
-/* MXT_SPT_COMMSCONFIG */
+/* MXT_SPT_COMMSCONFIG_T18 */
 #define MXT_COMMS_CTRL		0
 #define MXT_COMMS_CMD		1
 
-/* MXT_SPT_CTECONFIG field */
+/* MXT_SPT_CTECONFIG_T28 field */
 #define MXT_CTE_CTRL		0
 #define MXT_CTE_CMD		1
 #define MXT_CTE_MODE		2
@@ -166,7 +172,7 @@
 #define MXT_VOLTAGE_DEFAULT	2700000
 #define MXT_VOLTAGE_STEP	10000
 
-/* Define for MXT_GEN_COMMAND */
+/* Define for MXT_GEN_COMMAND_T6 */
 #define MXT_BOOT_VALUE		0xa5
 #define MXT_BACKUP_VALUE	0x55
 #define MXT_BACKUP_TIME		25	/* msec */
@@ -256,24 +262,31 @@ struct mxt_data {
 static bool mxt_object_readable(unsigned int type)
 {
 	switch (type) {
-	case MXT_GEN_MESSAGE:
-	case MXT_GEN_COMMAND:
-	case MXT_GEN_POWER:
-	case MXT_GEN_ACQUIRE:
-	case MXT_TOUCH_MULTI:
-	case MXT_TOUCH_KEYARRAY:
-	case MXT_TOUCH_PROXIMITY:
-	case MXT_PROCI_GRIPFACE:
-	case MXT_PROCG_NOISE:
-	case MXT_PROCI_ONETOUCH:
-	case MXT_PROCI_TWOTOUCH:
-	case MXT_PROCI_GRIP:
-	case MXT_PROCI_PALM:
-	case MXT_SPT_COMMSCONFIG:
-	case MXT_SPT_GPIOPWM:
-	case MXT_SPT_SELFTEST:
-	case MXT_SPT_CTECONFIG:
-	case MXT_SPT_USERDATA:
+	case MXT_GEN_MESSAGE_T5:
+	case MXT_GEN_COMMAND_T6:
+	case MXT_GEN_POWER_T7:
+	case MXT_GEN_ACQUIRE_T8:
+	case MXT_GEN_DATASOURCE_T53:
+	case MXT_TOUCH_MULTI_T9:
+	case MXT_TOUCH_KEYARRAY_T15:
+	case MXT_TOUCH_PROXIMITY_T23:
+	case MXT_TOUCH_PROXKEY_T52:
+	case MXT_PROCI_GRIPFACE_T20:
+	case MXT_PROCG_NOISE_T22:
+	case MXT_PROCI_ONETOUCH_T24:
+	case MXT_PROCI_TWOTOUCH_T27:
+	case MXT_PROCI_GRIP_T40:
+	case MXT_PROCI_PALM_T41:
+	case MXT_PROCI_TOUCHSUPPRESSION_T42:
+	case MXT_PROCI_STYLUS_T47:
+	case MXT_PROCG_NOISESUPPRESSION_T48:
+	case MXT_SPT_COMMSCONFIG_T18:
+	case MXT_SPT_GPIOPWM_T19:
+	case MXT_SPT_SELFTEST_T25:
+	case MXT_SPT_CTECONFIG_T28:
+	case MXT_SPT_USERDATA_T38:
+	case MXT_SPT_DIGITIZER_T43:
+	case MXT_SPT_CTECONFIG_T46:
 		return true;
 	default:
 		return false;
@@ -283,21 +296,28 @@ static bool mxt_object_readable(unsigned int type)
 static bool mxt_object_writable(unsigned int type)
 {
 	switch (type) {
-	case MXT_GEN_COMMAND:
-	case MXT_GEN_POWER:
-	case MXT_GEN_ACQUIRE:
-	case MXT_TOUCH_MULTI:
-	case MXT_TOUCH_KEYARRAY:
-	case MXT_TOUCH_PROXIMITY:
-	case MXT_PROCI_GRIPFACE:
-	case MXT_PROCG_NOISE:
-	case MXT_PROCI_ONETOUCH:
-	case MXT_PROCI_TWOTOUCH:
-	case MXT_PROCI_GRIP:
-	case MXT_PROCI_PALM:
-	case MXT_SPT_GPIOPWM:
-	case MXT_SPT_SELFTEST:
-	case MXT_SPT_CTECONFIG:
+	case MXT_GEN_COMMAND_T6:
+	case MXT_GEN_POWER_T7:
+	case MXT_GEN_ACQUIRE_T8:
+	case MXT_TOUCH_MULTI_T9:
+	case MXT_TOUCH_KEYARRAY_T15:
+	case MXT_TOUCH_PROXIMITY_T23:
+	case MXT_TOUCH_PROXKEY_T52:
+	case MXT_PROCI_GRIPFACE_T20:
+	case MXT_PROCG_NOISE_T22:
+	case MXT_PROCI_ONETOUCH_T24:
+	case MXT_PROCI_TWOTOUCH_T27:
+	case MXT_PROCI_GRIP_T40:
+	case MXT_PROCI_PALM_T41:
+	case MXT_PROCI_TOUCHSUPPRESSION_T42:
+	case MXT_PROCI_STYLUS_T47:
+	case MXT_PROCG_NOISESUPPRESSION_T48:
+	case MXT_SPT_COMMSCONFIG_T18:
+	case MXT_SPT_GPIOPWM_T19:
+	case MXT_SPT_SELFTEST_T25:
+	case MXT_SPT_CTECONFIG_T28:
+	case MXT_SPT_DIGITIZER_T43:
+	case MXT_SPT_CTECONFIG_T46:
 		return true;
 	default:
 		return false;
@@ -455,7 +475,7 @@ static int mxt_read_message(struct mxt_data *data,
 	struct mxt_object *object;
 	u16 reg;
 
-	object = mxt_get_object(data, MXT_GEN_MESSAGE);
+	object = mxt_get_object(data, MXT_GEN_MESSAGE_T5);
 	if (!object)
 		return -EINVAL;
 
@@ -597,8 +617,8 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 
 		reportid = message.reportid;
 
-		/* whether reportid is thing of MXT_TOUCH_MULTI */
-		object = mxt_get_object(data, MXT_TOUCH_MULTI);
+		/* whether reportid is thing of MXT_TOUCH_MULTI_T9 */
+		object = mxt_get_object(data, MXT_TOUCH_MULTI_T9);
 		if (!object)
 			goto end;
 
@@ -678,31 +698,31 @@ static void mxt_handle_pdata(struct mxt_data *data)
 	u8 voltage;
 
 	/* Set touchscreen lines */
-	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_XSIZE,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9, MXT_TOUCH_XSIZE,
 			pdata->x_line);
-	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_YSIZE,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9, MXT_TOUCH_YSIZE,
 			pdata->y_line);
 
 	/* Set touchscreen orient */
-	mxt_write_object(data, MXT_TOUCH_MULTI, MXT_TOUCH_ORIENT,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9, MXT_TOUCH_ORIENT,
 			pdata->orient);
 
 	/* Set touchscreen burst length */
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_BLEN, pdata->blen);
 
 	/* Set touchscreen threshold */
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_TCHTHR, pdata->threshold);
 
 	/* Set touchscreen resolution */
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_XRANGE_LSB, (pdata->x_size - 1) & 0xff);
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_XRANGE_MSB, (pdata->x_size - 1) >> 8);
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_YRANGE_LSB, (pdata->y_size - 1) & 0xff);
-	mxt_write_object(data, MXT_TOUCH_MULTI,
+	mxt_write_object(data, MXT_TOUCH_MULTI_T9,
 			MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
 
 	/* Set touchscreen voltage */
@@ -715,7 +735,7 @@ static void mxt_handle_pdata(struct mxt_data *data)
 			voltage = (pdata->voltage - MXT_VOLTAGE_DEFAULT) /
 				MXT_VOLTAGE_STEP;
 
-		mxt_write_object(data, MXT_SPT_CTECONFIG,
+		mxt_write_object(data, MXT_SPT_CTECONFIG_T28,
 				MXT_CTE_VOLTAGE, voltage);
 	}
 }
@@ -819,13 +839,13 @@ static int mxt_initialize(struct mxt_data *data)
 	mxt_handle_pdata(data);
 
 	/* Backup to memory */
-	mxt_write_object(data, MXT_GEN_COMMAND,
+	mxt_write_object(data, MXT_GEN_COMMAND_T6,
 			MXT_COMMAND_BACKUPNV,
 			MXT_BACKUP_VALUE);
 	msleep(MXT_BACKUP_TIME);
 
 	/* Soft reset */
-	mxt_write_object(data, MXT_GEN_COMMAND,
+	mxt_write_object(data, MXT_GEN_COMMAND_T6,
 			MXT_COMMAND_RESET, 1);
 	msleep(MXT_RESET_TIME);
 	while (data->pdata->read_chg())
@@ -923,7 +943,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 	}
 
 	/* Change to the bootloader mode */
-	mxt_write_object(data, MXT_GEN_COMMAND,
+	mxt_write_object(data, MXT_GEN_COMMAND_T6,
 			MXT_COMMAND_RESET, MXT_BOOT_VALUE);
 	msleep(MXT_RESET_TIME);
 
@@ -1029,14 +1049,14 @@ static void mxt_start(struct mxt_data *data)
 {
 	/* Touch enable */
 	mxt_write_object(data,
-			MXT_TOUCH_MULTI, MXT_TOUCH_CTRL, 0x83);
+			MXT_TOUCH_MULTI_T9, MXT_TOUCH_CTRL, 0x83);
 }
 
 static void mxt_stop(struct mxt_data *data)
 {
 	/* Touch disable */
 	mxt_write_object(data,
-			MXT_TOUCH_MULTI, MXT_TOUCH_CTRL, 0);
+			MXT_TOUCH_MULTI_T9, MXT_TOUCH_CTRL, 0);
 }
 
 static int mxt_input_open(struct input_dev *dev)
@@ -1184,7 +1204,7 @@ static int mxt_resume(struct device *dev)
 	struct input_dev *input_dev = data->input_dev;
 
 	/* Soft reset */
-	mxt_write_object(data, MXT_GEN_COMMAND,
+	mxt_write_object(data, MXT_GEN_COMMAND_T6,
 			MXT_COMMAND_RESET, 1);
 
 	msleep(MXT_RESET_TIME);
-- 
1.7.0.4
