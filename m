From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard)
 stopped functioning in kernels >= 2.6.28
Date: Tue, 2 Jun 2009 11:55:51 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906021148140.29471@twin.jikos.cz>
References: <bug-13411-10286@http.bugzilla.kernel.org/> <20090601202509.87f57ef9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090601202509.87f57ef9.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugzilla.kernel.org-Dy4KJ/v5nlEVgfBnK23ub6xOck334EZe@public.gmane.org, Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 1 Jun 2009, Andrew Morton wrote:

> > My K__nig CMP-BARSCAN 10 (being reported as ID 1130:0001 Tenx Technology, Inc.)
> > stopped working in kernels upwards from 2.6.28. I'm running a Gentoo 64-bits
> > system. 
> > 
> > The device is still being detected, however, no input-node is being created.
> > Dmesg reports (under a 2.6.28 kernel):
> > 
> > usb 6-2: new low speed USB device using uhci_hcd and address 2
> > usb 6-2: configuration #1 chosen from 1 choice
> > usb 6-2: New USB device found, idVendor=1130, idProduct=0001
> > usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> > usb 62: Product: USB-TMU
> > 
> > 
> > Under 2.6.27.24 it does work as expected. Dmesg reports:
> > 
> > usb 6-2: new low speed USB device using uhci_hcd and address 2
> > usb 6-2: configuration #1 chosen from 1 choice
> > input: USB-TMU as /class/input/input6
> > input: USB HID v1.10 Keyboard [USB-TMU] on usb-0000:00:1d.0-2
> > usb 6-2: New USB device found, idVendor=1130, idProduct=0001
> > usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> > usb 6-2: Product: USB-TMU

This is almost certainly because of this commit:

	commit d1d3a5f6eaee337d793ab9ac28e696f0262c3c8a
	Author: Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
	Date:   Tue Sep 9 01:39:33 2008 +0200

	    HID: ignore iBuddy devices

	    iBuddy devices claim to be HID devices, but they are not.
	    Add them to the blacklist.

	    Signed-off-by: Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
	    Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

The problem apparently [1] is, that the vendor has been super-creative and 
assigned the same combination of idVendor/idProduct to completely 
different devices. Oh well.

Remi, could you please check your device against the lsusb data provided 
in bugzilla to check whether there is any possibility to distinguish these 
devices, so that we could put some ugly check in place probably?

Thanks.

[1] http://lkml.org/lkml/2009/2/10/434

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
