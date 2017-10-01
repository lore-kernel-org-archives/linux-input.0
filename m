From: IFo Hancroft <lists@ifohancroft.com>
Subject: Need help investigating not working NKRO over USB in Linux
Date: Sun, 1 Oct 2017 08:55:13 +0300
Message-ID: <00f6687f-49a7-3fae-b96c-f934f5a32605@ifohancroft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avalon.superhosting.bg ([195.191.149.14]:50940 "EHLO
        avalon.superhosting.bg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdJAGgO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 1 Oct 2017 02:36:14 -0400
Received: from [94.26.87.140] (port=34346 helo=[192.168.0.106])
        by avalon.superhosting.bg with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <lists@ifohancroft.com>)
        id 1dyXDd-0046ru-Fl
        for linux-input@vger.kernel.org; Sun, 01 Oct 2017 08:55:13 +0300
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello Everyone,

Greg Kroah-Hartman directed me to here.

Here is what I am trying to do, what problems am I facing and what I've
tried so far:

My keyboard is USB and it is supposed to have NKRO (the ability to
register as many keys as pressed). (I know the protocol doesn't really
allow it and it's using some hack).
However, the NKRO doesn't work in Linux (By not working, I mean it only
registers 6 keys and modifiers.), so I am trying to investigate what is
happening. For example is it just sending one stream of
data (the 6KRO one (referred to as boot mode)) or two and one gets
ignored. In theory, since I know the NKRO works in Windows and
supposedly in Mac OS X, I think it is sending two but one of them gets
ignored somehow.

I've first ran lsbusb and got this:

Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 011: ID 2516:003c
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 046d:082d Logitech, Inc. HD Pro Webcam C920
Bus 001 Device 002: ID 046d:c07d Logitech, Inc.
Bus 001 Device 005: ID 0909:001c Audio-Technica Corp.
Bus 001 Device 004: ID 0951:16a4 Kingston Technology
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

I know that the second line refers to the keyboard:

Bus 003 Device 011: ID 2516:003c

I've run: sudo bash -c "echo -n 3-2:1.0
> /sys/bus/usb/drivers/usbhid/unbind"; sudo bash -c "echo -n 3-2:1.2
> /sys/bus/usb/drivers/usbhid/unbind"; sudo lsusb -v -d 2516:003c;
(I've run it as sudo so I get rid of the 'Couldn't open device, some
information will be missing' and hopefully get the full info. I've
unbind the device to get the Debug descriptor, however since at places,
I still get
can't get debug descriptor: Resource temporarily unavailable I thought
I'd unbind both device events that show up in dmesg after plugging the
device')
The output for the device in dmesg is the following:

[387473.151166] usb 3-2: new full-speed USB device number 11 using xhci_hcd
[387473.320074] usb 3-2: New USB device found, idVendor=2516, idProduct=003c
[387473.320079] usb 3-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[387473.320103] usb 3-2: Product: MASTERKEYS PRO S
[387473.320105] usb 3-2: Manufacturer: Cooler Master Technology Inc.
[387473.322051] input: Cooler Master Technology Inc. MASTERKEYS PRO S as
/devices/pci0000:00/0000:00:1c.0/0000:03:00.0/0000:04:02.0/0000:07:00.0/usb3/3-2/3-2:1.0/0003:2516:003C.0026/input/input44
 [387473.373897] hid-generic 0003:2516:003C.0026: input,hidraw2: USB HID
v1.11 Keyboard [Cooler Master Technology Inc. MASTERKEYS PRO S] on
usb-0000:07:00.0-2/input0
[387473.374961] hid-generic 0003:2516:003C.0027: hiddev0,hidraw3: USB
HID v1.11 Device [Cooler Master Technology Inc. MASTERKEYS PRO S] on
usb-0000:07:00.0-2/input1
[387473.376754] input: Cooler Master Technology Inc. MASTERKEYS PRO S as
/devices/pci0000:00/0000:00:1c.0/0000:03:00.0/0000:04:02.0/0000:07:00.0/usb3/3-2/3-2:1.2/0003:2516:003C.0028/input/input45
 [387473.428595] hid-generic 0003:2516:003C.0028: input,hidraw4: USB HID
v1.11 Keyboard [Cooler Master Technology Inc. MASTERKEYS PRO S] on
usb-0000:07:00.0-2/input2

As you can see, there are two input: lines having different parts in the
path in the form of 3-2:1.0 and 3-2:1.2 (to be honest no idea why and
what that means)

The output of: sudo bash -c "echo -n 3-2:1.0
> /sys/bus/usb/drivers/usbhid/unbind"; sudo bash -c "echo -n 3-2:1.2
> /sys/bus/usb/drivers/usbhid/unbind"; sudo lsusb -v -d 2516:003c; is the
following:

Bus 003 Device 008: ID 2516:003c
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x2516
  idProduct          0x003c
  bcdDevice           12.01
  iManufacturer           1 Cooler Master Technology Inc.
  iProduct                2 MASTERKEYS PRO S
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           91
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
          Report Descriptor: (length is 64)
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x06 ] 6
                            Keyboard
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Usage Page, data= [ 0x07 ] 7
                            Keyboard
            Item(Local ): Usage Minimum, data= [ 0xe0 ] 224
                            Control Left
            Item(Local ): Usage Maximum, data= [ 0xe7 ] 231
                            GUI Right
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x03 ] 3
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Usage Page, data= [ 0x08 ] 8
                            LEDs
            Item(Local ): Usage Minimum, data= [ 0x01 ] 1
                            NumLock
            Item(Local ): Usage Maximum, data= [ 0x03 ] 3
                            Scroll Lock
            Item(Main  ): Output, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x05 ] 5
            Item(Main  ): Output, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x06 ] 6
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xa4 0x00 ] 164
            Item(Global): Usage Page, data= [ 0x07 ] 7
                            Keyboard
            Item(Local ): Usage Minimum, data= [ 0x00 ] 0
                            No Event
            Item(Local ): Usage Maximum, data= [ 0xa4 ] 164
                            ExSel
            Item(Main  ): Input, data= [ 0x00 ] 0
                            Data Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      34
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     134
          Report Descriptor: (length is 134)
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x80 ] 128
                            System Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x01 ] 1
            Item(Local ): Usage Minimum, data= [ 0x81 ] 129
                            System Power Down
            Item(Local ): Usage Maximum, data= [ 0x83 ] 131
                            System Wake Up
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x03 ] 3
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x05 ] 5
            Item(Main  ): Input, data= [ 0x01 ] 1
                            Constant Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Consumer Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x02 ] 2
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x12 ] 18
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Local ): Usage, data= [ 0x83 0x01 ] 387
                            AL Consumer Control Configuration
            Item(Local ): Usage, data= [ 0x8a 0x01 ] 394
                            AL Email Reader
            Item(Local ): Usage, data= [ 0x92 0x01 ] 402
                            AL Calculator
            Item(Local ): Usage, data= [ 0x94 0x01 ] 404
                            AL Local Machine Browser
            Item(Local ): Usage, data= [ 0xcd ] 205
                            Play/Pause
            Item(Local ): Usage, data= [ 0xb7 ] 183
                            Stop
            Item(Local ): Usage, data= [ 0xb6 ] 182
                            Scan Previous Track
            Item(Local ): Usage, data= [ 0xb5 ] 181
                            Scan Next Track
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Local ): Usage, data= [ 0x21 0x02 ] 545
                            AC Search
            Item(Local ): Usage, data= [ 0x23 0x02 ] 547
                            AC Home
            Item(Local ): Usage, data= [ 0x24 0x02 ] 548
                            AC Back
            Item(Local ): Usage, data= [ 0x25 0x02 ] 549
                            AC Forward
            Item(Local ): Usage, data= [ 0x26 0x02 ] 550
                            AC Stop
            Item(Local ): Usage, data= [ 0x27 0x02 ] 551
                            AC Refresh
            Item(Local ): Usage, data= [ 0x2a 0x02 ] 554
                            (null)
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x0e ] 14
            Item(Main  ): Input, data= [ 0x01 ] 1
                            Constant Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x06 ] 6
                            Keyboard
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Report ID, data= [ 0x04 ] 4
            Item(Global): Usage Page, data= [ 0x07 ] 7
                            Keyboard
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x03 ] 3
                            Constant Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Global): Report Count, data= [ 0xe8 ] 232
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Usage Page, data= [ 0x07 ] 7
                            Keyboard
            Item(Local ): Usage Minimum, data= [ 0x00 ] 0
                            No Event
            Item(Local ): Usage Maximum, data= [ 0xe7 ] 231
                            GUI Right
            Item(Main  ): Input, data= [ 0x00 ] 0
                            Data Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position
Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)

I've also did this:

sudo usbhid-dump -d2516 -i255

003:010:002:DESCRIPTOR         1503191059.257117
 05 01 09 80 A1 01 85 01 19 81 29 83 15 00 25 01
 95 03 75 01 81 02 95 01 75 05 81 01 C0 05 0C 09
 01 A1 01 85 02 15 00 25 01 95 12 75 01 0A 83 01
 0A 8A 01 0A 92 01 0A 94 01 09 CD 09 B7 09 B6 09
 B5 09 E2 09 EA 09 E9 0A 21 02 0A 23 02 0A 24 02
 0A 25 02 0A 26 02 0A 27 02 0A 2A 02 81 02 95 01
 75 0E 81 01 C0 05 01 09 06 A1 01 85 04 05 07 95
 01 75 08 81 03 95 E8 75 01 15 00 25 01 05 07 19
 00 29 E7 81 00 C0

003:010:001:DESCRIPTOR         1503191059.257558
 06 00 FF 09 01 A1 01 09 02 15 00 26 FF 00 75 08
 95 40 81 02 09 03 15 00 26 FF 00 75 08 95 40 91
 02 C0

003:010:000:DESCRIPTOR         1503191059.257945
 05 01 09 06 A1 01 05 07 19 E0 29 E7 15 00 25 01
 75 01 95 08 81 02 95 01 75 08 81 03 95 03 75 01
 05 08 19 01 29 03 91 02 95 01 75 05 91 03 95 06
 75 08 15 00 26 A4 00 05 07 19 00 29 A4 81 00 C0

sudo usbhid-dump -d2516 -i255 | grep -v : | xxd -r -p | hidrd-convert -o
spec
(here the 2516 is the vendor id from the vendor id: product id pair, as
for the 255 after the i, that's how I saw it in the article I was
looking at, recently I've saw examples with other integers there but I
have no idea what's the difference and it was 255 in the article related
to my issue so I've used it):

The output is:

Usage Page (Desktop),                   ; Generic desktop controls (01h)
Usage (Sys Control),                    ; System control (80h,
application collection)
Collection (Application),
    Report ID (1),
    Usage Minimum (Sys Power Down),     ; System power down (81h,
one-shot control)
    Usage Maximum (Sys Wake Up),        ; System wake up (83h, one-shot
control)
    Logical Minimum (0),
    Logical Maximum (1),
    Report Count (3),
    Report Size (1),
    Input (Variable),
    Report Count (1),
    Report Size (5),
    Input
(Constant),
             \


End
Collection,
             \


Usage Page (Consumer),                  ; Consumer
(0Ch)
             \


Usage (Consumer Control),               ; Consumer control (01h,
application
collection)
             \


Collection
(Application),
             \


    Report ID
(2),
             \


    Logical Minimum
(0),
             \


    Logical Maximum
(1),
             \


    Report Count
(18),
             \


    Report Size
(1),
             \


    Usage (AL Consumer Control Config), ; AL consumer control
configuration (0183h,
selector)
             \


    Usage (AL Email Reader),            ; AL email reader (018Ah,
selector)
             \


    Usage (AL Calculator),              ; AL calculator (0192h,
selector)
             \


    Usage (AL Local Machine Brwsr),     ; AL local machine browser
(0194h,
selector)
             \


    Usage (Play Pause),                 ; Play/pause (CDh, one-shot
control)
             \


    Usage (Stop),                       ; Stop (B7h, one-shot
control)
             \


    Usage (Scan Previous Track),        ; Scan previous track (B6h,
one-shot
control)
             \


    Usage (Scan Next Track),            ; Scan next track (B5h, one-shot
control)
             \


    Usage (Mute),                       ; Mute (E2h, on/off control)
    Usage (Volume Dec),                 ; Volume decrement (EAh,
re-trigger control)
    Usage (Volume Inc),                 ; Volume increment (E9h,
re-trigger control)
    Usage (AC Search),                  ; AC search (0221h, selector)
    Usage (AC Home),                    ; AC home (0223h, selector)
    Usage (AC Back),                    ; AC back (0224h, selector)
    Usage (AC Forward),                 ; AC forward (0225h, selector)
    Usage (AC Stop),                    ; AC stop (0226h, selector)
    Usage (AC Refresh),                 ; AC refresh (0227h, selector)
    Usage (AC Bookmarks),               ; AC bookmarks (022Ah, selector)
    Input (Variable),
    Report Count (1),
    Report Size (14),
    Input (Constant),
End Collection,
Usage Page (Desktop),                   ; Generic desktop controls (01h)
Usage (Keyboard),                       ; Keyboard (06h, application
collection)
Collection (Application),
    Report ID (4),
    Usage Page (Keyboard),              ; Keyboard/keypad (07h)
    Report Count (1),
    Report Size (8),
    Input (Constant, Variable),
    Report Count (232),
    Report Size (1),
    Logical Minimum (0),
    Logical Maximum (1),
    Usage Page (Keyboard),              ; Keyboard/keypad (07h)
    Usage Minimum (None),               ; No event (00h, selector)
    Usage Maximum (KB Right GUI),       ; Keyboard right GUI (E7h,
dynamic value)
    Input,
End Collection,
Usage Page (FF00h),                     ; FF00h, vendor-defined
Usage (01h),
Collection (Application),
    Usage (02h),
    Logical Minimum (0),
    Logical Maximum (255),
    Report Size (8),
    Report Count (64),
    Input (Variable),
    Usage (03h),
    Logical Minimum (0),
    Logical Maximum (255),
    Report Size (8),
    Report Count (64),
    Output (Variable),
End Collection,
Usage Page (Desktop),                   ; Generic desktop controls (01h)
Usage (Keyboard),                       ; Keyboard (06h, application
collection)
Collection (Application),
    Usage Page (Keyboard),              ; Keyboard/keypad (07h)
    Usage Minimum (KB Leftcontrol),     ; Keyboard left control (E0h,
dynamic value)
    Usage Maximum (KB Right GUI),       ; Keyboard right GUI (E7h,
dynamic value)
    Logical Minimum (0),
    Logical Maximum (1),
    Report Size (1),
    Report Count (8),
    Input (Variable),
    Report Count (1),
    Report Size (8),
    Input (Constant, Variable),
    Report Count (3),
    Report Size (1),
    Usage Page (LED),                   ; LEDs (08h)
    Usage Minimum (01h),
    Usage Maximum (03h),
    Output (Variable),
    Report Count (1),
    Report Size (5),
    Output (Constant, Variable),
    Report Count (6),
    Report Size (8),
    Logical Minimum (0),
    Logical Maximum (164),
    Usage Page (Keyboard),              ; Keyboard/keypad (07h)
    Usage Minimum (None),               ; No event (00h, selector)
    Usage Maximum (KB ExSel),           ; Keyboard ExSel (A4h, selector)
    Input,
End Collection

I think I am on the right track with the information hunting however at
this point I have no idea about what should I do further.
Is this information enough to find out what's going on or do I need more
info and what kind of info do I need?
If this information is enough - well, to be honest I don't understand
shit from it. How do I learn to understand it better?

Best Regards,
IFo Hancroft
