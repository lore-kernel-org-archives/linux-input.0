From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Suspend/Resume wakeup support
Date: Tue, 15 Mar 2011 22:51:02 -0700
Message-ID: <20110316055102.GC14604@core.coreip.homeip.net>
References: <20110316051030.2399.19707.sendpatchset@t400s>
 <20110316053202.GA14604@core.coreip.homeip.net>
 <AANLkTimj3W_SdnHDs1tpWxDZEN8S17zHMDVAU+Zr=fG9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32966 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1CPFvI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 01:51:08 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimj3W_SdnHDs1tpWxDZEN8S17zHMDVAU+Zr=fG9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: srk@ti.com, linux-sh@vger.kernel.org, chinyeow.sim.xt@renesas.com, linux-input@vger.kernel.org

On Wed, Mar 16, 2011 at 02:45:11PM +0900, Magnus Damm wrote:
> On Wed, Mar 16, 2011 at 2:32 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Mar 16, 2011 at 02:10:30PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Extend the tca6416 driver to use enable_irq_wake()
> >> and disable_irq_wake() in the suspend/resume hooks.
> >>
> >> This makes it possible to wake up from suspend-to-ram
> >> using a tca6416 key on the sh7372 mackerel board.
> >>
> >
> > Hi Magnus,
> >
> > Looks good, but why don't we guard PM code with CONFIG_PM_SLEEP, like
> > below? I also believe we should use bus-specific helpers to access
> > private driver data since it does not have to stay alias for the
> > core data pointer.
> 
> Hi Dmitry,
> 
> Thank you for the updated patch, your version looks much better than
> mine. I tested your version on my Mackerel board a few minutes ago and
> it is still working as expected. Unless there are any objections,
> please merge your version of the patch.
> 

Excellent, I'll queue it up.

Thank you for testing the updated patch.

-- 
Dmitry
