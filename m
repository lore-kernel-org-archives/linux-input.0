From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 20:33:06 +0200
Message-ID: <20111012183306.GA10397@polaris.bitmath.org>
References: <201110121637.22442.oliver@neukum.org>
 <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
 <20111012161651.GA28601@srcf.ucam.org>
 <201110121856.32444.oliver@neukum.org>
 <20111012165905.GA29313@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:37957 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab1JLS0T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 14:26:19 -0400
Received: from iph2.telenor.se (iph2.telenor.se [195.54.127.133])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 9F807E9EBC
	for <linux-input@vger.kernel.org>; Wed, 12 Oct 2011 20:26:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111012165905.GA29313@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, Oct 12, 2011 at 05:59:05PM +0100, Matthew Garrett wrote:
> On Wed, Oct 12, 2011 at 06:56:32PM +0200, Oliver Neukum wrote:
> > Am Mittwoch, 12. Oktober 2011, 18:16:51 schrieb Matthew Garrett:
> > > Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
> > > than set flags that block suspend, it might make more sense to take 
> > > references. It'd complicate things a little, in that we'd have to take 
> > > more care in terms of keeping track of the state.
> > 
> > I am afraid references are very hard to take there because it needs to be done
> > in interrupt.
> 
> True. That makes things rather more awkward.

I was looking at usb_autopm_get_interface_no_resume() yesterday for
the same reason, it seemed light-weight enough. No?

Btw, I wonder if the patch below would make sense or if calling put*()
is always a bug at zero usage count.

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 34e3da5..4857e76 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1516,7 +1516,7 @@ void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
        struct usb_device       *udev = interface_to_usbdev(intf);
 
        usb_mark_last_busy(udev);
-       atomic_dec(&intf->pm_usage_cnt);
+       atomic_add_unless(&intf->pm_usage_cnt, -1, 0);
        pm_runtime_put_noidle(&intf->dev);
 }
 EXPORT_SYMBOL_GPL(usb_autopm_put_interface_no_suspend);


Henrik
