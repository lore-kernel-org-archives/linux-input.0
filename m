From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: remove info() macro from usb input drivers
Date: Fri, 10 Oct 2008 09:20:07 -0700
Message-ID: <20081010162007.GA26779@kroah.com>
References: <20081010050305.GA32476@kroah.com> <20081010134207.GA10688@anvil.corenet.prv> <20081010155221.GC20231@kroah.com> <20081010.091139.264833623.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081010.091139.264833623.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 10, 2008 at 09:11:39AM -0700, David Miller wrote:
> From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
> Date: Fri, 10 Oct 2008 08:52:21 -0700
> 
> > On Fri, Oct 10, 2008 at 09:42:07AM -0400, Dmitry Torokhov wrote:
> > > On Thu, Oct 09, 2008 at 10:03:05PM -0700, Greg KH wrote:
> > > > From: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> > > > 
> > > > USB should not be having it's own printk macros, so remove info() and
> > > > use the system-wide standard of dev_info() wherever possible.
> > > > 
> > > > Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> > > > 
> > > > ---
> > > > Dmitry, this has been in the USB tree for a few months now, sorry for
> > > > not sending it to you sooner.  I can easily keep it in my tree and send
> > > > it to Linus for this merge if you want me to, or you can take it in your
> > > > tree, which ever you want me to do.
> > > > 
> > > 
> > > Greg, just push it through your tree since it's already there. I don't
> > > think we have any clashes in this code.
> > 
> > Great, thanks for letting me know.
> 
> Right, and Jeff is away until next week so even more reason for you to
> take care of it via the USB tree :-)

Hm, which one, the patch for the drivers/net/ tree?  I'll push that as
well due to him being gone, thanks for reminding me.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
