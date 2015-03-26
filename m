From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Thu, 26 Mar 2015 22:25:52 +0900
Message-ID: <551408E0.3060901@samsung.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
 <20150307201340.GF5233@earth> <54FCEABE.9000007@samsung.com>
 <CAJKOXPcLoOp30j5ZwFv2_nT5B+nZOnV6utck5KDw3vt-tmWRew@mail.gmail.com>
 <54FD880E.30903@samsung.com> <1425903199.13415.9.camel@AMDC1943>
 <54FEF541.6000305@samsung.com> <551119DE.2070402@samsung.com>
 <CAJKOXPdd5dDgH91NeytobJWg71pYOw5XnhB9N1=m2Mjmxxjv-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12042 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbCZNZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 09:25:55 -0400
In-reply-to: <CAJKOXPdd5dDgH91NeytobJWg71pYOw5XnhB9N1=m2Mjmxxjv-A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 03/24/2015 05:38 PM, Krzysztof Kozlowski wrote:
> 2015-03-24 9:01 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
>> On 03/10/2015 10:44 PM, Beomho Seo wrote:
>>> On 03/09/2015 09:13 PM, Krzysztof Kozlowski wrote:
>>>> On pon, 2015-03-09 at 20:46 +0900, Beomho Seo wrote:
>>>>> On 03/09/2015 08:02 PM, Krzysztof Kozlowski wrote:
>>>>>> 2015-03-09 1:35 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
>>>>>>> On 03/08/2015 05:13 AM, Sebastian Reichel wrote:
>>>>>>>> On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
>>>>>>>>> From: Beomho Seo <beomho.seo@samsung.com>
>>>>>>>>>
>>>>>>>>> This patch adds device driver of max77843 charger. This driver provide
>>>>>>>>> initialize each charging mode(e.g. fast charge, top-off mode and constant
>>>>>>>>> charging mode so on.). Additionally, control charging paramters to use
>>>>>>>>> i2c interface.
>>>>>>>>>
>>>>>>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>>>>>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>>>>>>>
>>>>>>>> Reviewed-By: Sebastian Reichel <sre@kernel.org>
>>>>>>>>
>>>>>>>> I can't take it as is, since it depends on the private header file
>>>>>>>> of PATCHv1.
>>>>>>>>
>>>>>>>> -- Sebastian
>>>>>>>>
>>>>>>>
>>>>>>> This patch reviewed by Sebastian.
>>>>>>> Could you Please merge that your git tree ?
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> ... and again we are adding a new driver for very similar chipset to
>>>>>> already supported. I looked at spec and the charger's registers are
>>>>>> almost the same as for max77693. Their layout and addresses are the
>>>>>> same. I see some minor differences, probably the most important would
>>>>>> be different values current (fast-charge, top-off). But still 90% of
>>>>>> registers are the same... Do we really have to add new driver?
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Thank you for your comment. As you say, both chip set are similar.
>>>>> But new driver need for support max77843. It is support different below
>>>>> - Provide Battery presence information.
>>>>
>>>> Another set of power supply properties could be added for that chip.
>>>> This way the get_property() function would be the same but actually the
>>>> POWER_SUPPLY_PROP_PRESENT won't be called for max77693.
>>>>
>>>>> - Can OTG FET control.
>>>>
>>>> Where the OTG FET feature is it enabled in your driver? I couldn't find
>>>> it.
>>>>
>>>
>>> Sorry. This driver don't control OTG FET feature.
>>>
>>>>> - Bigger Fast charge current, Top Off current Threshold selection.
>>>>> - Various and bigger OTG current limitation.
>>>>> - Bigger primary charger termination voltage setting.
>>>>> - Different maximum input current limit selection(Different step).
>>>>
>>>> Yes, I mentioned some of these differences (the Fast/top-off
>>>> differences). These are differences in values so it does not require new
>>>> driver. There is need to develop new driver just to support different
>>>> current (3.0 A instead of 2.1 A) or voltage threshold.
>>>>
>>>
>>> They are different charging current, OTG current limitation, top off current,
>>> charging limitation value. In case OTG current limitation different not
>>> limitation value but using register bit(max77843 use[7:6] max77693 use[7]
>>> bit only). Even if this driver not support all feature, some register
>>> different with max77693(support value, use register bit).
>>>
>>> If this driver will combined with max77693 may even be beneficial for
>>> new Maxim driver. But the present, this driver is related with
>>> max77843 core driver and max77843-regulator. So I hope this driver
>>> merge first. And then will extend two driver(max77843 charger and max77693 charger).
> 
> I still prefer merging common drivers into one instead of creating
> some more of them.
> However I understand your point and I am not entirely opposed against.
> Especially that you invested quite a bit of time for developing this
> and my feedback was quite late. To summarize I am fine with your
> approach.
> 
> Best regards,
> Krzysztof
>

Dear Lee Jones,

Could you please merge that your git tree ?

Best regards,
Beomho Seo
