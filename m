From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Thu, 2 Sep 2010 13:24:31 -0700
Message-ID: <20100902202431.GA22482@core.coreip.homeip.net>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
 <20100901165142.GB6908@core.coreip.homeip.net>
 <20100902065537.GA26429@bnru01.bnr.st.com>
 <20100902172222.GA17386@core.coreip.homeip.net>
 <4C8000D3.3060903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48021 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab0IBUYh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 16:24:37 -0400
Received: by iwn5 with SMTP id 5so803610iwn.19
        for <linux-input@vger.kernel.org>; Thu, 02 Sep 2010 13:24:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C8000D3.3060903@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Trilok,

On Fri, Sep 03, 2010 at 01:23:55AM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> On 9/2/2010 10:52 PM, Dmitry Torokhov wrote:
> > 
> >>>
> >>> I'll change it to use normal interrupts locally, no need to resubmit.
> >>
> >> Changing it to request_irq() will cause it to fail, because __setup_irq
> >> will error out if this is a nested thread interrupt and no interrupt
> >> thread is specified.  request_any_context_irq() should work, if you
> >> would like to get rid of explicitly asking for a threaded irq.
> >>
> > 
> > OK, request_any_context_irq() it is then.
> 
> Though request_any_context_irq() would work here, but I would still
> prefer to use the request_threaded_irq(..) because power-on key functionality
> is in-built to this PMIC chip and it will always be threaded it seems. No new
> thread will be created because they did the right thing in their PMIC core
> irq code it seems.
> 
> We could prefer the request_any_context_irq(...) when we are using the line
> (say gpio) coming out of this PMIC and used by generic device driver where
> the another h/w design could have memory mapped gpio for the same device driver.
> 
> Better to keep this driver with request_threaded_irq(..) only.
> 

I disagree. I believe that drivers should use request_threaded_irq()
only if they _themselves_ require handling interrupts in process context.
The fact that someone up the stack set up threaded IRQ and not hard IRQ
should not matter.

Ideally I'd love request_irq() to be what request_any_context_irq()
currently is and then we'd have request_hard_irq() for driver that
absolutely need hard IRQ context.

Thanks.

-- 
Dmitry
