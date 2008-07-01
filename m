From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 09:59:01 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807010957320.6375@jikos.suse.cz>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806301145020.2708-100000@iolanthe.rowland.org> <20080630115953.ZZRA012@mailhub.coreip.homeip.net> <200807010046.34219.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200807010046.34219.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Jul 2008, Oliver Neukum wrote:

>> Ok, I see... So what does a device do when it is suspended and a 
>> request comes in? Does it automatically resume and service the request 
>> (and potentially goes back to sleep)? Does it queue the request for 
>> later? Ignore it? Is it a system-wide policy or up to the device 
>> [class]?
> Return an error. If you queue, how much would you queue?
> There's no sane answer, so you better fail right away.

I guess that Dmitry's question was about the behavior of the driver, 
right? For example in situation when the LED state changes on PS/2 
keyboard, what should the USB keyboard driver do for a suspended USB 
keyboard.

I really don't think we want to return error in such cases. Either resume 
the device, or queue some requests (maybe depending on the type of 
requests), right?

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
