From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Best practices to improve a laptop
	driver	using ACPI (hotkeys, rfkill, kill switch...)
Date: Sat, 15 Mar 2008 02:59:06 -0300
Message-ID: <20080315055906.GD4922@khazad-dum.debian.net>
References: <47DB0D15.4040505@crespel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47DB0D15.4040505-czgx1wgAc3rR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>
Cc: Corentin CHARY <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 15 Mar 2008, Fabien Crespel wrote:
> Currently, hotkeys generate ACPI events (with acpi_bus_generate_proc_event) with
> the notification code, which are handled directly by acpid scripts or userspace
> programs like Lapsus. On some distros (like openSUSE 10.3 and probably Ubuntu),
> the acpi-keys daemon (from the hotkey-setup package) converts some of these
> events to keycodes.

My experience here is that you will get flak from the crowd when you finally
have to get rid of proc events, so introduce the input devices *early* and
make sure to make a fuss about the other ways being deprecated and not
guaranteed to still exist in an year.

For thinkpad-acpi, I tied the deprecation to one year or /proc/acpi/event
going away, whichever happens first.  I can always delay the removal when
the time comes to get rid of that code, if there is a compelling reason to.

But you do need to give people an input device first, and it will have to
stay around for some time before it is used (X.org's evdev driver being
busted beyond belief on some of the most interesting EV_KEY events doesn't
help any, here).

> - thinkpad_acpi's with the keymap of known key scancodes defined in the driver,
> and only allowing to remap unknown keys.
> - sony-laptop's with a predefined keymap too, but only allowing the known keys to
> be remapped.

Thinkpads have a very long lived firmware APIs.  Lenovo is respecting that
for the most part, I can trust they won't do any stupid stunts.

Leaving these keys as KEY_UNKNOWN makes it easy for userspace to remap them
if there is any reason.  I use KEY_RESERVED for stuff that *is* known, but
for which key events should not be generated.

And I got burned for letting stuff that should ALMOST NEVER be mapped to a
EV_KEY, mappable.  Read more about it below.

> I'd rather be for the thinkpad_acpi implementation, but what do you think?

Are those not "known keys" *known* to *be* keys?  If they could be
notifications (and not something passive like a key, that doesn't do
anything by itself), do NOT let userspace mess with them via a keymap.
Don't report them as keys, either.

As for the "known" parts of the keymap, if the firmware already did whatever
action the key should do, don't report it to userspace using EV_KEY events.

EV_KEY is for keys that the firmware won't act on by itself, only.  It is to
report events for "I am a poor key that can just tell you when I was
pressed, but the firmware will not do anything other than that".

It is NOT to report events for stuff like "hello, I am the all powerful
autodesctruction doomsday key.  I am letting you know I have been pressed,
and there is nothing you can do about it, because the firmware/hardware
already took action upon the keypress, and things will go up in flames soon
enough".  Report those as uevents.

> The problem here is whether to use the rfkill class device to implement the Fn+F2
> key, because it controls *both* WLAN and BT, which AFAIK isn't supported in any
> way by rfkill... There seems to be a KEY_RADIO keycode but I'm not sure if it

There are two sides to rfkill: the switches, and the radio on/off control.

First: the switch (input) side:

KEY_RADIO is the correct event to issue for "all radios" keys/buttons.
ThinkPads work like that as well.  This doesn't require any sort of rfkill
support.

EV_SW SW_RADIO is the correct event to issue for rocker (on/off) radio-kill
switches events, when they are software-controlled.  I am issuing them for
the hardware-controlled ones in thinkpads, because some WLAN cards
(Atheros) and the WWAN have no hardware rfkill line, so it ends up being a
mix of hardware-controlled and software-controoled radio kill switch in many
ThinkPads.

rfkill is *useless* to report the status of a rfkill switch.  It is
write-only(!).

Until that's fixed, I am just ignoring rfkill completely in thinkpad-acpi.
I will get to patching rfkill with proper read-only and read/write,
non-exclusive rfkill support eventually, so that I can use it in
thinkpad-acpi.  You're very welcome to do that work in rfkill instead of
wating for me (it is low in my priority list) :-)

Second: the radio control (output) side:

rfkill, as currently implemented, can only deal with write-only radio
control which is in *exclusive* control of the driver.  If the firmware or
hardware could change that control by itself, the rfkill class is useless
for that radio kill control.  This is what happens in just about every
laptop, btw.

> applies to this situation, or if it's even useful at all...? But, as the WLAN
> device can't be controlled by the driver (it would only control the LED), I don't
> know of any way to actually toggle the device other than rfkill...

Export the LED as a LED, and don't do anything else about the WLAN device.
It is the WLAN card's business to export a rfkill interface for it.

If you want to tie the LED to the rfkill state, I don't know how you could
do it.  Maybe there is already a notification chain you can listen to, or
some uevent?  Otherwise, you'll need to add a notification chain, etc.

> IMO, switching WL and BT in turn with the same sequence as in Windows (WL+BT ->
> WL -> BT -> OFF) should be the preferred behavior for asus-laptop, so that it
> stays consistent with the Windows/hardware behavior. Another possibility would be
> to toggle WL+BT together, but I'm not really for it as there is often a hardware
> kill switch to do that.

You issue the KEY_RADIO.  Whatever is supposed to deal with KEY_RADIO will
cause rfkill calls to toggle radios on/off in whatever way it is supposed to
be done (cycling, all radios, whatever).  It is not your problem :-)

You cannot turn the WLAN on/off if I understood it correctly, so you can't
handle it by yourself anyway.

> But is this kind of 'hack' a real solution?

IMO, we don't need any more excuses not to implement proper solutions for
these things :-)   rfkill needs some love, and then it will be possible to
do these things without *any* hacks.  I think that's the way to go.

> ___ Kill Switch _______________________________________________________________
> 
> The last tricky thing is the hardware Kill Switch, which of course is completely
> out of software control but still provides ACPI notifications when it's toggled.

EV_SW SW_RADIO.  Some ThinkPads also have one, and I asked the input
maintainer to add a proper event for this as I knew it would be handy sooner
or later.

You *have* to initialize the input system with the initial state of any
switch (issue an initial EV_SW event) thoughi, or the first event could be
lost if the initial state was NOT "off" and the first event you get is a
transition to "off".   You need to also sync the state of all switches (i.e.
issue EV_SW events with the current state read from the firmware) on resume
from STR/STD.

> Is there any recommended way of exposing its status to userspace? rfkill
> doesn't seem to have any way to say 'this device is completely disabled and not
> just OFF' ; a sysfs interface is possible but driver-specific ; and what about HAL?

We will have to fix rfkill.  Until then, feel free to copy thinkpad-acpi's
driver-specific interface for this (a boolean read-only attribute with
poll()/select() support).  HAL can deal with both, as long as it is
configured to do so.

> For instance, how to inform programs like NetworkManager that the WLAN connection
> is disabled? a keycode? HAL?

You send an input event, or an uevent, or you have a
poll()/select()-friendly sysfs attribute that one can read the state from.

It will go to stuff like NetworkManager through HAL, I think.  So you also
teach HAL about it.

> Finally, how should "set/get status" interfaces in sysfs and/or rfkill behave? in 
> a previous patch (not applied for the moment), I used the internal driver status
> when the kill switch is enabled, so that we can still read what devices were
> enabled and change them before toggling the kill switch again. At the time it
> appeared to be 'possibly useful' but a consequence is that it reports an
> inaccurate status, unless if the user or program is aware that the kill switch is
> ON. Would it be better to say all devices are OFF, and simply ignore changes made
> through sysfs/rfkill?

IMO, it is better to not use rfkill at all until someone fixes it to deal
with read-only and read/write radio kill control.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
