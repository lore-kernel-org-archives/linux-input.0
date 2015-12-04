From: Tolga Cakir <tolga@cevel.net>
Subject: Re: DESIGN: Logitech G710+ keyboard driver
Date: Fri, 4 Dec 2015 20:06:48 +0100
Message-ID: <5661E448.3070500@cevel.net>
References: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
 <56613561.1050100@cevel.net> <5661778E.9030100@gmail.com>
 <5661A566.4000703@cevel.net> <5661C4F5.9090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.udag.de ([62.146.106.17]:55123 "EHLO smtp01.udag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbbLDTGx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Dec 2015 14:06:53 -0500
In-Reply-To: <5661C4F5.9090404@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>, linux-input@vger.kernel.org
Cc: jimmy@boombatower.com

>> Hi Clement,
>>
>> I agree, but instead of using key events designed for joysticks and gamepads, we should define and use keycodes for our specific use-case.
>>
>> How come 40 individual keycodes have been added for a single joystick (Saitek X52 Pro Flight System), whereas macro keys and profile switching keys can be found on hundreds of different gaming keyboards and we have no fitting keycode for that?
>>
>> I'm quoting linux/input.h:
>>> We avoid low common keys in module aliases so they don't get huge.
>> Luckily, macro keys and profile switch keys are very common these days on gaming keyboards. So that shouldn't be a problem.
>>
>> I think it's time to define KEY_G1 - KEY_G30 and KEY_M1 - KEY_M5, so we can finally have appropiate keycodes for these kind of things. They can be found on nearly every gaming keyboard, so that should be enough to justify them. There is still enough room for additional keycodes. What are you thinking about this?
> I don't know what would be the correct number of key codes.
> For Corsair keyboards I know, there is either 18 or 6 G-keys and 3 profile keys (M-keys). So that would be enough for me.
> My current driver also exposes the MR (macro/mem record) key. But with two different key codes for start and stop. I am not sure it is really useful, I may just remove it when I update the key codes.
>
> You should make this proposition to a maintainer. I will update the corsair driver when it is accepted.

The Sidewinder X6 has 30 individual macro keys; that's the highest 
amount of G-Keys I've come across, so that could be a starting point. 
There are gaming peripherals with up to 22 individual macro keys 
(Logitech G13), which could also benefit from such keycodes. So, I think 
KEY_G1 - KEY_G30 would be enough for most devices. Most keyboards either 
have 3 or 5 profile keys (KEY_M1 - KEY_M5). To keep things simple, you 
could map both keycodes of MR-key to KEY_M4 / KEY_M5 (or KEY_RECORD / 
KEY_MACRO).

I will prepare a patch and talk with Dmitry Torokhov and Jiri Kosina 
about it.

>>>> 3. We should either have common ABI for gaming keyboards or we shouldn't have them at all (or just in very special cases). This just adds complexity in kernel- and user-space, as lots of keyboards need to be handled their own way. Gaming keyboards have things in common, like LEDs. Creating an ABI for setting extra LEDs is totally legit, but we should define standards, so user-space applications can rely on something. Most keyboards have multiple profile LEDs, 1 recording LED, sometimes 1 gaming mode LED (disabling Windows key) and sometimes keyboard backlight is also adjustable.
>>>>
>>>> We could define a common ABI for them:
>>>> - read-only profile_led_count (or profile_led_max): parse number of profile_leds
>>>> - rw profile_led_[N]: setting and parsing profile_led_[N] status, 0 and 1
>>> Isn't this the same as the current_profile attribute you were arguing against?
>> Nope. Exposing an interface to interact with the profile LEDs isn't the same as creating an ABI for the active profile. Turning on profile_led_1 for example does not has to mean, that profile 1 must be active. It just means, that the LED for profile 1 is turned on.
>>
>> We should not tie profile to profile_led in kernel space and give user-space applications all flexibility, how to use these LEDs and keeping track of profiles (really, instead of polling / parsing active_profile ABIs, they can easily keep track of them on their own and set LEDs accordingly).
> I won't be able to do that for the corsair driver, current profile and profile LEDs are tied in the hardware.

Interesting. The Logitech G710+ doesn't have any onboard memory, so it 
relies on software for managing everything. We're free to control LEDs 
via specific packets.

>>>> - rw recording_led: setting and parsing recording_led status, 0 and 1
>>>> - rw gaming_led: setting and parsing gaming_led status, 0 and 1
>>>> - read-only backlight_max: parse maximum brightness
>>>> - rw backlight: setting and parsing backlight intensity, 0 - backlight_max
>>> LED class devices already do that.
>> Perfect!
> The LED class documentation, defines that LED names should be "devicename:colour:function". I think we should use common function names.
>
> For the K90 (and similar keyboards, I expect K40 and K95), I cannot add the profile LEDs as explained above and the "gaming" LED exists but cannot be controlled or read (it is completely managed on the hardware).

The gaming LED exists on the G710+ aswell, but is also managed 
internally on hardware.

Well, it looks like eventhough the Corsair K90 and Logitech G710+ have 
many things in common, they have their own ways of handling things.

To summarize things so far:

- I think most gaming keyboards would benefit from having KEY_G1 - 
KEY_G30 and KEY_M1 - KEY_M5 defined.

- we need to send the magic packet to G710+ in kernel-space, so we can 
enable this keyboard's extra functionalities.

- I think it's a good idea to expose the LEDs and backlight via an ABI, 
but we should keep it identical to other implementations so far (and if 
needed, just omit flexibility in terms of consistency).

- I agree on Jimmy's point of having a new file, something like 
hid-logitech-kbd.

- exposing profile-count via ABI and polling / parsing it in user-space 
has no real advantage over handling it directly in user-space. However, 
since the Corsair K90 is not able to seperate profile-counting from 
LEDs, we might think about keeping things consistent across 
implementations and simply do this in kernel-space instead. I think this 
point needs further discussion.

- it should completely be up to the user-space, what to do, if e.g. 
profile 2 is active and G1 has been pressed. This has nothing to do in 
kernel-space (and hid-corsair.c doesn't have anything like that, 
either). Therefore, I think we can omit the idea of having M1 - M3 keys 
as modifiers.

- we need user-space programs for full functionality either way. 
Therefore, we should design the kernel-space module with that in mind, 
so we can write efficient and maintainable code in both, user- and 
kernel-space. My idea behind this discussion was to have kernel-space 
just for the most essential stuff (like fixing bugs, sending magic 
packets, sending keycodes) and do everything in user-space, that can be 
done in user-space.

Cheers,
Tolga
