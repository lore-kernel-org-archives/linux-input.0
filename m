From: Scott Bauer <sbauer@plzdonthack.me>
Subject: [PATCH] Validate num_values for HIDIOCGUSAGES, HIDIOCSUSAGES commands.
Date: Thu, 23 Jun 2016 08:59:47 -0600
Message-ID: <1466693987-15363-1-git-send-email-sbauer@plzdonthack.me>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bout01.mta.xmission.com ([166.70.11.15]:39143 "EHLO
	bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcFWPXi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 11:23:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, wmealing@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Scott Bauer <sbauer@plzdonthack.me>

This patch validates the num_values parameter from userland during
the HIDIOCGUSAGES and HIDIOCSUSAGES commands. Previously, if the
report id was set to HID_REPORT_ID_UNKNOWN, we would fail to
validate the num_values parameter leading to a heap overflow.

Signed-off-by: Scott Bauer <sbauer@plzdonthack.me>
---
 drivers/hid/usbhid/hiddev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 2f1ddca..700145b 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -516,13 +516,13 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 					goto inval;
 			} else if (uref->usage_index >= field->report_count)
 				goto inval;
-
-			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
-				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-				  uref->usage_index + uref_multi->num_values > field->report_count))
-				goto inval;
 		}
 
+		if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
+		    (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
+		     uref->usage_index + uref_multi->num_values > field->report_count))
+			goto inval;
+
 		switch (cmd) {
 		case HIDIOCGUSAGE:
 			uref->value = field->value[uref->usage_index];
-- 
1.9.1

