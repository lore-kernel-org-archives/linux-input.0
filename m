From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard)
 stopped functioning in kernels >= 2.6.28
Date: Tue, 1 Dec 2009 11:40:55 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0912011138510.1106@wotan.suse.de>
References: <bug-13411-10286@http.bugzilla.kernel.org/> <20090601202509.87f57ef9.akpm@linux-foundation.org> <alpine.LRH.2.00.0906021148140.29471@twin.jikos.cz> <200911282251.28780.bugzilla.kernel.org@starbase12.cjb.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200911282251.28780.bugzilla.kernel.org-Dy4KJ/v5nlEVgfBnK23ub6xOck334EZe@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guido Dorssers <bugzilla.kernel.org-Dy4KJ/v5nlEVgfBnK23ub6xOck334EZe@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, Remi Cattiau <remi-O/wO+J8fF4JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 28 Nov 2009, Guido Dorssers wrote:

> > The problem apparently [1] is, that the vendor has been super-creative and
> > assigned the same combination of idVendor/idProduct to completely
> > different devices. Oh well.
> > 
> > Remi, could you please check your device against the lsusb data provided
> > in bugzilla to check whether there is any possibility to distinguish these
> > devices, so that we could put some ugly check in place probably?
> > 
> > Thanks.
> > 
> > [1] http://lkml.org/lkml/2009/2/10/434
> > 
> 
> Hi all,
>  
> A belated thanks for having pointed me into the right direction to get my 
> barcodescanner operational. However, as a thought since the bug is still 
> present, why not solve it with something as simple as making the blacklisting 
> user-configurable instead of blacklisting valid HID devices on purpose?

Hi,

actually, my current plan is to remove the blacklist entry for this 
combination of VID/PID completely, and let the user decide and unbind the 
driver via sysfs eventually, if needed (maybe together with warning in 
dmesg).

As the vendor apparently messed up horribly, as far as I understand, I 
don't really see another option.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
