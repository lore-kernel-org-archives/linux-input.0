From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: second race in hiddev
Date: Wed, 21 Jan 2009 10:05:22 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901211003140.5377@jikos.suse.cz>
References: <200901091121.56576.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901091121.56576.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 9 Jan 2009, Oliver Neukum wrote:

> upon further thought this code is still racy.
> 
> 	retval = usb_register_dev(usbhid->intf, &hiddev_class);
> 
> here you open a window during which open can happen
> 
> 	if (retval) {
> 		err_hid("Not able to get a minor for this device.");
> 		hid->hiddev = NULL;
> 		kfree(hiddev);
> 		return -1;
> 	} else {
> 		hid->minor = usbhid->intf->minor;
> 		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
> 
> and will fail because hiddev_table hasn't been updated

Indeed, thanks for catching that. It's a small race window and not very 
probably to be hit (or users aren't that fast, right? :) ).

> The obvious fix of using a mutex to guard hiddev_table doesn't work 
> because usb_open() and usb_register_dev() take minor_rwsem and we'd have 
> an AB-BA deadlock. We need a lock usb_open() also takes in the right 
> order and that leaves only one option, BKL. I don't like it but I see no 
> alternative.
[ ... ]
> @@ -878,16 +878,19 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  	hiddev->hid = hid;
>  	hiddev->exist = 1;
>  
> +	lock_kernel();
>  	retval = usb_register_dev(usbhid->intf, &hiddev_class);
>  	if (retval) {
>  		err_hid("Not able to get a minor for this device.");
>  		hid->hiddev = NULL;
> +		unlock_kernel();
>  		kfree(hiddev);
>  		return -1;
>  	} else {
>  		hid->minor = usbhid->intf->minor;
>  		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
>  	}
> +	unlock_kernel();

This is really not nice and I would like to avoid pulling BKL in as much 
as possible.

What exactly is the lock_kernel() in usb_open() protecting from anyway? 
Why isn't minor_rwsem sufficient protection?

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
