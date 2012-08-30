From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Let the FT5x06 driver build without debugfs
Date: Thu, 30 Aug 2012 15:55:47 -0700
Message-ID: <20120830225547.GB21501@core.coreip.homeip.net>
References: <87k3wy1ii3.fsf@xmission.com>
 <502DFC1D.20903@kernelconcepts.de>
 <87boi91g01.fsf@xmission.com>
 <20120820135303.GA9278@roeck-us.net>
 <20120822054919.GB20624@core.coreip.homeip.net>
 <alpine.DEB.2.00.1208301524560.14189@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1208301524560.14189@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Simon Budig <simon.budig@kernelconcepts.de>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Aug 30, 2012 at 03:26:21PM -0700, David Rientjes wrote:
> On Tue, 21 Aug 2012, Dmitry Torokhov wrote:
> 
> > > > > On 08/17/2012 02:15 AM, Eric W. Biederman wrote:
> > > > >> When testing to make certain my user namespace code works in
> > > > >> various configurations I tripped over the tf5x06.c not building
> > > > >> with debugfs disabled.
> > > > >
> > > > > Sorry for that.
> > > > >
> > > > > There already is a patch for this issue which I slightly prefer. You
> > > > > can find it in the mail from Guenther Roeck:
> > > > >    http://www.mail-archive.com/linux-input@vger.kernel.org/msg00646.html
> > > > 
> > > > If you guys could get that merged into 3.6 I would appreciate it.
> > > > 
> > > Yes, that would be great. I don't recall seeing an e-mail from Dmitry accepting
> > > it, though.
> > 
> > Applied, sorry for the delay.
> > 
> 
> This still affects Linus' tree and causes a build breakage without debugfs 
> configured.  Considering the driver went into 3.5-rc5, could you please 
> push this fix for 3.6

I Just sent a pull request to Linus.

> (and mark it for stable backport)?

I am pretty sure it was merged in 3.6 merge window, not 3.5, so no need
to mark for stable.

Thanks.

-- 
Dmitry
