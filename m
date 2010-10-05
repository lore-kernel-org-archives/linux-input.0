From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Mon, 4 Oct 2010 22:41:40 -0700
Message-ID: <20101005054139.GC15355@core.coreip.homeip.net>
References: <4C8E180D.4020309@suse.cz>
 <201010042033.53453.oliver@neukum.org>
 <20101004183848.GG8321@core.coreip.homeip.net>
 <201010042124.24253.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60036 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959Ab0JEFlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 01:41:47 -0400
Content-Disposition: inline
In-Reply-To: <201010042124.24253.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, pingc@wacom.com, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, Oct 04, 2010 at 09:24:24PM +0200, Oliver Neukum wrote:
> Am Montag, 4. Oktober 2010, 20:38:49 schrieb Dmitry Torokhov:
> > On Mon, Oct 04, 2010 at 08:33:53PM +0200, Oliver Neukum wrote:
> > > Am Montag, 4. Oktober 2010, 18:13:20 schrieb Dmitry Torokhov:
> > > > Lost track of this issue for a while. So I think we still need to fix
> > > > the deadlock for .36 and I think that the following will do that. Then
> > > > we'll adjust the driver to actually enable runtime PM for .37.
> > > 
> > > That's a viable plan.
> > > 
> > 
> > I take it as an "acked-by" for this patch, right?
> 
> Sure. Just in case:
> 
> Acked-by: Oliver Neukum <oneukum@suse.de>
> 

Thanks Oliver. And the patch below is for .37 properly enabling runtime
PM for wacom.

-- 
Dmitry

Input: wacom - properly enable runtime PM

We need to always call usb_autopm_put_interface() in wacom_open(),
not only when initialization fails, otherwise the device will be
marked as PM-busy and will never be put in suspended state.

Based on patch by Oliver Neukum.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/tablet/wacom_sys.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 02de653..fc38149 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -120,14 +120,16 @@ static int wacom_open(struct input_dev *dev)
 
 out:
 	mutex_unlock(&wacom->lock);
-	if (retval)
-		usb_autopm_put_interface(wacom->intf);
+	usb_autopm_put_interface(wacom->intf);
 	return retval;
 }
 
 static void wacom_close(struct input_dev *dev)
 {
 	struct wacom *wacom = input_get_drvdata(dev);
+	int autopm_error;
+
+	autopm_error = usb_autopm_get_interface(wacom->intf);
 
 	mutex_lock(&wacom->lock);
 	usb_kill_urb(wacom->irq);
@@ -135,7 +137,8 @@ static void wacom_close(struct input_dev *dev)
 	wacom->intf->needs_remote_wakeup = 0;
 	mutex_unlock(&wacom->lock);
 
-	usb_autopm_put_interface(wacom->intf);
+	if (!autopm_error)
+		usb_autopm_put_interface(wacom->intf);
 }
 
 static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hid_desc,
