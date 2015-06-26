From: Tom Gundersen <teg@jklm.no>
Subject: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 21:24:07 +0200
Message-ID: <1435346647-29473-1-git-send-email-teg@jklm.no>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36427 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbFZTYX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jun 2015 15:24:23 -0400
Received: by lacny3 with SMTP id ny3so69214985lac.3
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2015 12:24:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>, Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This policy used to be unconditionally applied by udev, but there
is no reason to make userspace be involved in this and in the future
udev will not be doing it by default.

See: <https://github.com/systemd/systemd/pull/353>.

Signed-off-by: Tom Gundersen <teg@jklm.no>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Hi,

I don't have the right hardware for this, so it has only been compile-tested.
I'm therefore sending it as an RFC only. Mainly I want to bring it to people's
attention that it would be great to get this feature into the kernel as we want
to drop it from udev.

Cheers,

Tom

 drivers/hid/usbhid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index bfbe1be..af80700 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1358,6 +1358,9 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 	spin_lock_init(&usbhid->lock);
 
+	if (dev->removable == USB_DEVICE_FIXED)
+		usb_enable_autosuspend(dev);
+
 	ret = hid_add_device(hid);
 	if (ret) {
 		if (ret != -ENODEV)
-- 
2.4.3

