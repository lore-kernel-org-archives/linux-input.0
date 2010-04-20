From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Tue, 20 Apr 2010 00:29:03 -0700
Message-ID: <20100420072903.GA32108@core.coreip.homeip.net>
References: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
 <20100327191102.GA14548@core.coreip.homeip.net>
 <t2u40ec3ea41004191336u64db7e79t455920a56bcd856c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:40261 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab0DTH3M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Apr 2010 03:29:12 -0400
Received: by yxe1 with SMTP id 1so3535942yxe.33
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 00:29:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <t2u40ec3ea41004191336u64db7e79t455920a56bcd856c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Mon, Apr 19, 2010 at 01:36:33PM -0700, Chase Douglas wrote:
> On Sat, Mar 27, 2010 at 12:11 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sat, Mar 27, 2010 at 01:51:51PM -0400, Chase Douglas wrote:
> >> Tested by a user running Ubuntu 9.10 in the following bug report.
> >>
> >> BugLink: http://bugs.launchpad.net/bugs/545307
> >>
> >> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> >> Cc: stable@kernel.org
> >
> > Will apply, thank you Chase.
> 
> Dmitry,
> 
> After more testing, some users found that they no longer could use the
> vertical edge scroll of their touchpad. I assumed everything was
> working correctly because I had read a response to another user on
> this list that if you add a new ID, things work, and you don't see any
> protocol error messages in dmesg, then things should be correct. The
> testers reported no errors, so I assumed the problem was in the X
> synaptics driver. However, after receiving some event reports from a
> tester, it may be that the normal ps2 driver is still sending events,
> while the alps/synaptics kernel driver is not sending any. Do you have
> any insight on what might be going on?
> 

That means that our standard magic knock did not work. It seems that
newer version of ALPS are using a different "magic knock" sequence for
them.

-- 
Dmitry
