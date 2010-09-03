From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 3 Sep 2010 09:43:49 -0700
Message-ID: <20100903164348.GD2200@core.coreip.homeip.net>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
 <20100901165142.GB6908@core.coreip.homeip.net>
 <20100902065537.GA26429@bnru01.bnr.st.com>
 <20100902172222.GA17386@core.coreip.homeip.net>
 <4C8000D3.3060903@codeaurora.org>
 <20100902202431.GA22482@core.coreip.homeip.net>
 <4C8084C7.4020105@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58615 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab0ICQoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 12:44:00 -0400
Received: by gyd8 with SMTP id 8so831119gyd.19
        for <linux-input@vger.kernel.org>; Fri, 03 Sep 2010 09:44:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C8084C7.4020105@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Fri, Sep 03, 2010 at 10:46:55AM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> On 9/3/2010 1:54 AM, Dmitry Torokhov wrote:
> >>
> > 
> > I disagree. I believe that drivers should use request_threaded_irq()
> > only if they _themselves_ require handling interrupts in process context.
> > The fact that someone up the stack set up threaded IRQ and not hard IRQ
> > should not matter.
> > 
> > Ideally I'd love request_irq() to be what request_any_context_irq()
> > currently is and then we'd have request_hard_irq() for driver that
> > absolutely need hard IRQ context.
> > 
> 
> Well, how I see the request_any_context_irq(...) call is that when the caller
> doesn't know the protocol being setup from the irq core code

Well, here lies the difference in our approaches ;) For me it is not
that the driver does not know, but that it does not _care_. It, by
itself, can work in both threaded and hard interrupt mode.

I do believe that driver should request threaded interrupts only if they
need threaded interrupts.

> and how the line
> he is controlling was being setup, so in that case request_any_context_irq(..)
> to be the safest call. But in this case we know that it will be __always__
> threaded due the PMIC driven over slow bus.
> 
> May be multiple APIs are now causing confusion :)
> 

Thanks.

-- 
Dmitry
