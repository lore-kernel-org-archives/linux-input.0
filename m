From: Tino Keitel <tino.keitel-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 15:40:46 +0200
Message-ID: <20080515134046.GA9529@dose.home.local>
References: <20080514221519.GA6575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080514221519.GA6575-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, May 14, 2008 at 15:15:19 -0700, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> 
> This driver was originally written by James McKenzie but forward ported
> and cleaned up by me to get it to work with modern kernel versions.
> 
> Tested on my mac mini and it actually works!

Did you test suspend to RAM? Last time I used the original driver, I
had to reload it after resume, otherwise LIRC didn't receive events
anymore.

Regards,
Tino
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
