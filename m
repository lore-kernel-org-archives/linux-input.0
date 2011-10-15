From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Date: Sat, 15 Oct 2011 11:43:27 +0200
Message-ID: <201110151143.27061.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1110141106270.2036-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1110141106270.2036-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag, 14. Oktober 2011, 17:09:32 schrieb Alan Stern:
> > Anyway, I'll solve this problem on my system by writing to wakeup
> > property on device attach. Consider my change abandoned.
> 
> That seems like the best approach.

Do you think this could be added to the USB configuration tool I wrote
last week?

In the longer run, we might consider that this properties may also need
to be changed based on AC vs. DC or the battery's charge level.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
