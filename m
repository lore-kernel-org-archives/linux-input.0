From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: second race in hiddev
Date: Thu, 12 Feb 2009 13:21:42 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902121320380.31014@jikos.suse.cz>
References: <200901091121.56576.oliver@neukum.org> <alpine.LNX.1.10.0901211003140.5377@jikos.suse.cz> <200901211026.35066.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901211026.35066.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 21 Jan 2009, Oliver Neukum wrote:

> I guess it wasn't removed because
> a) disconnect() used to take BKL
> b) nobody was ready to check all open() methods for dependency on BKL
>  
> > Why isn't minor_rwsem sufficient protection?
> 
> It is dropped too early. It is held only while a device is registered, not
> during enough of probing.

There really doesn't seem to be any other option with usb_open() relying 
on lock_kernel() still.

I have added comment to the code and applied the patch, thanks a lot 
Oliver.

-- 
Jiri Kosina
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
