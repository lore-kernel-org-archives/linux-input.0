From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Use calculated pkglen for wireless touch interface
Date: Mon,  3 Aug 2015 10:17:03 -0700
Message-ID: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34445 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbbHCRRT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 13:17:19 -0400
Received: by pawu10 with SMTP id u10so17182070paw.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 10:17:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit 01c846f introduced the 'wacom_compute_pktlen' function which
automatically determines the correct value for an interface's pkglen
by scanning the HID descriptor. This function returns the correct
value for the wireless receiver's touch interface, removing the need
for us to set it manually here.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index d932349..a334332 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -457,7 +457,6 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 			features->device_type = WACOM_DEVICETYPE_NONE;
 		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
 			features->device_type |= WACOM_DEVICETYPE_TOUCH;
-			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 		}
 	}
 
-- 
2.4.6

