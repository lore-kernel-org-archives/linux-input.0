From: Silvan Jegen <me@sillymon.ch>
Subject: Getting a functional driver for Mad Catz Fightstick TE 2 (Xbox One
 version)
Date: Tue, 8 Mar 2016 22:45:12 +0100
Message-ID: <20160308214512.ls7d4rs4jrs6paiy@myarchbang>
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.mykolab.com ([95.128.36.1]:46707 "EHLO
	mx-out03.mykolab.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750903AbcCHVpR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 16:45:17 -0500
Received: from mx05.mykolab.com (mx05.mykolab.com [10.20.7.161])
	by mx-out03.mykolab.com (Postfix) with ESMTPS id 87360260D4
	for <linux-input@vger.kernel.org>; Tue,  8 Mar 2016 22:45:13 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heyho

(I was asked on kernelnewbies to send this here instead)

I bought a Mad Catz Fightstick TE2 for Xbox One because I wanted to play
some fighting games on Linux. I chose this stick because it has gotten good
reviews and I assumed that the Kernel driver should work because there are
already drivers for Xbox One controllers in drivers/input/joystick/xpad.c.

It turns out that the driver does not work and dmesg just shows

[12293.077720] usb 1-1.2.1: new full-speed USB device number 9 using ehci-pci

when plugging it in. Simply adding the line

{ 0x0738, 0x4a01, "Mad Catz FightStick TE 2", 0, XTYPE_XBOXONE },

(where the two Hex values are VENDOR_ID and PRODUCT_ID) to xpad_device[]
in xpad.c does not help either (which I naively hoped it would).

I realized that the stick does not conform to the USB HID interface
after looking more closely at the lsusb -v output (pasted below).


Bus 001 Device 007: ID 0738:4a01 Mad Catz, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0        64
  idVendor           0x0738 Mad Catz, Inc.
  idProduct          0x4a01 
  bcdDevice            0.34
  iManufacturer           1 MADCATZ
  iProduct                2 FIGHTSTICK
  iSerial                 3 0000BCA2F0E774D2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              200mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass     71 
      bInterfaceProtocol    208 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               4
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled


The Fightstick seems to use a "Vendor Specific Class" and not the HID
interface.

The device is relatively simple having only about 10 buttons and a digital
stick and the Xbox One driver for Windows works for it so xpad.c should
be able to deal with it I assume. Worst case I would have to reverse-
engineer the USB protocol it uses on my Window installation though I
hope that will not be necessary given that the much more sophisticated
Xbox One controller works on Linux already.

What I would like to know is if it is possible to use the xpad.c
infrastructure in this case and maybe some pointers on where to go from
here (I have looked at [0],[1] and [2] but want to check if somebody
has dealt with a similar case already and can give me a hint). Thanks!


Cheers,

Silvan

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/input?id=refs/tags/v4.5-rc7
[1] https://lwn.net/Kernel/LDD3/
[2] http://matthias.vallentin.net/blog/2007/04/writing-a-linux-kernel-driver-for-an-unknown-usb-device/

