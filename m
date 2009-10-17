From: Anthony DeRobertis <anthony@derobert.net>
Subject: Unitech MS-180 barcode scanner vs. i-Buddy (bug 13411)
Date: Sat, 17 Oct 2009 02:44:25 -0400
Message-ID: <20091017064424.GA5893@derobert.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from maxwell.derobert.net ([72.83.229.69]:55508 "EHLO
	Maxwell.derobert.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZJQHKp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2009 03:10:45 -0400
Received: from feynman.home ([192.168.65.14])
	by Maxwell.derobert.net with esmtp (Exim 3.36 #1 (Debian))
	id 1Mz31c-0004d0-00
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2009 02:44:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[I'm not subscribed; please cc]

I'm being affected by the HID blacklist on USB_DEVICE_ID_TENX_IBUDDY1 as
described in 13411. My barcode scanner is a USB HID device, and works
completely once I remove that blacklist entry.

Please let me know if there is anything I can do to help get this bug
fixed.

Below is lsusb -v on the device (with the blacklist entry removed, if
that matters):

Bus 001 Device 071: ID 1130:0001 Tenx Technology, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1130 Tenx Technology, Inc.
  idProduct          0x0001 
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                2 USB-TMU-V3
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
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
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      78
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
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

-- 
BOFH excuse #211:

Lightning strikes.
