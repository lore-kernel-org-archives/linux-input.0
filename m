From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] Input: tegra-kbc - report wakeup key for some
 platforms.
Date: Sun, 4 Dec 2011 20:27:36 -0800
Message-ID: <20111205042736.GA23733@core.coreip.homeip.net>
References: <1322685811-14060-1-git-send-email-riyer@nvidia.com>
 <20111130212022.GB3108@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D034F3D1BB4BD@HQMAIL03.nvidia.com>
 <20111201072649.GE16816@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D034F3D1BB4C9@HQMAIL03.nvidia.com>
 <20111204085038.GC14593@core.coreip.homeip.net>
 <1323047897.3056.14.camel@riyer-dt2.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323047897.3056.14.camel-73r3X0hAYrhxWE4FnwvcdlaTQe2KTcn/@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: riyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org" <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, Dec 04, 2011 at 05:18:17PM -0800, riyer wrote:
> Hello Dmitry.
> Please find replies inline.
> 
> On Sun, 2011-12-04 at 00:50 -0800, Dmitry Torokhov wrote:
> > Hi Rakesh,
> > 
> > On Thu, Dec 01, 2011 at 01:09:59PM -0800, Rakesh Iyer wrote:
> > > Hello Dmitry.
> > > 
> > > Sorry for the wrap issue, my Outlook does not seem to obey the settings.
> > > 
> > > I wanted to explain the tegra system resume path implementation so I can justify 
> > > why I am doing this complicated fix and why I feel it will guarantee the resume 
> > > is due to keypress.
> > > 
> > > The tegra wake resume code is registered as a syscore ops.
> > > When the system is resumed due to a wake event, the suspend_enter (after wakeup) 
> > > routine will invoke the tegra syscoreops_resume method and that routine will propagate 
> > > the wake event to the individual ISR's through genirq.
> > > If kbc was wake source, kbc_isr will be invoked in this execution path.
> > > 
> > > If system is resumed due to other reason, the tegra_syscoreops_resume code will not 
> > > find the event.
> > 
> > Consider the following sequence:
> > 
> > 1. Something other than keyboard generates wakeup event
> > 2. It's IRQ fires up and gets serviced
> At this point syscoreops_resume has finished all its wakeup processing.
> 
> > 3. System starts resuming devices
> > 4. User presses a key on the keypad while it is still suspended _and_
> >    registered as a wakeup source
> This will have no impact on the system and keypad ISR will not be
> invoked.
> > 5. Keypad's ISR runs as well and you decide that KEY_POWER should be
> >    reported even though keypad wasn't the real reason the system
> >    woke up.
> The interrupt line we use to detect wakeup processing is the keypress
> interrupt which is disabled and will never cause the ISR invocation from
> a device interrupt(i.e. the PIC).
> 
> In other words KBC isr gets invoked for 2 reasons
> a) FIFO interrupt is generated, which will not happen as long as
> scanning logic is disabled until kbc_resume executes.
> b) The syscoreops_resume codepath calls into the ISR after finding KBC
> was a wakesource. If this happens it will happen only when the kernel
> resumes from its suspend code path.

Is this code already in mainline or still somewhere else?

> > 
> > Is this scenario not possible?
> > 
> > Thanks.
> > 
> With that being the case do you think the fix makes sense?

OK, yes. I do not think it is that important if we occasionally report
KEY_POWER even if KBC was not a true wakeup source but that's fine.

Thanks.

-- 
Dmitry
