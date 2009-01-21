From: Oliver Neukum <oliver@neukum.org>
Subject: Re: second race in hiddev
Date: Wed, 21 Jan 2009 10:26:33 +0100
Message-ID: <200901211026.35066.oliver@neukum.org>
References: <200901091121.56576.oliver@neukum.org> <alpine.LNX.1.10.0901211003140.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:41487 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbZAUJ0G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2009 04:26:06 -0500
In-Reply-To: <alpine.LNX.1.10.0901211003140.5377@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

Am Wednesday 21 January 2009 10:05:22 schrieb Jiri Kosina:
> On Fri, 9 Jan 2009, Oliver Neukum wrote:
> 
> > upon further thought this code is still racy.
> > 
> > 	retval = usb_register_dev(usbhid->intf, &hiddev_class);
> > 
> > here you open a window during which open can happen
> > 
> > 	if (retval) {
> > 		err_hid("Not able to get a minor for this device.");
> > 		hid->hiddev = NULL;
> > 		kfree(hiddev);
> > 		return -1;
> > 	} else {
> > 		hid->minor = usbhid->intf->minor;
> > 		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
> > 
> > and will fail because hiddev_table hasn't been updated
> 
> Indeed, thanks for catching that. It's a small race window and not very 
> probably to be hit (or users aren't that fast, right? :) ).

Users may not be that fast. Udev scripts may be. At least I hope we
want our udev fast and we've seen SMIs running for hundreds
of milliseconds.

> > The obvious fix of using a mutex to guard hiddev_table doesn't work 
> > because usb_open() and usb_register_dev() take minor_rwsem and we'd have 
> > an AB-BA deadlock. We need a lock usb_open() also takes in the right 
> > order and that leaves only one option, BKL. I don't like it but I see no 
> > alternative.
> [ ... ]
> > @@ -878,16 +878,19 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> >  	hiddev->hid = hid;
> >  	hiddev->exist = 1;
> >  
> > +	lock_kernel();
> >  	retval = usb_register_dev(usbhid->intf, &hiddev_class);
> >  	if (retval) {
> >  		err_hid("Not able to get a minor for this device.");
> >  		hid->hiddev = NULL;
> > +		unlock_kernel();
> >  		kfree(hiddev);
> >  		return -1;
> >  	} else {
> >  		hid->minor = usbhid->intf->minor;
> >  		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
> >  	}
> > +	unlock_kernel();
> 
> This is really not nice and I would like to avoid pulling BKL in as much 
> as possible.
> 
> What exactly is the lock_kernel() in usb_open() protecting from anyway?

I guess it wasn't removed because
a) disconnect() used to take BKL
b) nobody was ready to check all open() methods for dependency on BKL
 
> Why isn't minor_rwsem sufficient protection?

It is dropped too early. It is held only while a device is registered, not
during enough of probing.

	Regards
		Oliver
