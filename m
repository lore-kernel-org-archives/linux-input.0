From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Tue, 22 Jun 2010 15:15:44 +0800
Message-ID: <AANLkTil-yVO2cDKLccpWVsJFVn3rpaPF7LJOUo5TlAr3@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<20100621091952.GB7702@n2100.arm.linux.org.uk> <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
	<20100621111612.GJ7702@n2100.arm.linux.org.uk> <4C200847.9010200@samsung.com>
	<AANLkTikbBkDOVF6ti_bTultATuW1KhciAmKc1Geg1OSH@mail.gmail.com>
	<4C202D8F.7030005@samsung.com> <AANLkTik5ScLMuo5OTSFl_k7qfrBR8xAicVrt98CXqqBa@mail.gmail.com>
	<4C20356A.1050309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57312 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab0FVHQI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 03:16:08 -0400
In-Reply-To: <4C20356A.1050309@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 22, 2010 at 12:00 PM, Joonyoung Shim
<jy0922.shim@samsung.com> wrote:
> On 6/22/2010 12:38 PM, Eric Miao wrote:
>> On Tue, Jun 22, 2010 at 11:27 AM, Joonyoung Shim
>> <jy0922.shim@samsung.com> wrote:
>>> On 6/22/2010 12:02 PM, Eric Miao wrote:
>>>> On Tue, Jun 22, 2010 at 8:48 AM, Joonyoung Shim <jy0922.shim@samsu=
ng.com> wrote:
>>>>> On 6/21/2010 8:16 PM, Russell King - ARM Linux wrote:
>>>>>> On Mon, Jun 21, 2010 at 06:39:10PM +0800, Eric Miao wrote:
>>>>>>> On Mon, Jun 21, 2010 at 5:19 PM, Russell King - ARM Linux
>>>>>>> <linux@arm.linux.org.uk> wrote:
>>>>>>>> On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
>>>>>>>>> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@=
samsung.com> wrote:
>>>>>>>>>> +void __init samsung_keypad_set_platdata(struct samsung_keyp=
ad_platdata *pd)
>>>>>>>>>> +{
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD struct samsung_keypad_platda=
ta *npd;
>>>>>>>>>> +
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD if (!pd) {
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD printk(KERN_ERR "%s: no platform data\n", __func__);
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD return;
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>>>>>>>>>> +
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD npd =3D kmemdup(pd, sizeof(s=
truct samsung_keypad_platdata), GFP_KERNEL);
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD if (!npd)
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD printk(KERN_ERR "%s: no memory for platform data\n", __func_=
_);
>>>>>>>>> This part of the code is actually duplicated again and again =
and again
>>>>>>>>> for each device, PXA and other legacy platforms are bad refer=
ences for
>>>>>>>>> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there=
 are three
>>>>>>>>> major points:
>>>>>>>>>
>>>>>>>>> =EF=BF=BD1. A minimum 'struct pxa_device_desc' for a simple d=
escription of a
>>>>>>>>> =EF=BF=BD =EF=BF=BD device (more than 90% of the devices can =
be described that way),
>>>>>>>>> =EF=BF=BD =EF=BF=BD and avoid using a comparatively heavier w=
eight platform_device,
>>>>>>>>> =EF=BF=BD =EF=BF=BD which can be generated at run-time
>>>>>>>>>
>>>>>>>>> =EF=BF=BD2. pxa_register_device() to allocate and register th=
e platform_device
>>>>>>>>> =EF=BF=BD =EF=BF=BD at run-time, along with the platform data
>>>>>>>> It's a bad idea to make platform data be run-time discardable =
like this:
>>>>>>>>
>>>>>>>>>> +struct samsung_keypad_platdata {
>>>>>>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD const struct matrix_keymap_d=
ata *keymap_data;
>>>>>>>> What you end up with is some platform data structures which mu=
st be kept
>>>>>>>> (those which have pointers to them from the platform data), an=
d others
>>>>>>>> (the platform data itself) which can be discarded at runtime.
>>>>>>>>
>>>>>>>> We know that the __initdata attributations cause lots of probl=
ems -
>>>>>>>> they're frequently wrong. =EF=BF=BDJust see the constant hastl=
e with __devinit
>>>>>>>> et.al. =EF=BF=BDThe same issue happens with __initdata as well=
=2E
>>>>>>>>
>>>>>>>> So why make things more complicated by allowing some platform =
data
>>>>>>>> structures to be discardable and others not to be? =EF=BF=BDIs=
 their small
>>>>>>>> size (maybe 6 words for this one) really worth the hastle of g=
etting
>>>>>>>> __initdata attributations wrong (eg, on the keymap data?)
>>>>>>>>
>>>>>>> Russell,
>>>>>>>
>>>>>>> The benefit I see is when multiple boards are compiled in, thos=
e
>>>>>>> data not used can be automatically discarded.
>>>>>> Yes, but only some of the data can be discarded. =C2=A0Continuin=
g with the
>>>>>> example in hand, while you can discard the six words which repre=
sent
>>>>>> samsung_keypad_platdata, but the keymap_data can't be because th=
at won't
>>>>>> be re-allocated, which is probably a much larger data structure.
>>>>>>
>>>>> No. the keymap_data is possible too. The keypad driver allocates =
other
>>>>> keymap area of input device and it is assigned from datas based o=
n this
>>>>> keymap_data.
>>>>>
>>>> This is a generic issue. Even if in your example, you can avoid th=
is by
>>>> re-allocation and re-assignment (ignore the performance issue for =
such
>>>> behavior), the real question is the difficult to track all these d=
own. Since
>>> Right, it can occur difficulty of maintain. I wanted just to inform=
 the
>>> current fact.
>>>
>>>> matrix_keypad_data is something out of your control (it was actual=
ly
>>>> drafted by me and Dmitry if you are interested), and think about o=
ne day
>>>> I changed it's definition, now you have to sync your driver and co=
de every
>>>> time to make sure the discarded data is not referenced.
>>>>
>>> if matrix_keypad_data is changed, i think the patchset should inclu=
ded
>>> change of related other parts using it.
>>>
>>
>> That's reasonable but difficult in practice, every keypad driver usi=
ng
>> matrix_keypad_data could be doing things differently. That's what I'=
m
>
> Just FYI, correct name is matrix_keymap_data and current all keypad
> drivers using matrix_keymap_data use it to same way.
>

Note I was just thinking there is a potential issue as been pointed out=
 that
we can improve. And I'm not NACKing your perfect patch. Sorry if I made
you think so.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
