From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: Questions about the documentation/specification of Linux
 ForceFeedback input.h
Date: Wed, 19 Feb 2014 19:54:30 +0100
Message-ID: <CADbOyBSYeCLLa=WE72dwNpsexq7gDsL4iJiOfrpKgLOp3+A7tA@mail.gmail.com>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
	<52FECB6E.4000004@iki.fi>
	<CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
	<52FF73D7.6030108@iki.fi>
	<CADbOyBROrPtqptnnh+Xtb9+X7EhGMudaHRai2wQLga5vca=rxg@mail.gmail.com>
	<52FFF276.1060704@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:54207 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbaBSSyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 13:54:31 -0500
Received: by mail-vc0-f175.google.com with SMTP id ij19so824821vcb.20
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 10:54:30 -0800 (PST)
In-Reply-To: <52FFF276.1060704@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Johann Deneux <johann.deneux@gmail.com>, linux-input@vger.kernel.org

On Sun, Feb 16, 2014 at 12:04 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
> 15.02.2014 22:32, Elias Vanderstuyft kirjoitti:
>> On Sat, Feb 15, 2014 at 3:04 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
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

Today, I noticed something strange: an explicit saturation of zero in
DInput (or at least using the most recent driver for my Logitech MOMO
wheel), appears to be transformed to max saturation! (This is why I
chose to quote your "sat_right = 0x0000" part, however that's not the
point I want to make in this mail)

E.g:
    pos_sat = 10000    ->    Max saturation send to device
    pos_sat =  5000    ->    Half saturation send to device
    ...
    pos_sat =     1    ->    Zero saturation send to device (because
it appears to be rounded to zero)
    pos_sat =     0    ->    Max saturation send to device (?!)

Also interesting is that the FEdit tool (from MS DirectX SDK) sets all
'saturation' values to zero by default. This is not the case for the
'coefficient' values: they are set to maximum. The resulting default
conditional force generates a maxed out conditional effect on my MOMO
wheel.
The weird thing is, that MSDN does not explicitly say anything about
this: http://msdn.microsoft.com/en-us/library/windows/desktop/microsoft.directx_sdk.reference.dicondition%28v=vs.85%29.aspx
"dwPositiveSaturation:
    Maximum force output on the positive side of the offset, in the
range from 0 through 10,000.
    If the device does not support force saturation, the value of this
member is ignored.
"

So, my question is:
    - Should Wine's translation layer convert a 0 dinput saturation to
max linux saturation?
    - or Should the Linux FF drivers send a max saturation command
when the linux saturation equals zero?
    - or Should we forget about this? (but that will result Wine's
behaviour to be different from Windows', at least for my MOMO wheel (I
don't have another capable (non-Logitech?) wheel to test it with))

Best regards,
Elias
