From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #14626] oops on boot starting udev
Date: Mon, 16 Nov 2009 20:01:05 -0800
Message-ID: <20091117040104.GA5792@core.coreip.homeip.net>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera> <xXQGFmujPl.A.fpF.zSdALB@chimera> <20091117011455.GA7977@kroah.com> <20091117020451.GA27967@core.coreip.homeip.net> <1258426743.9883.53.camel@no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1258426743.9883.53.camel@no>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 17, 2009 at 03:59:03AM +0100, Soeren Sonnenburg wrote:
> On Mon, 2009-11-16 at 18:04 -0800, Dmitry Torokhov wrote:
> > On Mon, Nov 16, 2009 at 05:14:55PM -0800, Greg KH wrote:
> > > On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
> > > > This message has been generated automatically as a part of a report
> > > > of recent regressions.
> > > > 
> > > > The following bug entry is on the current list of known regressions
> > > > from 2.6.31.  Please verify if it still should be listed and let me know
> > > > (either way).
> > > > 
> > > > 
> > > > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14626
> > > > Subject		: oops on boot starting udev
> > > > Submitter	: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> > > > Date		: 2009-11-14 10:16 (3 days old)
> > > > References	: http://marc.info/?l=linux-kernel&m=125819380206800&w=4
> > > 
> > > This looks like an input core problem, as the evdev module was just
> > > loaded and died.
> > > 
> > > Any input developers have any ideas?
> > > 
> > 
> > 
> > Hmm, evdev does:
> > 
> > 	dev_set_name(&evdev->dev, "event%d", minor);
> > 
> > Not sure how it can go wrong...
> 
> Anything I should/could do to narrow it down a bit (apart from
> bisecting?).
> 

Umm, I looked through the changes between -rc6 and 7 but nothing jumped
out at me... You don't happen to have any local changes in your tree?

-- 
Dmitry
