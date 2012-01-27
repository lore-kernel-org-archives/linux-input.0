From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v10 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
Date: Fri, 27 Jan 2012 13:26:45 -0800
Message-ID: <3249126.MSECh6D9S6@dtor-d630.eng.vmware.com>
References: <1327021046-18024-1-git-send-email-javier@dowhile0.org> <20120127181846.GA22462@core.coreip.homeip.net> <CABxcv=n8kFJiL01WEVdFat5Y=W9xQeG6_2oNV=_45UUFr+0gtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40519 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab2A0V0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jan 2012 16:26:51 -0500
Received: by dadi2 with SMTP id i2so1748628dad.19
        for <linux-input@vger.kernel.org>; Fri, 27 Jan 2012 13:26:51 -0800 (PST)
In-Reply-To: <CABxcv=n8kFJiL01WEVdFat5Y=W9xQeG6_2oNV=_45UUFr+0gtw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Friday, January 27, 2012 10:01:22 PM Javier Martinez Canillas wrote:
> On Fri, Jan 27, 2012 at 7:18 PM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, Jan 27, 2012 at 04:57:12PM +0100, Javier Martinez Canillas wrote:
> >> On Fri, Jan 27, 2012 at 9:18 AM, Dmitry Torokhov
> >> 
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Thu, Jan 26, 2012 at 01:12:50AM +0100, Javier Martinez Canillas 
wrote:
> >> >> On Tue, Jan 24, 2012 at 8:54 AM, Dmitry Torokhov
> >> >> 
> >> >> <dmitry.torokhov@gmail.com> wrote:
> >> >> > On Tue, Jan 24, 2012 at 08:26:39AM +0100, Javier Martinez Canillas 
wrote:
> >> >> >> On Fri, Jan 20, 2012 at 1:57 AM, Javier Martinez Canillas
> >> >> >> 
> >> >> >> <javier@dowhile0.org> wrote:
> >> >> >> > Cypress TrueTouch(tm) Standard Product controllers are
> >> >> >> > found in
> >> >> >> > a wide range of embedded devices. This driver add
> >> >> >> > support for a
> >> >> >> > variety of TTSP controllers.
> >> >> >> > 
> >> >> >> > Since the hardware is capable of tracking identifiable
> >> >> >> > contacts, multi-touch protocol type B (stateful) is
> >> >> >> > used to report contact information.
> >> >> >> > 
> >> >> >> > The driver is composed of a core driver that process
> >> >> >> > the data sent by the contacts and a set of bus
> >> >> >> > specific interface modules. This patch adds the base
> >> >> >> > core TTSP driver.
> >> >> >> > 
> >> >> >> > Signed-off-by: Javier Martinez Canillas
> >> >> >> > <javier@dowhile0.org>
> >> >> >> > ---
> >> >> >> > 
> >> >> >> > Changes for v10: Fix issues called out by Dmitry
> >> >> >> > Torokhov
> >> >> >> >        - Remove use_sleep and put device to sleep
> >> >> >> > unconditionally on suspend - Cleanup
> >> >> >> > cyttsp_power_on() and remove cyttsp_bl_app_valid()
> >> >> >> > function
> >> >> >> > 
> >> >> >> >  drivers/input/touchscreen/Kconfig       |   31 ++
> >> >> >> >  drivers/input/touchscreen/Makefile      |    3 +
> >> >> >> >  drivers/input/touchscreen/cyttsp_core.c |  682
> >> >> >> > +++++++++++++++++++++++++++++++
> >> >> >> > drivers/input/touchscreen/cyttsp_core.h |  141
> >> >> >> > +++++++ include/linux/input/cyttsp.h            |  
> >> >> >> > 68 +++
> >> >> >> >  5 files changed, 925 insertions(+), 0 deletions(-)
> >> >> >> 
> >> >> >> Hello Dmitry,
> >> >> >> 
> >> >> >> Any comments on this version?
> >> >> > 
> >> >> > Looking at it... If you do not hear from me by Wednesday
> >> >> > please ping me again.
> >> >> > 
> >> >> > Thanks.
> >> >> > 
> >> >> > --
> >> >> > Dmitry
> >> >> 
> >> >> ping :)
> >> > 
> >> > Is it still Wednesday by any chance? ;)
> >> 
> >> Hi Dmitry,
> >> 
> >> Thanks for the review and the cleanup patch!
> >> 
> >> > Anyway, the driver looks pretty good, still below are some changes
> >> > that I'd like to get in as well:
> >> > 
> >> > - do not return EAGAIN when operation times out, EIO I believe
> >> > suits
> >> >  better.
> >> > - introduce ttsp_send_command() to replace host of custom
> >> > functions.
> >> > - reduce numver of states to 3 - IDLE, ACTIVE and BL mode.
> >> >  Suspended/full power is already covered by "suspended" attribute.
> >> > - streamline some functions.
> >> 
> >> Seems that your patch handlers all these issues.
> >> 
> >> > Please see the FIXME comment in cyttsp_enable() - is there a
> >> > generic way to wake up the device, similarly to the way we put it
> >> > to sleep?>> 
> >> I guess that CY_OPERATE_MODE works but I have to try it since I don't
> >> have the hw data-sheet.
> >> 
> >> > Please tell me if the device still works with this patch.
> >> > 
> >> > Thanks!
> >> > 
> >> > --
> >> > Dmitry
> >> 
> >> Strange enough, it doesn't apply cleanly on my tree...
> >> 
> >> with patch -p1 < your_patch
> >> 
> >> It should since only the files for this driver are modified and I've
> >> only applied the v10 patches I sent to you.
> >> Anyway I will manually do the changes, try it and resend to you.
> > 
> > Hmm, not sure why it gives you trouble, I tried not to change anything
> > when applying your v10 patches except for folding them all together.
> > 
> > I am attaching the version of the driver I've used as a base - maybe it
> > will save you some time instead of applying the changes manually.
> > 
> > Also, could you please send changes needed to make my patch work as
> > incremental patch so that I can apply on top of mime locally and fold
> > all 3 together? It will be easier to see what exactly changed.
> > 
> > Thanks!
> > 
> > --
> > Dmitry
> 
> Hi Dmitry,
> 
> Using that merged patch as a base your patch applies cleanly (not sure
> what happened with my branch)
> 
> Sadly the driver is not working with your modifications.

I was afraid it could happen - hazards of chaging the code without the way of 
testing it...  I'll try to double check and see what I might have done wrong. 
What device did you test - I2C or SPI? Or do they both fail?

> I'll make it
> work changing as less as possible what was in your patch. Only to make
> the device work again and will send you as an incremental patch as you
> suggested.

Thank you for your patience with me.

> 
> Just to be clear, do you want me to send as an incremental patch of my
> series (v10) or as an incremental patch of your last patch?
> 

Incremental to mine please - so in your working branch you should have the 
original change + my patch as a separate commit + your commit fixing my mess.

-- 
Dmitry
