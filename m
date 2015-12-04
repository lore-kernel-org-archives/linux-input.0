From: Tolga Cakir <tolga@cevel.net>
Subject: Re: DESIGN: Logitech G710+ keyboard driver
Date: Fri, 4 Dec 2015 15:38:30 +0100
Message-ID: <5661A566.4000703@cevel.net>
References: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
 <56613561.1050100@cevel.net> <5661778E.9030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.udag.de ([62.146.106.18]:54232 "EHLO smtp02.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbbLDOif (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Dec 2015 09:38:35 -0500
In-Reply-To: <5661778E.9030100@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>, linux-input@vger.kernel.org
Cc: jimmy@boombatower.com

Am 04.12.2015 um 12:22 schrieb Cl=C3=A9ment Vuchener:
> On 12/04/2015 07:40 AM, Tolga Cakir wrote:
>> I think we need a decision about what needs to be done in kernel and=
 what is better handled in user-space. I've walked through the Corsair =
Vengeance K90 driver (hid-corsair.c) and I must say, I'm not really hap=
py about the desicions made in the design. In my opinion, we should onl=
y do essential stuff in kernel space and do the rest in user-space.
>>
>> To be more precise about hid-corsair.c (and possibly future gaming k=
eyboard implementations):
>>
>> 1. We should not handle profile switching and exposing a sysfs ABI f=
or profile-number in kernel-space. This has no advantage over keeping t=
rack of profiles in user-space. We need to use user-space programs anyw=
ay in order to handle macros and profile-sensitive key-handling. Using =
a keyboard specific ABI for parsing the profile just adds complexity to=
 kernel- and user-space.
>>
>> 2. We should not map false keycodes to keys. hid-corsair.c is using =
BTN_TRIGGER_HAPPY[N] - this is a huge design flaw in my opinion. Eventh=
ough this might get the job done, I'm questioning the design decision. =
=46irst of all, we're generally talking about KEYs on a keyboard, not B=
TNs. Second, they are not TRIGGERs. Third, they are not HAPPY. Also, BT=
N_TRIGGER_HAPPY[N] is only specified for up to 40 extra keys. What do w=
e do with gaming keyboards, which offer more? The Microsoft Sidewinder =
X6 has 33 non-standard extra keys for example (agreed, it's less than 4=
0, but still near the maximum). Do we really need to map random linux/i=
nput.h keycodes to non-standard keys?
> I choose the TRIGGER_HAPPY buttons because the only use I found for i=
t was extra buttons on some devices. It seems the most appropriate. It =
would be nice to have special key codes for this kind of keys, I asked =
about that with my original patch but I did not get any answer so the B=
TN_TRIGGER_HAPPY stayed there.
>
> They are keys the user may be interested in, I don't see why they sho=
uld not have key events.

Hi Clement,

I agree, but instead of using key events designed for joysticks and=20
gamepads, we should define and use keycodes for our specific use-case.

How come 40 individual keycodes have been added for a single joystick=20
(Saitek X52 Pro Flight System), whereas macro keys and profile switchin=
g=20
keys can be found on hundreds of different gaming keyboards and we have=
=20
no fitting keycode for that?

I'm quoting linux/input.h:
 > We avoid low common keys in module aliases so they don't get huge.

Luckily, macro keys and profile switch keys are very common these days=20
on gaming keyboards. So that shouldn't be a problem.

I think it's time to define KEY_G1 - KEY_G30 and KEY_M1 - KEY_M5, so we=
=20
can finally have appropiate keycodes for these kind of things. They can=
=20
be found on nearly every gaming keyboard, so that should be enough to=20
justify them. There is still enough room for additional keycodes. What=20
are you thinking about this?

>> I think mapping linux/input.h keycodes to non-standard keys has only=
 one reason: to keep things simple with X11. As Clement mentioned, keyc=
odes above 256 don't work with X11. However, this should not be a reaso=
n to hack workarounds into kernel. We can use hidraw / hiddev in user-s=
pace instead to catch those events and map them accordingly to our need=
s (they are designed to be fully programmable keys after all). This add=
s complexity in user-space, but also adds flexibility and we don't need=
 to break / workaround any HID stuff.
> It does not work with X11 but it works with existing remapping softwa=
re based on evdev. I don't understand what you mean with "break / worka=
round", I am remapping *invalid* HID usage code from the keyboard. If I=
 don't do that pressing those keys triggers unwanted key events.

By "break / workaround" I mean mapping keycodes, which have not been=20
designed for this use-case. BTN suggests, that they are not designed fo=
r=20
keyboards in the first place.

>> 3. We should either have common ABI for gaming keyboards or we shoul=
dn't have them at all (or just in very special cases). This just adds c=
omplexity in kernel- and user-space, as lots of keyboards need to be ha=
ndled their own way. Gaming keyboards have things in common, like LEDs.=
 Creating an ABI for setting extra LEDs is totally legit, but we should=
 define standards, so user-space applications can rely on something. Mo=
st keyboards have multiple profile LEDs, 1 recording LED, sometimes 1 g=
aming mode LED (disabling Windows key) and sometimes keyboard backlight=
 is also adjustable.
>>
>> We could define a common ABI for them:
>> - read-only profile_led_count (or profile_led_max): parse number of =
profile_leds
>> - rw profile_led_[N]: setting and parsing profile_led_[N] status, 0 =
and 1
> Isn't this the same as the current_profile attribute you were arguing=
 against?

Nope. Exposing an interface to interact with the profile LEDs isn't the=
=20
same as creating an ABI for the active profile. Turning on profile_led_=
1=20
for example does not has to mean, that profile 1 must be active. It jus=
t=20
means, that the LED for profile 1 is turned on.

We should not tie profile to profile_led in kernel space and give=20
user-space applications all flexibility, how to use these LEDs and=20
keeping track of profiles (really, instead of polling / parsing=20
active_profile ABIs, they can easily keep track of them on their own an=
d=20
set LEDs accordingly).

>> - rw recording_led: setting and parsing recording_led status, 0 and =
1
>> - rw gaming_led: setting and parsing gaming_led status, 0 and 1
>> - read-only backlight_max: parse maximum brightness
>> - rw backlight: setting and parsing backlight intensity, 0 - backlig=
ht_max
> LED class devices already do that.

Perfect!

Cheers,
Tolga
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
