From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's
 mc34708
Date: Fri, 4 Oct 2019 15:07:49 +0100
Message-ID: <20191004140749.GH18429@dell>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190930095159.64e1001a@jawa>
 <20191001064130.GA11769@dell>
 <20191001101909.79aacda0@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001101909.79aacda0@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Tue, 01 Oct 2019, Lukasz Majewski wrote:
> > On Mon, 30 Sep 2019, Lukasz Majewski wrote:
> > 
> > > Dear Lee,
> > >   
> > > > This patch set provides several enhancements to mc13xxx MFD family
> > > > of devices by introducing mc34708 as a separate device.
> > > > 
> > > > This IC has dedicated pen detection feature, which allows better
> > > > touchscreen experience.
> > > > 
> > > > This is the fifth version of this code (v5).
> > > > Discussion regarding previous versions can be found here:
> > > > https://lkml.org/lkml/2018/4/12/351
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1661934.html
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1664296.html
> > > > https://lkml.org/lkml/2019/7/17/705  
> > > 
> > > Gentle ping on this patch series. It is now 3 weeks without any
> > > reply...  
> > 
> > Please take note and follow the kernel release cycle.
> > 
> > These patches were sent after the release of -rc7 i.e. very late
> > in the release cycle and a point where most kernel maintainers stop
> > reviewing/applying patches
> 
> Maybe something has changed recently, but I thought that the review is
> an ongoing process (that the discussion about patches takes place all
> the time to refine the code).
> 
> (and nobody expects maintainers pulling new patches after merge window).

Nothing changed recently.  Some maintainers will review just before
and during the merge windows, others use the time to prepare their
branches for submission and welcome the break from reviewing during
this time.  Either way, please do not *expect* a fast turn-around
during in this period of the cycle.

> > and start to prepare for the impending
> > merge-window.
> > 
> > Also, there is no such thing as a gentle ping.
> 
> I'm a bit puzzled now. 
> I do know that maintainers are overworked - and I do understand that.
> 
> However, NO reply for such a long time is at best confusing for
> somebody who is willing to fix the kernel.

If you respect the merge cycle, you will come to expect a short delay
at the end and during the merge-window.  Please also understand that
Maintainers also take vacation, attend conferences and have other work
to attend to.

> (Maybe this has changed too - but I do remember that there was a "rule
> of thumb" to express any comment about the patch in 2 weeks time).

Same rule of thumb applies.  If after 2 weeks you have not received a
review, feel free to send a [RESEND].  However, bumping threads with
contentless pings is considered bad form.

As an aside, I (and others) conduct reviews in batches and in
chronological order (first come, first served) of how the mails are
represented in my inbox.  Thus, if you bump a thread, it goes to the
back of the queue.

> >  If you genuinely think
> > your patches have unlikely("slipped though the gaps"), then post a
> > [RESEND] complete with a note alluding your reasons doing such.
> > 
> 
> Please forgive me, but are patches from this series eligible for pulling
> (to v5.4 or even next release)?

v5.4-rc1 has already been released.  No new functionality will hit
v5.4.  We have around 6-7 weeks to agree on acceptance for this set
for them to be eligible for v5.5.

> > > > Sascha Hauer (3):
> > > >   mfd: mc13xxx: Add mc34708 adc support
> > > >   input: touchscreen mc13xxx: Make platform data optional
> > > >   input: touchscreen mc13xxx: Add mc34708 support
> > > > 
> > > >  drivers/input/touchscreen/mc13783_ts.c | 63 ++++++++++++++---
> > > >  drivers/mfd/mc13xxx-core.c             | 98
> > > > +++++++++++++++++++++++++- include/linux/mfd/mc34708.h
> > > > | 37 ++++++++++ 3 files changed, 185 insertions(+), 13
> > > > deletions(-) create mode 100644 include/linux/mfd/mc34708.h  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
