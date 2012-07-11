From: Jonathan BISSON <bissonjonathan@gmail.com>
Subject: Linux Kernel: Microsoft Digital Media Keyboard 3000
Date: Wed, 11 Jul 2012 11:56:51 +0200
Message-ID: <4FFD4DE3.8010305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070108060904020509030902"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61554 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847Ab2GKJyW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jul 2012 05:54:22 -0400
Received: by eekb15 with SMTP id b15so162919eek.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jul 2012 02:54:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dtor@mail.ru, jkosina@suse.cz

This is a multi-part message in MIME format.
--------------070108060904020509030902
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi,


I've a problem with my Microsoft Digital Media Keyboard 3000.

One part of the keyboard is seen as a joystick by the hid layer of the
kernel (creating a js0 node with udev…)

The lsusb output is in the attachements.


as you can see inside it, the keyboard declares two interfaces:
bNumInterfaces          2


One with :
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard

which seems ok

and one with:

      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None

The device is cut in two by event system :
pci-0000:00:1d.7-usb-0:1.2:1.0-event-kbd
pci-0000:00:1d.7-usb-0:1.2:1.1-event-kbd

but this last one is also provided to :
pci-0000:00:1d.7-usb-0:1.2:1.1-kbd -> ../js0

The signals sent on it are nothing like a joystick (some garbage
sometimes, but nothing that seems coherent).

Special keys seems to be sent only to the second input event device. But
I managed to get them working by remapping them :
/usr/lib/udev/keymap input/event11 0xc022d back 0xc022e forward 0xc01b6
camera 0xc01a2 f19

the only one which is not working is the "Aero" key, giving a scancode
of 0x1A2, I can see it in the /sys/kernel/debug/hid/…/event but it
doesn't seems to be declared as a valid scancode judging by what I see
in include/linux/input.h of a 3.4 kernel.

Do you think it can be possible to avoid the kernel seeing this as a
joystick (joydev module) and to add this 0x1A2 scan code ?


If you need any further information, I may provide them to you.


Thanks for your work on the kernel.



--------------070108060904020509030902
Content-Type: text/plain; charset=UTF-8;
 name="lsusb.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="lsusb.txt"


Bus 002 Device 009: ID 045e:0730 Microsoft Corp. Digital Media Keyboard 3000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x0730 Digital Media Keyboard 3000
  bcdDevice            2.00
  iManufacturer           1 Microsoft
  iProduct                2 Microsoft® Digital Media Keyboard 3000
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
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
          wDescriptorLength      60
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
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
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
          wDescriptorLength     106
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

--------------070108060904020509030902--
