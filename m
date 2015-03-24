From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Tue, 24 Mar 2015 17:01:34 +0900
Message-ID: <551119DE.2070402@samsung.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
 <20150307201340.GF5233@earth> <54FCEABE.9000007@samsung.com>
 <CAJKOXPcLoOp30j5ZwFv2_nT5B+nZOnV6utck5KDw3vt-tmWRew@mail.gmail.com>
 <54FD880E.30903@samsung.com> <1425903199.13415.9.camel@AMDC1943>
 <54FEF541.6000305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <54FEF541.6000305-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 03/10/2015 10:44 PM, Beomho Seo wrote:
> On 03/09/2015 09:13 PM, Krzysztof Kozlowski wrote:
>> On pon, 2015-03-09 at 20:46 +0900, Beomho Seo wrote:
>>> On 03/09/2015 08:02 PM, Krzysztof Kozlowski wrote:
>>>> 2015-03-09 1:35 GMT+01:00 Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>>>>> On 03/08/2015 05:13 AM, Sebastian Reichel wrote:
>>>>>> On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
>>>>>>> From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>>>
>>>>>>> This patch adds device driver of max77843 charger. This driver provide
>>>>>>> initialize each charging mode(e.g. fast charge, top-off mode and constant
>>>>>>> charging mode so on.). Additionally, control charging paramters to use
>>>>>>> i2c interface.
>>>>>>>
>>>>>>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>>>>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>>
>>>>>> Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>>>>
>>>>>> I can't take it as is, since it depends on the private header file
>>>>>> of PATCHv1.
>>>>>>
>>>>>> -- Sebastian
>>>>>>
>>>>>
>>>>> This patch reviewed by Sebastian.
>>>>> Could you Please merge that your git tree ?
>>>>
>>>> Hi,
>>>>
>>>> ... and again we are adding a new driver for very similar chipset to
>>>> already supported. I looked at spec and the charger's registers are
>>>> almost the same as for max77693. Their layout and addresses are the
>>>> same. I see some minor differences, probably the most important would
>>>> be different values current (fast-charge, top-off). But still 90% of
>>>> registers are the same... Do we really have to add new driver?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> Hi,
>>>
>>> Thank you for your comment. As you say, both chip set are similar.
>>> But new driver need for support max77843. It is support different below
>>> - Provide Battery presence information.
>>
>> Another set of power supply properties could be added for that chip.
>> This way the get_property() function would be the same but actually the
>> POWER_SUPPLY_PROP_PRESENT won't be called for max77693.
>>
>>> - Can OTG FET control.
>>
>> Where the OTG FET feature is it enabled in your driver? I couldn't find
>> it.
>>
> 
> Sorry. This driver don't control OTG FET feature.
> 
>>> - Bigger Fast charge current, Top Off current Threshold selection.
>>> - Various and bigger OTG current limitation.
>>> - Bigger primary charger termination voltage setting.
>>> - Different maximum input current limit selection(Different step).
>>
>> Yes, I mentioned some of these differences (the Fast/top-off
>> differences). These are differences in values so it does not require new
>> driver. There is need to develop new driver just to support different
>> current (3.0 A instead of 2.1 A) or voltage threshold.
>>
> 
> They are different charging current, OTG current limitation, top off current,
> charging limitation value. In case OTG current limitation different not
> limitation value but using register bit(max77843 use[7:6] max77693 use[7]
> bit only). Even if this driver not support all feature, some register
> different with max77693(support value, use register bit).
> 
> If this driver will combined with max77693 may even be beneficial for
> new Maxim driver. But the present, this driver is related with
> max77843 core driver and max77843-regulator. So I hope this driver
> merge first. And then will extend two driver(max77843 charger and max77693 charger).
> 
>> So the only new feature - battery presence - can be easily added to
>> existing driver. The driver can be extended for different
>> current/voltage values. Such extension may even be beneficial for new
>> Maxim MUIC/PMIC chipsets.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Best regards,
> Beomho Seo

Krzysztof, gentle ping?

Best regards,
Beomho Seo

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
