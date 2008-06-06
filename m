From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: fix appletouch regression bugzilla.kernel.org#10825
Date: Fri, 6 Jun 2008 10:07:08 -0400
Message-ID: <20080606094514.ZZRA012@mailhub.coreip.homeip.net>
References: <200806061213.18066.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806061213.18066.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Oliver,

On Fri, Jun 06, 2008 at 12:13:17PM +0200, Oliver Neukum wrote:
> Hi,
> 
> this touchpad needs, probably due to a change in timing of suspension,
> a quirk in 2.6.25 and later. To use this quirk the driver needs to implement
> reset_resume(). I had written a patch that does that and implements USB
> autosuspend. The reporter tested it and found it to work.
> If you want me to I can't isolate the implementation of reset_resume() from
> the rest but I can't test it.
> 

Yes, that'd be great since I'd like the regression fix to show up in
.26 while the autosuspend can wait till .27.

Thanks!

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
