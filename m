From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 04/18] HID: wacom: Detect and correct descriptors missing HID_DG_BARRELSWITCH2
Date: Fri,  7 Oct 2016 15:16:39 -0700
Message-ID: <20161007221653.26941-4-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36595 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757154AbcJGWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 18:18:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id z190so3303144qkc.3
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 15:17:10 -0700 (PDT)
In-Reply-To: <20161007221653.26941-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

ISDv4 devices have long supported reporting data from each of two barrel
switches, but HID_DG_BARRELSWITCH2 itself was only recently standardized.
Prior to its adoption, ISDv4 devices would associate the bit indicating
the state of the second barrel switch with the "Undefined" 0x000D0000
usage. Although most such devices have explicit support, a few use the
HID_GENERIC codepath which ignores the "Undefined" usage.

This patch adds code which detects the presence of a pre-standard second
barrel switch and corrects the usage value so that the HID_GENERIC code
will declare its presence and report its state.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 773fa11..033cc03 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -240,6 +240,30 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 			features->touch_max = 1;
 	}
 
+	/*
+	 * ISDv4 devices which predate HID's adoption of the
+	 * HID_DG_BARELSWITCH2 usage use 0x000D0000 in its
+	 * position instead. We can accurately detect if a
+	 * usage with that value should be HID_DG_BARRELSWITCH2
+	 * based on the surrounding usages, which have remained
+	 * constant across generations.
+	 */
+	if (features->type == HID_GENERIC &&
+	    usage->hid == 0x000D0000 &&
+	    field->application == HID_DG_PEN &&
+	    field->physical == HID_DG_STYLUS) {
+		int i = usage->usage_index;
+
+		if (i-4 >= 0 && i+1 < field->maxusage &&
+		    field->usage[i-4].hid == HID_DG_TIPSWITCH &&
+		    field->usage[i-3].hid == HID_DG_BARRELSWITCH &&
+		    field->usage[i-2].hid == HID_DG_ERASER &&
+		    field->usage[i-1].hid == HID_DG_INVERT &&
+		    field->usage[i+1].hid == HID_DG_INRANGE) {
+			usage->hid = HID_DG_BARRELSWITCH2;
+		}
+	}
+
 	switch (usage->hid) {
 	case HID_GD_X:
 		features->x_max = field->logical_maximum;
-- 
2.10.0

