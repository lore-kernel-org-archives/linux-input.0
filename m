From: simon@mungewell.org
Subject: Wii Logitech Speed Force Wireless Wheel
Date: Fri, 9 Jul 2010 11:41:31 -0400
Message-ID: <e6ec947d39bd4a3c35610cf3cd9af9e7.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100709114131_69263"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:45513 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674Ab0GIQDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 12:03:09 -0400
Received: from localhost ([127.0.0.1] helo=host171.canaca.com)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1OXFhj-000852-P8
	for linux-input@vger.kernel.org; Fri, 09 Jul 2010 11:41:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

------=_20100709114131_69263
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Having picked up two of these devices extremely cheap, I would like to
assist on getting it working under Linux.
http://www.logitech.com/en-gb/gaming/wheels/devices/4566

The device claims to be HID and is recognised as such, however using
jstest it appears that there are no events being sent from the wheel.

If I enable the debug parameter for the HID module I can see an initial
burst of data in /dev/hidraw0, but after that no new information is sent
from the wheel.

The USB ID is 0x046d:0xc29c, and I've started a page for it here:
http://www.qbik.ch/usb/devices/showdev.php?id=4669

'lsusb -vvv' and HID tables are attached.



The system consist of a USB dongle (C-X5A57, FCC-ID JNZ212456) and the
'remote' wheel (E-VC12, FCC-ID JNZEVC12).

This device is very similar to the PS3 equivilant (E-X5D12, FCC-ID
JNZEX5D12), and apparently used the same USB dongle as the Pro2800 (FCC-ID
JNZCUBE35) and Cordless Precision controllers (FCC-ID JNZCX50002).

On attaching dongle to the PC (Linux or WinXP) it just shows a flashing
LED, which I believe means attempting to sync. Pressing the 'connect'
button on the dongle does not change this behaviour, there is no 'connect'
button on the wheel.



>From a hardware point of view this system uses the nRF24L01 transciever,
and scoping out the SPI bus on the wheel end it would appear that the
micro is searching for a partner. It never sees RX'ed traffic and
continuously:
--
Clears Status, FIFO etc
Sets RF channel (to a auto incrementing value)
Enables interrupt on RX
Sets RX address (to alternating values)
Sets TX address (to alternating values)
--


It would seems to me that either:
1) the device needs some for of software 'init' command.
2) the device needs to be continuously polled for data.

Since I'm rather in-experienced in Linux HID stuff I'm hoping that someone
here can give me a hit on what to try next.

Cheers,
Mungewell
(aka Simon)



------=_20100709114131_69263
Content-Type: text/plain; name="wii_hidraw0.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="wii_hidraw0.txt"

^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B
^@<FF><FF>^B

------=_20100709114131_69263
Content-Type: text/plain; name="wii_hidrd.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="wii_hidrd.txt"

Usage Page (Desktop),               ; Generic desktop controls (01h)
Usage (Joystik),                    ; Joystik (04h, application collection)
Collection (Application),
    Collection (Logical),
        Report Count (1),
        Report Size (10),
        Logical Minimum (0),
        Logical Maximum (1023),
        Physical Minimum (0),
        Physical Maximum (1023),
        Usage (X),                  ; X (30h, dynamic value)
        Input (Variable),
        Usage Page (FF00h),         ; FF00h, vendor-defined
        Report Count (2),
        Report Size (1),
        Logical Maximum (1),
        Physical Maximum (1),
        Usage (01h),
        Input (Variable),
        Report Count (11),
        Usage Minimum (01h),
        Usage Maximum (0Bh),
        Usage Page (Button),        ; Button (09h)
        Input (Variable),
        Usage Page (FF00h),         ; FF00h, vendor-defined
        Report Count (1),
        Report Size (1),
        Usage (02h),
        Input (Variable),
        Usage Page (Desktop),       ; Generic desktop controls (01h)
        Report Size (8),
        Logical Maximum (255),
        Physical Maximum (255),
        Usage (Y),                  ; Y (31h, dynamic value)
        Usage (Z),                  ; Z (32h, dynamic value)
        Report Count (2),
        Input (Variable),
    End Collection,
    Collection (Logical),
        Usage Page (FF00h),         ; FF00h, vendor-defined
        Report Count (7),
        Usage (03h),
        Output (Variable),
    End Collection,
    Usage (FFFFh),
    Report Count (8),
    Feature (Variable),
End Collection
------=_20100709114131_69263
Content-Type: text/plain; name="wii_hidrd_dump.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="wii_hidrd_dump.txt"

 05 01 09 04 A1 01 A1 02 95 01 75 0A 15 00 26 FF
 03 35 00 46 FF 03 09 30 81 02 06 00 FF 95 02 75
 01 25 01 45 01 09 01 81 02 95 0B 19 01 29 0B 05
 09 81 02 06 00 FF 95 01 75 01 09 02 81 02 05 01
 75 08 26 FF 00 46 FF 00 09 31 09 32 95 02 81 02
 C0 A1 02 06 00 FF 95 07 09 03 91 02 C0 0A FF FF
 95 08 B1 02 C0
------=_20100709114131_69263
Content-Type: text/plain; name="wii_test_libhid.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="wii_test_libhid.txt"

device identification of HIDInterface 003/002[0]:
  dev_handle:    0x08c811a0
  device:        0x08c8d500
  location:      003/002
  product:       Wii Cordless Wheel
parse tree of HIDInterface 003/002[0]:
  path: 0x00010004.0x00000000.0x00010030; type: 0x80
  path: 0x00010004.0x00000000.0xff000001; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0x00000000; type: 0x80
  path: 0x00010004.0x00000000.0xff000002; type: 0x80
  path: 0x00010004.0x00000000.0x00010031; type: 0x80
  path: 0x00010004.0x00000000.0x00010032; type: 0x80
  path: 0x00010004.0x00000000.0xff000003; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0x00000000.0x00000000; type: 0x90
  path: 0x00010004.0xff00ffff; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
  path: 0x00010004.0x00000000; type: 0xb0
------=_20100709114131_69263
Content-Type: text/plain; name="logitech_wii_wheel.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="logitech_wii_wheel.txt"

Bus 003 Device 002: ID 046d:c29c Logitech, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc29c 
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 Wii Cordless Wheel
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
    MaxPower               56mA
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
          wDescriptorLength     101
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0007  1x 7 bytes
        bInterval               2
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0007  1x 7 bytes
        bInterval               2
Device Status:     0x0000
  (Bus Powered)
------=_20100709114131_69263--


