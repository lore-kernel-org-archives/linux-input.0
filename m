From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - properly wake up touchpad on ASUS laptops
Date: Thu, 28 Jul 2016 15:13:38 -0700
Message-ID: <20160728221338.GA26740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35516 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcG1WNm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 18:13:42 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Gradstein <jgradstein@gmail.com>, Chris Chiu <chiu@endlessm.com>, Vlad Glagolev <stealth@vaygr.net>
Cc: linux-input@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>, linux-kernel@vger.kernel.org

=46rom: KT Liao <kt.liao@emc.com.tw>

Some ASUS laptops were shipped with touchpads that require to be woken =
up
first, before trying to switch them into absolute reporting mode, other=
wise
touchpad would fail to work while flooding the logs with:

	elan_i2c i2c-ELAN1000:00: invalid report id data (1)

Among affected devices are Asus E202SA, N552VW, X456UF, UX305CA, and
others. We detect such devices by checking the IC type and product ID
numbers and adjusting order of operations accordingly.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Reported-by: Chris Chiu <chiu@endlessm.com>
Reported-by: Vlad Glagolev <stealth@vaygr.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Vlad, Chris, Jonathan, could you please tell me if this version of the
patch fixes your touchpad issue?

Thanks!

 drivers/input/mouse/elan_i2c_core.c | 79 +++++++++++++++++++++++++++++=
--------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 2f58985..d15b338 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,8 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.6.0
+ * Author: KT Liao <kt.liao@emc.com.tw>
+ * Version: 1.6.2
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +41,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.1"
+#define ELAN_DRIVER_VERSION	"1.6.2"
 #define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -199,9 +200,41 @@ static int elan_sleep(struct elan_tp_data *data)
 	return error;
 }
=20
+static int elan_query_product(struct elan_tp_data *data)
+{
+	int error;
+
+	error =3D data->ops->get_product_id(data->client, &data->product_id);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
+					  &data->sm_version);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
+{
+	if (data->ic_type !=3D 0x0E)
+		return false;
+
+	switch (data->product_id) {
+	case 0x05 ... 0x07:
+	case 0x09:
+	case 0x13:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int __elan_initialize(struct elan_tp_data *data)
 {
 	struct i2c_client *client =3D data->client;
+	bool woken_up =3D false;
 	int error;
=20
 	error =3D data->ops->initialize(client);
@@ -210,6 +243,27 @@ static int __elan_initialize(struct elan_tp_data *=
data)
 		return error;
 	}
=20
+	error =3D elan_query_product(data);
+	if (error)
+		return error;
+
+	/*
+	 * Some ASUS devices were shipped with firmware that requires
+	 * touchpads to be woken up first, before attempting to switch
+	 * them into absolute reporting mode.
+	 */
+	if (elan_check_ASUS_special_fw(data)) {
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
+
+		msleep(200);
+		woken_up =3D true;
+	}
+
 	data->mode |=3D ETP_ENABLE_ABS;
 	error =3D data->ops->set_mode(client, data->mode);
 	if (error) {
@@ -218,11 +272,13 @@ static int __elan_initialize(struct elan_tp_data =
*data)
 		return error;
 	}
=20
-	error =3D data->ops->sleep_control(client, false);
-	if (error) {
-		dev_err(&client->dev,
-			"failed to wake device up: %d\n", error);
-		return error;
+	if (!woken_up) {
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
 	}
=20
 	return 0;
@@ -248,10 +304,6 @@ static int elan_query_device_info(struct elan_tp_d=
ata *data)
 {
 	int error;
=20
-	error =3D data->ops->get_product_id(data->client, &data->product_id);
-	if (error)
-		return error;
-
 	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
 	if (error)
 		return error;
@@ -261,11 +313,6 @@ static int elan_query_device_info(struct elan_tp_d=
ata *data)
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
-					  &data->sm_version);
-	if (error)
-		return error;
-
 	error =3D data->ops->get_version(data->client, true, &data->iap_versi=
on);
 	if (error)
 		return error;
--=20
2.8.0.rc3.226.g39d4020


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
