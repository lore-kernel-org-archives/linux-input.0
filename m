From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Tue, 01 Feb 2011 12:01:54 +0000
Message-ID: <1296561717.15349.5.camel@novo.hadess.net>
References: <1296485689.7756.9.camel@novo.hadess.net>
	 <20110131212842.GB1603@polaris.bitmath.org>
	 <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zxFFi+Rw9cp81XfThz14"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:53378 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab1BAMCj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 07:02:39 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 27595388B1
	for <linux-input@vger.kernel.org>; Tue,  1 Feb 2011 13:02:22 +0100 (CET)
In-Reply-To: <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org


--=-zxFFi+Rw9cp81XfThz14
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Tue, 2011-02-01 at 10:00 +0100, Benjamin Tissoires wrote:
> Hi Bastien, Henrik,
> 
> On Mon, Jan 31, 2011 at 22:28, Henrik Rydberg <rydberg@euromail.se> wrote:
> > Hi Bastien,
> >
> >> Built into my Lenovo A700 all-in-one is a touchscreen. lsusb says:
> >> $ lsusb | grep -i touch
> >> Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems
> >
> > I take it this is a dual-touch device?
> >
> >> The touchscreen "works", in that tapping it will create a click event,
> >> though that click event is always in the top left of the screen.
> >
> > This is quite common for HID multitouch devices without proper driver
> > support. Sometimes using the HID_MULTI_INPUT quirk helps. Check
> > usbhid/hid-quirks.c for examples.
> >
> >> Full output of lsusb -vvv attached.
> >>
> >> Anybody with ideas as to what I'm missing, or whether that particular
> >> device is supported?
> >
> > You probably noted already that the 04e7:0020 device is listed in
> > usbhid. Unless the device claims to be win7 compliant (implying
> > patching up hid-multitouch), going with the evtouch X driver might get
> > you a bit on the way. Or - god forbid - the binary blob drivers...
> 
> To know if the device is "win7 compliant" or not, we need the full
> output of lsusb (with the report descriptors).
> You need to tell usbhid to release the device before calling lsusb -v.
> 
> Please use the script at
> http://lii-enac.fr/en/architecture/linux-input/report.py
> and run, as root: python report.py > descriptors.txt
> 
> This will do the job. You can then send us the descriptors.txt, and we
> will see what we can do.

Attached (with the rest of the input devices stripped).

> >> Using kernel 2.6.38-rc2-git5 (from Fedora rawhide).
> 
> If your device is "win7 compliant" you will have to recompile a new kernel.

That's alright, I've done this before ;)

--=-zxFFi+Rw9cp81XfThz14
Content-Disposition: attachment; filename="elo-touchscreen-descriptors.txt"
Content-Type: text/plain; name="elo-touchscreen-descriptors.txt"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

found device HID 0a5c:4502
echo 2-1.1.1:1.0 > unbind
found device USB Audio
echo 2-1.3:1.3 > unbind
found device HID 0a5c:4503
echo 2-1.1.2:1.0 > unbind
found device Elo TouchSystems Elo TouchSystems 2515 IntelliTouch Plus USB Touchmonitor
echo 2-1.6:1.0 > unbind
echo 1-1.5.1:1.0 > unbind
echo 1-1.5.2:1.0 > unbind

lsusb -v -d 000004E7:00000022

Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x04e7 Elo TouchSystems
  idProduct          0x0022 
  bcdDevice            1.16
  iManufacturer           1 Elo TouchSystems
  iProduct                2 Elo TouchSystems 2515 IntelliTouch Plus USB Touchmonitor
  iSerial                 3 00000000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                4mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     273
          Report Descriptor: (length is 273)
            Item(Global): Usage Page, data= [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data= [ 0x04 ] 4
                            Touch Screen
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x01 ] 1
            Item(Local ): Usage, data= [ 0x22 ] 34
                            Finger
            Item(Main  ): Collection, data= [ 0x02 ] 2
                            Logical
            Item(Local ): Usage, data= [ 0x42 ] 66
                            Tip Switch
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x32 ] 50
                            In Range
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x06 ] 6
            Item(Main  ): Input, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Local ): Usage, data= [ 0x51 ] 81
                            Contact ID
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Global): Logical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Unit Exponent, data= [ 0x0e ] 14
                            Unit Exponent: 14
            Item(Global): Unit, data= [ 0x33 ] 51
                            System: English Linear, Unit: Inch^3
            Item(Local ): Usage, data= [ 0x30 ] 48
                            Direction-X
            Item(Global): Physical Minimum, data= [ 0x00 ] 0
            Item(Global): Physical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Physical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Local ): Usage, data= [ 0x31 ] 49
                            Direction-Y
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Main  ): Collection, data= [ 0x02 ] 2
                            Logical
            Item(Global): Usage Page, data= [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data= [ 0x42 ] 66
                            Tip Switch
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x32 ] 50
                            In Range
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x06 ] 6
            Item(Main  ): Input, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Local ): Usage, data= [ 0x51 ] 81
                            Contact ID
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Global): Logical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Unit Exponent, data= [ 0x00 ] 0
                            Unit Exponent: 0
            Item(Global): Unit, data= [ 0x00 ] 0
                            System: None, Unit: (None)
            Item(Local ): Usage, data= [ 0x30 ] 48
                            Direction-X
            Item(Global): Physical Minimum, data= [ 0x00 ] 0
            Item(Global): Physical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Physical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Local ): Usage, data= [ 0x31 ] 49
                            Direction-Y
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Global): Usage Page, data= [ 0x0d ] 13
                            Digitizer
            Item(Local ): Usage, data= [ 0x54 ] 84
                            Contact Count
            Item(Global): Logical Maximum, data= [ 0x10 ] 16
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report ID, data= [ 0x08 ] 8
            Item(Local ): Usage, data= [ 0x55 ] 85
                            Maximum Contact Number
            Item(Global): Logical Maximum, data= [ 0x02 ] 2
            Item(Main  ): Feature, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Local ): Usage, data= [ 0x0e ] 14
                            (null)
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x07 ] 7
            Item(Local ): Usage, data= [ 0x22 ] 34
                            Finger
            Item(Main  ): Collection, data= [ 0x00 ] 0
                            Physical
            Item(Local ): Usage, data= [ 0x52 ] 82
                            Input Mode
            Item(Local ): Usage, data= [ 0x53 ] 83
                            Device Index
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x0a ] 10
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Report Count, data= [ 0x02 ] 2
            Item(Main  ): Feature, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                            (null)
            Item(Local ): Usage, data= [ 0x55 ] 85
                            (null)
            Item(Global): Report ID, data= [ 0x80 ] 128
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Feature, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x02 ] 2
                            Mouse
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x54 ] 84
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Pointer
            Item(Main  ): Collection, data= [ 0x00 ] 0
                            Physical
            Item(Global): Usage Page, data= [ 0x09 ] 9
                            Buttons
            Item(Local ): Usage Minimum, data= [ 0x01 ] 1
                            Button 1 (Primary)
            Item(Local ): Usage Maximum, data= [ 0x02 ] 2
                            Button 2 (Secondary)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x02 ] 2
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x06 ] 6
            Item(Main  ): Input, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x30 ] 48
                            Direction-X
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0x0f ] 4095
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x31 ] 49
                            Direction-Y
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x3b ] 59
                            Byte Count
            Item(Global): Logical Minimum, data= [ 0x00 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x00 0x01 ] 256
            Item(Global): Physical Minimum, data= [ 0x00 0x00 ] 0
            Item(Global): Physical Maximum, data= [ 0x00 0x01 ] 256
            Item(Global): Unit, data= [ 0x00 0x00 ] 0
                            System: None, Unit: (None)
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x62 ] 98
                            Data Variable Absolute No_Wrap Linear
                            No_Preferred_State Null_State Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               3
Device Status:     0x0001
  Self Powered

echo 2-1.1.1:1.0 > bind
echo 2-1.3:1.3 > bind
echo 2-1.1.2:1.0 > bind
echo 2-1.6:1.0 > bind
echo 1-1.5.1:1.0 > bind
echo 1-1.5.2:1.0 > bind

--=-zxFFi+Rw9cp81XfThz14--

