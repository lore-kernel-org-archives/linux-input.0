From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Use iap_version to get firmware information
Date: Wed, 2 Sep 2015 08:45:21 +0800
Message-ID: <FFCE0D6C-B2CA-4CA6-B195-B64AB1A9607B@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:34130 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbIBApX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2015 20:45:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dusonlin@emc.com.tw

When driver get exception ic type (0xFF), maybe occurred from wrong
I2C protocol communication, system crash or other unknown situation,
instead of ic_type we use iap_version to get firmware information.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 5b5f403..494858c 100644
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
@@ -261,7 +261,7 @@ static int elan_query_device_info(struct elan_tp_da=
ta *data)
 	if (error)
 		return error;
=20
-	error =3D elan_get_fwinfo(data->ic_type, &data->fw_vaildpage_count,
+	error =3D elan_get_fwinfo(data->iap_version, &data->fw_vaildpage_coun=
t,
 				&data->fw_signature_address);
 	if (error) {
 		dev_err(&data->client->dev,--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
