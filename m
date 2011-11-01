From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 21:24:06 +0200
Message-ID: <CAOazyz03G1ofwh-GnLDECUqC1qgO0tXzSVjjdwML_JdXZR_9ug@mail.gmail.com>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
	<20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
	<CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
	<20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37040 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab1KATYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 15:24:08 -0400
Received: by eye27 with SMTP id 27so6528980eye.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 12:24:07 -0700 (PDT)
In-Reply-To: <20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 9:11 PM, Antonio Ospite <ospite@studenti.unina.i=
t> wrote:
> USB and bluetooth operation are independent, if I had to guess I'd sa=
y
> the problem is bluetooth related.

Yes, but I still need to figure out which patches of yours I should use=
=2E..
Very complicated...
https://patchwork.kernel.org/patch/1075972/ is down
And on the bluez mailing list there are a lot of variants.

> Even after pressing the *PS* button _after_ plugging the device in?

Yes. Nothing happens, I see no USB activity in usbmon.

> Try resetting the joypad using the hole-button on the bottom.

Tried that too... same result.

> Try attaching the output of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lsusb -d 054c:0268 -vvv

Attached.

> and is it an _original_ controller?

I am sure hope so!
How can I determine?
Written Sony all over.
And it does working in Windows... using [1].
And lsusb is exactly similar to what I found in [2]

Thank you for your help!
Alon

[1] http://www.motioninjoy.com/download
[2] http://ps3.jim.sh/sixaxis/usb/lsusb.txt

---

Bus 003 Device 011: ID 054c:0268 Sony Corp. Batoh Device / PlayStation
3 Controller
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x054c Sony Corp.
  idProduct          0x0268 Batoh Device / PlayStation 3 Controller
  bcdDevice            1.00
  iManufacturer           1 Gasia Co.,Ltd
  iProduct                2 PS(R) Gamepad
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
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
          wDescriptorLength     148
          Report Descriptor: (length is 148)
            Item(Global): Usage Page, data=3D [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data=3D [ 0x04 ] 4
                            Joystick
            Item(Main  ): Collection, data=3D [ 0x01 ] 1
                            Application
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Global): Report ID, data=3D [ 0x01 ] 1
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x01 ] 1
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0xff 0x00 ] 255
            Item(Main  ): Input, data=3D [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Size, data=3D [ 0x01 ] 1
            Item(Global): Report Count, data=3D [ 0x13 ] 19
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
            Item(Global): Physical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Physical Maximum, data=3D [ 0x01 ] 1
            Item(Global): Usage Page, data=3D [ 0x09 ] 9
                            Buttons
            Item(Local ): Usage Minimum, data=3D [ 0x01 ] 1
                            Button 1 (Primary)
            Item(Local ): Usage Maximum, data=3D [ 0x13 ] 19
                            (null)
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Size, data=3D [ 0x01 ] 1
            Item(Global): Report Count, data=3D [ 0x0d ] 13
            Item(Global): Usage Page, data=3D [ 0x00 0xff ] 65280
                            (null)
            Item(Main  ): Input, data=3D [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0xff 0x00 ] 255
            Item(Global): Usage Page, data=3D [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Collection, data=3D [ 0x00 ] 0
                            Physical
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x04 ] 4
            Item(Global): Physical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Physical Maximum, data=3D [ 0xff 0x00 ] 255
            Item(Local ): Usage, data=3D [ 0x30 ] 48
                            Direction-X
            Item(Local ): Usage, data=3D [ 0x31 ] 49
                            Direction-Y
            Item(Local ): Usage, data=3D [ 0x32 ] 50
                            Direction-Z
            Item(Local ): Usage, data=3D [ 0x35 ] 53
                            Rotate-Z
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
            Item(Global): Usage Page, data=3D [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x27 ] 39
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x30 ] 48
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Output, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x30 ] 48
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Global): Report ID, data=3D [ 0x02 ] 2
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x30 ] 48
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Global): Report ID, data=3D [ 0xee ] 238
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x30 ] 48
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
            Item(Main  ): Collection, data=3D [ 0x02 ] 2
                            Logical
            Item(Global): Report ID, data=3D [ 0xef ] 239
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x30 ] 48
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            Pointer
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=3Dnone
            Item(Main  ): End Collection, data=3Dnone
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
