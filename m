From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:gpio-key: set IRQF_NO_SUSPEND for wake capable key
Date: Fri, 2 Oct 2015 10:41:46 -0700
Message-ID: <20151002174146.GB8437@dtor-ws>
References: <1442506019-13687-1-git-send-email-qipeng.zha@intel.com>
 <CACRpkdYJEG1n4phfC=St0nic1_Z+qdoGKzhyS5yhDM9O9ci25w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33566 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbJBRlt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 13:41:49 -0400
Received: by pacex6 with SMTP id ex6so112274513pac.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 10:41:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdYJEG1n4phfC=St0nic1_Z+qdoGKzhyS5yhDM9O9ci25w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Linux Input <linux-input@vger.kernel.org>, Qi Zheng <qi.zheng@intel.com>, Aubrey Li <aubrey.li@intel.com>

On Fri, Oct 02, 2015 at 03:26:27AM -0700, Linus Walleij wrote:
> On Thu, Sep 17, 2015 at 9:06 AM, Qipeng Zha <qipeng.zha@intel.com> wrote:
> 
> > When wakeup attribute is set, GPIO key is supposed to wake up
> > the system from system sleep state, So set IRQF_NO_SUSPEND
> > flag to keep IRQ enabled during suspend.
> >
> > Signed-off-by: Qi Zheng <qi.zheng@intel.com>
> > Signed-off-by: Aubrey Li <aubrey.li@intel.com>
> > Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Should this not be tagged for stable?

I do not believe we need this at all. Otherwise every single driver for
devices that might be wakeup sources needs this flag set. Which would
basically means it is a noop and we should not suspend IRQ threads by
default.

The dirver correctly calls enable_irq_wake() and platform should do
whatever it needs to make sure wakeup interrupt will be serviced.

Thanks.

-- 
Dmitry
