From: Simon Wood <simon@mungewell.org>
Subject: [RFC 2/5] HID: hid-logitech-hidpp: Add support for very long packets
Date: Fri, 23 Oct 2015 11:27:24 -0600
Message-ID: <1445621247-18806-2-git-send-email-simon@mungewell.org>
References: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Patch add support for the 'very long' HID++ packets, which are
64 bytes in length.
---
 drivers/hid/hid-logitech-hidpp.c | 59 ++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4841964..c343b23 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -35,9 +35,11 @@ MODULE_PARM_DESC(disable_raw_mode,
 
 #define REPORT_ID_HIDPP_SHORT			0x10
 #define REPORT_ID_HIDPP_LONG			0x11
+#define REPORT_ID_HIDPP_VERY_LONG		0x12
 
 #define HIDPP_REPORT_SHORT_LENGTH		7
 #define HIDPP_REPORT_LONG_LENGTH		20
+#define HIDPP_REPORT_VERY_LONG_LENGTH		64
 
 #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
@@ -71,13 +73,13 @@ MODULE_PARM_DESC(disable_raw_mode,
 struct fap {
 	u8 feature_index;
 	u8 funcindex_clientid;
-	u8 params[HIDPP_REPORT_LONG_LENGTH - 4U];
+	u8 params[HIDPP_REPORT_VERY_LONG_LENGTH - 4U];
 };
 
 struct rap {
 	u8 sub_id;
 	u8 reg_address;
-	u8 params[HIDPP_REPORT_LONG_LENGTH - 4U];
+	u8 params[HIDPP_REPORT_VERY_LONG_LENGTH - 4U];
 };
 
 struct hidpp_report {
@@ -143,6 +145,9 @@ static int __hidpp_send_report(struct hid_device *hdev,
 	case REPORT_ID_HIDPP_LONG:
 		fields_count = HIDPP_REPORT_LONG_LENGTH;
 		break;
+	case REPORT_ID_HIDPP_VERY_LONG:
+		fields_count = HIDPP_REPORT_VERY_LONG_LENGTH;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -207,8 +212,9 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 		goto exit;
 	}
 
-	if (response->report_id == REPORT_ID_HIDPP_LONG &&
-	    response->fap.feature_index == HIDPP20_ERROR) {
+	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
+			response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
+			response->fap.feature_index == HIDPP20_ERROR) {
 		ret = response->fap.params[1];
 		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
 		goto exit;
@@ -233,7 +239,11 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
 	if (!message)
 		return -ENOMEM;
-	message->report_id = REPORT_ID_HIDPP_LONG;
+
+	if (param_count > (HIDPP_REPORT_LONG_LENGTH - 4))
+		message->report_id = REPORT_ID_HIDPP_VERY_LONG;
+	else
+		message->report_id = REPORT_ID_HIDPP_LONG;
 	message->fap.feature_index = feat_index;
 	message->fap.funcindex_clientid = funcindex_clientid;
 	memcpy(&message->fap.params, params, param_count);
@@ -248,13 +258,23 @@ static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	struct hidpp_report *response)
 {
 	struct hidpp_report *message;
-	int ret;
+	int ret, max_count;
 
-	if ((report_id != REPORT_ID_HIDPP_SHORT) &&
-	    (report_id != REPORT_ID_HIDPP_LONG))
+	switch (report_id) {
+	case REPORT_ID_HIDPP_SHORT:
+		max_count = HIDPP_REPORT_SHORT_LENGTH - 4;
+		break;
+	case REPORT_ID_HIDPP_LONG:
+		max_count = HIDPP_REPORT_LONG_LENGTH - 4;
+		break;
+	case REPORT_ID_HIDPP_VERY_LONG:
+		max_count = HIDPP_REPORT_VERY_LONG_LENGTH - 4;
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	if (param_count > sizeof(message->rap.params))
+	if (param_count > max_count)
 		return -EINVAL;
 
 	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
@@ -498,10 +518,19 @@ static int hidpp_devicenametype_get_device_name(struct hidpp_device *hidpp,
 	if (ret)
 		return ret;
 
-	if (response.report_id == REPORT_ID_HIDPP_LONG)
+	switch (response.report_id) {
+	case REPORT_ID_HIDPP_VERY_LONG:
+		count = HIDPP_REPORT_VERY_LONG_LENGTH - 4;
+		break;
+	case REPORT_ID_HIDPP_LONG:
 		count = HIDPP_REPORT_LONG_LENGTH - 4;
-	else
+		break;
+	case REPORT_ID_HIDPP_SHORT:
 		count = HIDPP_REPORT_SHORT_LENGTH - 4;
+		break;
+	default:
+		return -EPROTO;
+	}
 
 	if (len_buf < count)
 		count = len_buf;
@@ -1220,6 +1249,14 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	/* Generic HID++ processing. */
 	switch (data[0]) {
+	case REPORT_ID_HIDPP_VERY_LONG:
+		if (size != HIDPP_REPORT_VERY_LONG_LENGTH) {
+			hid_err(hdev, "received hid++ report of bad size (%d)",
+				size);
+			return 1;
+		}
+		ret = hidpp_raw_hidpp_event(hidpp, data, size);
+		break;
 	case REPORT_ID_HIDPP_LONG:
 		if (size != HIDPP_REPORT_LONG_LENGTH) {
 			hid_err(hdev, "received hid++ report of bad size (%d)",
-- 
2.1.4
