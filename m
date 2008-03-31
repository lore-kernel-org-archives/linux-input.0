From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch]race between open and disconnect in usbhid
Date: Mon, 31 Mar 2008 15:35:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0803311534240.5541@jikos.suse.cz>
References: <200803311535.10067.oliver@neukum.org> <Pine.LNX.4.64.0803311522110.5541@jikos.suse.cz>
 <200803311547.56448.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200803311547.56448.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 31 Mar 2008, Oliver Neukum wrote:

> > > +	char disconnected:1;						/* indicates undead device - no use */
> > Wouldn't introduction of new flag (HID_DISCONNECTED) to 
> > usbhid_device->iofl be cleaner?
> A matter of taste. I don't use atomic ops if I don't have to, but if you
> like it better the other way I can redo it.

I would really appreciate that, thanks. It really reflects the status of 
the device with respect to the I/O in a very similar way as other I/O 
flags, so we should keep it together if possible.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
