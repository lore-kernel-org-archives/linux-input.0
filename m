From: James <theholyettlz@gmail.com>
Subject: at90usbkey sample firmware (HID mouse) / "CDT 10.1" touch-screen
Date: Fri, 11 Feb 2011 00:33:56 +0000
Message-ID: <1297384436.17598.32.camel@rhapsody>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-azEfaC/L4eH/ezXoJZh8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32944 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757332Ab1BKAeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Feb 2011 19:34:02 -0500
Received: by wwa36 with SMTP id 36so2044901wwa.1
        for <linux-input@vger.kernel.org>; Thu, 10 Feb 2011 16:34:01 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--=-azEfaC/L4eH/ezXoJZh8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I've just acquired an Atom tablet PC with a 10.1-inch touchscreen. The
screen appear to be a USB HID device, showing up in lsusb as

  Bus 005 Device 002: ID 03eb:201c Atmel Corp. at90usbkey sample
firmware (HID mouse)

with manufacturer, product as "CDT", "10.1" in its sysfs entry. Please
find the output of report.py included at the end of this e-mail.

What I find is that attempting to use it in X, at a first attempt after
the machine is started or after resume from suspend-to-RAM, quickly
hoses the desktop: the cursor moves around, but clicks are obstructed
--- even those from other pointing devices. I then kill X via another
VT, which results in something less troublesome, but still not really
useful. In this state, monitoring with xinput test:

 - dragging one finger over the screen produces a slew of items of
   the form

     motion <co-ordinates>
     button press 1
     button release 1

 - a single "tap" can produce a bunch of events like this, resulting
   in an inability to sensibly click or double-click

 - *BUT* holding one finger on the screen and then dragging with the
   other gives something like

     button press 1
     motion <co-ordinates>
       .
       .
     button release 1

   (sometimes there are multiple press/releases at the end). This
   *sometimes* results in click-and-drag behaviour.

 - Seen a few sporadic "phantom" taps in a certain region of the screen.

(Consequently, I normally float this device.) In the Xorg log, there's
the following:


[    27.229] (II) config/udev: Adding input device CDT   10.1
(/dev/input/event5)
[    27.229] (**) CDT   10.1 : Applying InputClass "evdev tablet
catchall"
[    27.229] (**) CDT   10.1 : always reports core events
[    27.229] (**) CDT   10.1 : Device: "/dev/input/event5"
[    27.230] (--) CDT   10.1 : Found 2 mouse buttons
[    27.230] (--) CDT   10.1 : Found absolute axes
[    27.230] (--) CDT   10.1 : Found x and y absolute axes
[    27.230] (--) CDT   10.1 : Found absolute tablet.
[    27.230] (II) CDT   10.1 : Configuring as tablet
[    27.230] (**) CDT   10.1 : YAxisMapping: buttons 4 and 5
[    27.230] (**) CDT   10.1 : EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    27.230] (II) XINPUT: Adding extended input device "CDT   10.1
" (type: TABLET)
[    27.231] (II) CDT   10.1 : initialized for absolute axes.
[    27.232] (II) config/udev: Adding input device CDT   10.1
(/dev/input/mouse0)
[    27.232] (II) No input driver/identifier specified (ignoring)


Apologies for the length of this post, but I hope it's of some use. Let
me know if any more info would be helpful.

Thanks,
James.


Bus 005 Device 002: ID 03eb:201c Atmel Corp. at90usbkey sample firmware
(HID mouse)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        32
  idVendor           0x03eb Atmel Corp.
  idProduct          0x201c at90usbkey sample firmware (HID mouse)
  bcdDevice           10.04
  iManufacturer           1 CDT =20
  iProduct                2 10.1=20
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0x00
      (Missing must-be-set bit!)
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0=20
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     177
          Report Descriptor: (length is 177)
            Item(Global): Usage Page, data=3D [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data=3D [ 0x04 ] 4
                            Touch Screen
            Item(Main  ): Collection, data=3D [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data=3D [ 0x01 ] 1
            Item(Local ): Usage, data=3D [ 0x22 ] 34
                            Finger
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Local ): Usage, data=3D [ 0x42 ] 66
                            Tip Switch
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
            Item(Global): Report Size, data=3D [ 0x01 ] 1
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x32 ] 50
                            In Range
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x47 ] 71
                            Confidence
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data=3D [ 0x05 ] 5
            Item(Main  ): Input, data=3D [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x51 ] 81
                            Contact ID
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Usage Page, data=3D [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Global): Physical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Unit Exponent, data=3D [ 0x0e ] 14
                            Unit Exponent: 14
            Item(Global): Unit, data=3D [ 0x33 ] 51
                            System: English Linear, Unit: Inch^3
            Item(Global): Report Size, data=3D [ 0x10 ] 16
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Local ): Usage, data=3D [ 0x30 ] 48
                            Direction-X
            Item(Global): Logical Maximum, data=3D [ 0xff 0x4b ] 19455
            Item(Global): Physical Maximum, data=3D [ 0x70 0x03 ] 880
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x31 ] 49
                            Direction-Y
            Item(Global): Logical Maximum, data=3D [ 0xff 0x2b ] 11263
            Item(Global): Physical Maximum, data=3D [ 0xf1 0x01 ] 497
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Physical Maximum, data=3D [ 0x00 0x00 ] 0
            Item(Main  ): End Collection, data=3Dnone
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Global): Usage Page, data=3D [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data=3D [ 0x42 ] 66
                            Tip Switch
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
            Item(Global): Report Size, data=3D [ 0x01 ] 1
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x32 ] 50
                            In Range
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x47 ] 71
                            Confidence
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data=3D [ 0x05 ] 5
            Item(Main  ): Input, data=3D [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x51 ] 81
                            Contact ID
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Usage Page, data=3D [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Global): Physical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Unit Exponent, data=3D [ 0x0e ] 14
                            Unit Exponent: 14
            Item(Global): Unit, data=3D [ 0x33 ] 51
                            System: English Linear, Unit: Inch^3
            Item(Global): Report Size, data=3D [ 0x10 ] 16
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Local ): Usage, data=3D [ 0x30 ] 48
                            Direction-X
            Item(Global): Logical Maximum, data=3D [ 0xff 0x4b ] 19455
            Item(Global): Physical Maximum, data=3D [ 0x70 0x03 ] 880
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Local ): Usage, data=3D [ 0x31 ] 49
                            Direction-Y
            Item(Global): Logical Maximum, data=3D [ 0xff 0x2b ] 11263
            Item(Global): Physical Maximum, data=3D [ 0xf1 0x01 ] 497
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Physical Maximum, data=3D [ 0x00 0x00 ] 0
            Item(Main  ): End Collection, data=3Dnone
            Item(Global): Usage Page, data=3D [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data=3D [ 0x54 ] 84
                            Contact Count
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Usage Page, data=3D [ 0x0d ] 13
                            Digitizer
            Item(Global): Report ID, data=3D [ 0x02 ] 2
            Item(Local ): Usage, data=3D [ 0x55 ] 85
                            Maximum Contact Number
            Item(Global): Logical Maximum, data=3D [ 0x02 ] 2
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               5
Device Status:     0x00e3
  Self Powered
  Remote Wakeup Enabled
  Debug Mode

--=20
James                                            TheHolyettlz@gmail.com
PGP key ID: 03F94B5D
-----------------------------------------------------------------------

--=-azEfaC/L4eH/ezXoJZh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1Ug/MACgkQL/Is9AP5S12B+QCeM8+bmo9nrfaNQ9/4YawQEXHU
8DoAn2THHtwV0/zoabD9SroiWzidsHp1
=8nW6
-----END PGP SIGNATURE-----

--=-azEfaC/L4eH/ezXoJZh8--

