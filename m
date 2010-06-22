From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Tue, 22 Jun 2010 09:48:07 +0900
Message-ID: <4C200847.9010200@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
 <20100621091952.GB7702@n2100.arm.linux.org.uk>
 <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
 <20100621111612.GJ7702@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100621111612.GJ7702@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 6/21/2010 8:16 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 21, 2010 at 06:39:10PM +0800, Eric Miao wrote:
>> On Mon, Jun 21, 2010 at 5:19 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
>>>> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsu=
ng.com> wrote:
>>>>> +void __init samsung_keypad_set_platdata(struct samsung_keypad_pl=
atdata *pd)
>>>>> +{
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD struct samsung_keypad_platdata *n=
pd;
>>>>> +
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD if (!pd) {
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD printk(KERN_ERR "%s: no platform data\n", __func__);
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD return;
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD }
>>>>> +
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD npd =3D kmemdup(pd, sizeof(struct=
 samsung_keypad_platdata), GFP_KERNEL);
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD if (!npd)
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD printk(KERN_ERR "%s: no memory for platform data\n", __func__);
>>>> This part of the code is actually duplicated again and again and a=
gain
>>>> for each device, PXA and other legacy platforms are bad references=
 for
>>>> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are =
three
>>>> major points:
>>>>
>>>> =EF=BF=BD1. A minimum 'struct pxa_device_desc' for a simple descri=
ption of a
>>>> =EF=BF=BD =EF=BF=BD device (more than 90% of the devices can be de=
scribed that way),
>>>> =EF=BF=BD =EF=BF=BD and avoid using a comparatively heavier weight=
 platform_device,
>>>> =EF=BF=BD =EF=BF=BD which can be generated at run-time
>>>>
>>>> =EF=BF=BD2. pxa_register_device() to allocate and register the pla=
tform_device
>>>> =EF=BF=BD =EF=BF=BD at run-time, along with the platform data
>>> It's a bad idea to make platform data be run-time discardable like =
this:
>>>
>>>>> +struct samsung_keypad_platdata {
>>>>> + =EF=BF=BD =EF=BF=BD =EF=BF=BD const struct matrix_keymap_data *=
keymap_data;
>>> What you end up with is some platform data structures which must be=
 kept
>>> (those which have pointers to them from the platform data), and oth=
ers
>>> (the platform data itself) which can be discarded at runtime.
>>>
>>> We know that the __initdata attributations cause lots of problems -
>>> they're frequently wrong. =EF=BF=BDJust see the constant hastle wit=
h __devinit
>>> et.al. =EF=BF=BDThe same issue happens with __initdata as well.
>>>
>>> So why make things more complicated by allowing some platform data
>>> structures to be discardable and others not to be? =EF=BF=BDIs thei=
r small
>>> size (maybe 6 words for this one) really worth the hastle of gettin=
g
>>> __initdata attributations wrong (eg, on the keymap data?)
>>>
>> Russell,
>>
>> The benefit I see is when multiple boards are compiled in, those
>> data not used can be automatically discarded.
>=20
> Yes, but only some of the data can be discarded.  Continuing with the
> example in hand, while you can discard the six words which represent
> samsung_keypad_platdata, but the keymap_data can't be because that wo=
n't
> be re-allocated, which is probably a much larger data structure.
>=20

No. the keymap_data is possible too. The keypad driver allocates other
keymap area of input device and it is assigned from datas based on this
keymap_data.
