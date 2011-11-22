From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: joydev: support for Saitek PS1000 gamepad
Date: Tue, 22 Nov 2011 11:28:32 +0100
Message-ID: <20111122102832.GA22152@v36691.1blu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:46324 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab1KVKfh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 05:35:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by v36691.1blu.de (Postfix) with ESMTP id B8A6E89500DB
	for <linux-input@vger.kernel.org>; Tue, 22 Nov 2011 11:28:49 +0100 (CET)
Received: from v36691.1blu.de ([127.0.0.1])
	by localhost (v36691.1blu.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDOMteQm9-rf for <linux-input@vger.kernel.org>;
	Tue, 22 Nov 2011 11:28:43 +0100 (CET)
Received: from v36691.1blu.de (v36691.1blu.de [89.202.1.191])
	by v36691.1blu.de (Postfix) with ESMTPSA id 0E77D89500BB
	for <linux-input@vger.kernel.org>; Tue, 22 Nov 2011 11:28:43 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

I was trying to contact who I think is the maintainer of the joydev
module (vojtech@suze.cz), but had no success. Apologies if this list is
not the right target audience, I would appreciate any hints about who is
currently maintaining the module.
It's also possible, that the issue is not related to joydev module
itself. usb-hid could also be involved.

I'm pasting the contents of the mail I had sent:

---------------------------------------------------------------------------

In the linux kernel documentation you requested information on what
devices this driver currently can't make complete use of.
I have a Saitek PS1000 Gamepad (USB) that has 5 axis and at least 10 buttons,
probably more. (One of the axis is also wired to buttons in the windows
driver.)
The joydev driver does not fully support this device:

Joystick (Jess Technology Co., Ltd. PS1000 Dual AnaloguePad) has 6 axes and 0 buttons. Driver version is 2.1.0.
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0  2:     0  3:     0  4:     0  5:-32767

All the axes work but the sixth does not exist on the device. However,
no button is detected which makes it kind of unusable.

If you need more info or need me to compile, test, debug stuff, just ask.
I also attached the lsusb -vv output.

---------------------------------------------------------------------------

So if anyone has an idea how to deal with the issue, please contact me.
I'm willing to debug this if someone tells me where to dive in or how
the usb input stuff works.


Andreas Hübner

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb.txt"

Bus 002 Device 002: ID 06a3:0621 Saitek PLC 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x06a3 Saitek PLC
  idProduct          0x0621 
  bcdDevice            1.00
  iManufacturer           1 Jess Technology Co., Ltd.
  iProduct                2 PS1000 Dual AnaloguePad
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              200mA
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
          wDescriptorLength     137
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
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)


--tThc/1wpZn/ma/RB--
