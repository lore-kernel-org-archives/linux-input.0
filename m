From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: synaptics - add synaptics_query_int()
Date: Fri, 24 Mar 2017 23:04:06 -0700
Message-ID: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33487 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967124AbdCYGER (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:04:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

Factor out querying and parsing 3-byte response into an integer value.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 77 ++++++++++++++++-------------------------
 drivers/input/mouse/synaptics.h |  3 +-
 2 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index dd6caa0e7e09..7e35da8abcde 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -197,6 +197,22 @@ static int synaptics_send_cmd(struct psmouse *psmouse,
 	return 0;
 }
 
+static int synaptics_query_int(struct psmouse *psmouse, u8 query_cmd, u32 *val)
+{
+	int error;
+	union {
+		__be32 be_val;
+		char buf[4];
+	} resp = { 0 };
+
+	error = synaptics_send_cmd(psmouse, query_cmd, resp.buf + 1);
+	if (error)
+		return error;
+
+	*val = be32_to_cpu(resp.be_val);
+	return 0;
+}
+
 /*
  * Identify Touchpad
  * See also the SYN_ID_* macros
@@ -204,14 +220,12 @@ static int synaptics_send_cmd(struct psmouse *psmouse,
 static int synaptics_identify(struct psmouse *psmouse,
 			      struct synaptics_device_info *info)
 {
-	unsigned char id[3];
 	int error;
 
-	error = synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id);
+	error = synaptics_query_int(psmouse, SYN_QUE_IDENTIFY, &info->identity);
 	if (error)
 		return error;
 
-	info->identity = (id[0] << 16) | (id[1] << 8) | id[2];
 	return SYN_ID_IS_SYNAPTICS(info->identity) ? 0 : -ENXIO;
 }
 
@@ -222,15 +236,7 @@ static int synaptics_identify(struct psmouse *psmouse,
 static int synaptics_model_id(struct psmouse *psmouse,
 			      struct synaptics_device_info *info)
 {
-	unsigned char mi[3];
-	int error;
-
-	error = synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi);
-	if (error)
-		return error;
-
-	info->model_id = (mi[0] << 16) | (mi[1] << 8) | mi[2];
-	return 0;
+	return synaptics_query_int(psmouse, SYN_QUE_MODEL, &info->model_id);
 }
 
 /*
@@ -239,29 +245,8 @@ static int synaptics_model_id(struct psmouse *psmouse,
 static int synaptics_firmware_id(struct psmouse *psmouse,
 				 struct synaptics_device_info *info)
 {
-	unsigned char fwid[3];
-	int error;
-
-	error = synaptics_send_cmd(psmouse, SYN_QUE_FIRMWARE_ID, fwid);
-	if (error)
-		return error;
-
-	info->firmware_id = (fwid[0] << 16) | (fwid[1] << 8) | fwid[2];
-	return 0;
-}
-
-static int synaptics_more_extended_queries(struct psmouse *psmouse,
-					   struct synaptics_device_info *info)
-{
-	unsigned char buf[3];
-	int error;
-
-	error = synaptics_send_cmd(psmouse, SYN_QUE_MEXT_CAPAB_10, buf);
-	if (error)
-		return error;
-
-	info->ext_cap_10 = (buf[0] << 16) | (buf[1] << 8) | buf[2];
-	return 0;
+	return synaptics_query_int(psmouse, SYN_QUE_FIRMWARE_ID,
+				   &info->firmware_id);
 }
 
 /*
@@ -285,7 +270,8 @@ static int synaptics_query_modes(struct psmouse *psmouse,
 	info->board_id = ((bid[0] & 0xfc) << 6) | bid[1];
 
 	if (SYN_MEXT_CAP_BIT(bid[0]))
-		return synaptics_more_extended_queries(psmouse, info);
+		return synaptics_query_int(psmouse, SYN_QUE_MEXT_CAPAB_10,
+					   &info->ext_cap_10);
 
 	return 0;
 }
@@ -297,14 +283,13 @@ static int synaptics_query_modes(struct psmouse *psmouse,
 static int synaptics_capability(struct psmouse *psmouse,
 				struct synaptics_device_info *info)
 {
-	unsigned char cap[3];
 	int error;
 
-	error = synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap);
+	error = synaptics_query_int(psmouse, SYN_QUE_CAPABILITIES,
+				    &info->capabilities);
 	if (error)
 		return error;
 
-	info->capabilities = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 	info->ext_cap = info->ext_cap_0c = 0;
 
 	/*
@@ -322,29 +307,27 @@ static int synaptics_capability(struct psmouse *psmouse,
 		info->capabilities = 0;
 
 	if (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 1) {
-		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
+		error = synaptics_query_int(psmouse, SYN_QUE_EXT_CAPAB,
+					    &info->ext_cap);
+		if (error) {
 			psmouse_warn(psmouse,
 				     "device claims to have extended capabilities, but I'm not able to read them.\n");
 		} else {
-			info->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
-
 			/*
 			 * if nExtBtn is greater than 8 it should be considered
 			 * invalid and treated as 0
 			 */
 			if (SYN_CAP_MULTI_BUTTON_NO(info->ext_cap) > 8)
-				info->ext_cap &= 0xff0fff;
+				info->ext_cap &= ~SYN_CAP_MB_MASK;
 		}
 	}
 
 	if (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 4) {
-		error = synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB_0C, cap);
+		error = synaptics_query_int(psmouse, SYN_QUE_EXT_CAPAB_0C,
+					    &info->ext_cap_0c);
 		if (error)
 			psmouse_warn(psmouse,
 				     "device claims to have extended capability 0x0c, but I'm not able to read it.\n");
-		else
-			info->ext_cap_0c =
-				(cap[0] << 16) | (cap[1] << 8) | cap[2];
 	}
 
 	return 0;
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 31652d98b8f7..87fbe5b53803 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -52,7 +52,8 @@
 #define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
 #define SYN_CAP_SUBMODEL_ID(c)		(((c) & 0x00ff00) >> 8)
 #define SYN_EXT_CAP_REQUESTS(c)		(((c) & 0x700000) >> 20)
-#define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)
+#define SYN_CAP_MB_MASK			GENMASK(15, 12)
+#define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & SYN_CAP_MB_MASK) >> 12)
 #define SYN_CAP_PRODUCT_ID(ec)		(((ec) & 0xff0000) >> 16)
 #define SYN_MEXT_CAP_BIT(m)		((m) & (1 << 1))
 
-- 
2.12.1.578.ge9c3154ca4-goog

