From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Expand maxmium product_id form 0xFF to  0xFFFF
Date: Thu, 10 Sep 2015 21:55:47 +0800
Message-ID: <AB605F46-0993-42EB-9A79-560C9C0DD31D@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:26052 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbbIJNz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 09:55:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arker <arker_wu@emc.com.tw>, =?big5?B?pvOo57z9?= <hank_ho@emc.com.tw>, kyle_lin <kyle_lin@emc.com.tw>

In order to support more projects in the feture, we expand the
maxmium product_id value form 0xFF to 0xFFFF.

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c.h       |    2 +-
 drivers/input/mouse/elan_i2c_core.c  |    6 +++---
 drivers/input/mouse/elan_i2c_i2c.c   |    4 ++--
 drivers/input/mouse/elan_i2c_smbus.c |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_=
i2c.h
index 73670f2..c0ec261 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -60,7 +60,7 @@ struct elan_transport_ops {
 	int (*get_sm_version)(struct i2c_client *client,
 			      u8* ic_type, u8 *version);
 	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);
-	int (*get_product_id)(struct i2c_client *client, u8 *id);
+	int (*get_product_id)(struct i2c_client *client, u16 *id);
=20
 	int (*get_max)(struct i2c_client *client,
 		       unsigned int *max_x, unsigned int *max_y);
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index e2b7420..4a5450d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =AAL=ACF=BA=FB (Duson Lin) <dusonlin@emc.com.tw>
- * Version: 1.6.0
+ * Version: 1.6.1
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.0"
+#define ELAN_DRIVER_VERSION	"1.6.1"
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
@@ -76,7 +76,7 @@ struct elan_tp_data {
 	unsigned int		x_res;
 	unsigned int		y_res;
=20
-	u8			product_id;
+	u16			product_id;
 	u8			fw_version;
 	u8			sm_version;
 	u8			iap_version;
diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/e=
lan_i2c_i2c.c
index 683c840..a679e56 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -276,7 +276,7 @@ static int elan_i2c_get_sm_version(struct i2c_clien=
t *client,
 	return 0;
 }
=20
-static int elan_i2c_get_product_id(struct i2c_client *client, u8 *id)
+static int elan_i2c_get_product_id(struct i2c_client *client, u16 *id)
 {
 	int error;
 	u8 val[3];
@@ -287,7 +287,7 @@ static int elan_i2c_get_product_id(struct i2c_clien=
t *client, u8 *id)
 		return error;
 	}
=20
-	*id =3D val[0];
+	*id =3D le16_to_cpup((__le16 *)val);
 	return 0;
 }
=20
diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse=
/elan_i2c_smbus.c
index ff36a36..cb6aecb 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -183,7 +183,7 @@ static int elan_smbus_get_sm_version(struct i2c_cli=
ent *client,
 	return 0;
 }
=20
-static int elan_smbus_get_product_id(struct i2c_client *client, u8 *id=
)
+static int elan_smbus_get_product_id(struct i2c_client *client, u16 *i=
d)
 {
 	int error;
 	u8 val[3];
@@ -195,7 +195,7 @@ static int elan_smbus_get_product_id(struct i2c_cli=
ent *client, u8 *id)
 		return error;
 	}
=20
-	*id =3D val[1];
+	*id =3D be16_to_cpup((__be16 *)val);
 	return 0;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
