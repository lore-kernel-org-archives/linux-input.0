From: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>
Subject: Re: DESIGN: Logitech G710+ keyboard driver
Date: Fri, 4 Dec 2015 17:53:09 +0100
Message-ID: <5661C4F5.9090404@gmail.com>
References: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
 <56613561.1050100@cevel.net> <5661778E.9030100@gmail.com>
 <5661A566.4000703@cevel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37339 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbbLDQxN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2015 11:53:13 -0500
Received: by wmww144 with SMTP id w144so72589369wmw.0
        for <linux-input@vger.kernel.org>; Fri, 04 Dec 2015 08:53:11 -0800 (PST)
In-Reply-To: <5661A566.4000703@cevel.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tolga Cakir <tolga@cevel.net>, linux-input@vger.kernel.org
Cc: jimmy@boombatower.com

On 12/04/2015 03:38 PM, Tolga Cakir wrote:
> Am 04.12.2015 um 12:22 schrieb Cl=C3=A9ment Vuchener:
>> On 12/04/2015 07:40 AM, Tolga Cakir wrote:
>>> I think we need a decision about what needs to be done in kernel an=
d what is better handled in user-space. I've walked through the Corsair=
 Vengeance K90 driver (hid-corsair.c) and I must say, I'm not really ha=
ppy about the desicions made in the design. In my opinion, we should on=
ly do essential stuff in kernel space and do the rest in user-space.
>>>
>>> To be more precise about hid-corsair.c (and possibly future gaming =
keyboard implementations):
>>>
>>> 1. We should not handle profile switching and exposing a sysfs ABI =
for profile-number in kernel-space. This has no advantage over keeping =
track of profiles in user-space. We need to use user-space programs any=
way in order to handle macros and profile-sensitive key-handling. Using=
 a keyboard specific ABI for parsing the profile just adds complexity t=
o kernel- and user-space.
>>>
>>> 2. We should not map false keycodes to keys. hid-corsair.c is using=
 BTN_TRIGGER_HAPPY[N] - this is a huge design flaw in my opinion. Event=
hough this might get the job done, I'm questioning the design decision.=
 First of all, we're generally talking about KEYs on a keyboard, not BT=
Ns. Second, they are not TRIGGERs. Third, they are not HAPPY. Also, BTN=
_TRIGGER_HAPPY[N] is only specified for up to 40 extra keys. What do we=
 do with gaming keyboards, which offer more? The Microsoft Sidewinder X=
6 has 33 non-standard extra keys for example (agreed, it's less than 40=
, but still near the maximum). Do we really need to map random linux/in=
put.h keycodes to non-standard keys?
>> I choose the TRIGGER_HAPPY buttons because the only use I found for =
it was extra buttons on some devices. It seems the most appropriate. It=
 would be nice to have special key codes for this kind of keys, I asked=
 about that with my original patch but I did not get any answer so the =
BTN_TRIGGER_HAPPY stayed there.
>>
>> They are keys the user may be interested in, I don't see why they sh=
ould not have key events.
>
> Hi Clement,
>
> I agree, but instead of using key events designed for joysticks and g=
amepads, we should define and use keycodes for our specific use-case.
>
> How come 40 individual keycodes have been added for a single joystick=
 (Saitek X52 Pro Flight System), whereas macro keys and profile switchi=
ng keys can be found on hundreds of different gaming keyboards and we h=
ave no fitting keycode for that?
>
> I'm quoting linux/input.h:
> > We avoid low common keys in module aliases so they don't get huge.
>
> Luckily, macro keys and profile switch keys are very common these day=
s on gaming keyboards. So that shouldn't be a problem.
>
> I think it's time to define KEY_G1 - KEY_G30 and KEY_M1 - KEY_M5, so =
we can finally have appropiate keycodes for these kind of things. They =
can be found on nearly every gaming keyboard, so that should be enough =
to justify them. There is still enough room for additional keycodes. Wh=
at are you thinking about this?
I don't know what would be the correct number of key codes.
=46or Corsair keyboards I know, there is either 18 or 6 G-keys and 3 pr=
ofile keys (M-keys). So that would be enough for me.
My current driver also exposes the MR (macro/mem record) key. But with =
two different key codes for start and stop. I am not sure it is really =
useful, I may just remove it when I update the key codes.

You should make this proposition to a maintainer. I will update the cor=
sair driver when it is accepted.
>
>>> I think mapping linux/input.h keycodes to non-standard keys has onl=
y one reason: to keep things simple with X11. As Clement mentioned, key=
codes above 256 don't work with X11. However, this should not be a reas=
on to hack workarounds into kernel. We can use hidraw / hiddev in user-=
space instead to catch those events and map them accordingly to our nee=
ds (they are designed to be fully programmable keys after all). This ad=
ds complexity in user-space, but also adds flexibility and we don't nee=
d to break / workaround any HID stuff.
>> It does not work with X11 but it works with existing remapping softw=
are based on evdev. I don't understand what you mean with "break / work=
around", I am remapping *invalid* HID usage code from the keyboard. If =
I don't do that pressing those keys triggers unwanted key events.
>
> By "break / workaround" I mean mapping keycodes, which have not been =
designed for this use-case. BTN suggests, that they are not designed fo=
r keyboards in the first place.
>
>>> 3. We should either have common ABI for gaming keyboards or we shou=
ldn't have them at all (or just in very special cases). This just adds =
complexity in kernel- and user-space, as lots of keyboards need to be h=
andled their own way. Gaming keyboards have things in common, like LEDs=
=2E Creating an ABI for setting extra LEDs is totally legit, but we sho=
uld define standards, so user-space applications can rely on something.=
 Most keyboards have multiple profile LEDs, 1 recording LED, sometimes =
1 gaming mode LED (disabling Windows key) and sometimes keyboard backli=
ght is also adjustable.
>>>
>>> We could define a common ABI for them:
>>> - read-only profile_led_count (or profile_led_max): parse number of=
 profile_leds
>>> - rw profile_led_[N]: setting and parsing profile_led_[N] status, 0=
 and 1
>> Isn't this the same as the current_profile attribute you were arguin=
g against?
>
> Nope. Exposing an interface to interact with the profile LEDs isn't t=
he same as creating an ABI for the active profile. Turning on profile_l=
ed_1 for example does not has to mean, that profile 1 must be active. I=
t just means, that the LED for profile 1 is turned on.
>
> We should not tie profile to profile_led in kernel space and give use=
r-space applications all flexibility, how to use these LEDs and keeping=
 track of profiles (really, instead of polling / parsing active_profile=
 ABIs, they can easily keep track of them on their own and set LEDs acc=
ordingly).
I won't be able to do that for the corsair driver, current profile and =
profile LEDs are tied in the hardware.
>
>>> - rw recording_led: setting and parsing recording_led status, 0 and=
 1
>>> - rw gaming_led: setting and parsing gaming_led status, 0 and 1
>>> - read-only backlight_max: parse maximum brightness
>>> - rw backlight: setting and parsing backlight intensity, 0 - backli=
ght_max
>> LED class devices already do that.
>
> Perfect!
The LED class documentation, defines that LED names should be "devicena=
me:colour:function". I think we should use common function names.

=46or the K90 (and similar keyboards, I expect K40 and K95), I cannot a=
dd the profile LEDs as explained above and the "gaming" LED exists but =
cannot be controlled or read (it is completely managed on the hardware)=
=2E

>
> Cheers,
> Tolga

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
