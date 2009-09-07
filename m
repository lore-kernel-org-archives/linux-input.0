From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 22:14:28 +0900
Message-ID: <9c9fda240909070614r4a6181f1l809df076b71ae757@mail.gmail.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
	 <4AA49C53.3030400@samsung.com>
	 <20090907063341.GT3962@prithivi.gnumonks.org>
	 <4AA4B6E9.2070603@samsung.com>
	 <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
	 <4AA4F948.6080002@samsung.com>
	 <003201ca2fb8$207d7020$61785060$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:65532 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZIGNO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 09:14:27 -0400
Received: by vws33 with SMTP id 33so1755134vws.33
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 06:14:28 -0700 (PDT)
In-Reply-To: <003201ca2fb8$207d7020$61785060$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jinsung Yang <jsgood.yang@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, Harald Welte <laforge@gnumonks.org>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?EUC-KR?B?IidcIrHosObAzy9BULCzud/GwChTWVMuTFNJKS9FMyi757/4KS+777y6wPzA2lwi?= =?EUC-KR?B?JyI=?= <ki0351.kim@samsung.com>, =?EUC-KR?B?IidcIiex6LG5wfgvQVCws7nfxsAoU1lTLkxTSSkvRTUow6XA0ykvu++8usD8wNon?= =?EUC-KR?B?XCInIg==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, jh80.chung@samsung.com

On Mon, Sep 7, 2009 at 9:38 PM, Jinsung Yang<jsgood.yang@samsung.com> wrote:
>> > I have some questions:
>> > 1) Could you explain to us what is the 'well-defined' driver?
>>
>> I mean the driver to support three cpu and various target in one keypad
>> driver, but i think that your posted driver seems for only SMDK6410.
>> Also, we can make better driver via the review.
>>
>
> Why do you think my driver cannot support various target?
> I think there are misunderstandings, are there any architecture specific codes?
> Surely, there can be something wrong driver-specific codes such as 'dev_pm_ops',
> but that's not a big deal.. we can modify it with mainline feedbacks.
> My driver codes also have considered for our s5pc100, s5pc110, and many Samsung SoCs.
> We will support other SoCs with adding some architecture definitions (not changing driver codes), but just 'NOT NOW'.
> Please understand, 'step by step'.
> Of course we aware now our SoCs line-ups better than you, we are not happy to hear from you.
>
> Finally, in your driver, regarding the if (cpu_is_s5pc100()) statement,
> how do you think if you have to check another SoC at some time in the future?
> Doing like this if (cpu_is_s5pc110()) else if (cpu_is_s5pc120()) else if (cpu_is_s5pc130()) ??
> Will you send some patches for this? looks be not good.

Then question. If next new chips has different field but has same
offset or address. In this case how you handle it?
E.g., How to use handle s5pc100 and s5pc110 simultaneously at one
driver without re-compile?

BR,
Kyungmin Park
