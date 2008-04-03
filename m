From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 17:41:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804031740100.5410-100000@iolanthe.rowland.org>
References: <200804032242.36493.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804032242.36493.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Stefan Schweizer <genstef-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 3 Apr 2008, Oliver Neukum wrote:

> Am Donnerstag, 3. April 2008 17:44:19 schrieb Stefan Schweizer:
> > Cannot seem to find the persist attribute even after this patch applied :((
> > 
> > CONFIG_USB_PERSIST is enabled, but other drivers do not provide it.
> > However this is 2.6.24 - I will try it on 2.6.25 now.
> 
> Odd, I can't reproduce it. Alan?
> 
> 	Regards
> 		Oliver
> 
> oneukum@tranquility:/sys/bus/usb/devices/6-1/power> ll
> insgesamt 0
> -r--r--r-- 1 root root 4096  3. Apr 22:40 active_duration
> -rw-r--r-- 1 root root 4096  3. Apr 22:40 autosuspend
> -r--r--r-- 1 root root 4096  3. Apr 22:40 connected_duration
> -rw-r--r-- 1 root root 4096  3. Apr 22:40 level
> -rw-r--r-- 1 root root 4096  3. Apr 22:40 persist
> -rw-r--r-- 1 root root 4096  3. Apr 22:40 wakeup

Sometimes people run into problems when rebuilding usbcore.  Depending
on the distribution, the usbcore.ko module is sometimes loaded as part
of an initramfs image.  Merely installing the new modules won't change
the image.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
