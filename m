From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 01/10] mfd/extcon: max77693: Remove unused extern
 declarations and max77693_dev members
Date: Mon, 4 May 2015 16:01:55 +0900
Message-ID: <CAJKOXPctQbsLc5mqAb-D_7RYN8ZvFzDafa_KcLgrCQAM1WWDRQ@mail.gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
	<1430305114-23598-2-git-send-email-k.kozlowski.k@gmail.com>
	<5547156C.9030402@samsung.com>
	<CAJKOXPfcir+NPa2Abj8PBtyxn_b8cb+E8wDL9nAuTyO2soDQEw@mail.gmail.com>
	<554717A6.40807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vn0-f44.google.com ([209.85.216.44]:42567 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbEDHB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2015 03:01:56 -0400
In-Reply-To: <554717A6.40807@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org

2015-05-04 15:54 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> On 05/04/2015 03:49 PM, Krzysztof Koz=C5=82owski wrote:
>> 2015-05-04 15:45 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
>>> On 04/29/2015 07:58 PM, Krzysztof Kozlowski wrote:
>>>> Clean up the max77693 private header file by removing:
>>>> 1. Left-overs from previous way of interrupt handling (driver uses
>>>>    regmap_irq_chip).
>>>> 2. Unused members of struct 'max77693_dev' related to interrupts i=
n
>>>>    extcon driver.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>>> ---
>>>>  drivers/extcon/extcon-max77693.c     | 4 ----
>>>>  include/linux/mfd/max77693-private.h | 8 --------
>>>>  2 files changed, 12 deletions(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/ext=
con-max77693.c
>>>> index a66bec8f6252..760e1e2cc1ce 100644
>>>> --- a/drivers/extcon/extcon-max77693.c
>>>> +++ b/drivers/extcon/extcon-max77693.c
>>>> @@ -1218,10 +1218,6 @@ static int max77693_muic_probe(struct platf=
orm_device *pdev)
>>>>                       irq_src =3D MUIC_INT3;
>>>>                       break;
>>>>               }
>>>> -
>>>> -             if (irq_src < MAX77693_IRQ_GROUP_NR)
>>>> -                     info->max77693->irq_masks_cur[irq_src]
>>>> -                             =3D init_data[i].data;
>>>>       }
>>>
>>> When removing the unused statement, I think you better to remove it=
 as following:
>>> because 'enum max77693_irq_source irq_src' is not used.
>>
>> Yes, you're right. Actually some time ago I removed all of this:
>> extcon: max77693: Remove left-over code after switching to regmap ir=
q chip
>> http://lkml.iu.edu/hypermail/linux/kernel/1410.2/03403.html
>>
>>>
>>>         for (i =3D 0; i < num_init_data; i++) {
>>> -               enum max77693_irq_source irq_src
>>> -                               =3D MAX77693_IRQ_GROUP_NR;
>>> -
>>>                 regmap_write(info->max77693->regmap_muic,
>>>                                 init_data[i].addr,
>>>                                 init_data[i].data);
>>> -
>>> -               switch (init_data[i].addr) {
>>> -               case MAX77693_MUIC_REG_INTMASK1:
>>> -                       irq_src =3D MUIC_INT1;
>>> -                       break;
>>> -               case MAX77693_MUIC_REG_INTMASK2:
>>> -                       irq_src =3D MUIC_INT2;
>>> -                       break;
>>> -               case MAX77693_MUIC_REG_INTMASK3:
>>> -                       irq_src =3D MUIC_INT3;
>>> -                       break;
>>> -               }
>>> -
>>> -               if (irq_src < MAX77693_IRQ_GROUP_NR)
>>> -                       info->max77693->irq_masks_cur[irq_src]
>>> -                               =3D init_data[i].data;
>>>         }
>>>
>>> [snip]
>>>
>>> Except for upper comment, Looks good to me.
>>
>> Okay, I'll do as you suggested and add your ack (in case it will go
>> through some other tree).
>
> I'm wondering the merge confilct if this patch will be merged on othe=
r tree.
> Because extcon-max77693.c was already modified on extcon-next branch.
>
> So, If the base commit of this patch is different, there are potentia=
l merge conflict.

Right, we can solve it by an immutable branch shared between trees. I
suspect that getting acks for whole patchset will take some time, so
the cleanups (few first patches) can be picked at beginning by
someone. Then, if needed, the maintainer can provide the branch for
other. Fortunately currently I don't see many conflicts between this
patch and extcon-next.

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
