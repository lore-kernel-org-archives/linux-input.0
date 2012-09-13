From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] HID: lg: Remove unnecessary casts of void pointers
Date: Thu, 13 Sep 2012 14:08:32 +0800
Message-ID: <1347516512.3319.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40082 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2IMGIh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 02:08:37 -0400
Received: by obbuo13 with SMTP id uo13so3969446obb.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 23:08:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>, Michael Bauer <michael@m-bauer.org>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-lg.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index e6eca2d..55ce2bf 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -108,7 +108,7 @@ static __u8 dfp_rdesc_fixed[] = {
 static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hdev);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
 
 	if ((drv_data->quirks & LG_RDESC) && *rsize >= 90 && rdesc[83] == 0x26 &&
 			rdesc[84] == 0x8c && rdesc[85] == 0x02) {
@@ -277,7 +277,7 @@ static int lg_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		  0,  0,  0,  0,  0,183,184,185,186,187,
 		188,189,190,191,192,193,194,  0,  0,  0
 	};
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hdev);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
 	unsigned int hid = usage->hid;
 
 	if (hdev->product == USB_DEVICE_ID_LOGITECH_RECEIVER &&
@@ -318,7 +318,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hdev);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
 
 	if ((drv_data->quirks & LG_BAD_RELATIVE_KEYS) && usage->type == EV_KEY &&
 			(field->flags & HID_MAIN_ITEM_RELATIVE))
@@ -334,7 +334,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int lg_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hdev);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
 
 	if ((drv_data->quirks & LG_INVERT_HWHEEL) && usage->code == REL_HWHEEL) {
 		input_event(field->hidinput->input, usage->type, usage->code,
@@ -415,7 +415,7 @@ err_free:
 
 static void lg_remove(struct hid_device *hdev)
 {
-	struct lg_drv_data *drv_data = (struct lg_drv_data *)hid_get_drvdata(hdev);
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
 	if (drv_data->quirks & LG_FF4)
 		lg4ff_deinit(hdev);
 
-- 
1.7.9.5



