From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 00:44:31 +0200
Message-ID: <20111010224431.GA2377@polaris.bitmath.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010210534.GA2223@polaris.bitmath.org>
 <20111010211231.GA26359@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:44173 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab1JJWhr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 18:37:47 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id AEC12EAA4F
	for <linux-input@vger.kernel.org>; Tue, 11 Oct 2011 00:37:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111010211231.GA26359@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

On Mon, Oct 10, 2011 at 10:12:31PM +0100, Matthew Garrett wrote:
> On Mon, Oct 10, 2011 at 11:05:34PM +0200, Henrik Rydberg wrote:
> 
> > With this patch, autosuspend seems to work correctly after boot, while
> > keeping a device file open. When all device files are closed, the
> > looping suspend/resume behavior is still there. Moreover, when coming
> > back from a user suspend, rpm_suspend fails with EBUSY on my machine,
> > and the device will not autosuspend thereafter.
> 
> Is this with the patch I sent for usbhid earlier applied? Right now the 
> keyboard will fail to suspend after system suspend, which will keep the 
> entire composite device awake. I'm looking into your other issue now.

Ahh, yes, the suspend failure was due to the keyboard interface,
thanks. The loop-on-closed is still present, though (as expected,
since there is no usb_mark_last_busy() call).

Since the autosuspend removes the special handling of an open device,
we could simply the patch further, removing open/close altogether. The
patch below seems to work for all corner cases tested.

Cheers,
Henrik

>From 8a1e46bf45c6d43070447472757519a909fcaeb5 Mon Sep 17 00:00:00 2001
From: Matthew Garrett <mjg@redhat.com>
Date: Mon, 10 Oct 2011 11:47:10 -0400
Subject: [PATCH v3] input: Fix USB autosuspend on bcm5974

The bcm5974 code takes a USB autosuspend reference on device open and
releases it on device close. This means that the hardware won't sleep when
anything holds it open. This is sensible for input devices that don't
support remote wakeups on normal use (like most mice), but this hardware
trigger wakeups on touch and so can suspend transparently to the user. Doing
so allows the USB host controller to sleep when the machine is idle, giving
measurable power savings.

[rydberg@euromail.se: removal of open/close]
Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |   74 +++++++++++------------------------------
 1 files changed, 20 insertions(+), 54 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..178be2b 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -221,7 +221,7 @@ struct bcm5974 {
 	struct input_dev *input;	/* input dev */
 	struct bcm5974_config cfg;	/* device configuration */
 	struct mutex pm_mutex;		/* serialize access to open/suspend */
-	int opened;			/* 1: opened, 0: closed */
+	int started;			/* 1: started, 0: paused */
 	struct urb *bt_urb;		/* button usb request block */
 	struct bt_data *bt_data;	/* button transferred data */
 	struct urb *tp_urb;		/* trackpad usb request block */
@@ -631,6 +631,7 @@ static void bcm5974_irq_button(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(dev->udev);
 		break;
 	case -EOVERFLOW:
 	case -ECONNRESET:
@@ -660,6 +661,7 @@ static void bcm5974_irq_trackpad(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(dev->udev);
 		break;
 	case -EOVERFLOW:
 	case -ECONNRESET:
@@ -708,6 +710,9 @@ static int bcm5974_start_traffic(struct bcm5974 *dev)
 {
 	int error;
 
+	if (dev->started)
+		return 0;
+
 	error = bcm5974_wellspring_mode(dev, true);
 	if (error) {
 		dprintk(1, "bcm5974: mode switch failed\n");
@@ -722,6 +727,7 @@ static int bcm5974_start_traffic(struct bcm5974 *dev)
 	if (error)
 		goto err_kill_bt;
 
+	dev->started = 1;
 	return 0;
 
 err_kill_bt:
@@ -734,54 +740,12 @@ err_out:
 
 static void bcm5974_pause_traffic(struct bcm5974 *dev)
 {
+	if (!dev->started)
+		return;
 	usb_kill_urb(dev->tp_urb);
 	usb_kill_urb(dev->bt_urb);
 	bcm5974_wellspring_mode(dev, false);
-}
-
-/*
- * The code below implements open/close and manual suspend/resume.
- * All functions may be called in random order.
- *
- * Opening a suspended device fails with EACCES - permission denied.
- *
- * Failing a resume leaves the device resumed but closed.
- */
-static int bcm5974_open(struct input_dev *input)
-{
-	struct bcm5974 *dev = input_get_drvdata(input);
-	int error;
-
-	error = usb_autopm_get_interface(dev->intf);
-	if (error)
-		return error;
-
-	mutex_lock(&dev->pm_mutex);
-
-	error = bcm5974_start_traffic(dev);
-	if (!error)
-		dev->opened = 1;
-
-	mutex_unlock(&dev->pm_mutex);
-
-	if (error)
-		usb_autopm_put_interface(dev->intf);
-
-	return error;
-}
-
-static void bcm5974_close(struct input_dev *input)
-{
-	struct bcm5974 *dev = input_get_drvdata(input);
-
-	mutex_lock(&dev->pm_mutex);
-
-	bcm5974_pause_traffic(dev);
-	dev->opened = 0;
-
-	mutex_unlock(&dev->pm_mutex);
-
-	usb_autopm_put_interface(dev->intf);
+	dev->started = 0;
 }
 
 static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
@@ -790,8 +754,7 @@ static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
 
 	mutex_lock(&dev->pm_mutex);
 
-	if (dev->opened)
-		bcm5974_pause_traffic(dev);
+	bcm5974_pause_traffic(dev);
 
 	mutex_unlock(&dev->pm_mutex);
 
@@ -801,12 +764,11 @@ static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
 static int bcm5974_resume(struct usb_interface *iface)
 {
 	struct bcm5974 *dev = usb_get_intfdata(iface);
-	int error = 0;
+	int error;
 
 	mutex_lock(&dev->pm_mutex);
 
-	if (dev->opened)
-		error = bcm5974_start_traffic(dev);
+	error = bcm5974_start_traffic(dev);
 
 	mutex_unlock(&dev->pm_mutex);
 
@@ -870,6 +832,9 @@ static int bcm5974_probe(struct usb_interface *iface,
 			 dev->tp_data, dev->cfg.tp_datalen,
 			 bcm5974_irq_trackpad, dev, 1);
 
+	/* Required for autosuspend */
+	iface->needs_remote_wakeup = 1;
+
 	/* create bcm5974 device */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -883,9 +848,6 @@ static int bcm5974_probe(struct usb_interface *iface,
 
 	input_set_drvdata(input_dev, dev);
 
-	input_dev->open = bcm5974_open;
-	input_dev->close = bcm5974_close;
-
 	setup_events_to_report(input_dev, cfg);
 
 	error = input_register_device(dev->input);
@@ -895,6 +857,10 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* save our data pointer in this interface device */
 	usb_set_intfdata(iface, dev);
 
+	error = bcm5974_start_traffic(dev);
+	if (error)
+		goto err_free_buffer;
+
 	return 0;
 
 err_free_buffer:
-- 
1.7.7

