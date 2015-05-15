From: Manuel Reithuber <manuel@reithuber.net>
Subject: bcm5974: support for early 2015 MacBook Pro
Date: Fri, 15 May 2015 19:26:38 +0200
Message-ID: <55562C4E.1090505@reithuber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx201.easyname.com ([212.232.28.122]:53381 "EHLO
	mx201.easyname.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbEOR7D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 13:59:03 -0400
Received: from chello062178151029.7.14.vie.surfer.at ([62.178.151.29] helo=[192.168.1.136])
	by mx.easyname.eu with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <manuel@reithuber.net>)
	id 1YtJNj-0000CA-20
	for linux-input@vger.kernel.org; Fri, 15 May 2015 19:26:45 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm trying to get bcm5974 to work with my new MacBook Pro (early 2015).
Apple seems to be using new USB IDs for this one (05ac:0273) and on 
vanilla Linux 4.0.1. those aren't supported properly.

The keyboard's FN key didn't work (as well as none of the special 
function keys like volume, brightness).
The touchpad only supported movement and left clicks (no scrolling or 
other multitouch stuff)

After adding the new USB IDs to the kernel sources, the keyboard works 
as expected but the trackpad stopped working completely (i simply copied 
the WELLSPRING8 config and replaced the USB IDs).

Here's what I've found out so far:

- according to the output of lsusb (see below), the correct endpoint is 0x83
- when using TYPE3, usbmon captures only bt_data-conforming packets (8 
bytes long with the last 4 bytes being 0). For each packet the driver 
reports "bcm5974: bad trackpad package, length: 8".
- TYPE1 and 2 fail in _wellspring_mode()'s "/* read configuration */". 
usb_control_mode returns EPIPE.


I'm using a self-compiled 4.0.1 kernel on Debian Jessie.
I'd appreciate any tips on how to proceed from where I am.

Thanks in advance,
Manuel.

PS.: Here's the output of `lsusb -v -d 05ac:0273`:

Bus 001 Device 003: ID 05ac:0273 Apple, Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x05ac Apple, Inc.
   idProduct          0x0273
   bcdDevice            6.22
   iManufacturer           1 Apple Inc.
   iProduct                2 Apple Internal Keyboard / Trackpad
   iSerial                 3 D3H5103DY91FTV3AR6PS
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          141
     bNumInterfaces          5
     bConfigurationValue     1
     iConfiguration          4 Keyboard / Trackpad
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              500mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              5 Device Management
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      27
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
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               8
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      1 Keyboard
       iInterface              6 Keyboard / Boot
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode           13 International (ISO)
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength     182
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
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               8
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      2 Mouse
       iInterface              7 Trackpad / Boot
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength     110
           Report Descriptor: (length is 110)
             Item(Global): Usage Page, data= [ 0x01 ] 1
                             Generic Desktop Controls
             Item(Local ): Usage, data= [ 0x02 ] 2
                             Mouse
             Item(Main  ): Collection, data= [ 0x01 ] 1
                             Application
             Item(Local ): Usage, data= [ 0x01 ] 1
                             Pointer
             Item(Main  ): Collection, data= [ 0x00 ] 0
                             Physical
             Item(Global): Usage Page, data= [ 0x09 ] 9
                             Buttons
             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
                             Button 1 (Primary)
             Item(Local ): Usage Maximum, data= [ 0x03 ] 3
                             Button 3 (Tertiary)
             Item(Global): Logical Minimum, data= [ 0x00 ] 0
             Item(Global): Logical Maximum, data= [ 0x01 ] 1
             Item(Global): Report ID, data= [ 0x02 ] 2
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
             Item(Global): Usage Page, data= [ 0x01 ] 1
                             Generic Desktop Controls
             Item(Local ): Usage, data= [ 0x30 ] 48
                             Direction-X
             Item(Local ): Usage, data= [ 0x31 ] 49
                             Direction-Y
             Item(Global): Logical Minimum, data= [ 0x81 ] 129
             Item(Global): Logical Maximum, data= [ 0x7f ] 127
             Item(Global): Report Size, data= [ 0x08 ] 8
             Item(Global): Report Count, data= [ 0x02 ] 2
             Item(Main  ): Input, data= [ 0x06 ] 6
                             Data Variable Relative No_Wrap Linear
                             Preferred_State No_Null_Position 
Non_Volatile Bitfield
             Item(Global): Report Count, data= [ 0x04 ] 4
             Item(Global): Report Size, data= [ 0x08 ] 8
             Item(Main  ): Input, data= [ 0x01 ] 1
                             Constant Array Absolute No_Wrap Linear
                             Preferred_State No_Null_Position 
Non_Volatile Bitfield
             Item(Main  ): End Collection, data=none
             Item(Main  ): End Collection, data=none
             Item(Global): Usage Page, data= [ 0x0d ] 13
                             Digitizer
             Item(Local ): Usage, data= [ 0x05 ] 5
                             Touch Pad
             Item(Main  ): Collection, data= [ 0x01 ] 1
                             Application
             Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                             (null)
             Item(Local ): Usage, data= [ 0x0c ] 12
                             (null)
             Item(Global): Logical Minimum, data= [ 0x00 ] 0
             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
             Item(Global): Report Size, data= [ 0x08 ] 8
             Item(Global): Report Count, data= [ 0x10 ] 16
             Item(Global): Report ID, data= [ 0x3f ] 63
             Item(Main  ): Input, data= [ 0x22 ] 34
                             Data Variable Absolute No_Wrap Linear
                             No_Preferred_State No_Null_Position 
Non_Volatile Bitfield
             Item(Main  ): End Collection, data=none
             Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                             (null)
             Item(Local ): Usage, data= [ 0x0c ] 12
                             (null)
             Item(Main  ): Collection, data= [ 0x01 ] 1
                             Application
             Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                             (null)
             Item(Local ): Usage, data= [ 0x0c ] 12
                             (null)
             Item(Global): Logical Minimum, data= [ 0x00 ] 0
             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
             Item(Global): Report ID, data= [ 0x44 ] 68
             Item(Global): Report Size, data= [ 0x08 ] 8
             Item(Global): Report Count, data= [ 0xdf 0x03 ] 991
             Item(Main  ): Input, data= [ 0x00 ] 0
                             Data Array Absolute No_Wrap Linear
                             Preferred_State No_Null_Position 
Non_Volatile Bitfield
             Item(Main  ): End Collection, data=none
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              8 Actuator
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      34
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x84  EP 4 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               8
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               2
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        4
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              9 Accelerometer
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      27
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x85  EP 5 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               2
Device Status:     0x0000
   (Bus Powered)
