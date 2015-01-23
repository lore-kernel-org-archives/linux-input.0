From: Jim Keir <jimkeir@oracledbadirect.com>
Subject: [PATCH 1/2] Fix initialisation for the Microsoft Sidewinder Force Feedback Pro 2 joystick
Date: Fri, 23 Jan 2015 17:21:12 +0000
Message-ID: <0000014b17cfda93-ba54b0fb-23f4-4005-95c1-6ae695a48369-000000@email.amazonses.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a8-41.smtp-out.amazonses.com ([54.240.8.41]:45939 "EHLO
	a8-41.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932106AbbAWRnD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 12:43:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz
Cc: Jim Keir <jimkeir@oracledbadirect.com>

---
Hi,

Changes from previous patches:
- All changes removed from higher-level files
- Calls to hid_device_io_start/stop added here

Signed-off-by: Jim Keir <jimkeir@oracledbadirect.com> 

 drivers/hid/usbhid/hid-pidff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 10b6167..0b531c6 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1252,6 +1252,8 @@ int hid_pidff_init(struct hid_device *hid)
 
 	pidff->hid = hid;
 
+	hid_device_io_start(hid);
+
 	pidff_find_reports(hid, HID_OUTPUT_REPORT, pidff);
 	pidff_find_reports(hid, HID_FEATURE_REPORT, pidff);
 
@@ -1315,9 +1317,13 @@ int hid_pidff_init(struct hid_device *hid)
 
 	hid_info(dev, "Force feedback for USB HID PID devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
 
+	hid_device_io_stop(hid);
+
 	return 0;
 
  fail:
+	hid_device_io_stop(hid);
+
 	kfree(pidff);
 	return error;
 }
-- 
1.9.1

