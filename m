From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: 3.19: Thinkpad T440s clickpad always gives button3
Date: Tue, 10 Mar 2015 11:24:56 +1000
Message-ID: <20150310012456.GA7196@jelly.redhat.com>
References: <20150310003458.GA14045@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:10728 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbCJBZG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 21:25:06 -0400
Content-Disposition: inline
In-Reply-To: <20150310003458.GA14045@hexapodia.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-input@vger.kernel.org

On Mon, Mar 09, 2015 at 05:34:58PM -0700, Andy Isaacson wrote:
> I recently upgraded from 3.15.10 to 3.19.0 (I skipped a bunch of
> versions due to some GPU issues which I finally resolved).  In the
> upgrade, the touchpad stopped delivering button1 and now always delivers
> button3 events on click.

first, this isn't a kernel bug, right-button emulation is handled in the
xorg synaptics driver. best to file a bug for it on
https://bugs.freedesktop.org (component Input/synaptics)
 
> I normally use the laptop after disabling the touchpad and simply using
> the TrackPoint, or an external mouse.  I use the following to disable
> it:
> 
> synclient HorizHysteresis=10000 VertHysteresis=10000

if you want the touchpad off, you should use the SynapticsOff property. with
this hysteresis, all you get is that the last spot on the touchpad is
frozen. If you run this automatically without using the touchpad then it
should work (it does here), but if your last touch was in the right top or
right bottom of the touchpad, then you'll get a right button click from then
on.

Cheers,
   Peter

> Ah! in testing to send this message, I noticed that 1-finger taps are
> turning into button1 events, two-finger taps turn into button3 events,
> and three-finger taps turn into button2 events.  Clicking the trackpad
> is the buggy behavior, it always turns into a button3 rather than a
> button1.
> 
> dmesg is fairly uninformative regarding what quirks/etc are enabled, but
> I've appended the whole thing below.
> 
> Xorg.0.log says
> 
> [    19.739] (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/event16)
> [    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "evdev touchpad catchall"
> [    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "touchpad catchall"
> [    19.739] (**) SynPS/2 Synaptics TouchPad: Applying InputClass "Default clickpad buttons"
> [    19.739] (II) LoadModule: "synaptics"
> [    19.739] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
> [    19.740] (II) Module synaptics: vendor="X.Org Foundation"
> [    19.740]    compiled for 1.16.0.901, module version = 1.8.99
> [    19.740]    Module class: X.Org XInput Driver
> [    19.740]    ABI class: X.Org XInput driver, version 21.0
> [    19.740] (II) Using input driver 'synaptics' for 'SynPS/2 Synaptics TouchPad'
> [    19.740] (**) SynPS/2 Synaptics TouchPad: always reports core events
> [    19.740] (**) Option "Device" "/dev/input/event16"
> [    19.772] (II) synaptics: SynPS/2 Synaptics TouchPad: found clickpad property
> [    19.772] (II) synaptics: SynPS/2 Synaptics TouchPad: found top buttonpad property
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: x-axis range 1024 - 5112 (res 42)
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: y-axis range 2024 - 4832 (res 42)
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: pressure range 0 - 255
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: finger width range 0 - 15
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: buttons: left double triple
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: Vendor 0x2 Product 0x7
> [    19.772] (**) Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
> [    19.772] (**) Option "SecondarySoftButtonAreas" "58% 0 0 15% 42% 58% 0 15%"
> [    19.772] (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
> [    19.772] (**) SynPS/2 Synaptics TouchPad: always reports core events
> [    19.808] (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/input/input7/event16"
> [    19.808] (II) XINPUT: Adding extended input device "SynPS/2 Synaptics TouchPad" (type: TOUCHPAD, id 11)
> [    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MinSpeed is now constant deceleration 2.5
> [    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MaxSpeed is now 1.75
> [    19.808] (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) AccelFactor is now 0.040
> [    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) keeping acceleration scheme 1
> [    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration profile 1
> [    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration factor: 2.000
> [    19.808] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration threshold: 4
> [    19.808] (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
> [    19.808] (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/mouse1)
> [    19.808] (**) SynPS/2 Synaptics TouchPad: Ignoring device from InputClass "touchpad ignore duplicates"
> [    19.809] (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/event17)
> [    19.809] (**) TPPS/2 IBM TrackPoint: Applying InputClass "evdev pointer catchall"
> [    19.809] (II) Using input driver 'evdev' for 'TPPS/2 IBM TrackPoint'
> [    19.809] (**) TPPS/2 IBM TrackPoint: always reports core events
> [    19.809] (**) evdev: TPPS/2 IBM TrackPoint: Device: "/dev/input/event17"
> [    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Vendor 0x2 Product 0xa
> [    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found 3 mouse buttons
> [    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found relative axes
> [    19.809] (--) evdev: TPPS/2 IBM TrackPoint: Found x and y relative axes
> [    19.809] (II) evdev: TPPS/2 IBM TrackPoint: Configuring as mouse
> [    19.809] (**) evdev: TPPS/2 IBM TrackPoint: YAxisMapping: buttons 4 and 5
> [    19.809] (**) evdev: TPPS/2 IBM TrackPoint: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
> [    19.809] (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/serio2/input/input18/event17"
> [    19.809] (II) XINPUT: Adding extended input device "TPPS/2 IBM TrackPoint" (type: MOUSE, id 12)
> [    19.809] (II) evdev: TPPS/2 IBM TrackPoint: initialized for relative axes.
> [    19.809] (**) TPPS/2 IBM TrackPoint: (accel) keeping acceleration scheme 1
> [    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration profile 0
> [    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration factor: 2.000
> [    19.809] (**) TPPS/2 IBM TrackPoint: (accel) acceleration threshold: 4
> [    19.809] (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/mouse2)
> 
> -andy
> 
