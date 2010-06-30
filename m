From: Alan Ott <alan@signal11.us>
Subject: [PATCH 1/1] HID: Send Report ID when numbered reports are sent over the control endpoint.
Date: Wed, 30 Jun 2010 09:50:36 -0400
Message-ID: <1277905836-3949-2-git-send-email-alan@signal11.us>
References: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:48585 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756005Ab0F3NvA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:51:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 61E8A104068
	for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 09:50:59 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, Anton
Cc: Alan Ott <alan@signal11.us>

The Report ID wasn't sent as part of the payload for reports which were sent
over the control endpoint. This is required by section 8.1 of the HID spec.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/usbhid/hid-core.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index deef816..1697687 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -854,14 +854,21 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 				ret++;
 		}
 	} else {
+		int skipped_report_id = 0;
+		if (buf[0] == 0x0) {
+			/* Don't send the Report ID */
+			buf++;
+			count--;
+			skipped_report_id = 1;
+		}
 		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			HID_REQ_SET_REPORT,
 			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 			((report_type + 1) << 8) | *buf,
-			interface->desc.bInterfaceNumber, buf + 1, count - 1,
+			interface->desc.bInterfaceNumber, buf, count,
 			USB_CTRL_SET_TIMEOUT);
-		/* count also the report id */
-		if (ret > 0)
+		/* count also the report id, if this was a numbered report. */
+		if (ret > 0 && skipped_report_id)
 			ret++;
 	}
 
-- 
1.7.0.4


