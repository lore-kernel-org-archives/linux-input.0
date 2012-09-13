From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: Tree for Sept 12 (kernel-panic after pressing any
 key at X login)
Date: Wed, 12 Sep 2012 23:49:09 -0700
Message-ID: <20120913064909.GF17105@core.coreip.homeip.net>
References: <CA+icZUVEQNPGL7_BbLA-urgP6rFvdOh0SUtYESUv6ZJc+w78Nw@mail.gmail.com>
 <CA+icZUXqzV=YFjHT=5QxUf1_WHwS1-DhuXkhN8QAhn1t9+-PYA@mail.gmail.com>
 <20120913060412.GB5085@bbox>
 <CA+icZUUF=vTwSoNrs-+F08H7LAO0RUwztJ3M1_iyNR28TsrFMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62135 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab2IMGtO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 02:49:14 -0400
Content-Disposition: inline
In-Reply-To: <CA+icZUUF=vTwSoNrs-+F08H7LAO0RUwztJ3M1_iyNR28TsrFMw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Ping Cheng <pingc@wacom.com>

On Thu, Sep 13, 2012 at 08:36:36AM +0200, Sedat Dilek wrote:
> On Thu, Sep 13, 2012 at 8:04 AM, Minchan Kim <minchan@kernel.org> wrote:
> > On Thu, Sep 13, 2012 at 07:29:32AM +0200, Sedat Dilek wrote:
> >> On Thu, Sep 13, 2012 at 5:18 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >> > On Wed, Sep 12, 2012 at 10:46 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> >> Hi all,
> >> >>
> >> >> Changes since 201209011:
> >> >>
> >> >> The pci tree lost its build failure.
> >> >>
> >> >> The mfd tree gained a conflict against Linus' tree.
> >> >>
> >> >> The omap_dss2 tree lost its conflict.
> >> >>
> >> >> The trivial tree gained a conflict against the mfd tree.
> >> >>
> >> >> The kvm tree gained a conflict against Linus' tree.
> >> >>
> >> >> The workqueues tree gained a conflict against the omap_dss2 tree.
> >> >>
> >> >> The usb tree gained conflicts against the usb.current tree.
> >> >>
> >> >> The staging tree gained a conflict against the thermal tree and a build
> >> >> failure for which I applied a merge fix patch.
> >> >>
> >> >> The tegra tree gained conflicts against the usb and arm-perf trees.
> >> >>
> >> >> ----------------------------------------------------------------------------
> >> >>
> >> >
> >> > Hi,
> >> >
> >> > this weeks linux-next seems to bring new and new issues, yay :-)!
> >> >
> >> > I have taken a photo, but can't say what can have caused.
> >> > The issue is reproducible...
> >> > Immediately, after pressing any key (when X-display-manager (lightdm)
> >> > and X-greeter are up) my machine panics and is no more usable (cold
> >> > rough brutal killer restart).
> >> > Note: Using upstart or systemd does not matter.
> >> >
> >> > Any pointer to an area where to dig into or any feedback in general is welcome!
> >> >
> >> > Kind Regards,
> >> > - Sedat -
> >>
> >> [ CC Dmitry Torokhov (linux-input maintainer) plus linux-input ML ]
> >>
> >> By looking at my screenshot, someone could imagine that there is a
> >> problem coming from the input GIT branch(es) merges:
> >>
> >> input_to_handler()
> >> input_pass_values()
> >> input_handle_event()
> >> input_event()
> >>
> >> Unfortunately, with those 3 revert-patches I see the same kernel-panic.
> >>
> >> Dimitry, any idea what can cause this kernel-panic?
> >
> > Today, I met similar problem in mmotm-2012-09-12-17-36 on my KVM.
> > It's hard to reproduce in my mahcine but I confirmed following as
> > Hoping it helps you.
> >
> 
> [ CC more input developers/testers ]
> 
> Hi Minchan,
> 
> Hey, cool. Thanks for the pointer in the source-code and the call-trace!
> I had reverted [1], but anyway input folks should look at this.
> 
> Kind Regards,
> - Sedat -
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=b276fc1e875a51e4a9dc3322ed008bf4ae481baf

Henrik,

It looks like your changes are causing the panic.

-- 
Dmitry
