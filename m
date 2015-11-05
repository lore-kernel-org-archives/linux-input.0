From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] usbhid: discarded events don't abort idleness
Date: Thu,  5 Nov 2015 12:55:27 +0100
Message-ID: <1446724527-27736-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52028 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965471AbbKEL5L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Nov 2015 06:57:11 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7582FAAF4
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2015 11:56:51 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.com, linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>

If an event is discarded the device stays idle.
Just reverse the order of check and marking busy.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 36712e9..19a4364 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -274,10 +274,10 @@ static void hid_irq_in(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:			/* success */
-		usbhid_mark_busy(usbhid);
 		usbhid->retry_delay = 0;
 		if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) && !hid->open)
 			break;
+		usbhid_mark_busy(usbhid);
 		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
 			hid_input_report(urb->context, HID_INPUT_REPORT,
 					 urb->transfer_buffer,
-- 
2.1.4

