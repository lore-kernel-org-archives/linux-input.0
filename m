From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] HID: asus: Add T100TA touchpad resolution info
Date: Sun,  2 Jul 2017 16:34:14 +0200
Message-ID: <20170702143416.23643-4-hdegoede@redhat.com>
References: <20170702143416.23643-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdGBOeY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 10:34:24 -0400
In-Reply-To: <20170702143416.23643-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The touchpad code is only used with the T100TA touchpad which
measures 75.5 x 41.5 mm, add corresponding resolution info.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4ff4add14974..e27cc4a25ed0 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -86,6 +86,8 @@ struct asus_kbd_leds {
 struct asus_touchpad_info {
 	int max_x;
 	int max_y;
+	int res_x;
+	int res_y;
 	int contact_size;
 	int max_contacts;
 };
@@ -108,6 +110,8 @@ static const struct asus_touchpad_info asus_i2c_tp = {
 static const struct asus_touchpad_info asus_t100ta_tp = {
 	.max_x = 2240,
 	.max_y = 1120,
+	.res_x = 30, /* units/mm */
+	.res_y = 27, /* units/mm */
 	.contact_size = 5,
 	.max_contacts = 5,
 };
@@ -361,6 +365,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 				     drvdata->tp->max_x, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
 				     drvdata->tp->max_y, 0, 0);
+		input_abs_set_res(input, ABS_MT_POSITION_X, drvdata->tp->res_x);
+		input_abs_set_res(input, ABS_MT_POSITION_Y, drvdata->tp->res_y);
 		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
 		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, MAX_TOUCH_MAJOR, 0, 0);
 		input_set_abs_params(input, ABS_MT_PRESSURE, 0, MAX_PRESSURE, 0, 0);
-- 
2.13.0

