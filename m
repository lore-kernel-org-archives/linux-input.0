From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: handle external buttons for Precision Touchpads
Date: Fri, 25 Nov 2016 11:08:10 +0100
Message-ID: <1480068490-32765-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbcKYKIN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 05:08:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Chris Chiu <chiu@endlessm.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

According to https://msdn.microsoft.com/en-us/library/windows/hardware/mt604195(v=vs.85).aspx
external buttons have some weird usage mapping:
- Button 2 Indicates Button State for external button for primary
  (default left) clicking.
- Button 3 Indicates Button State for external button for secondary
  (default right) clicking.

So in the current state, the buttons are mapped to right and middle.
Move the usage by one to correctly map the external buttons.

Tested-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index da7b68b..e6f6a6c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -570,6 +570,14 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 	case HID_UP_BUTTON:
 		code = BTN_MOUSE + ((usage->hid - 1) & HID_USAGE);
+		/*
+		 * MS PTP spec says that external buttons left and right have
+		 * usages 2 and 3.
+		 */
+		if (cls->name == MT_CLS_WIN_8 &&
+		    field->application == HID_DG_TOUCHPAD &&
+		    (usage->hid & HID_USAGE) > 1)
+			code--;
 		hid_map_usage(hi, usage, bit, max, EV_KEY, code);
 		input_set_capability(hi->input, EV_KEY, code);
 		return 1;
-- 
2.7.4

