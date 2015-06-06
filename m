From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input - elan_i2c: support multi ic type and iap format
Date: Sun, 7 Jun 2015 03:34:04 +0800
Message-ID: <FE1EA6CC-E67E-419C-9394-EFA490D8BA76@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:48423 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbFFTeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jun 2015 15:34:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

In order to support multi ic type for i2c/smbus protocol, add get ic ty=
pe
command and check fw vaild page count and signature address function.

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c.h       |    5 ++--
 drivers/input/mouse/elan_i2c_core.c  |   44 ++++++++++++++++++++++++++=
++++----
 drivers/input/mouse/elan_i2c_i2c.c   |    5 +++-
 drivers/input/mouse/elan_i2c_smbus.c |    6 +++--
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_=
i2c.h
index 6d5f8a4..ff622a1 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -33,9 +33,7 @@
 #define ETP_FW_IAP_PAGE_ERR	(1 << 5)
 #define ETP_FW_IAP_INTF_ERR	(1 << 4)
 #define ETP_FW_PAGE_SIZE	64
-#define ETP_FW_VAILDPAGE_COUNT	768
 #define ETP_FW_SIGNATURE_SIZE	6
-#define ETP_FW_SIGNATURE_ADDRESS	0xBFFA
=20
 struct i2c_client;
 struct completion;
@@ -58,7 +56,8 @@ struct elan_transport_ops {
 				 bool max_baseliune, u8 *value);
=20
 	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);
-	int (*get_sm_version)(struct i2c_client *client, u8 *version);
+	int (*get_sm_version)(struct i2c_client *client,
+			      u8* ic_type, u8 *version);
 	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);
 	int (*get_product_id)(struct i2c_client *client, u8 *id);
=20
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index fd5068b..81e7bc9 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =AAL=ACF=BA=FB (Duson Lin) <dusonlin@emc.com.tw>
- * Version: 1.5.7
+ * Version: 1.5.8
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.5.7"
+#define ELAN_DRIVER_VERSION	"1.5.8"
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
@@ -83,6 +83,9 @@ struct elan_tp_data {
 	u16			fw_checksum;
 	int			pressure_adjustment;
 	u8			mode;
+	u8			ic_type;
+	u16			fw_vaildpage_count;
+	u16			fw_signature_address;
=20
 	bool			irq_wake;
=20
@@ -91,6 +94,28 @@ struct elan_tp_data {
 	bool			baseline_ready;
 };
=20
+static int elan_get_fwinfo(u8 ic_type, u16 *vaildpage_count,
+			   u16 *signature_address)
+{
+=09
+	switch(ic_type) {
+	case 0x09:
+		*vaildpage_count =3D 768;
+		break;
+	case 0x0D:
+		*vaildpage_count =3D 896;
+		break;
+	default:
+		/* unknown ic type clear value */
+		*vaildpage_count =3D 0;
+		*signature_address =3D 0;
+		return -ENXIO;
+	}
+	*signature_address =3D (*vaildpage_count * ETP_FW_PAGE_SIZE)
+			     - ETP_FW_SIGNATURE_SIZE;
+	return 0;
+}
+
 static int elan_enable_power(struct elan_tp_data *data)
 {
 	int repeat =3D ETP_RETRY_COUNT;
@@ -221,7 +246,8 @@ static int elan_query_device_info(struct elan_tp_da=
ta *data)
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_sm_version(data->client, &data->sm_version);
+	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
+					  &data->sm_version);
 	if (error)
 		return error;
=20
@@ -234,6 +260,14 @@ static int elan_query_device_info(struct elan_tp_d=
ata *data)
 	if (error)
 		return error;
=20
+	error =3D elan_get_fwinfo(data->ic_type, &data->fw_vaildpage_count,
+				&data->fw_signature_address);
+	if (error) {
+		dev_err(&data->client->dev,
+			"unknown ic type %d\n", data->ic_type);
+		return error;
+	}
+
 	return 0;
 }
=20
@@ -318,7 +352,7 @@ static int __elan_update_firmware(struct elan_tp_da=
ta *data,
 	iap_start_addr =3D get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * =
2]);
=20
 	boot_page_count =3D (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
-	for (i =3D boot_page_count; i < ETP_FW_VAILDPAGE_COUNT; i++) {
+	for (i =3D boot_page_count; i < data->fw_vaildpage_count; i++) {
 		u16 checksum =3D 0;
 		const u8 *page =3D &fw->data[i * ETP_FW_PAGE_SIZE];
=20
@@ -454,7 +488,7 @@ static ssize_t elan_sysfs_update_fw(struct device *=
dev,
 	}
=20
 	/* Firmware file must match signature data */
-	fw_signature =3D &fw->data[ETP_FW_SIGNATURE_ADDRESS];
+	fw_signature =3D &fw->data[data->fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) !=3D 0) {
 		dev_err(dev, "signature mismatch (expected %*ph, got %*ph)\n",
 			(int)sizeof(signature), signature,
diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/e=
lan_i2c_i2c.c
index a0acbbf..549cdfb 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -259,7 +259,8 @@ static int elan_i2c_get_version(struct i2c_client *=
client,
 	return 0;
 }
=20
-static int elan_i2c_get_sm_version(struct i2c_client *client, u8 *vers=
ion)
+static int elan_i2c_get_sm_version(struct i2c_client *client, u8 *ic_t=
ype,
+				   u8 *version)
 {
 	int error;
 	u8 val[3];
@@ -271,9 +272,11 @@ static int elan_i2c_get_sm_version(struct i2c_clie=
nt *client, u8 *version)
 	}
=20
 	*version =3D val[0];
+	*ic_type =3D val[1];
 	return 0;
 }
=20
+
 static int elan_i2c_get_product_id(struct i2c_client *client, u8 *id)
 {
 	int error;
diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse=
/elan_i2c_smbus.c
index 30ab80d..c28caef 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -165,7 +165,8 @@ static int elan_smbus_get_version(struct i2c_client=
 *client,
 	return 0;
 }
=20
-static int elan_smbus_get_sm_version(struct i2c_client *client, u8 *ve=
rsion)
+static int elan_smbus_get_sm_version(struct i2c_client *client, u8 *ic=
_type,
+				     u8 *version)
 {
 	int error;
 	u8 val[3];
@@ -177,7 +178,8 @@ static int elan_smbus_get_sm_version(struct i2c_cli=
ent *client, u8 *version)
 		return error;
 	}
=20
-	*version =3D val[0]; /* XXX Why 0 and not 2 as in IAP/FW versions? */
+	*version =3D val[0];
+	*ic_type =3D val[1];
 	return 0;
 }--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
