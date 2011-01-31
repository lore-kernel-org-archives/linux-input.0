From: Bastien Nocera <hadess@hadess.net>
Subject: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Mon, 31 Jan 2011 14:54:47 +0000
Message-ID: <1296485689.7756.9.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Xa5dnNN1sQ92xu5EhYcQ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36690 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1AaOyw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 09:54:52 -0500
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.45])
	by relay1-d.mail.gandi.net (Postfix) with ESMTP id B45A92552FB
	for <linux-input@vger.kernel.org>; Mon, 31 Jan 2011 15:54:50 +0100 (CET)
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.45]) (amavisd-new, port 10024)
	with ESMTP id ZgulSwrJ5QFH for <linux-input@vger.kernel.org>;
	Mon, 31 Jan 2011 15:54:49 +0100 (CET)
Received: from [192.168.1.108] (cpc6-glfd5-2-0-cust126.6-2.cable.virginmedia.com [80.4.117.127])
	(Authenticated sender: hadess@hadess.net)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 24A562552FD
	for <linux-input@vger.kernel.org>; Mon, 31 Jan 2011 15:54:48 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--=-Xa5dnNN1sQ92xu5EhYcQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

Built into my Lenovo A700 all-in-one is a touchscreen. lsusb says:
$ lsusb | grep -i touch
Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems 

The touchscreen "works", in that tapping it will create a click event,
though that click event is always in the top left of the screen.

Full output of lsusb -vvv attached.

Anybody with ideas as to what I'm missing, or whether that particular
device is supported?

Using kernel 2.6.38-rc2-git5 (from Fedora rawhide).

Cheers

--=-Xa5dnNN1sQ92xu5EhYcQ
Content-Disposition: attachment; filename="touchscreen-lsusb.txt"
Content-Type: text/plain; name="touchscreen-lsusb.txt"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit


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
        bInterval               3
Device Status:     0x0001
  Self Powered

--=-Xa5dnNN1sQ92xu5EhYcQ--

