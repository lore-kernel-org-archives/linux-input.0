From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Enable addition function keys
Date: Tue, 24 May 2011 09:49:31 -0700
Message-ID: <20110524164931.GA16841@core.coreip.homeip.net>
References: <000001cc1403$1e0ede10$5a2c9a30$@com>
 <20110524062256.GA20829@core.coreip.homeip.net>
 <BANLkTinh4Ssnv16t9wp79D82XekiQMZguQ@mail.gmail.com>
 <BANLkTikFxR_xzZV6WNce+HBDVwc5QZc9yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48481 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab1EXQth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 12:49:37 -0400
Received: by pwi15 with SMTP id 15so3092086pwi.19
        for <linux-input@vger.kernel.org>; Tue, 24 May 2011 09:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikFxR_xzZV6WNce+HBDVwc5QZc9yQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Christen <davidchristen@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, May 24, 2011 at 06:27:57PM +0200, David Christen wrote:
> On Tue, May 24, 2011 at 1:30 PM, David Christen <davidchristen@gmail.com> wrote:
> > On Tue, May 24, 2011 at 8:22 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> Hi David,
> >>
> >> On Mon, May 16, 2011 at 09:54:49PM +0200, David Christen wrote:
> >>> I have a custom made keyboard with 48 Function keys attached to an embedded
> >>> PC running on a RISC CPU. With hid module in the kernel the regular part of
> >>> the keyboard (i.e. all letters, num pad and Fxx keys up to F12) are working
> >>> perfectly fine. However with the additional keys I don't get any events in
> >>> /dev/input/event0. This is the same behavior as found on a regular Linux PC
> >>> and also under Windows. Although the manufacturer of the keyboard confirmed
> >>> that those keys do send proper HID codes (0x68 to 0x8b for F13 to F48).
> >>> I don't have any experience in programming on the Kernel level. Could you
> >>> maybe direct me in how to get the input events of those keys running?
> >>>
> >>
> >> Even though the usage codes are not mapped you should be able to map
> >> them yourself using EVIOCSKEYCODE ioctl. See udev sources for how to
> >> adjust keymaps on input devices.
> >>
> >> We have F1 through F24 keycode defines, but no F25-F48 (nor do I want to
> >> add these since userspace would not really know what to do with these,
> >> they are device-specific); you'll have to pick some standard ones that
> >> match the functions you want to assign to your extended keys.
> >>
> >
> > Dear Dmitry,
> >
> > Thank you for looking into this.
> >
> > I'm trying to figure out how to use udev for this. Just to make sure
> > that my problem was described correctly. My issue is not the mapping
> > from the scancode to the keycode, but that I don't get any scancode at
> > all. If I look at the output of usbmon, in particular the rdesc file,
> > I get
> >
> > ====
> > Keyboard.0063 ---> Key.KPDot
> > Keyboard.0064 ---> Key.102nd
> > Keyboard.0065 ---> Key.Compose
> > LED.NumLock ---> LED.NumLock
> > LED.CapsLock ---> LED.CapsLock
> > LED.ScrollLock ---> LED.ScrollLock
> > (eof)
> > ====
> >
> > Looking at the output of my standard Logitech keyboard, this would be
> > exactly what I would need:
> >
> > ====
> > Keyboard.0080 ---> Key.VolumeUp
> > Keyboard.0081 ---> Key.VolumeDown
> > Keyboard.0082 ---> Key.Unknown
> > Keyboard.0083 ---> Key.Unknown
> > Keyboard.0084 ---> Key.Unknown
> > Keyboard.0085 ---> Key.KPComma
> > Keyboard.0086 ---> Key.Unknown
> > Keyboard.0087 ---> Key.RO
> > Keyboard.0088 ---> Key.Katakana/Hiragana
> > Keyboard.0089 ---> Key.Yen
> > Keyboard.008a ---> Key.Henkan
> > Keyboard.008b ---> Key.Muhenkan
> > Keyboard.008c ---> Key.KPJpComma
> > Keyboard.008d ---> Key.Unknown
> > Keyboard.008e ---> Key.Unknown
> > Keyboard.008f ---> Key.Unknown
> > Keyboard.0090 ---> Key.Hangeul
> > Keyboard.0091 ---> Key.Hanja
> > (eof)
> > ====
> >
> > Even better would be to use a keymap without any Key.Unknown in the
> > range 0x6b - 0x8b. The exact keycode is not relevant to me as long as
> > they are unique. I translate them immediately to some other codes and
> > send them to the serial port.
> >
> > So is there an easy way to select which keymap should be loaded? 

We try to follow HID Usage Table 1.12 or later as close as possible,
but we do not have keys defined for all possible usage codes and expect
userspace to adjust keymap as needed for specific devices.

> > Below
> > is the output when the keyboard is being attached:
> >
> > ====
> > usb 2-1: new full speed USB device using uhci_hcd and address 9
> > usb 2-1: New USB device found, idVendor=03eb, idProduct=2003
> > usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > usb 2-1: Product: USB Foil Keyboard Controller 32 12 885
> > usb 2-1: Manufacturer: GESYS
> > input: GESYS USB Foil Keyboard Controller 32 12 885 as /class/input/input11
> > generic-usb 0003:03EB:2003.000C: input,hidraw0: USB HID v1.11 Keyboard
> > [GESYS USB Foil Keyboard Controller 32 12 885] on
> > usb-0000:00:06.0-1/input0
> > ====
> >
> > as opposed to the logitech keyboard:
> >
> > ====
> > usb 2-1: new low speed USB device using uhci_hcd and address 10
> > usb 2-1: New USB device found, idVendor=046d, idProduct=c30e
> > usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > usb 2-1: Product: HID compliant keyboard
> > usb 2-1: Manufacturer: Logitech
> > input: Logitech HID compliant keyboard as /class/input/input12
> > generic-usb 0003:046D:C30E.000D: input,hidraw0: USB HID v1.10 Keyboard
> > [Logitech HID compliant keyboard] on usb-0000:00:06.0-1/input0
> > input: Logitech HID compliant keyboard as /class/input/input13
> > generic-usb 0003:046D:C30E.000E: input,hidraw1: USB HID v1.10 Device
> > [Logitech HID compliant keyboard] on usb-0000:00:06.0-1/input1
> > ====
> >
> > Thank you,
> > David
> >
> 
> Dear Dmitry,
> 
> I'm starting to feel stupid. I tried a simple code doing some ioctl
> calls using EVIOCSKEYCODE  and EVIOCGKEYCODE. But it does not appear
> to work. If I run it using ./ioctl-test /dev/input/event0 I get lots
> of complains about wrong arguments:
> 
> ====
> evdev ioctl: Invalid argument
> [0]= 125, [1] = 0
> evdev ioctl: Invalid argument
> [0]= 126, [1] = 0
> evdev ioctl: Invalid argument
> [0]= 127, [1] = 0
> evdev ioctl: Invalid argument
> [0]= 128, [1] = 0
> evdev ioctl: Invalid argument
> [0]= 129, [1] = 0
> evdev ioctl: Invalid argument
> Testing changes
> evdev ioctl: Invalid argument
> [0]= 49, [1] = 49
> evdev ioctl: Invalid argument
> [0]= 50, [1] = 49

The "scancode" for USB HID devices is full usage code (32 bit), so to
remap 'M' to 'N' I think you need to issue EVIOCSKEYCODE for
usage 0x00070010 (I think) and keycode 49 (KEY_N). 

BTW, this requires somewhat recent kernel. What kernel are you using?

Hope this helps.

-- 
Dmitry

P.S. In your program you call EVIOCSKEYCODE twice. I believe the 2nd
time, when you test, you want to call EVIOCGKEYCODE.

