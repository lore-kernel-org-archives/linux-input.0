From: Hanno Zulla <abos@hanno.de>
Subject: No right clicks or multitouch with touchpad "ITE Tech. Inc. ITE
 Device(8910)" ID 04f3:074a
Date: Mon, 31 Jul 2017 13:26:25 +0200
Message-ID: <5108a54d-e271-0f0e-8042-80c128fc7de6@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoot.epublica.de ([78.46.103.157]:60129 "EHLO zoot.epublica.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdGaLcT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 07:32:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zoot.epublica.de (Postfix) with ESMTP id B047C1841699
        for <linux-input@vger.kernel.org>; Mon, 31 Jul 2017 13:26:26 +0200 (CEST)
Received: from zoot.epublica.de ([127.0.0.1])
        by localhost (zoot.epublica.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7SyOrzYqKxrM for <linux-input@vger.kernel.org>;
        Mon, 31 Jul 2017 13:26:25 +0200 (CEST)
Received: from [10.1.0.41] (unknown [31.19.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by zoot.epublica.de (Postfix) with ESMTPSA id A2B5218403D8
        for <linux-input@vger.kernel.org>; Mon, 31 Jul 2017 13:26:25 +0200 (CEST)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

the integrated touchpad mentioned below is built into my Medion Akoya
S2218 / MD99590 based on a Z3735F "Bay Trail" chipset. This device is
not a 2-in-1, but a traditional laptop with a non-detachable keyboard:
http://www.aldi.medion.com/md99590/sued/

This is a very nice laptop, but the touchpad is missing functionality
with 4.13-rc3: There are only left clicks, no right click and no
multitouch gestures.

Please advice on how I can help to debug or improve this.

Thanks.


The integrated keyboard and mousepad identifies as

I: Bus=0003 Vendor=04f3 Product=074a Version=0111
N: Name="ITE Tech. Inc. ITE Device(8910)"
P: Phys=usb-0000:00:14.0-1.1/input0
S:
Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:04F3:074A.0001/input/input2
U: Uniq=
H: Handlers=sysrq kbd event2 leds
B: PROP=0
B: EV=12001f
B: KEY=3007f 0 0 483ffff17aff32d bf54444600000000 3 130c130b17c007
ffbf7bfad941dfff febeffdfffefffff fffffffffffffffe
B: REL=40
B: ABS=100000000
B: MSC=10
B: LED=1f

I: Bus=0003 Vendor=04f3 Product=074a Version=0111
N: Name="ITE Tech. Inc. ITE Device(8910)"
P: Phys=usb-0000:00:14.0-1.1/input1
S:
Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:04F3:074A.0002/input/input3
U: Uniq=
H: Handlers=mouse0 event3
B: PROP=0
B: EV=17
B: KEY=3f0000 0 0 0 0
B: REL=ff
B: MSC=10

Bus 001 Device 003: ID 04f3:074a Elan Microelectronics Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x04f3 Elan Microelectronics Corp.
  idProduct          0x074a
  bcdDevice            0.03
  iManufacturer           1 ITE Tech. Inc.
  iProduct                2 ITE Device(8910)
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           66
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
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
          wDescriptorLength     163
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
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              1 ITE Tech. Inc.
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     100
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
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered
