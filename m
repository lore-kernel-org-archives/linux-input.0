From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: Questions about the documentation/specification of Linux
 ForceFeedback input.h
Date: Sun, 16 Feb 2014 00:47:15 +0100
Message-ID: <CADbOyBS+5vCv06xxuz9p=O3i_Y10f-sYman8a7i4TSw8h4opZQ@mail.gmail.com>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
	<52FECB6E.4000004@iki.fi>
	<CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
	<52FF73D7.6030108@iki.fi>
	<CADbOyBROrPtqptnnh+Xtb9+X7EhGMudaHRai2wQLga5vca=rxg@mail.gmail.com>
	<52FFF276.1060704@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:53330 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaBOXrQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Feb 2014 18:47:16 -0500
Received: by mail-ve0-f170.google.com with SMTP id cz12so11156176veb.1
        for <linux-input@vger.kernel.org>; Sat, 15 Feb 2014 15:47:15 -0800 (PST)
In-Reply-To: <52FFF276.1060704@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Johann Deneux <johann.deneux@gmail.com>, linux-input@vger.kernel.org

On Sun, Feb 16, 2014 at 12:04 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
> 15.02.2014 22:32, Elias Vanderstuyft kirjoitti:
>> On Sat, Feb 15, 2014 at 3:04 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>> 15.02.2014 14:14, Elias Vanderstuyft kirjoitti:
>>>> On Sat, Feb 15, 2014 at 3:05 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>> 15.02.2014 01:28, Elias Vanderstuyft kirjoitti:
> [...]
>>>>>> 1)
>>>>>> The real meaning of 'directions', declared in
>>>>>> http://lxr.free-electrons.com/source/include/uapi/linux/input.h#L1113
>>>>>> :
>>>>>>     "Direction of the effect" is encoded as follows: ...
>>>>>> But it is not clear whether 'direction of the effect' means either:
>>>>>> - positive direction of the force the user should apply to counteract
>>>>>> the force that the joystick applies; or
>>>>>> - positive direction of the force applied by joystick
>>>>>> From my intuition, I think the latter is (silently?) meant by input.h
>>>>>> If you're interested why this is so important, I attached a document
>>>>>> "DInputVsLinuxDirections.txt" that tries to explain the dilemma if a
>>>>>> translation layer between DInput and Linux input is to be written.
>>>>>
>>>>> From input.h:
>>>>>  * Direction of the effect is encoded as follows:
>>>>>  *      0 deg -> 0x0000 (down)
>>>>>  *      90 deg -> 0x4000 (left)
>>>>>  *      180 deg -> 0x8000 (up)
>>>>>  *      270 deg -> 0xC000 (right)
>>>>>
>>>>> The directions in parantheses are the direction of applied force.
>>>>
>>>> Alright, thanks! That is invaluable information, maybe it should be
>>>> added to input.h .
>>>> It will avoid a lot of confusion for former DInput devs.
>>>>
>>>>>
>>>>> However, there is actually a 1:1 mapping between DInput polar
>>>>> coordinates and our direction parameter; DInput polar coordinates have 0
>>>>> deg = up, 90 deg = right, etc, so they are exactly flipped and therefore
>>>>> match our values due to the reverse definition.
>>>>>
>>>>> Looking at your DInputVsLinuxDirections.txt, you seem to have mixed
>>>>> different definitions of Carts: For DInput you use -1 = north, but for
>>>>> Linux +1 = up, while you use -1 = west/left for both.
>>>>
>>>> So I assume you agree that I got the DInput part right? ((0, -1) = north)
>>>
>>> I guess so.
>>>
>>>> Then my mistake lies in the assumption that (0, +1) = up, so I should
>>>> flip the y-axis to correct the Linux part.
>>>> I'll explain how I originally derived the Linux part:
>>>> Michal documented (in "ff-memless-next.txt") the Linux directions in
>>>> the following way:
>>>> "
>>>> Direction of the effect's force translates to Cartesian coordinates system
>>>> as follows:
>>>>   Direction = 0: Down
>>>>   Direction (0; 16384): 3rd quadrant
>>>>   Direction = 16384: Left
>>>>   Direction (16385; 32768): 2nd quadrant
>>>>   Direction = 32768: Up
>>>>   Direction (32769; 49152): 1st quadrant
>>>>   Direction = 49152: Right
>>>>   Direction (49153; 65535) :4th quadrant
>>>>   Direction = 65565: Down
>>>> "
>>>
>>> The above is correct.
>>>
>>>> For a Cartesian coordinates system:
>>>> - The (-1, 0)-axis (=-x) is the intersection of 3rd quadrant and 2nd
>>>> quadrant => Left
>>>> - The (0, +1)-axis (=+y) is the intersection of 2nd quadrant and 1st
>>>> quadrant => Up
>>>> - The (+1, 0)-axis (=+x) is the intersection of 1st quadrant and 4th
>>>> quadrant => Right
>>>> - The (0, -1)-axis (=-y) is the intersection of 4th quadrant and 3rd
>>>> quadrant => Down
>>>
>>> Not sure why you've arbitrarily chosen reverse definition of Y axis
>>> here,
>>
>> I really tried to derive the above in a non-arbitrary manner, here you
>> can verify why I 'chose' the +y axis as the intersection of 2nd
>> quadrant and 1st quadrant:
>>     http://en.wikipedia.org/wiki/File:Cartesian_coordinates_2D.svg
>> And because you said that the part about directions in
>> "ff-memless-next.txt" is correct, it follows that Up (which lies
>> between the 2nd quadrant and 1st quadrant) corresponds with +y
>> direction.
>> I hope this makes sense.
>>
>>> when all DInput and Linux joysticks, mouses, etc. have -y as "up".
>>
>> Alright, I did not know that, at least not for Linux. Where in the
>> Linux documentation can I find this?
>
> I don't think it is explicitely said either. I guess one could say it is
> "standard industry practice" (not limited to input, by the way, with
> e.g. in images the pixel row and column values are increasing right and
> down, not right and up).
>
> I don't oppose more explicit documentation, though.
>
>>>
>>>> Michal's approach seems logical to me, if he made a mistake, it's
>>>> caused by the lack of documentation of input.h : it should mention
>>>> what axes (-x, +x, -y or +y) the words (left, right, down and up)
>>>> correspond with.
>>>
>>> Well, the "left", "right", "down", "up" correspond to directions from
>>> the user perspective.
>>
>> That makes sense.
>>
>>> I don't think that is ambigiuous at all, as I
>>> don't see how you could consider "down" to be away from user?
>>
>> Yes, that's true. But it does not say to which axes (and polarity) they map.
>>
>>>
>>> I'm not against more documentation if it helps, though.
>>>
>>>> So, which interpretation is the right one?
>>>
>>> The one where the directions provided in input.h match physical
>>> direction of the force effect from user perspective on a 2-axis joystick
>>> device.
>>
>> That's a nice explanation! For the doc, also add to what axis each
>> direction corresponds to.
>>
>>>
>>>> (I did not find anything in the Linux documentation that states "there
>>>> is actually a 1:1 mapping between DInput polar coordinates and our
>>>> direction parameter")
>>>
>>> It is not stated explicitely, it just naturally follows.
>>>
>>> 1. Both use a clock-wise direction.
>>> 1. DInput direction definition is reversed, as they use the "counteract"
>>> direction. We can flip to correct.
>>> 2. DInput direction has 0 = up/north, we have 0 = down/south,
>>>    i.e. the exact opposite, so we must flip the direction.
>>>
>>> DInput direction = flipped(flipped(Linux direction))
>>>                  = Linux direction
>>
>> Alright, now I understand how it works.
>> But: the thing I wrote about the Cartesian coordinates system (the +y
>> axis lies between 2nd quadrant and 1st quadrant) is mathematically
>> correct (see referenced link to wiki), so, to fix the only
>> contradiction left, we will have to change the explanation about
>> directions in "ff-memless-next.txt" to the following text:
>> "
>> Direction of the effect's force translates to Cartesian coordinates system
>> as follows:
>>   Direction = 0: Down: +y
>>   Direction (0; 16384): 2nd quadrant
>>   Direction = 16384: Left: -x
>>   Direction (16385; 32768): 3th quadrant
>>   Direction = 32768: Up: -y
>>   Direction (32769; 49152): 4rd quadrant
>>   Direction = 49152: Right: +x
>>   Direction (49153; 65535) :1st quadrant
>>   Direction = 65565: Down: +y
>> "
>> As you can see, I only changed the quadrants (and added axes for
>> convenience), now they agree to
>> "http://en.wikipedia.org/wiki/File:Cartesian_coordinates_2D.svg", and
>> to input.h , so everyone should be happy :)
>> Can you confirm the modification is correct?
>
> I think so.
>
> However, assigning quadrants here is a bit confusing to me here with the
> non-mathematical-traditional reversed Y axis. I.e. my first instinct is
> that the upper-right quadrant is the first one, while it is not the case
> here...

I totally understand your confusion about the quadrants: Michal seems
so have meant the 'quadrants' that can be seen in the text about
directions in "input.h", which are different of the classical
mathematical Cartesian coordinate system. I probably should ask Michal
to clearify that in the doc of "ff-memless-next.txt".

>
> But if it helps...
>
>
>>>
>>>>> This causes the
>>>>> 1st and 3rd entries on both of the Mapping tables to be reversed. When
>>>>> that is fixed, the table #2 shows the correct result.
> [...]
>>>>>> 3)
>>>>>> Many Linux FF effect parameters don't have a clear explanation of the
>>>>>> allowed range, and their corresponding meaning at the extrema.
>>>>>> Here I list the ones that need more explanation, also take a look at
>>>>>> "interactive.fig" in the kernel documentation (but also included as
>>>>>> attachment):
>>>>>> - left_saturation and right_saturation; and
>>>>>
>>>>> left_saturation = maximum force on the negative ("left") side of the
>>>>> center point
>>>>> right_saturation = same for positive side
>>>>>
>>>>> 0x0 => no force,
>>>>> 0xFFFF => maximum force.
>>>>
>>>> OK, thanks for giving the definition. I think these things can be
>>>> understood from "interactive.fig", so there's no need to write
>>>> additional doc about this topic.
>>>>
>>>>>
>>>>>> - deadband
>>>>>
>>>>> The range from center point wherein the effect has no effect
>>>>
>>>> Notice this contradicts with "interactive.fig", this figure defines
>>>> 'deadband' as bound-to-bound, not as center-to-bound (as with DInput).
>>>
>>> There is no difference between those definitions that I can see:
>>>
>>>                        Axis range
>>> |------------------------------------------------------|
>>>
>>> Definition from interactive.fig, bound-to-bound:
>>> 0x0:
>>> |--------------------------X---------------------------|
>>> 0x8000 (covers half of the end-to-end area):
>>> |------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------|
>>> 0xFFFF:
>>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
>>
>> Alright, agreed with this part: deadband units or dimensions are the
>> same as the ones of the center offset parameter.
>>
>>>
>>> Center-to-bound definition:
>>> 0x0:
>>> |--------------------------X---------------------------|
>>> 0x8000 (covers half of the center-to-end area):
>>> |------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------|
>>> 0xFFFF:
>>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
>>
>> Ah, I see, this is where we disagree: now you're not working with the
>> same units or dimensions as the ones of the center offset parameter:
>> you have multiplied them by a factor 2 (that's where my "<< 1" came
>> from, for going from my definition to your definition).
>
> Yes, the center offset and deadband are in "relative" units, so due to
> the different value range the scales differ by a factor of 2.
>
> I agree it is a bit unfortunate the scales do not match, but IMHO not a
> totally hopeless situation.
>
>> This is my proposal of how it could be:
>>
>> Center-to-bound definition (same dimensions as center offset parameter):
>> 0x0:
>> |--------------------------X---------------------------|
>> 0x4000 (covers half of the center-to-end area):
>> |------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------|
>> 0x8000 (covers whole the center-to-end area):
>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
>> 0xC000:
>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| (clamped)
>> 0xFFFF:
>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| (clamped)
>
> Yes, this I understood.
>
>>>
>>>
>>>>> , with
>>>>> 0x0 => no dead band
>>>>> 0xFFFF => dead band encompassing the entire axis, effect not active
>>>>> anywhere.
>>>>>
>>>>> Assuming center offset of 0, though. Not sure how the currently
>>>>> supported devices interpret 0xFFFF with non-zero center offset, i.e. if
>>>>> the effect is then still active in the extreme opposite end of the axis.
>>>>> You wrote below that this is indeed the case with DInput, so it is
>>>>> highly likely this is how the devices handle it as well.
>>>>
>>>> Careful, here there's a catch:
>>>>     I did not write that in DInput "if deadband == maxValue(deadband)
>>>> with non-zero center offset, then the effect is still active in the
>>>> extreme opposite end of the axis.",
>>>>     I wrote that in DInput "if deadband == maxValue(deadband) with
>>>> maximum non-zero center offset, then the effect can only cover half of
>>>> the total region". For reference: maxValue(deadband)=10000
>>>
>>> I don't see the difference in those statements here.
>>
>> There is, when assuming same dimensions as center offset parameter.
>> Otherwise, you're right.
>
> Right.
>
>>> Note that deadband
>>> is the area where the effect is *not* active.
>>
>> I know, that's why it's called *dead*-band ;)
>>
>>>
>>>> Now I'm proposing to let DInput maxValue(deadband) correspond to linux
>>>> deadband 0x7FFF.
>>>> And still allowing linux deadband to be maximal 0xFFFF => two times
>>>> the maximum range of DInput
>>>>
>>>>>
>>>>>
>>>>>> They all have __u16 types, but "/include/uapi/linux/input.h" does not
>>>>>> say what the maximum values are.
>>>>>> I'm doing a proposal to define and document this (in the Linux kernel)
>>>>>> in the following way, also take a look at my attachment
>>>>>> "interactiveAlteredWithRanges.svg" for the modified version:
>>>>>>     Max Range of {right_saturation and left_saturation} = 0x7FFF
>>>>>>         Because the maximal value of the saturation bound can be only
>>>>>> half of the total range covered by the max negative to max positive
>>>>>> bounds.
>>>>>>         And also because they are related to some form of force, and
>>>>>> all other forms of force magnitude in Linux FF have a maximum value of
>>>>>> 0x7FFF
>>>>>
>>>>> I'm not really convinced that the different range from the other
>>>>> magnitude values is a reason enough to change the definition here.
>>>>
>>>> After reviewing this mail, I totally agree with you, sorry for that.
>>>>
>>>>>
>>>>>>     Max Range of {deadband} = 0xFFFF
>>>>>>         This is a bit harder to explain:
>>>>>>         - First, I would suggest to alter the deadband definition in
>>>>>> figure "interactive.fig":
>>>>>>             I would define deadband as going from a deadband-bound to
>>>>>> the center (BTW, This is how MSDN defines it: "In other words, the
>>>>>> condition is not active between lOffset minus lDeadBand and lOffset
>>>>>> plus lDeadBand."),
>>>>>>             instead of from a deadband-bound to the other deadband-bound.
>>>>>>                 => Same spec as in DInput.
>>>>>
>>>>> With 0xFFFF being the maximum deadband with center offset 0, it does not
>>>>> matter if deadband is defined as range from center or total width,
>>>>> maximum is 0xFFFF in both cases.
>>>>
>>>> Indeed, because (assume applying 0xFFFF linux deadband with center offset 0):
>>>> a) If DInput maxValue(deadband)=10000 (=half of the total region) maps
>>>> to 0x7FFF in the Linux case (=my proposal) if linux deadband is
>>>> defined as range from center:
>>>>     the driver will clamp {0 + 0xFFFF =approx 0 + 2 * 0x7FFF} to
>>>> 0x7FFF for both left as right side of center => Total region is
>>>> covered by the deadband.
>>>> b) If DInput maxValue(deadband)=10000 (=half of the total region) maps
>>>> to 0x7FFF in the Linux case (=my proposal) if linux deadband is
>>>> defined as total width:
>>>>     the driver will set {0 + 0xFFFF / 2 =approx 0 + 0x7FFF} for both
>>>> left as right side of center => Total region is covered by the
>>>> deadband.
>>>>
>>>> If we define linux deadband as range from center, like a), the Linux
>>>> FF API can represent more variations of conditional effects than
>>>> DInput can (and also with greater resolution), and thus becomes
>>>> superior in that aspect.
>>>
>>> Can you provide any example effect parameters on your proposed system
>>> that would not be possible on DInput?
>>
>> Sure:
>>
>> Center-to-bound definition (same dimensions as center offset parameter):
>> Assume center offset is set to the maximum non-zero value +32767
>> 0x0:
>> |-----------------------------------------------------X|
>> 0x4000 (covers a quarter of the end-to-end area):
>> |----------------------------------------XXXXXXXXXXXXXX|
>> 0x8000 (covers half of the end-to-end area):
>> |---------------------------XXXXXXXXXXXXXXXXXXXXXXXXXXX|
>> 0xC000 (covers three quarters of the end-to-end area):
>> |-------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
>> 0xFFFF (covers whole the end-to-end area):
>> |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|
>
> I meant a complete set of effect parameters that will cause an effect
> not possible with the DInput definitions, like I provided below. Your
> above example seems to be the same case I covered below in my example,
> in which case you can simply move the center point left a bit and use a
> zero right-side saturation value, without needing a large deadband value.

Indeed, it's always possible to find a set of parameters in DInput to
match the same result as with using any parameters with the deadband
of my proposal.

>
>>>
>>> If I understood correctly, what you are saying is an effect like this
>>> (percentages in parantheses are from left extreme of the axis to right
>>> extreme of the axis):
>>> sat_left = 0xFFFF
>>> sat_right = 0xFFFF
>>> coeff_left = 0x4000
>>> coeff_right = -0x4000
>>> center = 0x6000   (87.5% point)
>>> deadband (your definition) = 0xA000
>>>      (62.5% of full area from 87.5% point to either direction, i.e.
>>>       25%..150% => (clamping) 25%..100%)
>>>
>>> So that deadband can reach further left than it would be with DInput
>>> definition (which maxes at 0x7FFF of your definition, which would not
>>> reach the 25% mark at the left side).
>>
>> Exactly.
>>
>>>
>>> However, from what I can see, you can achieve the exact same effect with
>>> these parameters (DInput deadband definition):
>>> sat_left = 0xFFFF
>>> sat_right = 0x0000
>>> coeff_left = 0x4000
>>> coeff_right = 0x0000
>>> center = 0x0000 (50% point)
>>> deadband (DInput/ours) = 0x8000 (50% total area, or 50% of
>>> center-to-end, so it reaches 25%..75%)
>>>
>>> On the left side, the effect is exactly the same as before with same
>>> parameters (sat 0xffff, coeff 0x4000, starts at 25% point).
>>>
>>> On the right side the parameters differ, but the end-result is the same,
>>> there is no effect at all:
>>> - In the first example, the right side is fully in deadband area,
>>>   causing the effect to have zero effect.
>>> - In my variant with our definition, the right side has zero saturation,
>>>   causing the effect to have zero effect.
>>>
>>>
>>> So the present definitions (and DInput definitions) can achieve the same
>>> effects as your proposed definitions, unless I'm missing something,
>>> making the change unneeded.
>>
>> Agreed.
>>
>> But the benefit could be to make the user application less complex,
>> since otherwise, when a special case like the one you mentioned above
>> (with deadband larger than half of the total region), they would also
>> need to change the saturation values. This is not really a problem
>> when the conditional effect is a 'static' one (i.e. center and
>> deadband do not change over time), but it might come in handy for
>> 'dynamic' conditional effects.
>
> True. Though it will likely not outweigh the benefit of using the same
> definition as DInput.
>
>
>> Although honestly I think that situation is extremely rare, so I'm OK
>> with it if we leave the current definition as is.
>> And now I realize that for devices that require the deadband paramater
>> to be passed explicitly (and use the present definition) like SWFF2,
>> this either would not work, or would require additional (and maybe
>> complex) kernel driver code, which is not what we want.
>>
>> So, I agree to leave its definition unchanged, sorry for the discussion ;)
>> I just have to be sure about this to improve Wine's DInput translation layer.
>
> No problem with the discussion, better too much discussion than not
> enough :)
>
> As you've seen, the effect model should very closely match the DInput
> model (as that is what the devices tend to support), mostly just the
> units are different (our units use the 16-bit range as a whole, i.e.
> there are no out-of-range values).
>
> If you have any specific suggestions (patches preferred, otherwise this
> ends up further from the head of my TODO list :) ) to improve docs,
> those would be welcome.

Alright, when I find enough spare time, I will bundle all additional
documentation and propose it as a patch.

>
>
>>>> We will have to do the clamping anyway for devices that only accept
>>>> left and right deadband bounds, i.e. Logitech wheels.
>>>> For devices that only accept a single deadband value, like your SWFF2
>>>> as you mentioned below, the linux deadband would only need to be
>>>> shifted "<< 1" before being send to the device, if they accept u16 and
>>>> work exactly like DInput (range from center, and
>>>> maxValue(deadband)=half of total region).
>>>
>>> I'm not sure what you are trying to accomplish with "<< 1" here. If the
>>> device can't accept the deadband you want, left-shifting wouldn't fix that.
>>
>> See above about the factor 2.
>>
>>>
>>>>>
>>>>>>         - Now, knowing that ff_condition_effect->center is __s16:
>>>>>>             The worst case scenario is that "center = -32768" or
>>>>>> "center = +32767" while still wanting to cover the whole region (this
>>>>>> is actually not possible with DInput's specs: in that case, they can
>>>>>> only cover half of the total region):
>>>>>>             Then, to keep the scale of "center" and "deadband" the
>>>>>> same, "deadband = 65535" = +32767 - -32768 = 0xFFFF
>>>>>
>>>>> Interesting idea. However, if this is not possible in DInput, this means
>>>>> the devices will likely not support it either, since they are using the
>>>>> DInput effect model (as are we).
>>>>
>>>> This is no problem, use "<< 1" as mentioned above.
>>>>
>>>>>
>>>>>
>>>>> I tried to confirm this with my SWFF2 device, but either it has stopped
>>>>> working properly or, more likely, there is a regression in the kernel...
>>>>> no time to debug now, though, so added to my TODO (HID_REQ_GET_REPORT
>>>>> requests don't seem to go through properly).
>>>>>
>>>>>
>>>>>> I expect we will have to add/document the answers to my questions in
>>>>>> the appropriate file "/include/uapi/linux/input.h" or
>>>>>> "/Documentation/input/ff.txt", so that other userspace developers (and
>>>>>> maybe also kernel devs) don't face the same ambiguities.
>>>>>>
>>>>>>
>>>>>> Thank you very much for your time,
>>>>>
>>>>> Thanks for looking into this.
>>>>>
>>>>>> Elias
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Anssi Hannula
>>>>
>>>> Elias
>>>>
>>>
>>>
>>> --
>>> Anssi Hannula
>>
>> Elias
>>
>
>
> --
> Anssi Hannula

Elias
