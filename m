From: Jinsung Yang <jsgood.yang@samsung.com>
Subject: RE: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 21:38:39 +0900
Message-ID: <003201ca2fb8$207d7020$61785060$%yang@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <4AA49C53.3030400@samsung.com> <20090907063341.GT3962@prithivi.gnumonks.org>
 <4AA4B6E9.2070603@samsung.com>
 <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
 <4AA4F948.6080002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53331 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZIGMf7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 08:35:59 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL0087OPO1Y8@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 21:36:01 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL00MP0PO1ZV@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 21:36:01 +0900 (KST)
In-reply-to: <4AA4F948.6080002@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>
Cc: 'Harald Welte' <laforge@gnumonks.org>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?JyInXCLquYDqsr3snbwvQVDqsJzrsJztjIAoU1lTLkxTSSkvRTMo7IKs7JuQKQ==?= =?utf-8?B?L+yCvOyEseyghOyekFwiJyIn?= <ki0351.kim@samsung.com>, =?utf-8?B?JyInXCIn6rmA6rWt7KeEL0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0U1KOyxheyehCkv?= =?utf-8?B?7IK87ISx7KCE7J6QJ1wiJyIn?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

> > I have some questions:
> > 1) Could you explain to us what is the 'well-defined' driver?
> 
> I mean the driver to support three cpu and various target in one keypad
> driver, but i think that your posted driver seems for only SMDK6410.
> Also, we can make better driver via the review.
> 

Why do you think my driver cannot support various target?
I think there are misunderstandings, are there any architecture specific codes?
Surely, there can be something wrong driver-specific codes such as 'dev_pm_ops',
but that's not a big deal.. we can modify it with mainline feedbacks.
My driver codes also have considered for our s5pc100, s5pc110, and many Samsung SoCs.
We will support other SoCs with adding some architecture definitions (not changing driver codes), but just 'NOT NOW'.
Please understand, 'step by step'.
Of course we aware now our SoCs line-ups better than you, we are not happy to hear from you.

Finally, in your driver, regarding the if (cpu_is_s5pc100()) statement,
how do you think if you have to check another SoC at some time in the future?
Doing like this if (cpu_is_s5pc110()) else if (cpu_is_s5pc120()) else if (cpu_is_s5pc130()) ??
Will you send some patches for this? looks be not good.

> > 2) Did you test your keypad driver at s3c6410 based platform?
> 
> No, i cannot test it on s3c64xx because i don't have a target using the
> keypad of s3c64xx such SMDK6410 but i tested the keypad driver on
> s5pc100 and s5pc110 and as you know, the keypad of the s3c6410 and
> s5pc100 datasheet is same almost, so i think it will operate on s3c64xx.
> 
> > 3) There is no architecture codes for s5pc1xx series, why did you send
> keypad driver first for s5pc1xx before architecture codes?
> >
> 
> Of course, I can post the arch code for keypad, but it is the common
> code for s3c64xx and s5pc1xx and we didn't post s5pc1xx arch code yet on
> ML. I also think it is better to post the keypad driver after posting
> arch.
> 

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD


