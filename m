From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: where to put USB IDs to?
Date: Wed, 28 Jan 2009 09:36:24 -0800
Message-ID: <20090128173624.GB7583@kroah.com>
References: <498090CF.7070609@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <498090CF.7070609-Gdu+ltImwkhes2APU0mLOQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Tokarev <mjt-XAri/EZa3C4vJsYlp49lxw@public.gmane.org>
Cc: Linux INPUT list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 28, 2009 at 08:07:27PM +0300, Michael Tokarev wrote:
> F.e., a Powercom UPS (0x0d9f:0x0002).  It's
> defined in drivers/usb/serial/cypress_m8.h
> (and used in drivers/usb/serial/cypress_m8.c)
> for now, I'd like to add it to hid blacklist
> at drivers/hid/hid-core.c.  So it belongs
> to some common place.  The question is which
> one.

Nowhere, just put it in both places.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
