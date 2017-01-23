From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 00/17] Report power supply from hid-logitech-dj and others
Date: Mon, 23 Jan 2017 16:22:54 +0100
Message-ID: <20170123152254.GB9285@mail.corp.redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
 <1485182115.5845.12.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485182115.5845.12.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jan 23 2017 or thereabouts, Bastien Nocera wrote:
> On Tue, 2017-01-17 at 15:35 +0100, Benjamin Tissoires wrote:
> > Hey guys,
> > 
> > I tried to revive the in-kernel battery support for HID++ devices.
> > I was thinking of doing just a few patches, but in the end I had to
> > do
> > cleanups and some more tweaks...
> > 
> > So, the final result is that now hid-logitech-hidpp should allow to
> > handle any HID++ device, no matter which connection it uses.
> > I was able to test it on some unifying devices, some USB and
> > Bluetooth,
> > but I'd like to get the confirmation from Simon that I did not break
> > the G920.
> > 
> > Other than that, I implemented most features asked by Bastien during
> > the
> > last round:
> > - have a sysfs file to indicate we are capable of power_supply
> > - use ONLINE capability (not sure if I mess something up or if Gnome
> > handles
> >   it correctly)
> > - report product, serial and manufacturer
> > - report K750 battery info (not Lux, sorry)
> > - report HID++ 1.0 battery info
> > 
> > 
> <snip>
> 
> I've tested your patches with the kernel build that you kindly
> provided. The output of "upower -d", here[1], shows both a K750
> keyboard (the one with the solar charging) and a T650 touchpad (which
> was plugged in to a separate power supply when testing).
> 
> Here's a jumble of notes:
> - UPower expects the serial number to be available when the device is
> created. This wasn't the case for the keyboard here, and we end up with
> no serial number, even though the serial_number sysfs file is now
> populated

I think I can fix that, but I think upower might need to get some tweaks
too. In the kernel, the way the sysfs files are created is decided by
power_supply core. We just set a list of properties and power_supply
creates the sysfs. I would say it creates the files with the order of
the property list we provide, thus the fixable state.

But this means that the order we declare the properties is rather
important because you are probably notified by one specific property,
which should be the last one in the list. I'd need to check into the
udev enumeration process, but we should probably enforce upower to not
handle the power_supply before it gets fully initialized (either in
power_supply core, or in udev, or in upower).

> - the K750's battery state doesn't seem to match that found by the
> UPower code, eg. it's stuck in "Unknown" when upower could detect that
> it is charging (it's sunny here). That might also be why the icon is
> stuck at "battery-missing-symbolic".

I'll look into that. But I tested it with 2 K750 here and both were
reporting charging... I wonder if this has to do with the enumeration
process too.

> - the model names of the batteries seem to have manufacturer
> information prepended, eg. vendor: Logitech model_name: Logitech K750
> I'd have expected to only have "K750" there.

That's fixable.

> - the touchpad is detected as a random "battery", but that's likely due
> to the slightly dodgy code in UPower (look for "try to detect using the
> device type" and cringe)

Yep, I'll cringe, for sure :)

> - the serial number is in a different format than in UPower:
>   kernel: 4101-6f-63-fd-39
>   UPower: 6F63FD39

Yes, the serial is the same format as the one reported on the Windows
application. The first 4 chars are the unifying PID, and the rest is the
same than yours. I like having the Quad ID (unifying PID): that way, you
are ensured to have a unique identifier across all Unifying devices.

Is it really an issue to change the serial?

> 
> I'll look at updating the UPower code, thanks.

Thank you for testing and reporting!

Cheers,
Benjamin

> 
> UPower's "power_supply_ class code:
> https://cgit.freedesktop.org/upower/tree/src/linux/up-device-supply.c
> and its HID++ support:
> https://cgit.freedesktop.org/upower/tree/src/linux/up-device-unifying.c
> 
> [1]: https://paste.fedoraproject.org/535093/51785481
