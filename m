From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 08/12] HID: uhid: keep legacy definitions at the bottom of uhid.h
Date: Tue, 29 Jul 2014 17:14:22 +0200
Message-ID: <1406646866-999-9-git-send-email-dh.herrmann@gmail.com>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45496 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbaG2PPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:15:00 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so9137258wgg.4
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:58 -0700 (PDT)
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Instead of inlining the legacy definitions into the main part of uhid.h,
keep them at the bottom now. This way, the API is much easier to read and
legacy requests can be looked up at a separate place.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/uapi/linux/uhid.h | 101 ++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index 0a08f2b..116536e 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -24,37 +24,21 @@
 #include <linux/hid.h>
 
 enum uhid_event_type {
-	UHID_CREATE,
+	__UHID_LEGACY_CREATE,
 	UHID_DESTROY,
 	UHID_START,
 	UHID_STOP,
 	UHID_OPEN,
 	UHID_CLOSE,
 	UHID_OUTPUT,
-	UHID_OUTPUT_EV,			/* obsolete! */
-	UHID_INPUT,
-	UHID_FEATURE,			/* obsolete! use UHID_GET_REPORT */
-	UHID_GET_REPORT = UHID_FEATURE,
-	UHID_FEATURE_ANSWER,		/* obsolete! use UHID_GET_REPORT_REPLY */
-	UHID_GET_REPORT_REPLY = UHID_FEATURE_ANSWER,
+	__UHID_LEGACY_OUTPUT_EV,
+	__UHID_LEGACY_INPUT,
+	UHID_GET_REPORT,
+	UHID_GET_REPORT_REPLY,
 	UHID_CREATE2,
 	UHID_INPUT2,
 };
 
-struct uhid_create_req {
-	__u8 name[128];
-	__u8 phys[64];
-	__u8 uniq[64];
-	__u8 __user *rd_data;
-	__u16 rd_size;
-
-	__u16 bus;
-	__u32 vendor;
-	__u32 product;
-	__u32 version;
-	__u32 country;
-} __attribute__((__packed__));
-
 struct uhid_create2_req {
 	__u8 name[128];
 	__u8 phys[64];
@@ -76,24 +60,67 @@ enum uhid_report_type {
 	UHID_INPUT_REPORT,
 };
 
-struct uhid_input_req {
+struct uhid_input2_req {
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+} __attribute__((__packed__));
+
+struct uhid_output_req {
 	__u8 data[UHID_DATA_MAX];
 	__u16 size;
+	__u8 rtype;
 } __attribute__((__packed__));
 
-struct uhid_input2_req {
+struct uhid_get_report_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+} __attribute__((__packed__));
+
+struct uhid_get_report_reply_req {
+	__u32 id;
+	__u16 err;
 	__u16 size;
 	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
-struct uhid_output_req {
+/*
+ * Compat Layer
+ * All these commands and requests are obsolete. You should avoid using them in
+ * new code. We support them for backwards-compatibility, but you might not get
+ * access to new feature in case you use them.
+ */
+
+enum uhid_legacy_event_type {
+	UHID_CREATE			= __UHID_LEGACY_CREATE,
+	UHID_OUTPUT_EV			= __UHID_LEGACY_OUTPUT_EV,
+	UHID_INPUT			= __UHID_LEGACY_INPUT,
+	UHID_FEATURE			= UHID_GET_REPORT,
+	UHID_FEATURE_ANSWER		= UHID_GET_REPORT_REPLY,
+};
+
+/* Obsolete! Use UHID_CREATE2. */
+struct uhid_create_req {
+	__u8 name[128];
+	__u8 phys[64];
+	__u8 uniq[64];
+	__u8 __user *rd_data;
+	__u16 rd_size;
+
+	__u16 bus;
+	__u32 vendor;
+	__u32 product;
+	__u32 version;
+	__u32 country;
+} __attribute__((__packed__));
+
+/* Obsolete! Use UHID_INPUT2. */
+struct uhid_input_req {
 	__u8 data[UHID_DATA_MAX];
 	__u16 size;
-	__u8 rtype;
 } __attribute__((__packed__));
 
-/* Obsolete! Newer kernels will no longer send these events but instead convert
- * it into raw output reports via UHID_OUTPUT. */
+/* Obsolete! Kernel uses UHID_OUTPUT exclusively now. */
 struct uhid_output_ev_req {
 	__u16 type;
 	__u16 code;
@@ -107,12 +134,6 @@ struct uhid_feature_req {
 	__u8 rtype;
 } __attribute__((__packed__));
 
-struct uhid_get_report_req {
-	__u32 id;
-	__u8 rnum;
-	__u8 rtype;
-} __attribute__((__packed__));
-
 /* Obsolete! Use ABI compatible UHID_GET_REPORT_REPLY. */
 struct uhid_feature_answer_req {
 	__u32 id;
@@ -121,12 +142,14 @@ struct uhid_feature_answer_req {
 	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
-struct uhid_get_report_reply_req {
-	__u32 id;
-	__u16 err;
-	__u16 size;
-	__u8 data[UHID_DATA_MAX];
-} __attribute__((__packed__));
+/*
+ * UHID Events
+ * All UHID events from and to the kernel are encoded as "struct uhid_event".
+ * The "type" field contains a UHID_* type identifier. All payload depends on
+ * that type and can be accessed via ev->u.XYZ accordingly.
+ * If user-space writes short events, they're extended with 0s by the kernel. If
+ * the kernel writes short events, user-space shall extend them with 0s.
+ */
 
 struct uhid_event {
 	__u32 type;
-- 
2.0.3

