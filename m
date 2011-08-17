From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] input: wacom - remove pressure for touch devices
Date: Wed, 17 Aug 2011 09:21:59 -0700
Message-ID: <20110817162159.GA4877@core.coreip.homeip.net>
References: <1313194109-4987-1-git-send-email-pinglinux@gmail.com>
 <CAGzDe_YC2afYK-Xr5JNveZC-=h9dpnysLxwQSM0i7q3tN91--g@mail.gmail.com>
 <CAF8JNh+90K2Qfpzu9Rwt_cdvqxTxaF8iJJ2-=nmWY8qLL6Wmzg@mail.gmail.com>
 <20110817065040.GC29361@core.coreip.homeip.net>
 <CAF8JNh+dpmh50ixyNKtVNL-ZGVZg3rfjbyvnVAi790nwvFCJVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55845 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab1HQQWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 12:22:06 -0400
Received: by yie30 with SMTP id 30so876932yie.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 09:22:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+dpmh50ixyNKtVNL-ZGVZg3rfjbyvnVAi790nwvFCJVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>

On Wed, Aug 17, 2011 at 08:32:28AM -0700, Ping Cheng wrote:
> On Tue, Aug 16, 2011 at 11:50 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com
> > wrote:
> 
> > On Mon, Aug 15, 2011 at 09:34:23PM -0700, Ping Cheng wrote:
> > > On Sun, Aug 14, 2011 at 8:27 PM, Chris Bagwell <chris@cnpbagwell.com>
> > wrote:
> > >
> > > > On Fri, Aug 12, 2011 at 7:08 PM, Ping Cheng <pinglinux@gmail.com>
> > wrote:
> > > > > Touch devices do not report valid pressure or capacitance.
> > > > >
> > > > > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > > > > ---
> > > >
> > > > I'd prefer if we kept pressure support.  At least for Bamboo's with
> > > > product ID between 0xd0 and 0xd4.
> > > >
> > > > In my testing of an 0xd1 device, pressure works fine (low pressure and
> > > > high pressure work great.  Not much middle pressure sensitivity.
> > > > Multi-touch will increase pressure reading.  All pretty common
> > > > behaviour).
> > > >
> > >
> > > Basically, there were three reasons to remove the pressure bit for all
> > touch
> > > devices:
> > >
> > > 1.   The value is not a pressure and it does not report valid capacitance
> > > either;
> > > 2.   The only valid use in the kernel driver is to decide if the finger
> > is
> > > touching the tablet or not, which has already been correctly reported by
> > the
> > > firmware in the other bits. So, it is redundant to check the pressure for
> > > this purpose;
> > > 3.   Passing the invalid "pressure" to the user land would only introduce
> > > bad user experience since touch is not designed for drawing. We don't
> > want
> > > to confuse user with that "pressure".
> >
> > Not speaking about touch per se, but pressure is important for other
> > things besides drawing. Different people prefer different device
> > sensitivity and if userspace knows pressure it can adjust according to
> > user preference, like synaptics X driver does with touchpads that
> > actually report it. I believe tslib allows similar for touchscreens.
> >
> 
> Your suggestion is based on the assumption that the value is pressure.

I did not make any assumptions, I was just making general observation
that if pressure data is available it is useful not only for drawing
applications.

> But
> that is not true. The value is not pressure and it is unreliable.

So what is this data then?

Thanks.

-- 
Dmitry
