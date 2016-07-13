From: KT Liao <ktalex.liao@gmail.com>
Subject: [PATCH] Input: /input/mouse/elan_i2c_core.c
Date: Wed, 13 Jul 2016 21:30:29 +0800
Message-ID: <1468416629-4615-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

=46ix some Asus touchapod which casue TP no funciton sometimes, the pat=
ch detect some specific touchpad and run a special initialize

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 93 ++++++++++++++++++++++++++++-=
--------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 2f58985..36a69d2 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -3,8 +3,8 @@
  *
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
- * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.6.0
+ * Author: KT Liao <kt.liao@emc.com.tw>
+ * Version: 1.6.2
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.1"
+#define ELAN_DRIVER_VERSION	"1.6.2"
 #define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -95,6 +95,8 @@ struct elan_tp_data {
 	bool			baseline_ready;
 };
=20
+static int check_ASUS_special_fw(struct elan_tp_data *data);
+
 static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 			   u16 *signature_address)
 {
@@ -210,21 +212,40 @@ static int __elan_initialize(struct elan_tp_data =
*data)
 		return error;
 	}
=20
-	data->mode |=3D ETP_ENABLE_ABS;
-	error =3D data->ops->set_mode(client, data->mode);
-	if (error) {
-		dev_err(&client->dev,
-			"failed to switch to absolute mode: %d\n", error);
-		return error;
-	}
+	/* If it's the special FW, it need a different flow for mode change.*=
/
+	if (check_ASUS_special_fw(data)) {
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
=20
-	error =3D data->ops->sleep_control(client, false);
-	if (error) {
-		dev_err(&client->dev,
-			"failed to wake device up: %d\n", error);
-		return error;
-	}
+		msleep(200);
=20
+		data->mode |=3D ETP_ENABLE_ABS;
+		error =3D data->ops->set_mode(client, data->mode);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to switch to absolute mode: %d\n", error);
+			return error;
+		}
+	} else {
+		data->mode |=3D ETP_ENABLE_ABS;
+		error =3D data->ops->set_mode(client, data->mode);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to switch to absolute mode: %d\n", error);
+			return error;
+		}
+
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
+	}
 	return 0;
 }
=20
@@ -244,7 +265,7 @@ static int elan_initialize(struct elan_tp_data *dat=
a)
 	return error;
 }
=20
-static int elan_query_device_info(struct elan_tp_data *data)
+static int elan_query_device_pid_smver(struct elan_tp_data *data)
 {
 	int error;
=20
@@ -252,17 +273,24 @@ static int elan_query_device_info(struct elan_tp_=
data *data)
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
+	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
+					  &data->sm_version);
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_checksum(data->client, false,
-					&data->fw_checksum);
+	return 0;
+}
+
+static int elan_query_device_info(struct elan_tp_data *data)
+{
+	int error;
+
+	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
-					  &data->sm_version);
+	error =3D data->ops->get_checksum(data->client, false,
+					&data->fw_checksum);
 	if (error)
 		return error;
=20
@@ -419,6 +447,7 @@ static int elan_update_firmware(struct elan_tp_data=
 *data,
 		data->ops->iap_reset(client);
 	} else {
 		/* Reinitialize TP after fw is updated */
+		elan_query_device_pid_smver(data);
 		elan_initialize(data);
 		elan_query_device_info(data);
 	}
@@ -757,6 +786,22 @@ out:
 	return retval;
 }
=20
+static int check_ASUS_special_fw(struct elan_tp_data *data)
+{
+	if (data->ic_type !=3D 0x0E)
+		return false;
+
+	switch (data->product_id) {
+	case 0x05:
+	case 0x06:
+	case 0x07:
+	case 0x09:
+	case 0x013:
+		return true;
+	default:
+		return false;
+	}
+}
=20
 static DEVICE_ATTR_WO(acquire);
 static DEVICE_ATTR_RO(min);
@@ -1033,6 +1078,10 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
=20
+	error =3D elan_query_device_pid_smver(data);
+	if (error)
+		return error;
+
 	/* Initialize the touchpad. */
 	error =3D elan_initialize(data);
 	if (error)
--=20
2.7.4
