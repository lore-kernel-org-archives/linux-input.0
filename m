From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Support two physical button touchapd for elan_i2c
Date: Fri, 18 Aug 2017 17:47:16 +0800
Message-ID: <1503049636-3333-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

Extend information accessing to get button setting information
and support L/R button-pad for I2C touchpad

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c.h       |  2 +-
 drivers/input/mouse/elan_i2c_core.c  |  9 +++++++--
 drivers/input/mouse/elan_i2c_i2c.c   | 13 ++++++++++++-
 drivers/input/mouse/elan_i2c_smbus.c |  4 +++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
index 61c2024..599544c 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -58,7 +58,7 @@ struct elan_transport_ops {
 
 	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);
 	int (*get_sm_version)(struct i2c_client *client,
-			      u16 *ic_type, u8 *version);
+			      u16 *ic_type, u8 *version, u8 *clickpad);
 	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);
 	int (*get_product_id)(struct i2c_client *client, u16 *id);
 
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 0d111322..59baced 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -95,6 +95,7 @@ struct elan_tp_data {
 	u8			min_baseline;
 	u8			max_baseline;
 	bool			baseline_ready;
+	u8			clickpad;
 };
 
 static int elan_get_fwinfo(u16 ic_type, u16 *validpage_count,
@@ -213,7 +214,7 @@ static int elan_query_product(struct elan_tp_data *data)
 		return error;
 
 	error = data->ops->get_sm_version(data->client, &data->ic_type,
-					  &data->sm_version);
+					  &data->sm_version, &data->clickpad);
 	if (error)
 		return error;
 
@@ -923,6 +924,7 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	}
 
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);
+	input_report_key(input, BTN_RIGHT, tp_info & 0x02);
 	input_report_abs(input, ABS_DISTANCE, hover_event != 0);
 	input_mt_report_pointer_emulation(input, true);
 	input_sync(input);
@@ -991,7 +993,10 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 
 	__set_bit(EV_ABS, input->evbit);
 	__set_bit(INPUT_PROP_POINTER, input->propbit);
-	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	if (data->clickpad)
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	else
+		__set_bit(BTN_RIGHT, input->keybit);
 	__set_bit(BTN_LEFT, input->keybit);
 
 	/* Set up ST parameters */
diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
index 80172f2..15b1330 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -288,7 +288,8 @@ static int elan_i2c_get_version(struct i2c_client *client,
 }
 
 static int elan_i2c_get_sm_version(struct i2c_client *client,
-				   u16 *ic_type, u8 *version)
+				   u16 *ic_type, u8 *version,
+				   u8 *clickpad)
 {
 	int error;
 	u8 pattern_ver;
@@ -317,6 +318,7 @@ static int elan_i2c_get_sm_version(struct i2c_client *client,
 			return error;
 		}
 		*version = val[1];
+		*clickpad = val[0] & 0x10;
 	} else {
 		error = elan_i2c_read_cmd(client, ETP_I2C_OSM_VERSION_CMD, val);
 		if (error) {
@@ -326,6 +328,15 @@ static int elan_i2c_get_sm_version(struct i2c_client *client,
 		}
 		*version = val[0];
 		*ic_type = val[1];
+
+		error = elan_i2c_read_cmd(client, ETP_I2C_NSM_VERSION_CMD,
+					  val);
+		if (error) {
+			dev_err(&client->dev, "failed to get SM version: %d\n",
+				error);
+			return error;
+		}
+		*clickpad = val[0] & 0x10;
 	}
 
 	return 0;
diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index df7a57c..29f9952 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -166,7 +166,8 @@ static int elan_smbus_get_version(struct i2c_client *client,
 }
 
 static int elan_smbus_get_sm_version(struct i2c_client *client,
-				     u16 *ic_type, u8 *version)
+				     u16 *ic_type, u8 *version,
+				     u8 *clickpad)
 {
 	int error;
 	u8 val[3];
@@ -180,6 +181,7 @@ static int elan_smbus_get_sm_version(struct i2c_client *client,
 
 	*version = val[0];
 	*ic_type = val[1];
+	*clickpad = val[0] & 0x10;
 	return 0;
 }
 
-- 
2.7.4
