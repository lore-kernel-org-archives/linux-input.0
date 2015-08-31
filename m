From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Recovery exception ic type
Date: Mon, 31 Aug 2015 09:49:36 +0800
Message-ID: <49A03C1E-AB33-464B-BBD6-E1F9FA4F84DD@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:42992 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbHaBtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2015 21:49:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When driver get exception ic type (0xFF), maybe occurred from wrong
I2C protocol communication, system crash or other unknown situation,
we need to reset ic type from iap_version.
---
 drivers/input/mouse/elan_i2c_core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 5b5f403..39d9929 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =AAL=ACF=BA=FB (Duson Lin) <dusonlin@emc.com.tw>
- * Version: 1.5.9
+ * Version: 1.6.0
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.5.9"
+#define ELAN_DRIVER_VERSION	"1.6.0"
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
@@ -247,15 +247,19 @@ static int elan_query_device_info(struct elan_tp_=
data *data)
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
-					  &data->sm_version);
+	error =3D data->ops->get_version(data->client, true, &data->iap_versi=
on);
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_version(data->client, true, &data->iap_versi=
on);
+	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
+					  &data->sm_version);
 	if (error)
 		return error;
=20
+	/* exception type, need reset from iap_version */
+	if (data->ic_type =3D=3D 0xFF)
+		data->ic_type =3D data->iap_version;
+
 	error =3D data->ops->get_pressure_adjustment(data->client,
 						   &data->pressure_adjustment);
 	if (error)


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
