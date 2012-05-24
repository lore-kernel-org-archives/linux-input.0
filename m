From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: Reg. kernel crash while using pixcir touchscreen driver
Date: Thu, 24 May 2012 13:41:27 +0530
Message-ID: <CAK9yfHzcT_fK1xiBf0opYBy-Qj6G8CUKcpfeZ81q0sY7byjGaA@mail.gmail.com>
References: <CAK9yfHzGgYTSE7mJ1xmnCrZ-_eYxBvbZp-hQ8tSJ77=TLvFdvQ@mail.gmail.com>
	<20120524074705.GA10562@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50179 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2EXIL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 04:11:28 -0400
Received: by qcro28 with SMTP id o28so5460800qcr.19
        for <linux-input@vger.kernel.org>; Thu, 24 May 2012 01:11:27 -0700 (PDT)
In-Reply-To: <20120524074705.GA10562@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jcbian@pixcir.com.cn, rydberg@euromail.se

Hi Dmitry,

Thank you for your reply.


On 24/05/2012, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Sachin,
>
> On Thu, May 24, 2012 at 11:20:01AM +0530, Sachin Kamat wrote:
>> Hi,
>>
>> I encountered a kernel crash while integrating Pixcir touchscreen
>> driver with one of our hardware. The log is attached at the end of the
>> mail (inline).
>>
>> The following ISR code:
>>
>> while (!tsdata->exiting) {
>>         pixcir_ts_poscheck(tsdata);
>>
>>         if (tsdata->chip->attb_read_val())
>>               break;
>>
>>         msleep(20);
>> }
>>
>> seems to run until the if condition is false. However, when it exits
>> the loop (when the condition becomes true), it crashes saying "exiting
>> task "irq/438-pixcir_" (1011) is an active IRQ thread".
>
> It actually crashes earlier, in pixcir_ts_isr() itself. The message is
> coming from do_exit() when ISR thread dies. Did you porvide
> attb_read_val implementation?

Yes, i did provide the implementation for it.
In fact even a simplest implementation where I return a positive
integer (for testing) results in the above crash.

>
>>
>> I have 2 questions here:
>> 1. Do we need such a loop and the if condition. In my case it worked
>> with the isr just doing
>> pixcir_ts_poscheck(tsdata);
>>
>> 2. What exactly is expected by attb_read_val() function.
>
> I believe it is supposed to indicate if touch is detected so we can keep
> polling.
>
> Thanks.
>
> --
> Dmitry
>


-- 
With warm regards,
Sachin
