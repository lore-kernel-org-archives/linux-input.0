From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2] HID: wacom: Call 'wacom_query_tablet_data' only after 'hid_hw_start'
Date: Tue,  3 Nov 2015 16:57:58 -0800
Message-ID: <1446598678-1908-1-git-send-email-killertofu@gmail.com>
References: <CAF8JNhLjUCmQ30+fQG7_a0xHr6kCG-Kq_-q8T_8T90gs2qLPMw@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35790 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbbKDA6J (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 19:58:09 -0500
Received: by pasz6 with SMTP id z6so34819594pas.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2015 16:58:08 -0800 (PST)
In-Reply-To: <CAF8JNhLjUCmQ30+fQG7_a0xHr6kCG-Kq_-q8T_8T90gs2qLPMw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

When connecting the Cintiq Companion 2 as an external tablet (i.e., using
it in "hybrid" mode) it has been seen to cause the kernel of the machine
it is connected to to Oops. The cause has been traced to us attempting to
switch the tablet's mode prior to actually starting HID device (resulting
in the eventual dereference of the uninitialized control URB).

Commit 3b164a0 moved the mode switch from occuring post-start to occurring
pre-start. The change was not seen to cause issues largely due to the fact
that most devices mode switch with 'hid_hw_raw_request' (which is safe to
call prior to start) rather than 'hid_hw_request'.

Moving the call back to its original location resolves the issue, but
causes some touch-only Bamboo tablets (e.g. 056a:00d0) to stop working.
The affected tablets require us to perform a mode switch on their
vestigial pen interface prior ignoring with -ENODEV, meaning that the
code which is responsible for doing the ignoring has to move as well.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri,

Ping clued me in to the fact that 'wacom_query_tablet_data' hasn't always 
been in this problematic location. The offending commit mentioned in the 
revised commit summary is queued for 4.4, so this only needs to get into 
the next RC rather than be targeted for stable.

Jason

 drivers/hid/wacom_sys.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index abb7fdf..e06af5b 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1778,24 +1778,6 @@ static int wacom_probe(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
 
-	/* Note that if query fails it is not a hard failure */
-	wacom_query_tablet_data(hdev, features);
-
-	/* touch only Bamboo doesn't support pen */
-	if ((features->type == BAMBOO_TOUCH) &&
-	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
-		error = -ENODEV;
-		goto fail_shared_data;
-	}
-
-	/* pen only Bamboo neither support touch nor pad */
-	if ((features->type == BAMBOO_PEN) &&
-	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
-	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
-		error = -ENODEV;
-		goto fail_shared_data;
-	}
-
 	wacom_calculate_res(features);
 
 	wacom_update_name(wacom);
@@ -1833,6 +1815,24 @@ static int wacom_probe(struct hid_device *hdev,
 		goto fail_hw_start;
 	}
 
+	/* Note that if query fails it is not a hard failure */
+	wacom_query_tablet_data(hdev, features);
+
+	/* touch only Bamboo doesn't support pen */
+	if ((features->type == BAMBOO_TOUCH) &&
+	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
+		error = -ENODEV;
+		goto fail_hw_start;
+	}
+
+	/* pen only Bamboo neither support touch nor pad */
+	if ((features->type == BAMBOO_PEN) &&
+	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
+	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
+		error = -ENODEV;
+		goto fail_hw_start;
+	}
+
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
-- 
2.6.2

