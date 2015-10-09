From: "Li, Aubrey" <aubrey.li@intel.com>
Subject: RE: [PATCH] input:gpio-key: set IRQF_NO_SUSPEND for wake capable key
Date: Fri, 9 Oct 2015 02:47:41 +0000
Message-ID: <070BEF4AC20468458C22969097656CD912B0FE65@shsmsx102.ccr.corp.intel.com>
References: <1442506019-13687-1-git-send-email-qipeng.zha@intel.com>
 <CACRpkdYJEG1n4phfC=St0nic1_Z+qdoGKzhyS5yhDM9O9ci25w@mail.gmail.com>
 <20151002174146.GB8437@dtor-ws>
 <0DD381DBF8F68D419C32ACFCEB28EB25212F7D02@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55489 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbbJICrp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 22:47:45 -0400
In-Reply-To: <0DD381DBF8F68D419C32ACFCEB28EB25212F7D02@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Zheng, Qi" <qi.zheng@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "Zha, Qipeng" <qipeng.zha@intel.com>, Linux Input <linux-input@vger.kernel.org>

On Friday, October 09, 2015 10:14 AM, Zheng, Qi wrote:
> 
> Hi,
> 
> "enable_irq_wake" is to enable/disable power-management wake-on of an
> IRQ.
> It is wake-on control not interrupt enable control.
> In my opinion, to make sure the keys press working when system suspend, both
> wake-on and interrupt should be enabled.
> Besides,  for many platforms, the gpio irq chip don't implement the method
> "enable_irq_wake" by setting "IRQCHIP_SKIP_SET_WAKE".
> So, I think "IRQF_NO_SUSPEND" is necessary for this case.

We had a discussion on this before. Here is the thread:
https://lkml.org/lkml/2014/7/8/970

device_init_wakeup() is a general interface and supposed to be used to enable
wakeup for the wakeup sources. How gpio keys probe and call device_init_wakeup()
is a good reference for your case.

Thanks,
-Aubrey

> 
> BRs
> 
> Zheng Qi
> PEG->IPG->EIG SH IO/LPSS team
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Saturday, October 3, 2015 1:42 AM
> To: Linus Walleij <linus.walleij@linaro.org>
> Cc: Zha, Qipeng <qipeng.zha@intel.com>; Linux Input
> <linux-input@vger.kernel.org>; Zheng, Qi <qi.zheng@intel.com>; Li, Aubrey
> <aubrey.li@intel.com>
> Subject: Re: [PATCH] input:gpio-key: set IRQF_NO_SUSPEND for wake capable
> key
> 
> On Fri, Oct 02, 2015 at 03:26:27AM -0700, Linus Walleij wrote:
> > On Thu, Sep 17, 2015 at 9:06 AM, Qipeng Zha <qipeng.zha@intel.com>
> wrote:
> >
> > > When wakeup attribute is set, GPIO key is supposed to wake up the
> > > system from system sleep state, So set IRQF_NO_SUSPEND flag to keep
> > > IRQ enabled during suspend.
> > >
> > > Signed-off-by: Qi Zheng <qi.zheng@intel.com>
> > > Signed-off-by: Aubrey Li <aubrey.li@intel.com>
> > > Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Should this not be tagged for stable?
> 
> I do not believe we need this at all. Otherwise every single driver for devices
> that might be wakeup sources needs this flag set. Which would basically means
> it is a noop and we should not suspend IRQ threads by default.
> 
> The dirver correctly calls enable_irq_wake() and platform should do whatever it
> needs to make sure wakeup interrupt will be serviced.
> 
> Thanks.
> 
> --
> Dmitry
