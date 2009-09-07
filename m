From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 21:15:04 +0900
Message-ID: <4AA4F948.6080002@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <4AA49C53.3030400@samsung.com> <20090907063341.GT3962@prithivi.gnumonks.org>
 <4AA4B6E9.2070603@samsung.com>
 <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54636 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZIGMQ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 08:16:28 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL00D7WOP4P3@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 21:15:04 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL00E8JOP49W@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 21:15:04 +0900 (KST)
In-reply-to: <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jinsung Yang <jsgood.yang@samsung.com>
Cc: 'Harald Welte' <laforge@gnumonks.org>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?UTF-8?B?IidcIuq5gOqyveydvC9BUOqwnOuwnO2MgChTWVMuTA==?= =?UTF-8?B?U0kpL0UzKOyCrOybkCkv7IK87ISx7KCE7J6QXCInIg==?= <ki0351.kim@samsung.com>, =?UTF-8?B?IidcIifquYDqta3sp4QvQVDqsJzrsJztjIAo?= =?UTF-8?B?U1lTLkxTSSkvRTUo7LGF7J6EKS/sgrzshLHsoITsnpAnXCInIg==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi,

On 9/7/2009 8:32 PM, Jinsung Yang wrote:
> Hi, Mr.Shim
> 
>>>    submitted mainline.  This is what Jinsun was starting, and which he
>>>    will continue until it is included mainline.
>>>
>> The keypad of s3c64xx and s5pc1xx is same almost, so we need to submit
>> the well-defined driver from the first.
> 
> I have some questions:
> 1) Could you explain to us what is the 'well-defined' driver?

I mean the driver to support three cpu and various target in one keypad
driver, but i think that your posted driver seems for only SMDK6410.
Also, we can make better driver via the review.

> 2) Did you test your keypad driver at s3c6410 based platform?

No, i cannot test it on s3c64xx because i don't have a target using the
keypad of s3c64xx such SMDK6410 but i tested the keypad driver on
s5pc100 and s5pc110 and as you know, the keypad of the s3c6410 and 
s5pc100 datasheet is same almost, so i think it will operate on s3c64xx.

> 3) There is no architecture codes for s5pc1xx series, why did you send keypad driver first for s5pc1xx before architecture codes?
> 

Of course, I can post the arch code for keypad, but it is the common
code for s3c64xx and s5pc1xx and we didn't post s5pc1xx arch code yet on
ML. I also think it is better to post the keypad driver after posting
arch.

> Best Regards
> --
> Jinsung, Yang <jsgood.yang@samsung.com>
> AP Development Team
> System LSI, Semiconductor Business
> SAMSUNG Electronics Co., LTD
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

