From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25-rc8] ads7846 vref support (ads7843)
Date: Fri, 11 Apr 2008 08:28:30 -0700
Message-ID: <200804110828.31244.david-b@pacbell.net>
References: <200804110036.34408.david-b@pacbell.net> <200804110115.25647.david-b@pacbell.net> <20080411094738.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:24888 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759878AbYDKP2q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 11:28:46 -0400
In-Reply-To: <20080411094738.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz

On Friday 11 April 2008, Dmitry Torokhov wrote:
> On Fri, Apr 11, 2008 at 01:15:25AM -0700, David Brownell wrote:
> > On Friday 11 April 2008, David Brownell wrote:
> > > Updated since the version sent 5-January (evidently bounced from
> > > list archives) ... to remove the warning fix that was merged (from
> > > someone else) on 10-March.
> > > 
> 
> Could you please check the following commit in my tree and make sure
> it is the right one:
> 
> http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=7c6d0ee14cb7a4cfad4864dc196256da5749bc0c

Looks OK to me -- thanks!


> > > MAINTAINERS says "linux-input@vger" but the only archives
> > > I could find seems to say "@atrey.karlin.mff.cuni.cz"...
> > 
> > I eventually found an @vger archive, but it seems to have no
> > postings since February (unlike the @atrey one).  Those two
> > lost patches certainly made it to that archive:
> > 
> >   http://www.mail-archive.com/linux-input@vger.kernel.org/msg00086.html
> >   http://www.mail-archive.com/linux-input@vger.kernel.org/msg00103.html
> > 
> > It seems maybe the MAINTAINERS entry may be incorrect ...
> 
> @vger is the correct only, we are migrating from @atrey due to heavy
> spam issues.

Are there better archives for that list?  Like, ones which
include March and April?  I tried marc.info first, and it
had nothing...

- Dave
