From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Questions about the documentation/specification of Linux ForceFeedback
 input.h
Date: Sat, 15 Feb 2014 04:05:34 +0200
Message-ID: <52FECB6E.4000004@iki.fi>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:40228 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbaBOCL3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 21:11:29 -0500
In-Reply-To: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, johann.deneux@gmail.com, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>

15.02.2014 01:28, Elias Vanderstuyft kirjoitti:
> Hi everyone,

Hi!

> 
> If you receive my mail, it is either because you:
> - are listed under the MAINTAINERS for "/include/uapi/linux/input.h":
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n4410
> - are listed as an author of "/Documentation/input/ff.txt" or of
> "/Documentation/input/interactive.fig"
> 
> In the process of testing the new driver (ff-memless-next) Michal
> (CC-ed) is working on, this allowed me to gain more insight in the
> internal workings of Linux FF. That's why I decided to review the
> userspace code that currently uses most of Linux FF functionality:
> Wine's DInput translation layer (and eventually SDL2.)
> Trying to get everything correct, I noticed both
> "/include/uapi/linux/input.h" and "/Documentation/input/ff.txt"
> provide not enough information for the following things:
> 
> 1)
> The real meaning of 'directions', declared in
> http://lxr.free-electrons.com/source/include/uapi/linux/input.h#L1113
> :
>     "Direction of the effect" is encoded as follows: ...
> But it is not clear whether 'direction of the effect' means either:
> - positive direction of the force the user should apply to counteract
> the force that the joystick applies; or
> - positive direction of the force applied by joystick
> From my intuition, I think the latter is (silently?) meant by input.h
> If you're interested why this is so important, I attached a document
> "DInputVsLinuxDirections.txt" that tries to explain the dilemma if a
> translation layer between DInput and Linux input is to be written.

>From input.h:
 * Direction of the effect is encoded as follows:
 *      0 deg -> 0x0000 (down)
 *      90 deg -> 0x4000 (left)
 *      180 deg -> 0x8000 (up)
 *      270 deg -> 0xC000 (right)

The directions in parantheses are the direction of applied force.

However, there is actually a 1:1 mapping between DInput polar
coordinates and our direction parameter; DInput polar coordinates have 0
deg = up, 90 deg = right, etc, so they are exactly flipped and therefore
match our values due to the reverse definition.

Looking at your DInputVsLinuxDirections.txt, you seem to have mixed
different definitions of Carts: For DInput you use -1 = north, but for
Linux +1 = up, while you use -1 = west/left for both. This causes the
1st and 3rd entries on both of the Mapping tables to be reversed. When
that is fixed, the table #2 shows the correct result.

> 2)
> It is not clear how to create a FF effect with infinite duration
> (replay.length):
> http://lxr.free-electrons.com/source/include/uapi/linux/input.h#L966
> Only the following is written about duration values in general:
> "All duration values are expressed in ms. Values above 32767 ms
> (0x7fff) should not be used and have unspecified results."
> Michal solved this by associating replay.length==0 for infinite, which
> makes sense since otherwise the effect would not have been started
> anyway.

Infinite duration can be achieved with length = 0.

> 3)
> Many Linux FF effect parameters don't have a clear explanation of the
> allowed range, and their corresponding meaning at the extrema.
> Here I list the ones that need more explanation, also take a look at
> "interactive.fig" in the kernel documentation (but also included as
> attachment):
> - left_saturation and right_saturation; and

left_saturation = maximum force on the negative ("left") side of the
center point
right_saturation = same for positive side

0x0 => no force,
0xFFFF => maximum force.

> - deadband

The range from center point wherein the effect has no effect, with
0x0 => no dead band
0xFFFF => dead band encompassing the entire axis, effect not active
anywhere.

Assuming center offset of 0, though. Not sure how the currently
supported devices interpret 0xFFFF with non-zero center offset, i.e. if
the effect is then still active in the extreme opposite end of the axis.
You wrote below that this is indeed the case with DInput, so it is
highly likely this is how the devices handle it as well.


> They all have __u16 types, but "/include/uapi/linux/input.h" does not
> say what the maximum values are.
> I'm doing a proposal to define and document this (in the Linux kernel)
> in the following way, also take a look at my attachment
> "interactiveAlteredWithRanges.svg" for the modified version:
>     Max Range of {right_saturation and left_saturation} = 0x7FFF
>         Because the maximal value of the saturation bound can be only
> half of the total range covered by the max negative to max positive
> bounds.
>         And also because they are related to some form of force, and
> all other forms of force magnitude in Linux FF have a maximum value of
> 0x7FFF

I'm not really convinced that the different range from the other
magnitude values is a reason enough to change the definition here.

>     Max Range of {deadband} = 0xFFFF
>         This is a bit harder to explain:
>         - First, I would suggest to alter the deadband definition in
> figure "interactive.fig":
>             I would define deadband as going from a deadband-bound to
> the center (BTW, This is how MSDN defines it: "In other words, the
> condition is not active between lOffset minus lDeadBand and lOffset
> plus lDeadBand."),
>             instead of from a deadband-bound to the other deadband-bound.
>                 => Same spec as in DInput.

With 0xFFFF being the maximum deadband with center offset 0, it does not
matter if deadband is defined as range from center or total width,
maximum is 0xFFFF in both cases.

>         - Now, knowing that ff_condition_effect->center is __s16:
>             The worst case scenario is that "center = -32768" or
> "center = +32767" while still wanting to cover the whole region (this
> is actually not possible with DInput's specs: in that case, they can
> only cover half of the total region):
>             Then, to keep the scale of "center" and "deadband" the
> same, "deadband = 65535" = +32767 - -32768 = 0xFFFF

Interesting idea. However, if this is not possible in DInput, this means
the devices will likely not support it either, since they are using the
DInput effect model (as are we).


I tried to confirm this with my SWFF2 device, but either it has stopped
working properly or, more likely, there is a regression in the kernel...
no time to debug now, though, so added to my TODO (HID_REQ_GET_REPORT
requests don't seem to go through properly).


> I expect we will have to add/document the answers to my questions in
> the appropriate file "/include/uapi/linux/input.h" or
> "/Documentation/input/ff.txt", so that other userspace developers (and
> maybe also kernel devs) don't face the same ambiguities.
> 
> 
> Thank you very much for your time,

Thanks for looking into this.

> Elias
> 


-- 
Anssi Hannula
