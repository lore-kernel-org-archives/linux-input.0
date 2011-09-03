From: Benson Leung <bleung@chromium.org>
Subject: [PATCH] HID: usbhid: fix suspend timeout due to RUNNING bits
Date: Fri,  2 Sep 2011 17:07:27 -0700
Message-ID: <1315008447-11012-1-git-send-email-bleung@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49265 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1ICAH6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2011 20:07:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bleung@chromium.org

hid_submit_ctrl and hid_submit_out should return error
codes when HID_REPORTED_IDLE is set by hid_suspend.
This will allow the output and control completion
handlers to clear HID_OUT_RUNNING and HID_CTRL_RUNNING
so hid_suspend succeeds.

Previously, if there were outstanding out messages
or control messages while hid_suspend was called,
hid_suspend would fail because usbhid_wait_io would time
out.

This condition happens with USB keyboards with both capslock and
numlock leds enabled at suspend time. Control requests
will come down to the hid-core to disable both leds, with
hid_suspend being called between the two being submitted.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/hid/usbhid/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a9fa294..cf5c106 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -326,6 +326,8 @@ static int hid_submit_out(struct hid_device *hid)
 			return -1;
 		}
 		usbhid->last_out = jiffies;
+	} else {
+		return -1;
 	}
 
 	return 0;
@@ -385,6 +387,8 @@ static int hid_submit_ctrl(struct hid_device *hid)
 			return -1;
 		}
 		usbhid->last_ctrl = jiffies;
+	} else {
+		return -1;
 	}
 
 	return 0;
-- 
1.7.1

