From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Regression during 4.13 merge window: Mouse not working (under X)
Date: Wed, 12 Jul 2017 14:55:17 -0700
Message-ID: <20170712215517.GA22123@dtor-ws>
References: <CAOesGMheE95s75AAz7+H5SPSF068XxAZudWOrEi_FQj_Krkffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34671 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbdGLVzU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 17:55:20 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMheE95s75AAz7+H5SPSF068XxAZudWOrEi_FQj_Krkffg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 12, 2017 at 02:45:18PM -0700, Olof Johansson wrote:
> Dmitry,
> 
> I installed current mainline (as of 3b06b1a744) on a z840 here, and
> lost the mouse.
> 
> Bisecting down, it seems like "HID: usbhid: remove custom locking from
> usbhid_open/close" (e399396a6b0) is at fault, and if I revert that and
> 283a21da1239 I get a working system again. Userspace is Ubuntu 16.04.

Olof, does the patch below work for you?

-- 
Dmitry

HID: usbhid: fix "always poll" quirk

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Even though the IO for devices with "always poll" quirk is already running,
we still need to set HID_OPENED bit in usbhid->iofl so the interrupt
handler does not ignore the data coming from the device.

Reported-by: Olof Johansson <olof@lixom.net>
Fixes: e399396a6b0 ("HID: usbhid: remove custom locking from usbhid_open...")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 76013eb5cb7f..c008847e0b20 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -680,18 +680,21 @@ static int usbhid_open(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int res;
 
+	set_bit(HID_OPENED, &usbhid->iofl);
+
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
 		return 0;
 
 	res = usb_autopm_get_interface(usbhid->intf);
 	/* the device must be awake to reliably request remote wakeup */
-	if (res < 0)
+	if (res < 0) {
+		clear_bit(HID_OPENED, &usbhid->iofl);
 		return -EIO;
+	}
 
 	usbhid->intf->needs_remote_wakeup = 1;
 
 	set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
-	set_bit(HID_OPENED, &usbhid->iofl);
 	set_bit(HID_IN_POLLING, &usbhid->iofl);
 
 	res = hid_start_in(hid);
@@ -727,19 +730,20 @@ static void usbhid_close(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
-		return;
-
 	/*
 	 * Make sure we don't restart data acquisition due to
 	 * a resumption we no longer care about by avoiding racing
 	 * with hid_start_in().
 	 */
 	spin_lock_irq(&usbhid->lock);
-	clear_bit(HID_IN_POLLING, &usbhid->iofl);
 	clear_bit(HID_OPENED, &usbhid->iofl);
+	if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
+		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->lock);
 
+	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
+		return;
+
 	hid_cancel_delayed_stuff(usbhid);
 	usb_kill_urb(usbhid->urbin);
 	usbhid->intf->needs_remote_wakeup = 0;
