From: Jimmy Berry <jimmy@boombatower.com>
Subject: DESIGN: Logitech G710+ keyboard driver
Date: Mon, 23 Nov 2015 01:47:14 -0600
Message-ID: <CABTDdhXnKFBcekp_g1Ewm=4p-86xAP0pZaVnb5ZCuznXiEZ_pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38240 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbbKWHra (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 02:47:30 -0500
Received: by wmec201 with SMTP id c201so92958255wme.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2015 23:47:28 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

There are a variety of Logitech G-series out-of-tree keyboard drivers and a
number of discussions on the linux-input list regarding merging the drivers. The
end result appears to be stagnation. I notice the recent addition of a driver
for the Corsair Vengeance K90 Keyboard (hid-corsair.c) which seems to have a
similar feature set.

Some of the previous mailing list discussions mentioned splitting up the
Logitech drivers by feature instead of device.

> - base input driver handling the "dead" keys
> - adding LEDs
> - adding LCD fb/backlight
> - adding other goodies

Additionally, there was a driver for the G710+ keyboard developed separately
from the other G-series drivers that was submitted to the list, but it appears
no response was given.

I am looking to refactor and submit that G710+ driver and submit. Given the
common base of "extra" features provided by various niche keyboards it seems
reasonable to consider supporting them using a common set of code, but having
only looked at hid-corsair.c and the G710+ code in detail I cannot be certain of
the extent to which the "extra" features are implemented similarly.

With that in mind the corsair driver provides a good reference implementation
with a number of things that should be improved in the G710+ driver.

Looking at the existing Logitech hid code I see the following:

- hid-lg2ff
- hid-lg3ff
- hid-lg4ff
- hid-lgff
- hid-lg
- hid-logitech-dj
- hid-logitech-hidpp

Everything seems unrelated to keyboards except DINOVO* devices, but they appear
to be an unrelated class of keyboard. As such it seems likely a new file would
be the best route forward. The "logitech" spelled out seems to be the newer
choice so perhaps hid-logitech-keyboard or similar?

Would it be preferable to try and extract out the common features, if feasible,
from the existing corsair driver into a common file that can be shared by the
new G710+ and eventually other G-series keyboards, or just build the G710+
driver in a similar manor to corsair and submit? Perhaps refactoring if desired
at a later point.

The extra keys + modifiers/profiles can be implemented in a variety of ways, but
it is unclear which is best. I would appreciate some input.

Both keyboards provide extra keys (G1-N) and modifiers/profiles (M1-3). The M
keys act as modifiers to the G keys or profiles in that they can change the
behavior of the G keys. The corsair driver exposes each of the G and M keys and
keeps track of the active profile exposed through sysfs current_profile. While
this works the approach is dependent on user-space for mapping G keys + a
profile to a specific action. Existing key mapping applications do not have the
concept of a profile. What seems like a better implementation would be to think
of the M keys as modifiers and issue both events when a G key event is
triggered. This is how I modified the existing G710+ driver to operate.

The following is an example simulation:

M1 pressed
- emit M1 down
- emit M1 up
G1 pressed
- emit M1 down (could emit modifier like ctrl)
- emit G1 down
- emit G2 up
- emit M1 up   (could emit modifier like ctrl)

The driver keeps track of the active modifier/profile (which is still be exposed
va sysfs), but it also simulates the modifier keys being pressed with the G
keys. The concept is not too dissimilar from sticky keys except that the
modifier keys are not required to be pressed before each G key. Instead the M
keys may be pressed once and remain active until another M key is pressed.

With the following implementation I mapped the M keys to modifiers using xmodmap
which resulted in key mapping applications picking up the G keys with respect to
the active profile. Presumably the mapping could also be in the driver instead
of using xmodmap if desired (seems like a better solution).

Perhaps emitting proper modifier keys when G keys are pressed and unique codes
when M keys are pressed so user-space could still distinguish them.

Without the above technique nor a user-space application that understands
profiles the full functionality of the keyboards are not usable since there is
effectively only a one usable profile.

For reference:
- https://github.com/Wattos/logitech-g710-linux-driver (original author)
- https://github.com/boombatower/logitech-g710-linux-driver (my fork)

I have detailed notes on the differences in both features, implementation, and
the existing driver code, but that is probably more than is needed for this
initial mail.

I look forward to your feedback.

--
Jimmy
