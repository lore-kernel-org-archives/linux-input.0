From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 22:42:43 +0900
Message-ID: <4e1455be0909070642p6e604dfes518fa0c3d3b78afa@mail.gmail.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
	 <4AA49C53.3030400@samsung.com>
	 <20090907063341.GT3962@prithivi.gnumonks.org>
	 <4AA4B6E9.2070603@samsung.com>
	 <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
	 <4AA4F948.6080002@samsung.com>
	 <003201ca2fb8$207d7020$61785060$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:65286 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZIGNml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 09:42:41 -0400
Received: by vws33 with SMTP id 33so1765700vws.33
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 06:42:43 -0700 (PDT)
In-Reply-To: <003201ca2fb8$207d7020$61785060$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jinsung Yang <jsgood.yang@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, Harald Welte <laforge@gnumonks.org>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?EUC-KR?B?IidcIrHosObAzy9BULCzud/GwChTWVMuTFNJKS9FMyi757/4KS+777y6wPzA2lwi?= =?EUC-KR?B?JyI=?= <ki0351.kim@samsung.com>, =?EUC-KR?B?IidcIiex6LG5wfgvQVCws7nfxsAoU1lTLkxTSSkvRTUow6XA0ykvu++8usD8wNon?= =?EUC-KR?B?XCInIg==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

2009/9/7 Jinsung Yang <jsgood.yang@samsung.com>:
>> > I have some questions:
>> > 1) Could you explain to us what is the 'well-defined' driver?
>>
>> I mean the driver to support three cpu and various target in one key=
pad
>> driver, but i think that your posted driver seems for only SMDK6410.
>> Also, we can make better driver via the review.
>>
>
> Why do you think my driver cannot support various target?
> I think there are misunderstandings, are there any architecture speci=
fic codes?

=46or example, there is the keycodes. My target uses other keycodes.

> Surely, there can be something wrong driver-specific codes such as 'd=
ev_pm_ops',
> but that's not a big deal.. we can modify it with mainline feedbacks.
> My driver codes also have considered for our s5pc100, s5pc110, and ma=
ny Samsung SoCs.
> We will support other SoCs with adding some architecture definitions =
(not changing driver codes), but just 'NOT NOW'.

OK, but It needs to implement considering not only s3c64xx but also
s5pc1xx from first, and i think it's better to use "samsung" prefix.

> Please understand, 'step by step'.
> Of course we aware now our SoCs line-ups better than you, we are not =
happy to hear from you.

I know but we need many discussion to merge the better code in kernel.
I welcome it whenever.

>
> Finally, in your driver, regarding the if (cpu_is_s5pc100()) statemen=
t,
> how do you think if you have to check another SoC at some time in the=
 future?
> Doing like this if (cpu_is_s5pc110()) else if (cpu_is_s5pc120()) else=
 if (cpu_is_s5pc130()) ??
> Will you send some patches for this? looks be not good.

I used only cpu_is_s5pc110(), also you can refer the omap keypad driver=
=2E
It is a good example to support many omap arch

>
>> > 2) Did you test your keypad driver at s3c6410 based platform?
>>
>> No, i cannot test it on s3c64xx because i don't have a target using =
the
>> keypad of s3c64xx such SMDK6410 but i tested the keypad driver on
>> s5pc100 and s5pc110 and as you know, the keypad of the s3c6410 and
>> s5pc100 datasheet is same almost, so i think it will operate on s3c6=
4xx.
>>
>> > 3) There is no architecture codes for s5pc1xx series, why did you =
send
>> keypad driver first for s5pc1xx before architecture codes?
>> >
>>
>> Of course, I can post the arch code for keypad, but it is the common
>> code for s3c64xx and s5pc1xx and we didn't post s5pc1xx arch code ye=
t on
>> ML. I also think it is better to post the keypad driver after postin=
g
>> arch.
>>
>
> Best Regards
> --
> Jinsung, Yang <jsgood.yang@samsung.com>
> AP Development Team
> System LSI, Semiconductor Business
> SAMSUNG Electronics Co., LTD
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
- Joonyoung Shim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
