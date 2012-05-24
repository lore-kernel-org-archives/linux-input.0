From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Reg. kernel crash while using pixcir touchscreen driver
Date: Thu, 24 May 2012 01:22:02 -0700
Message-ID: <20120524082202.GC10562@core.coreip.homeip.net>
References: <CAK9yfHzGgYTSE7mJ1xmnCrZ-_eYxBvbZp-hQ8tSJ77=TLvFdvQ@mail.gmail.com>
 <20120524074705.GA10562@core.coreip.homeip.net>
 <CAK9yfHzcT_fK1xiBf0opYBy-Qj6G8CUKcpfeZ81q0sY7byjGaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57467 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2EXIWI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 04:22:08 -0400
Received: by pbbrp8 with SMTP id rp8so11125147pbb.19
        for <linux-input@vger.kernel.org>; Thu, 24 May 2012 01:22:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK9yfHzcT_fK1xiBf0opYBy-Qj6G8CUKcpfeZ81q0sY7byjGaA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, jcbian@pixcir.com.cn, rydberg@euromail.se

On Thu, May 24, 2012 at 01:41:27PM +0530, Sachin Kamat wrote:
> Hi Dmitry,
> 
> Thank you for your reply.
> 
> 
> On 24/05/2012, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Hi Sachin,
> >
> > On Thu, May 24, 2012 at 11:20:01AM +0530, Sachin Kamat wrote:
> >> Hi,
> >>
> >> I encountered a kernel crash while integrating Pixcir touchscreen
> >> driver with one of our hardware. The log is attached at the end of the
> >> mail (inline).
> >>
> >> The following ISR code:
> >>
> >> while (!tsdata->exiting) {
> >>         pixcir_ts_poscheck(tsdata);
> >>
> >>         if (tsdata->chip->attb_read_val())
> >>               break;
> >>
> >>         msleep(20);
> >> }
> >>
> >> seems to run until the if condition is false. However, when it exits
> >> the loop (when the condition becomes true), it crashes saying "exiting
> >> task "irq/438-pixcir_" (1011) is an active IRQ thread".
> >
> > It actually crashes earlier, in pixcir_ts_isr() itself. The message is
> > coming from do_exit() when ISR thread dies. Did you porvide
> > attb_read_val implementation?
> 
> Yes, i did provide the implementation for it.
> In fact even a simplest implementation where I return a positive
> integer (for testing) results in the above crash.

Hmm, this is wierd... are you sure you do not discard platform data
after binding to the touchscreen?

-- 
Dmitry
