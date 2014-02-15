From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Questions about the documentation/specification of Linux ForceFeedback
 input.h
Date: Sat, 15 Feb 2014 16:04:07 +0200
Message-ID: <52FF73D7.6030108@iki.fi>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>	<52FECB6E.4000004@iki.fi> <CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:32997 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753046AbaBOOER (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Feb 2014 09:04:17 -0500
In-Reply-To: <CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Johann Deneux <johann.deneux@gmail.com>, linux-input@vger.kernel.org

15.02.2014 14:14, Elias Vanderstuyft kirjoitti:
> On Sat, Feb 15, 2014 at 3:05 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>> 15.02.2014 01:28, Elias Vanderstuyft kirjoitti:
>>> Hi everyone,
>>
>> Hi!
>>
>>>
>>> If you receive my mail, it is either because you:
>>> - are listed under the MAINTAINERS for "/include/uapi/linux/input.h":
>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n4410
>>> - are listed as an author of "/Documentation/input/ff.txt" or of
>>> "/Documentation/input/interactive.fig"
>>>
>>> In the process of testing the new driver (ff-memless-next) Michal
>>> (CC-ed) is working on, this allowed me to gain more insight in the
>>> internal workings of Linux FF. That's why I decided to review the
>>> userspace code that currently uses most of Linux FF functionality:
>>> Wine's DInput translation layer (and eventually SDL2.)
>>> Trying to get everything correct, I noticed both
>>> "/include/uapi/linux/input.h" and "/Documentation/input/ff.txt"
>>> provide not enough information for the following things:
>>>
>>> 1)
>>> The real meaning of 'directions', declared in
>>> http://lxr.free-electrons.com/source/include/uapi/linux/input.h#L1113
>>> :
>>>     "Direction of the effect" is encoded as follows: ...
>>> But it is not clear whether 'direction of the effect' means either:
>>> - positive direction of the force the user should apply to counteract
>>> the force that the joystick applies; or
>>> - positive direction of the force applied by joystick
>>> From my intuition, I think the latter is (silently?) meant by input.h
>>> If you're interested why this is so important, I attached a document
>>> "DInputVsLinuxDirections.txt" that tries to explain the dilemma if a
>>> translation layer between DInput and Linux input is to be written.
>>
>> From input.h:
>>  * Direction of the effect is encoded as follows:
>>  *      0 deg -> 0x0000 (down)
>>  *      90 deg -> 0x4000 (left)
>>  *      180 deg -> 0x8000 (up)
>>  *      270 deg -> 0xC000 (right)
>>
>> The directions in parantheses are the direction of applied force.
> 
> Alright, thanks! That is invaluable information, maybe it should be
> added to input.h .
> It will avoid a lot of confusion for former DInput devs.
> 
>>
>> However, there is actually a 1:1 mapping between DInput polar
>> coordinates and our direction parameter; DInput polar coordinates have 0
>> deg = up, 90 deg = right, etc, so they are exactly flipped and therefore
>> match our values due to the reverse definition.
>>
>> Looking at your DInputVsLinuxDirections.txt, you seem to have mixed
>> different definitions of Carts: For DInput you use -1 = north, but for
>> Linux +1 = up, while you use -1 = west/left for both.
> 
> So I assume you agree that I got the DInput part right? ((0, -1) = north)

I guess so.

> Then my mistake lies in the assumption that (0, +1) = up, so I should
> flip the y-axis to correct the Linux part.
> I'll explain how I originally derived the Linux part:
> Michal documented (in "ff-memless-next.txt") the Linux directions in
> the following way:
> "
> Direction of the effect's force translates to Cartesian coordinates system
> as follows:
>   Direction = 0: Down
>   Direction (0; 16384): 3rd quadrant
>   Direction = 16384: Left
>   Direction (16385; 32768): 2nd quadrant
>   Direction = 32768: Up
>   Direction (32769; 49152): 1st quadrant
>   Direction = 49152: Right
>   Direction (49153; 65535) :4th quadrant
>   Direction = 65565: Down
> "

The above is correct.

> For a Cartesian coordinates system:
> - The (-1, 0)-axis (=-x) is the intersection of 3rd quadrant and 2nd
> quadrant => Left
> - The (0, +1)-axis (=+y) is the intersection of 2nd quadrant and 1st
> quadrant => Up
> - The (+1, 0)-axis (=+x) is the intersection of 1st quadrant and 4th
> quadrant => Right
> - The (0, -1)-axis (=-y) is the intersection of 4th quadrant and 3rd
> quadrant => Down

Not sure why you've arbitrarily chosen reverse definition of Y axis
here, when all DInput and Linux joysticks, mouses, etc. have -y as "up".

> Michal's approach seems logical to me, if he made a mistake, it's
> caused by the lack of documentation of input.h : it should mention
> what axes (-x, +x, -y or +y) the words (left, right, down and up)
> correspond with.

Well, the "left", "right", "down", "up" correspond to directions from
the user perspective. I don't think that is ambigiuous at all, as I
don't see how you could consider "down" to be away from user?

I'm not against more documentation if it helps, though.

> So, which interpretation is the right one?

The one where the directions provided in input.h match physical
direction of the force effect from user perspective on a 2-axis joystick
device.

> (I did not find anything in the Linux documentation that states "there
> is actually a 1:1 mapping between DInput polar coordinates and our
> direction parameter")

It is not stated explicitely, it just naturally follows.

1. Both use a clock-wise direction.
1. DInput direction definition is reversed, as they use the "counteract"
direction. We can flip to correct.
2. DInput direction has 0 = up/north, we have 0 = down/south,
   i.e. the exact opposite, so we must flip the direction.

DInput direction = flipped(flipped(Linux direction))
                 = Linux direction

>> This causes the
>> 1st and 3rd entries on both of the Mapping tables to be reversed. When
>> that is fixed, the table #2 shows the correct result.
>>
>>> 2)
>>> It is not clear how to create a FF effect with infinite duration
>>> (replay.length):
>>> http://lxr.free-electrons.com/source/include/uapi/linux/input.h#L966
>>> Only the following is written about duration values in general:
>>> "All duration values are expressed in ms. Values above 32767 ms
>>> (0x7fff) should not be used and have unspecified results."
>>> Michal solved this by associating replay.length==0 for infinite, which
>>> makes sense since otherwise the effect would not have been started
>>> anyway.
>>
>> Infinite duration can be achieved with length = 0.
> 
> Thanks! This has to be documented.
> 
>>
>>> 3)
>>> Many Linux FF effect parameters don't have a clear explanation of the
>>> allowed range, and their corresponding meaning at the extrema.
>>> Here I list the ones that need more explanation, also take a look at
>>> "interactive.fig" in the kernel documentation (but also included as
>>> attachment):
>>> - left_saturation and right_saturation; and
>>
>> left_saturation = maximum force on the negative ("left") side of the
>> center point
>> right_saturation = same for positive side
>>
>> 0x0 => no force,
>> 0xFFFF => maximum force.
> 
> OK, thanks for giving the definition. I think these things can be
> understood from "interactive.fig", so there's no need to write
> additional doc about this topic.
> 
>>
>>> - deadband
>>
>> The range from center point wherein the effect has no effect
> 
> Notice this contradicts with "interactive.fig", this figure defines
> 'deadband' as bound-to-bound, not as center-to-bound (as with DInput).

There is no difference between those definitions that I can see:

                       Axis range
|------------------------------------------------------|

Definition from interactive.fig, bound-to-bound:
0x0:
|--------------------------X---------------------------|
0x8000 (covers half of the end-to-end area):
|------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------|
0xFFFF:
|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|

Center-to-bound definition:
0x0:
|--------------------------X---------------------------|
0x8000 (covers half of the center-to-end area):
|------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX------------|
0xFFFF:
|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|


>> , with
>> 0x0 => no dead band
>> 0xFFFF => dead band encompassing the entire axis, effect not active
>> anywhere.
>>
>> Assuming center offset of 0, though. Not sure how the currently
>> supported devices interpret 0xFFFF with non-zero center offset, i.e. if
>> the effect is then still active in the extreme opposite end of the axis.
>> You wrote below that this is indeed the case with DInput, so it is
>> highly likely this is how the devices handle it as well.
> 
> Careful, here there's a catch:
>     I did not write that in DInput "if deadband == maxValue(deadband)
> with non-zero center offset, then the effect is still active in the
> extreme opposite end of the axis.",
>     I wrote that in DInput "if deadband == maxValue(deadband) with
> maximum non-zero center offset, then the effect can only cover half of
> the total region". For reference: maxValue(deadband)=10000

I don't see the difference in those statements here. Note that deadband
is the area where the effect is *not* active.

> Now I'm proposing to let DInput maxValue(deadband) correspond to linux
> deadband 0x7FFF.
> And still allowing linux deadband to be maximal 0xFFFF => two times
> the maximum range of DInput
> 
>>
>>
>>> They all have __u16 types, but "/include/uapi/linux/input.h" does not
>>> say what the maximum values are.
>>> I'm doing a proposal to define and document this (in the Linux kernel)
>>> in the following way, also take a look at my attachment
>>> "interactiveAlteredWithRanges.svg" for the modified version:
>>>     Max Range of {right_saturation and left_saturation} = 0x7FFF
>>>         Because the maximal value of the saturation bound can be only
>>> half of the total range covered by the max negative to max positive
>>> bounds.
>>>         And also because they are related to some form of force, and
>>> all other forms of force magnitude in Linux FF have a maximum value of
>>> 0x7FFF
>>
>> I'm not really convinced that the different range from the other
>> magnitude values is a reason enough to change the definition here.
> 
> After reviewing this mail, I totally agree with you, sorry for that.
> 
>>
>>>     Max Range of {deadband} = 0xFFFF
>>>         This is a bit harder to explain:
>>>         - First, I would suggest to alter the deadband definition in
>>> figure "interactive.fig":
>>>             I would define deadband as going from a deadband-bound to
>>> the center (BTW, This is how MSDN defines it: "In other words, the
>>> condition is not active between lOffset minus lDeadBand and lOffset
>>> plus lDeadBand."),
>>>             instead of from a deadband-bound to the other deadband-bound.
>>>                 => Same spec as in DInput.
>>
>> With 0xFFFF being the maximum deadband with center offset 0, it does not
>> matter if deadband is defined as range from center or total width,
>> maximum is 0xFFFF in both cases.
> 
> Indeed, because (assume applying 0xFFFF linux deadband with center offset 0):
> a) If DInput maxValue(deadband)=10000 (=half of the total region) maps
> to 0x7FFF in the Linux case (=my proposal) if linux deadband is
> defined as range from center:
>     the driver will clamp {0 + 0xFFFF =approx 0 + 2 * 0x7FFF} to
> 0x7FFF for both left as right side of center => Total region is
> covered by the deadband.
> b) If DInput maxValue(deadband)=10000 (=half of the total region) maps
> to 0x7FFF in the Linux case (=my proposal) if linux deadband is
> defined as total width:
>     the driver will set {0 + 0xFFFF / 2 =approx 0 + 0x7FFF} for both
> left as right side of center => Total region is covered by the
> deadband.
> 
> If we define linux deadband as range from center, like a), the Linux
> FF API can represent more variations of conditional effects than
> DInput can (and also with greater resolution), and thus becomes
> superior in that aspect.

Can you provide any example effect parameters on your proposed system
that would not be possible on DInput?

If I understood correctly, what you are saying is an effect like this
(percentages in parantheses are from left extreme of the axis to right
extreme of the axis):
sat_left = 0xFFFF
sat_right = 0xFFFF
coeff_left = 0x4000
coeff_right = -0x4000
center = 0x6000   (87.5% point)
deadband (your definition) = 0xA000
     (62.5% of full area from 87.5% point to either direction, i.e.
      25%..150% => (clamping) 25%..100%)

So that deadband can reach further left than it would be with DInput
definition (which maxes at 0x7FFF of your definition, which would not
reach the 25% mark at the left side).

However, from what I can see, you can achieve the exact same effect with
these parameters (DInput deadband definition):
sat_left = 0xFFFF
sat_right = 0x0000
coeff_left = 0x4000
coeff_right = 0x0000
center = 0x0000 (50% point)
deadband (DInput/ours) = 0x8000 (50% total area, or 50% of
center-to-end, so it reaches 25%..75%)

On the left side, the effect is exactly the same as before with same
parameters (sat 0xffff, coeff 0x4000, starts at 25% point).

On the right side the parameters differ, but the end-result is the same,
there is no effect at all:
- In the first example, the right side is fully in deadband area,
  causing the effect to have zero effect.
- In my variant with our definition, the right side has zero saturation,
  causing the effect to have zero effect.


So the present definitions (and DInput definitions) can achieve the same
effects as your proposed definitions, unless I'm missing something,
making the change unneeded.

> We will have to do the clamping anyway for devices that only accept
> left and right deadband bounds, i.e. Logitech wheels.
> For devices that only accept a single deadband value, like your SWFF2
> as you mentioned below, the linux deadband would only need to be
> shifted "<< 1" before being send to the device, if they accept u16 and
> work exactly like DInput (range from center, and
> maxValue(deadband)=half of total region).

I'm not sure what you are trying to accomplish with "<< 1" here. If the
device can't accept the deadband you want, left-shifting wouldn't fix that.

>>
>>>         - Now, knowing that ff_condition_effect->center is __s16:
>>>             The worst case scenario is that "center = -32768" or
>>> "center = +32767" while still wanting to cover the whole region (this
>>> is actually not possible with DInput's specs: in that case, they can
>>> only cover half of the total region):
>>>             Then, to keep the scale of "center" and "deadband" the
>>> same, "deadband = 65535" = +32767 - -32768 = 0xFFFF
>>
>> Interesting idea. However, if this is not possible in DInput, this means
>> the devices will likely not support it either, since they are using the
>> DInput effect model (as are we).
> 
> This is no problem, use "<< 1" as mentioned above.
> 
>>
>>
>> I tried to confirm this with my SWFF2 device, but either it has stopped
>> working properly or, more likely, there is a regression in the kernel...
>> no time to debug now, though, so added to my TODO (HID_REQ_GET_REPORT
>> requests don't seem to go through properly).
>>
>>
>>> I expect we will have to add/document the answers to my questions in
>>> the appropriate file "/include/uapi/linux/input.h" or
>>> "/Documentation/input/ff.txt", so that other userspace developers (and
>>> maybe also kernel devs) don't face the same ambiguities.
>>>
>>>
>>> Thank you very much for your time,
>>
>> Thanks for looking into this.
>>
>>> Elias
>>>
>>
>>
>> --
>> Anssi Hannula
> 
> Elias
> 


-- 
Anssi Hannula
