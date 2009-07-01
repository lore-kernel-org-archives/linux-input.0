From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 1 Jul 2009 21:14:26 +0900
Message-ID: <4d34a0a70907010514u177feb34m6725bc6e531db91b@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
	 <200906112103.54043.dmitry.torokhov@gmail.com>
	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
	 <20090629162619.GB24533@dtor-d630.eng.vmware.com>
	 <5d5443650906292343i5ac0452fq4232147fb4e419a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:50727 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZGAMTn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2009 08:19:43 -0400
Received: by vwj40 with SMTP id 40so389879vwj.33
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2009 05:19:46 -0700 (PDT)
In-Reply-To: <5d5443650906292343i5ac0452fq4232147fb4e419a3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

On Tue, Jun 30, 2009 at 3:43 PM, Trilok Soni<soni.trilok@gmail.com> wrote:
> Hi Dmitry,
>
> On Mon, Jun 29, 2009 at 9:56 PM, Dmitry
> Torokhov<dmitry.torokhov@gmail.com> wrote:
>> Hi Eric,
>>
>> On Fri, Jun 12, 2009 at 09:26:43PM +0800, Eric Miao wrote:
>>>
>>> Hi Dmitry,
>>>
>>> I've tested the driver code, and it's basically OK except for two minor
>>> fixes:
>>>
>>> 1) GPIO and IRQs have to be initialized before input_register_device(),
>>> otherwise input->open() will be invoked before that, which will schedule
>>> an immediate scan work and fail.
>>>
>>> 2) disable_irq_rows() called in init_matrix_gpio() so that by default it's
>>> initialized to disabled - and will be enabled by input->open()
>>>
>>
>> Could you please take a look at the driver as it is commited to
>> 'for-linus' branch of my tree and let me know if you see anything wrong
>> there? Otherwise I inted to submit it in my next update to Linus.
>>
>
> Are you planning to take "MAX7359 input switch controller driver" too
> for submission to Linus in -rc1?

Thanks, Trilok

Dmitry, can I know when MAX7359 keypad driver will be merged to mainline?

Regards,
Kyuwon
