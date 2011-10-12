From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: possible race between reset and error handling in usbhid
Date: Wed, 12 Oct 2011 16:14:23 +0200
Message-ID: <201110121614.23410.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

looking at the usbhid code it seems to me that there is no protection
between the error handling code and pre_reset() racing.

In particular there seems to be no protection from hid_retry_timeout() calling
hid_start_in() which would start IO after hid_pre_reset() has already called
hid_cease_io() because that uses del_timer(), not del_timer_sync()

What do you think about this patch?

	Regards
		Oliver

>From d13b3b42669cfbed3716d040cc8ce489fecd6963 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Wed, 12 Oct 2011 10:54:54 +0200
Subject: [PATCH] USB: usbhid: cancel timer for retry synchronously

This makes sure IO is never restarted while a reset is going on

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ad978f5..77e705c 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1270,7 +1270,7 @@ static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
 
 static void hid_cease_io(struct usbhid_device *usbhid)
 {
-	del_timer(&usbhid->io_retry);
+	del_timer_sync(&usbhid->io_retry);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbctrl);
 	usb_kill_urb(usbhid->urbout);
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
