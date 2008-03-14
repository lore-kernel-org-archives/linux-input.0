From: Fabien Crespel <fabien@crespel.net>
Subject: Best practices to improve a laptop driver using ACPI (hotkeys, rfkill,
 kill switch...)
Date: Sat, 15 Mar 2008 00:41:09 +0100
Message-ID: <47DB0D15.4040505@crespel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: acpi4asus-user@lists.sourceforge.net
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>
List-Id: linux-input@vger.kernel.org

Hello,

as an ASUS laptop owner, quite new to Linux kernel driver programming but long
time programmer, I'm interested in improving the asus-laptop driver in several
ways, with anyone that might be interested in the process (and of course 
especially the maintainer, Corentin Chary).

But for this, I would first like to know what the "best practices" are, to avoid
design mistakes. So here I come with many questions and unclear points I'd like
to define a bit better. Sorry if some questions have already been answered
elsewhere, but if they haven't, maybe the resulting discussion will also be
useful for other laptop drivers :)


___ INTRODUCTION _______________________________________________________________

Before asking anything, let me explain quickly how things work on ASUS laptops:
- hotkeys use ACPI notifications catched by the driver with a notify handler.
- there are several "operation modes" in most DSDTs, controlled by the CWAP
method / WAPF variable:
   0 = no driver (behavior hardcoded in the DSDT),
   1 = half-driver, half-hardware (current default in asus-laptop),
   4 = pure driver mode (notifications only for most events)
- in all modes, the Bluetooth device and LED (if present) are tied together, i.e.
toggling the LED through an ACPI method (BLED) also toggles the device.
- the WLAN device and LED are more tricky depending on the mode:
   0 = tied together on some models,
   1 and 4 = only the LED can be toggled with an ACPI method (WLED).

The goals of the proposed driver enhancements are to move to "mode 4" (pure
driver mode) on all ASUS laptops, to support more modern ways of handling things
like hotkeys, and to support new features like the hardware kill switch and the
Fn+F2 WLAN/Bluetooth toggle key.


___ HOTKEYS ____________________________________________________________________

Currently, hotkeys generate ACPI events (with acpi_bus_generate_proc_event) with
the notification code, which are handled directly by acpid scripts or userspace
programs like Lapsus. On some distros (like openSUSE 10.3 and probably Ubuntu),
the acpi-keys daemon (from the hotkey-setup package) converts some of these
events to keycodes.

Here the way to go seems to be the input framework, for which I noticed two
implementations:
- thinkpad_acpi's with the keymap of known key scancodes defined in the driver,
and only allowing to remap unknown keys.
- sony-laptop's with a predefined keymap too, but only allowing the known keys to
be remapped.

I'd rather be for the thinkpad_acpi implementation, but what do you think?


___ WLAN + Bluetooth control ___________________________________________________

There are many ways to control WLAN and BT depending on the laptop model:
- dedicated button to toggle WLAN
- dedicated button to toggle BT, always works fine but seems to be out of
software control (simply sends a notification after toggling the device and LED)
- Fn+F2 key, which usually works as a cycle between WL+BT -> WL -> BT -> OFF, or
just WL ON/OFF if the laptop doesn't have a Bluetooth device (on Windows or in
"mode 0", if supported)
- hardware kill switch (see further down in this message)

The problem here is whether to use the rfkill class device to implement the Fn+F2
key, because it controls *both* WLAN and BT, which AFAIK isn't supported in any
way by rfkill... There seems to be a KEY_RADIO keycode but I'm not sure if it
applies to this situation, or if it's even useful at all...? But, as the WLAN
device can't be controlled by the driver (it would only control the LED), I don't
know of any way to actually toggle the device other than rfkill...

IMO, switching WL and BT in turn with the same sequence as in Windows (WL+BT ->
WL -> BT -> OFF) should be the preferred behavior for asus-laptop, so that it
stays consistent with the Windows/hardware behavior. Another possibility would be
to toggle WL+BT together, but I'm not really for it as there is often a hardware
kill switch to do that.

So, a possible implementation of this Fn+F2 key would be to hardcode the sequence
in the ACPI notify handler of the driver, to send KEY_WLAN or KEY_BLUETOOTH
only in the appropriate case. Then the rfkill input handler would catch that and
call the appropriate rfkill function of the asus-laptop driver to finally switch
the WL LED or BT LED+device.

But is this kind of 'hack' a real solution?
Do other laptop drivers have the same problem and if so, how do they handle it?


___ Kill Switch _______________________________________________________________

The last tricky thing is the hardware Kill Switch, which of course is completely
out of software control but still provides ACPI notifications when it's toggled.

Is there any recommended way of exposing its status to userspace? rfkill
doesn't seem to have any way to say 'this device is completely disabled and not
just OFF' ; a sysfs interface is possible but driver-specific ; and what about HAL?

For instance, how to inform programs like NetworkManager that the WLAN connection
is disabled? a keycode? HAL?

Finally, how should "set/get status" interfaces in sysfs and/or rfkill behave? in 
a previous patch (not applied for the moment), I used the internal driver status
when the kill switch is enabled, so that we can still read what devices were
enabled and change them before toggling the kill switch again. At the time it
appeared to be 'possibly useful' but a consequence is that it reports an
inaccurate status, unless if the user or program is aware that the kill switch is
ON. Would it be better to say all devices are OFF, and simply ignore changes made
through sysfs/rfkill?


So this is it, sorry for making such a long post :P
Thanks for reading, and thanks for any constructive answer you might provide.

- Fabien.


