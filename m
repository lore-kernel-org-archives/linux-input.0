From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846 - Replace spinlock by mutex to wrap
 disable()/enable()
Date: Tue, 7 Sep 2010 21:43:26 -0700
Message-ID: <20100908044326.GA10338@core.coreip.homeip.net>
References: <1282370340-3157-1-git-send-email-jason77.wang@gmail.com>
 <4C7491D7.1030801@gmail.com>
 <20100901064841.GH23585@core.coreip.homeip.net>
 <4C7E25E2.90904@gmail.com>
 <20100901164818.GA6908@core.coreip.homeip.net>
 <20100902160132.GD16914@core.coreip.homeip.net>
 <4C86FE0D.2060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:37132 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0IHEnd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 00:43:33 -0400
Received: by pxi10 with SMTP id 10so1606346pxi.19
        for <linux-input@vger.kernel.org>; Tue, 07 Sep 2010 21:43:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C86FE0D.2060905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

On Wed, Sep 08, 2010 at 11:07:57AM +0800, Jason Wang wrote:
> Dmitry Torokhov wrote:
> >On Wed, Sep 01, 2010 at 09:48:18AM -0700, Dmitry Torokhov wrote:
> >>On Wed, Sep 01, 2010 at 06:07:30PM +0800, Jason Wang wrote:
> >>>Dmitry Torokhov wrote:
> >>>>Hi Jason,
> >>>>
> >>>>On Wed, Aug 25, 2010 at 11:45:27AM +0800, Jason Wang wrote:
> >>>>>Hi dmitry and others,
> >>>>>
> >>>>>could you please to help me review this patch?
> >>>>>
> >>>>>Thanks,
> >>>>>Jason.
> >>>>>
> >>>>>Jason Wang wrote:
> >>>>>>The commit 9114337 introduces regulator operations in the ads7846
> >>>>>>touchscreen driver. Among these operations, some are called in the
> >>>>>>spinlock protected context.
> >>>>>>On most platforms, the regulator operation is achieved through
> >>>>>>i2c/spi bus transfer operations, some bus transfer operations will
> >>>>>>call wait_for_completion function. It isn't allowable  to call
> >>>>>>sleepable function in the atomic context. So replace the spinlock with
> >>>>>>mutex to protect ads7846_disable()/ads7846_enable().
> >>>>>>
> >>>>I am afraid the patch is not correct. ads7846_disable() and
> >>>>ads7846_enable() check and modify flags (such as irq_disabled and
> >>>>pending) that are also accessed form timer/interrupt context. Moving to
> >>>>mutex removes the serialization that used to be there.
> >>>Thanks for your comments. you are right it is dangerous and
> >>>unreasonable to use different locks to protect a critical resource.
> >>>>I wonder if we should start by converting the driver to used threaded
> >>>>IRQ model with "long playing" interrupt handler so all access happens in
> >>>>process context and shutdown sequence is simplified.
> >>>It can solve most issues, but it can't solve this situation. Because
> >>>here the atomic region in which conflicts happened is from spin_lock
> >>>instead of irq handler.
> >>>
> >>Right, but switching to threaded IRQ will allow to use mutex in place
> >>of the spinlock everywhere.
> >>
> >
> >I wonder if the following patch works (or can be made to work)...
> >
> Hi Dmitry,
> 
> I have made a quick test of this patch, currently two issues found:
> 1) missing #include <linux/sched.h> , it will produce a building error.
> 2) touch panel can't work, it seems that the input dev doesn't
> report pen up events.
> 

Yeah, it is kinda hard to get stuff working first time around without
the hardware :)

> Your patch is a good frame work, i will continue working basing off
> your patch.
> Maybe several dates later, i will send out an extra patch to
> strengthen your patch.
> 

Great, let me know how it goes.

Thanks.

-- 
Dmitry
