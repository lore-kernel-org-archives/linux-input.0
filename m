From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch]hopefully final version of full autosuspend for usb hid
Date: Fri, 16 Jan 2009 12:59:24 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901161153400.5377@jikos.suse.cz>
References: <200812151616.16888.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812151616.16888.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 15 Dec 2008, Oliver Neukum wrote:

> This uses the USB busy mechanism for aggessive autosuspend of USB
> HID devices. It autosuspends all opened devices supporting remote wakeup
> after a timeout unless
> 
> - output is being done to the device
> - a key is being held down (remote wakeup isn't triggered upon key release)
> - LED(s) are lit
> - hiddev is opened

It is also important to note that we always need the leve default to 'on' 
for HID devices, as it is known to not work properly for many of them 
(losing keypresses on resume, mice waking up only on button press not on 
movement, etc), so whitelisting the ones that are known to work properly 
is the only viable option. Preferably from userspace (HAL).

I don't have any objections to this version of the patch, thanks a lot 
Oliver for taking care to fix and respin so many times so far.

I have now pulled the 'autosuspend' branch into the branch that gets 
pulled into -next.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
