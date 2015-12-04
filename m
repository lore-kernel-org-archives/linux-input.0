From: Tolga Cakir <tolga@cevel.net>
Subject: Re: DESIGN: Logitech G710+ keyboard driver
Date: Fri, 4 Dec 2015 07:40:33 +0100
Message-ID: <56613561.1050100@cevel.net>
References: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.udag.de ([62.146.106.18]:59244 "EHLO smtp02.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbbLDGsM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Dec 2015 01:48:12 -0500
In-Reply-To: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jimmy@boombatower.com, clement.vuchener@gmail.com

I think we need a decision about what needs to be done in kernel and 
what is better handled in user-space. I've walked through the Corsair 
Vengeance K90 driver (hid-corsair.c) and I must say, I'm not really 
happy about the desicions made in the design. In my opinion, we should 
only do essential stuff in kernel space and do the rest in user-space.

To be more precise about hid-corsair.c (and possibly future gaming 
keyboard implementations):

1. We should not handle profile switching and exposing a sysfs ABI for 
profile-number in kernel-space. This has no advantage over keeping track 
of profiles in user-space. We need to use user-space programs anyway in 
order to handle macros and profile-sensitive key-handling. Using a 
keyboard specific ABI for parsing the profile just adds complexity to 
kernel- and user-space.

2. We should not map false keycodes to keys. hid-corsair.c is using 
BTN_TRIGGER_HAPPY[N] - this is a huge design flaw in my opinion. 
Eventhough this might get the job done, I'm questioning the design 
decision. First of all, we're generally talking about KEYs on a 
keyboard, not BTNs. Second, they are not TRIGGERs. Third, they are not 
HAPPY. Also, BTN_TRIGGER_HAPPY[N] is only specified for up to 40 extra 
keys. What do we do with gaming keyboards, which offer more? The 
Microsoft Sidewinder X6 has 33 non-standard extra keys for example 
(agreed, it's less than 40, but still near the maximum). Do we really 
need to map random linux/input.h keycodes to non-standard keys?

I think mapping linux/input.h keycodes to non-standard keys has only one 
reason: to keep things simple with X11. As Clement mentioned, keycodes 
above 256 don't work with X11. However, this should not be a reason to 
hack workarounds into kernel. We can use hidraw / hiddev in user-space 
instead to catch those events and map them accordingly to our needs 
(they are designed to be fully programmable keys after all). This adds 
complexity in user-space, but also adds flexibility and we don't need to 
break / workaround any HID stuff.

3. We should either have common ABI for gaming keyboards or we shouldn't 
have them at all (or just in very special cases). This just adds 
complexity in kernel- and user-space, as lots of keyboards need to be 
handled their own way. Gaming keyboards have things in common, like 
LEDs. Creating an ABI for setting extra LEDs is totally legit, but we 
should define standards, so user-space applications can rely on 
something. Most keyboards have multiple profile LEDs, 1 recording LED, 
sometimes 1 gaming mode LED (disabling Windows key) and sometimes 
keyboard backlight is also adjustable.

We could define a common ABI for them:
- read-only profile_led_count (or profile_led_max): parse number of 
profile_leds
- rw profile_led_[N]: setting and parsing profile_led_[N] status, 0 and 1
- rw recording_led: setting and parsing recording_led status, 0 and 1
- rw gaming_led: setting and parsing gaming_led status, 0 and 1
- read-only backlight_max: parse maximum brightness
- rw backlight: setting and parsing backlight intensity, 0 - backlight_max

Exposing a read-write interface for switching HW / SW mode is also a 
legit use-case for ABI.

A major drawback of ABI (and user-space programs depending on it): we 
cannot respond fast enough to new devices, as people need to wait 
several months / years for the updated kernel versions or run a patched 
kernel (including all the drawbacks associated with using a custom 
kernel for the average user).

The kernel's role would be creating an interface to interact with the 
keyboard's extras and it's up to the user-space, how to make use of them 
(e.g. profile-switching macro tool using LEDs for active profile number, 
or custom script using them in a blinking pattern for incoming E-Mails).

Now about the Logitech G710+. Things, that need and should be handled in 
kernel space (in my opinion):

1. Bugs. Thanks to Jimmy Berry, there is already a G710+ bugfix applied 
to 4.4 (http://www.spinics.net/lists/linux-input/msg42186.html). There 
are no other bugs for the G710+ I'm aware of.

2. The Logitech G710+ is a composite device: interface #1 is used for G1 
- G6 keys + usual standard keyboard. Please note, that the G1 - G6 keys 
are outputting KEY_1 - KEY_6. Interface #2 is used for M1 - M3, MR key 
(macro recording and profile switching / LEDs) and also the G1 - G6 keys 
(outputting non-standard HID events!). As you can see, G1 - G6 keys are 
double mapped for 2 devices. In case, an operating system doesn't 
recognize G1 - G6 keys on interface #2, we're simply getting KEY_1 - 
KEY6 from interface #1. The Windows Logitech driver is sending out a 
specific packet, so the G1 - G6 keys on interface #1 get completely 
disabled (maybe other changes aswell, I don't know). This is a perfect 
use case for kernel-space.

Sorry for the wall of text.

Cheers,
Tolga
