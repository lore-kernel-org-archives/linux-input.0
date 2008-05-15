From: Tino Keitel <tino.keitel-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 22:59:59 +0200
Message-ID: <20080515205959.GA11683@dose.home.local>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net> <20080515184034.GB15231@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080515184034.GB15231-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, May 15, 2008 at 11:40:34 -0700, Greg KH wrote:
> On Thu, May 15, 2008 at 09:45:52AM -0400, Dmitry Torokhov wrote:
> > Hi Tino,
> > 
> > On Thu, May 15, 2008 at 03:21:08PM +0200, Tino Keitel wrote:
> > > Hi,
> > >
> > > I'm pretty sure that this breaks the macmini LIRC driver again, see
> > > commit 3e1928e8793208802589aae851b6685671187242.
> > >
> > 
> > But with in-kernel driver can't LIRC feed of event device? Ane people
> > that dont use LIRC can also have access to the remote?
> 
> And, to be blunt, why would an in-kernel driver be concerned about an
> out-of-tree-project-that-refuses-to-be-included chunk of code?

The macmini LIRC driver is a pure userspace driver, so nothing needs to
be ever included in the kernel.

Regards,
Tino

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
