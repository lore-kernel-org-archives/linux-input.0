From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch]convert away from urb->status in xpad driver
Date: Thu, 3 Apr 2008 13:26:35 -0700
Message-ID: <20080403202635.GA26808@kroah.com>
References: <200804031326.00717.oliver@neukum.org> <Pine.LNX.4.64.0804031748330.32130@jikos.suse.cz> <20080403153901.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080403153901.ZZRA012-NG0XCrj25/nJrYCpivWRnl5pS2h4L8biXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, jikos-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kratochvil <honza-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 03, 2008 at 03:41:54PM -0400, Dmitry Torokhov wrote:
> On Thu, Apr 03, 2008 at 05:49:54PM +0200, Jiri Kosina wrote:
> > [ added Dmitry ]
> > 
> > On Thu, 3 Apr 2008, Oliver Neukum wrote:
> > 
> > > USB is moving to transfering status as a parameter. To ease the transition
> > > urb->status is to be touched only once in a function. The xpad driver has
> > > been overlooked.
> > > Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> > 
> > FWIW
> > 
> > Acked-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> > 
> 
> I think it would be better if this patch come through USB tree so there
> are no merge dependencies. I will carry a local copy of this patch so
> I don't merge something that may screw it up.
> 
> Acked-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>

Ok, I can do that.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
