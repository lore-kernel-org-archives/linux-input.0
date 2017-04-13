From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: generic: Treat HID_DG_TOOLSERIALNUMBER as unsigned
Date: Thu, 13 Apr 2017 08:39:49 -0700
Message-ID: <20170413153949.23518-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35872 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbdDMPkT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2017 11:40:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

Because HID_DG_TOOLSERIALNUMBER doesn't first cast the value recieved
from HID to an unsigned type, sign-extension rules can cause the
value of wacom_wac->serial[0] to inadvertently wind up with all 32 of
its highest bits set if the highest bit of "value" was set.

This can cause problems for Tablet PC devices which use AES sensors
and the xf86-input-wacom userspace driver. It is not uncommon for AES
sensors to send a serial number of '0' while the pen is entering or
leaving proximity. The xf86-input-wacom driver ignores events with a
serial number of '0' since it cannot match them up to an in-use tool.
To ensure the xf86-input-wacom driver does not ignore the final
out-of-proximity event, the kernel does not send MSC_SERIAL events
when the value of wacom_wac->serial[0] is '0'. If the highest bit of
HID_DG_TOOLSERIALNUMBER is set by an in-prox pen which later leaves
proximity and sends a '0' for HID_DG_TOOLSERIALNUMBER, then only the
lowest 32 bits of wacom_wac->serial[0] are actually cleared, causing
the kernel to send an MSC_SERIAL event. Since the 'input_event'
function takes an 'int' as argument, only those lowest (now-cleared)
32 bits of wacom_wac->serial[0] are sent to userspace, causing
xf86-input-wacom to ignore the event. If the event was the final
out-of-prox event, then xf86-input-wacom may remain in a state where
it believes the pen is in proximity and refuses to allow other
devices under its control (e.g. the touchscreen) to move the cursor.

It should be noted that EMR devices and devices which use both the
HID_DG_TOOLSERIALNUMBER and WACOM_HID_WD_SERIALHI usages (in that
order) would be immune to this issue. It appears only AES devices are
affected.

Fixes: f85c9dc678a ("HID: wacom: generic: Support tool ID and additional tool types")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1f3bdd16e159..51cf3d5eb478 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2002,7 +2002,7 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		return;
 	case HID_DG_TOOLSERIALNUMBER:
 		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
-		wacom_wac->serial[0] |= value;
+		wacom_wac->serial[0] |= (__u32)value;
 		return;
 	case WACOM_HID_WD_SENSE:
 		wacom_wac->hid_data.sense_state = value;
-- 
2.12.0

