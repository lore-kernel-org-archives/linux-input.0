From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: clarify gamepad API ABS values
Date: Thu, 14 Nov 2013 18:22:28 +0100
Message-ID: <CANq1E4Q-yPVh7ah-SMGb--VCJA97c2yCLSGQakFzGWWQydo7jw@mail.gmail.com>
References: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
	<20131114180720.fece45888942c29d5865073e@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49848 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab3KNRWa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Nov 2013 12:22:30 -0500
Received: by mail-lb0-f180.google.com with SMTP id u14so1836212lbd.11
        for <linux-input@vger.kernel.org>; Thu, 14 Nov 2013 09:22:28 -0800 (PST)
In-Reply-To: <20131114180720.fece45888942c29d5865073e@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

On Thu, Nov 14, 2013 at 6:07 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Thu,  3 Oct 2013 15:27:09 +0200
> David Herrmann <dh.herrmann@gmail.com> wrote:
>
>> It wasn't really clear from the gamepad-API description how ABS values are
>> mapped exactly. Clarify that negative is left/up and positive is
>> right/down.
>
> I was just going to ask that, thanks.
> Has this patch picked up?

Yepp, already applied by Dmitry to input-next.

>> ... Unfortunately, this means I screwed up the Wii U ProController
>> ABI. Anyhow, this just means we continue to have 0 compatible gamepad
>> drivers in the kernel. User-space needs to fix them up, anyway, as all
>> other gamepads are also incompatible.
>>
>
> I know it is not really relevant and you won't fix the kernel interface
> anyway, but I was just curios: is there any known userspace using the
> gamepad API?

The xwiimote userspace-drivers use it, other than that it is hard to
tell.. I looked at a lot of games and applications and they all just
contain a bunch of hacks and per-driver-mappings. I cannot really tell
whether anyone uses it, yet (there's isn't really a reason to use it
as only the wiimote kernel drivers comply to it).

However, I hope we can make all new drivers adhere these rules so
user-space no longer has to guess the mappings.

> Another question is below.
>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>  Documentation/input/gamepad.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
>> index 8002c89..31bb6a4 100644
>> --- a/Documentation/input/gamepad.txt
>> +++ b/Documentation/input/gamepad.txt
>> @@ -122,12 +122,14 @@ D-Pad:
>>        BTN_DPAD_*
>>      Analog buttons are reported as:
>>        ABS_HAT0X and ABS_HAT0Y
>> +      (for ABS values negative is left/up, positive is right/down)
>>
>
> Does that mean that analog D-Pad Left and D-Pad Right are supposed to be
> described as a single axis (ABS_HAT0X), even if in the input report
> they come as two different fields (non adjacent even)? And same for
> analog Up/Down?
>
> JFYI on the PS3 controller it is possible to have values from analog
> D-Pad Left and analog D-Pad Right at the same time, even if it is
> mechanically unlikely.

Yes, it's a single axis. It's called a D-Pad (Direction-Pad) so it is
supposed to give information about a direction. This somehow excludes
reporting information for left/right separately, right?

I didn't know there are actually devices reporting this separately, so
I never considered that during the development of the API.
Fortunately, the drivers which follow this spec all use digital DPADs,
so we can easily change it now.

What exactly does the PS3 controller return? Is it
pressure-information for the dpad? I'm open to change this to report 4
ABS values, but I'm not sure that we want that. From a user-space
perspective I want to get 2 values, not 4. I wouldn't even know what
to do with 4 dpad-values. So why not convert that in the kernel to:
  x = x1 - x0;
  y = y1 - y0;
This gives you proper x/y DPAD values from 4 pressure inputs.

But I'm open for suggestions..

>>  Analog-Sticks:
>>    The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
>>    reported as ABS_RX, ABS_RY. Zero, one or two sticks may be present.
>>    If analog-sticks provide digital buttons, they are mapped accordingly as
>>    BTN_THUMBL (first/left) and BTN_THUMBR (second/right).
>> +    (for ABS values negative is left/up, positive is right/down)
>>
>>  Triggers:
>>    Trigger buttons can be available as digital or analog buttons or both. User-
>> @@ -138,6 +140,7 @@ Triggers:
>>    ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
>>    If only one trigger-button combination is present (upper+lower), they are
>>    reported as "right" triggers (BTN_TR/ABS_HAT1X).
>> +    (ABS trigger values start at 0, pressure is reported as positive values)
>>
>
> What about analog Action-Pad buttons?
> Do you suggest any mapping for them?

Do we have devices which report analog action-pad values? If there
are, we can introduce new ABS_* bits for them (the current ones really
don't fit). This requires the ABS2 patches which are currently pending
on the list, though.

And again, what information do these action-pads provide? Pressure?

Thanks
David
