From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Reg. kernel crash while using pixcir touchscreen driver
Date: Thu, 24 May 2012 00:47:05 -0700
Message-ID: <20120524074705.GA10562@core.coreip.homeip.net>
References: <CAK9yfHzGgYTSE7mJ1xmnCrZ-_eYxBvbZp-hQ8tSJ77=TLvFdvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57371 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab2EXHrK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 03:47:10 -0400
Received: by dady13 with SMTP id y13so10940752dad.19
        for <linux-input@vger.kernel.org>; Thu, 24 May 2012 00:47:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK9yfHzGgYTSE7mJ1xmnCrZ-_eYxBvbZp-hQ8tSJ77=TLvFdvQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, jcbian@pixcir.com.cn, rydberg@euromail.se

Hi Sachin,

On Thu, May 24, 2012 at 11:20:01AM +0530, Sachin Kamat wrote:
> Hi,
> 
> I encountered a kernel crash while integrating Pixcir touchscreen
> driver with one of our hardware. The log is attached at the end of the
> mail (inline).
> 
> The following ISR code:
> 
> while (!tsdata->exiting) {
>         pixcir_ts_poscheck(tsdata);
> 
>         if (tsdata->chip->attb_read_val())
>               break;
> 
>         msleep(20);
> }
> 
> seems to run until the if condition is false. However, when it exits
> the loop (when the condition becomes true), it crashes saying "exiting
> task "irq/438-pixcir_" (1011) is an active IRQ thread".

It actually crashes earlier, in pixcir_ts_isr() itself. The message is
coming from do_exit() when ISR thread dies. Did you porvide
attb_read_val implementation?

> 
> I have 2 questions here:
> 1. Do we need such a loop and the if condition. In my case it worked
> with the isr just doing
> pixcir_ts_poscheck(tsdata);
> 
> 2. What exactly is expected by attb_read_val() function.

I believe it is supposed to indicate if touch is detected so we can keep
polling.

Thanks.

-- 
Dmitry
