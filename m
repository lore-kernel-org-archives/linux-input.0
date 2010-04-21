From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Wed, 21 Apr 2010 12:56:59 -0700
Message-ID: <20100421195659.GB10641@core.coreip.homeip.net>
References: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
 <20100327191102.GA14548@core.coreip.homeip.net>
 <t2u40ec3ea41004191336u64db7e79t455920a56bcd856c@mail.gmail.com>
 <20100420072903.GA32108@core.coreip.homeip.net>
 <l2s40ec3ea41004200601jd2772157ye1210e3d4764b199@mail.gmail.com>
 <r2x40ec3ea41004202047w9e5ae654xe375b67273a3f647@mail.gmail.com>
 <20100421041029.GA9482@core.coreip.homeip.net>
 <p2r40ec3ea41004210515geb17ed8du24ff7d1eb4cc2214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47769 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0DUT5G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 15:57:06 -0400
Received: by pvg13 with SMTP id 13so1126434pvg.19
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 12:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <p2r40ec3ea41004210515geb17ed8du24ff7d1eb4cc2214@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Wed, Apr 21, 2010 at 08:15:17AM -0400, Chase Douglas wrote:
> On Wed, Apr 21, 2010 at 12:10 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Apr 20, 2010 at 11:47:20PM -0400, Chase Douglas wrote:
> >> On Tue, Apr 20, 2010 at 9:01 AM, Chase Douglas
> >> <chase.douglas@canonical.com> wrote:
> >> > On Tue, Apr 20, 2010 at 12:29 AM, Dmitry Torokhov
> >> > <dmitry.torokhov@gmail.com> wrote:
> >> >> That means that our standard magic knock did not work. It seems that
> >> >> newer version of ALPS are using a different "magic knock" sequence for
> >> >> them.
> >> >
> >> > How can we find out what the new knock sequence is?
> >>
> >
> > One way would be to run the $OTHER_OS with proper driver inside a VM and
> > pass-through all commands from that OS to real PS/2 hardware recodring
> > the sequence in process.
> 
> Do you know of any documentation on how to do this? I've tried various
> google searches, but I'm having difficulty finding information on
> sniffing the ps/2 protocol through a vm.
> 

I do not know of existing setups. I'd expect you'll have to pick in
QEMU/KVM guts and make it talk to psaux interface (the old, 2.4-style
PS/2 port). Then, on the host side, set up serio_raw driver instead of
psmouse to that VM can talk to real hardware.

-- 
Dmitry
