From: Duson Lin <dusonlin@emc.com.tw>
Subject: =?UTF-8?q?=5BPATCH=5D=20Input=3A=20elan=5Fi2c=20-=20Compare=20signature=20metadata=20before=20update=20fw?=
Date: Fri, 23 Jan 2015 20:35:30 +0800
Message-ID: <1422016530-24071-1-git-send-email-dusonlin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from msr13.hinet.net ([168.95.4.113]:52366 "EHLO msr13.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbAWOy1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 09:54:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, Duson Lin <dusonlin@emc.com.tw>

To match different firmware file format, we replace original firmware f=
ile size
checking with the signature metadata comparison when update firmware, I=
f failed,
the update will be aborted.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c.h       |    6 +++---
 drivers/input/mouse/elan_i2c_core.c  |   23 +++++++++++++----------
 drivers/input/mouse/elan_i2c_i2c.c   |    1 -
 drivers/input/mouse/elan_i2c_smbus.c |    1 -
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_=
i2c.h
index 2e83862..e100c1b 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -4,7 +4,6 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.5.5
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -33,8 +32,9 @@
 #define ETP_FW_IAP_PAGE_ERR	(1 << 5)
 #define ETP_FW_IAP_INTF_ERR	(1 << 4)
 #define ETP_FW_PAGE_SIZE	64
-#define ETP_FW_PAGE_COUNT	768
-#define ETP_FW_SIZE		(ETP_FW_PAGE_SIZE * ETP_FW_PAGE_COUNT)
+#define ETP_FW_VAILDPAGE_COUNT	768
+#define ETP_FW_SIGNATURE_SIZE	6
+#define ETP_FW_SIGNATURE_ADDRESS	0xBFFA
=20
 struct i2c_client;
 struct completion;
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 0cb2be4..16f9584 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.5.5
+ * Version: 1.5.6
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.5.5"
+#define ELAN_DRIVER_VERSION	"1.5.6"
 #define ETP_PRESSURE_OFFSET	25
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -312,7 +312,7 @@ static int __elan_update_firmware(struct elan_tp_da=
ta *data,
 	iap_start_addr =3D get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * =
2]);
=20
 	boot_page_count =3D (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
-	for (i =3D boot_page_count; i < ETP_FW_PAGE_COUNT; i++) {
+	for (i =3D boot_page_count; i < ETP_FW_VAILDPAGE_COUNT; i++) {
 		u16 checksum =3D 0;
 		const u8 *page =3D &fw->data[i * ETP_FW_PAGE_SIZE];
=20
@@ -434,10 +434,11 @@ static ssize_t elan_sysfs_update_fw(struct device=
 *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct elan_tp_data *data =3D i2c_get_clientdata(client);
+	struct elan_tp_data *data =3D dev_get_drvdata(dev);
 	const struct firmware *fw;
 	int error;
+	const u8 *fw_signature;
+	static const u8 signature[] =3D {0xAA, 0x55, 0xCC, 0x33, 0xFF, 0xFF};
=20
 	error =3D request_firmware(&fw, ETP_FW_NAME, dev);
 	if (error) {
@@ -446,10 +447,12 @@ static ssize_t elan_sysfs_update_fw(struct device=
 *dev,
 		return error;
 	}
=20
-	/* Firmware must be exactly PAGE_NUM * PAGE_SIZE bytes */
-	if (fw->size !=3D ETP_FW_SIZE) {
-		dev_err(dev, "invalid firmware size =3D %zu, expected %d.\n",
-			fw->size, ETP_FW_SIZE);
+	/* Firmware file must match signature data */
+	fw_signature =3D &fw->data[ETP_FW_SIGNATURE_ADDRESS];
+	if (memcmp(fw_signature, signature, sizeof(signature)) !=3D 0) {
+		dev_err(dev, "signature mismatch (expected %*ph, got %*ph)\n",
+			     (int)sizeof(signature), signature,
+			     (int)sizeof(signature), fw_signature);
 		error =3D -EBADF;
 		goto out_release_fw;
 	}
@@ -464,7 +467,7 @@ static ssize_t elan_sysfs_update_fw(struct device *=
dev,
=20
 out_release_fw:
 	release_firmware(fw);
-	return error ?: count;
+	return error?: count;
 }
=20
 static ssize_t calibrate_store(struct device *dev,
diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/e=
lan_i2c_i2c.c
index 97d4937..029941f 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.5.5
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse=
/elan_i2c_smbus.c
index 359bf85..5cd4a05 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.5.5
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
