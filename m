From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Mon, 21 Dec 2009 00:22:59 -0800
Message-ID: <20091221082259.GG3234@core.coreip.homeip.net>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53157 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZLUIXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 03:23:07 -0500
Received: by pzk1 with SMTP id 1so3604453pzk.33
        for <linux-input@vger.kernel.org>; Mon, 21 Dec 2009 00:23:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091221074419.GD3234@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
> > Hi,
> > 
> > It seems that the force feedback works well, I have ported the force
> > feedback for my favorite game to linux now, and it works well.
> > 
> > What does not work is updating effects - there just nothing happens, and
> > the old event is played. I have circumvented this by
> > deleting/re-uploading the effect, but this should probably been made to
> > work. Does it work well with other hardware?
> > 
> > Thirdly, I have re-discovered one kernel oops that occurs if the
> > joystick is unplugged if some process still has the event device open.
> > Steps to reproduce:
> > * plug joystick in
> > * fftest /dev/input/eventXX
> > * unplug joystick
> > 
> > (kern.log extract attached)
> > 
> > Sometimes this just gives an oops, sometimes it escalates into a kernel
> > panic.
> > 
> 
> Hmm, it looks like iforce unbinding is completely busted:
> 
> static void iforce_usb_disconnect(struct usb_interface *intf)
> {
>         struct iforce *iforce = usb_get_intfdata(intf);
>         int open = 0; /* FIXME! iforce->dev.handle->open; */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>         usb_set_intfdata(intf, NULL);
>         if (iforce) {
>                 iforce->usbdev = NULL;
>                 input_unregister_device(iforce->dev);
> 
>                 if (!open) {
>                         iforce_delete_device(iforce);
>                         kfree(iforce);
>                 }
>         }
> }
> 
> 
> Any chance you could fix that FIXME ;) ?
> 

Actually, does the below fixes it for you?

-- 
Dmitry

Input: iforce - fix oops on device disconnect

Reported-by: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/iforce/iforce-main.c |   26 +++++--------------------
 drivers/input/joystick/iforce/iforce-usb.c  |   28 +++++++--------------------
 drivers/input/joystick/iforce/iforce.h      |    2 --
 3 files changed, 12 insertions(+), 44 deletions(-)


diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 47d8c43..df142df 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -218,7 +218,7 @@ static int iforce_open(struct input_dev *dev)
 	return 0;
 }
 
-static void iforce_release(struct input_dev *dev)
+static void iforce_close(struct input_dev *dev)
 {
 	struct iforce *iforce = input_get_drvdata(dev);
 	int i;
@@ -240,26 +240,10 @@ static void iforce_release(struct input_dev *dev)
 
 	switch (iforce->bus) {
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB:
-			usb_kill_urb(iforce->irq);
-
-			/* The device was unplugged before the file
-			 * was released */
-			if (iforce->usbdev == NULL) {
-				iforce_delete_device(iforce);
-				kfree(iforce);
-			}
-		break;
-#endif
-	}
-}
-
-void iforce_delete_device(struct iforce *iforce)
-{
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
 	case IFORCE_USB:
-		iforce_usb_delete(iforce);
+		usb_kill_urb(iforce->irq);
+		usb_kill_urb(iforce->out);
+		usb_kill_urb(iforce->ctrl);
 		break;
 #endif
 #ifdef CONFIG_JOYSTICK_IFORCE_232
@@ -311,7 +295,7 @@ int iforce_init_device(struct iforce *iforce)
 
 	input_dev->name = "Unknown I-Force device";
 	input_dev->open = iforce_open;
-	input_dev->close = iforce_release;
+	input_dev->close = iforce_close;
 
 /*
  * On-device memory allocation.
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index ae2e8c6..3fc9f46 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -186,33 +186,19 @@ fail:
 	return err;
 }
 
-/* Called by iforce_delete() */
-void iforce_usb_delete(struct iforce* iforce)
-{
-	usb_kill_urb(iforce->irq);
-	usb_kill_urb(iforce->out);
-	usb_kill_urb(iforce->ctrl);
-
-	usb_free_urb(iforce->irq);
-	usb_free_urb(iforce->out);
-	usb_free_urb(iforce->ctrl);
-}
-
 static void iforce_usb_disconnect(struct usb_interface *intf)
 {
 	struct iforce *iforce = usb_get_intfdata(intf);
-	int open = 0; /* FIXME! iforce->dev.handle->open; */
 
 	usb_set_intfdata(intf, NULL);
-	if (iforce) {
-		iforce->usbdev = NULL;
-		input_unregister_device(iforce->dev);
 
-		if (!open) {
-			iforce_delete_device(iforce);
-			kfree(iforce);
-		}
-	}
+	input_unregister_device(iforce->dev);
+
+	usb_free_urb(iforce->irq);
+	usb_free_urb(iforce->out);
+	usb_free_urb(iforce->ctrl);
+
+	kfree(iforce);
 }
 
 static struct usb_device_id iforce_usb_ids [] = {
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 1a76ca1..7fa7b5d 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -151,11 +151,9 @@ void iforce_serial_xmit(struct iforce *iforce);
 
 /* iforce-usb.c */
 void iforce_usb_xmit(struct iforce *iforce);
-void iforce_usb_delete(struct iforce *iforce);
 
 /* iforce-main.c */
 int iforce_init_device(struct iforce *iforce);
-void iforce_delete_device(struct iforce *iforce);
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
