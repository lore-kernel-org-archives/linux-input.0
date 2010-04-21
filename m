From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Tue, 20 Apr 2010 21:10:30 -0700
Message-ID: <20100421041029.GA9482@core.coreip.homeip.net>
References: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
 <20100327191102.GA14548@core.coreip.homeip.net>
 <t2u40ec3ea41004191336u64db7e79t455920a56bcd856c@mail.gmail.com>
 <20100420072903.GA32108@core.coreip.homeip.net>
 <l2s40ec3ea41004200601jd2772157ye1210e3d4764b199@mail.gmail.com>
 <r2x40ec3ea41004202047w9e5ae654xe375b67273a3f647@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59854 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0DUEKj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 00:10:39 -0400
Received: by gyg13 with SMTP id 13so3603737gyg.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 21:10:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <r2x40ec3ea41004202047w9e5ae654xe375b67273a3f647@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 20, 2010 at 11:47:20PM -0400, Chase Douglas wrote:
> On Tue, Apr 20, 2010 at 9:01 AM, Chase Douglas
> <chase.douglas@canonical.com> wrote:
> > On Tue, Apr 20, 2010 at 12:29 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> On Mon, Apr 19, 2010 at 01:36:33PM -0700, Chase Douglas wrote:
> >>> After more testing, some users found that they no longer could use the
> >>> vertical edge scroll of their touchpad. I assumed everything was
> >>> working correctly because I had read a response to another user on
> >>> this list that if you add a new ID, things work, and you don't see any
> >>> protocol error messages in dmesg, then things should be correct. The
> >>> testers reported no errors, so I assumed the problem was in the X
> >>> synaptics driver. However, after receiving some event reports from a
> >>> tester, it may be that the normal ps2 driver is still sending events,
> >>> while the alps/synaptics kernel driver is not sending any. Do you have
> >>> any insight on what might be going on?
> >>>
> >>
> >> That means that our standard magic knock did not work. It seems that
> >> newer version of ALPS are using a different "magic knock" sequence for
> >> them.
> >
> > How can we find out what the new knock sequence is?
> 

One way would be to run the $OTHER_OS with proper driver inside a VM and
pass-through all commands from that OS to real PS/2 hardware recodring
the sequence in process.

> I've had more testing done by others with hardware. It's clear to me
> that the magic knock sequence in alps.c does not work for this device.
> I have tried both with ALPS_PASS as well, with no change. That means
> that we have two potential ways to go from here:
> 
> a. Revert the signature and use the ImPS/2 Generic Wheel Mouse driver,
> which provides wheel events automatically but without any absolute
> event support
> b. Leave the signature as is, which disables wheel events and enables
> no extra functionality
> 
> I would call b a regression. Maybe we can figure out the new knock
> protocol before the change propagates from tip to distros, but I think
> it's better to revert the signature and reapply it later when we find
> the right sequence. What do you think?
> 

The change has been reverted in my tree and will be reverted in mainline
when I request next pull (before .34 is released).

Thanks.

-- 
Dmitry
