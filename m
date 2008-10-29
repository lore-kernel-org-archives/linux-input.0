From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to
 corruption)
Date: Wed, 29 Oct 2008 14:28:12 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz>
References: <200810271042.37365.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200810271042.37365.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Yang, Yi Y" <yi.y.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 27 Oct 2008, Oliver Neukum wrote:

> This uses the USB busy mechanism for aggessive autosuspend of USB HID 
> devices. It autosuspends all opened devices supporting remote wakeup 
> after a timeout unless
> 
> - output is being done to the device
> - a key is being held down (remote wakeup isn't triggered upon key release)
> - LED(s) are lit
> - hiddev is opened

Hi Oliver,

doesn't hidraw (the generic transport-independent variant of 
USB-specific hiddev) need also some handling?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
