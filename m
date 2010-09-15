From: Alan Ott <alan@signal11.us>
Subject: [PATCH 1/1] Don't Send Feature Reports on Interrupt Endpoint
Date: Wed, 15 Sep 2010 10:45:09 -0400
Message-ID: <1284561909-14350-1-git-send-email-alan@signal11.us>
References: <ba7172472e7fa92f305c16ab3456da18.squirrel@host171.canaca.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:40943 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab0IOOph (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 10:45:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 44E6C1CCAA6D
	for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 10:45:36 -0400 (EDT)
In-Reply-To: <ba7172472e7fa92f305c16ab3456da18.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, linux
Cc: Alan Ott <alan@signal11.us>

Feature reports should only be sent on the control endpoint.

Reported-by: simon@mungewell.org
Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/usbhid/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b729c02..b0ccc42 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -807,7 +807,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	int ret;
 
-	if (usbhid->urbout) {
+	if (usbhid->urbout && report_type != HID_FEATURE_REPORT) {
 		int actual_length;
 		int skipped_report_id = 0;
 		if (buf[0] == 0x0) {
-- 
1.7.0.4


