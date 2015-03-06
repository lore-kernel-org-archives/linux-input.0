From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: add support of clickpads
Date: Fri,  6 Mar 2015 11:14:42 -0500
Message-ID: <1425658482-13330-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbCFQOt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Mar 2015 11:14:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Touchpads that have only one button are called clickpads and should
be advertised as such by the kernel.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

this has been on my local tree for nearly a year now, but I never really
managed to take the time to make it working properly.
Jason raised the subject yesterday, so I finally had a look and fixed the
last bugs.

All the current touchscreens I have the logs are not showing INPUT_PROP_BUTTONPAD
as expected, so I think this should be fine to go upstream.

Cheers,
Benjamin

 drivers/hid/hid-multitouch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b61715f..a8bec33 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -115,6 +115,7 @@ struct mt_device {
 	__u8 touches_by_report;	/* how many touches are present in one report:
 				* 1 means we should use a serial protocol
 				* > 1 means hybrid (multitouch) protocol */
+	__u8 buttons_count;	/* number of physical buttons per touchpad */
 	bool serial_maybe;	/* need to check for serial protocol */
 	bool curvalid;		/* is the current contact valid? */
 	unsigned mt_flags;	/* flags to pass to input-mt */
@@ -378,6 +379,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
 
+	/* count the buttons on touchpads */
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
+		td->buttons_count++;
+
 	if (usage->usage_index)
 		prev_usage = &field->usage[usage->usage_index - 1];
 
@@ -727,6 +732,10 @@ static void mt_touch_input_configured(struct hid_device *hdev,
 	if (cls->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
 		td->mt_flags |= INPUT_MT_DROP_UNUSED;
 
+	/* check for clickpads */
+	if ((td->mt_flags & INPUT_MT_POINTER) && (td->buttons_count == 1))
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
 	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
 
 	td->mt_flags = 0;
-- 
2.1.0

