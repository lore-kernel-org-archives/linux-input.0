From: Alan Ott <alan@signal11.us>
Subject: [PATCH 1/1] usbhid: Set Report ID properly for Output reports on the Control endpoint.
Date: Tue, 17 Aug 2010 00:44:04 -0400
Message-ID: <1282020244-25786-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:56302 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab0HQEob (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 00:44:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id E006E1CCAA46
	for <linux-input@vger.kernel.org>; Tue, 17 Aug 2010 00:44:30 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, linux
Cc: Alan Ott <alan@signal11.us>

When I made commit 29129a98e6fc89, I didn't account for *buf not being
the report ID anymore, as buf is incremented.

This applies to 2.6.35 and newer.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/usbhid/hid-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b729c02..ffd6899 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -828,6 +828,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 		}
 	} else {
 		int skipped_report_id = 0;
+		int report_id = buf[0];
 		if (buf[0] == 0x0) {
 			/* Don't send the Report ID */
 			buf++;
@@ -837,7 +838,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			HID_REQ_SET_REPORT,
 			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			((report_type + 1) << 8) | *buf,
+			((report_type + 1) << 8) | report_id,
 			interface->desc.bInterfaceNumber, buf, count,
 			USB_CTRL_SET_TIMEOUT);
 		/* count also the report id, if this was a numbered report. */
-- 
1.7.0.4


