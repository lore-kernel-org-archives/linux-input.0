From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Call 'wacom_query_tablet_data' only after 'hid_hw_start'
Date: Mon,  2 Nov 2015 15:41:11 -0800
Message-ID: <1446507673-4458-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34426 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbKBXlu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 18:41:50 -0500
Received: by padec8 with SMTP id ec8so65386pad.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 15:41:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

When connecting the Cintiq Companion 2 as an external tablet (i.e., using
it in "hybrid" mode) it has been seen to cause the kernel of the machine
it is connected to to Oops. The cause has been traced to us attempting to
switch the tablet's mode prior to actually starting HID device (resulting
in the eventual dereference of the uninitialized control URB).

This has not been an issue in the past since we've historically used
'hid_hw_raw_request' to perform the mode switch. HID_GENERIC devices,
however use 'hid_hw_request' which assumes that 'hid_hw_start' has already
been called. That we've not encountered problems beforehand seems to
be entirely due to luck.

Since the timing of the mode switch is not critical, we can simply
move it to occur after the call to 'hid_hw_start'. Alternately, we
could have potentially modified 'wacom_hid_set_device_mode' to use
'hid_hw_raw_reqest'.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri,

Please mark this for stable since it possible other HID_GENERIC 
devices may trigger this Oops as well.

Thanks,
Jason

 drivers/hid/wacom_sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b4de325..45656e8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1778,9 +1778,6 @@ static int wacom_probe(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
 
-	/* Note that if query fails it is not a hard failure */
-	wacom_query_tablet_data(hdev, features);
-
 	/* touch only Bamboo doesn't support pen */
 	if ((features->type == BAMBOO_TOUCH) &&
 	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
@@ -1833,6 +1830,9 @@ static int wacom_probe(struct hid_device *hdev,
 		goto fail_hw_start;
 	}
 
+	/* Note that if query fails it is not a hard failure */
+	wacom_query_tablet_data(hdev, features);
+
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
-- 
2.6.2

