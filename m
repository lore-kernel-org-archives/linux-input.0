From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/3 v2] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Thu, 07 Jul 2011 09:04:49 +0900
Message-ID: <4E14F821.1000504@samsung.com>
References: <4E11B8C3.8010608@atmel.com> <4E1263C9.3010704@samsung.com>
 <4E12B96B.2050601@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62817 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1GGAEe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 20:04:34 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNX009WWS7ECMH0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 07 Jul 2011 09:04:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNX0098US7KX3@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 07 Jul 2011 09:04:32 +0900 (KST)
In-reply-to: <4E12B96B.2050601@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 2011-07-05 =EC=98=A4=ED=9B=84 4:12, Iiro Valkonen wrote:
> Hello,
>
> On 07/05/2011 04:07 AM, Joonyoung Shim wrote:
>> Hi,
>>
>> On 2011-07-04 =EC=98=A4=ED=9B=84 9:57, Iiro Valkonen wrote:
>>> The delay before the chip can be accessed after reset varies betwee=
n different
>>> chips in maXTouch family. Waiting for 200ms and then monitoring the=
 CHG (chip
>>> is ready when the line is low) is guaranteed to work with all chips=
=2E
>>
>> I wonder 200ms waiting needs indeed, it is very long time.
>> If monitoring the CHG line can detect the completion of reset,
>> 200ms waiting can be removed?
>>

My question is monitoring the CHG line can substitute=20
"msleep(MXT_RESET_TIME)"? In other words, i want to remove
msleep(MXT_RESET_TIME) and add only waiting until CHG line is low.

>
> Yes, 200ms is a bit longish. But it is what we need to guarantee corr=
ect
> functionality with all chips in all situations. I would prefer to see=
 that
> in the mainline version. Anyone worried about the delay could maybe a=
djust
> the value to suit his/her needs, for example with mXT224 you could ge=
t away with
> using just 65ms, like in the original version. Another option would b=
e to
> check the family ID in the driver, and wait just long enough. Drawbac=
k with
> that is that the driver (possibly) needs updating with every new chip=
=2E I'd
> like to keep this simple&  robust, wait 200ms which works for every c=
urrent
> (and most likely with every upcoming) chip, and take the small delay =
penalty.
>

The 200ms delay is sometimes a problem for fastbooting, and if each
chip has different delay value, i think it's better that driver support=
s
suitable delay value of the chip because it isn't difficult stuff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
