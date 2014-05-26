From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: PenMount 6000 usb touch controller
Date: Mon, 26 May 2014 15:18:48 +0200
Message-ID: <CAH9NwWe4issOhAzi7KYPRn9KvhjCOyo6coojcUGsmb6_rRZ-ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:45428 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaEZNTJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 09:19:09 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so8112146wes.13
        for <linux-input@vger.kernel.org>; Mon, 26 May 2014 06:19:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi.


I am using the following usb touch controller:

lsusb -s 6:2 -vvv

Bus 006 Device 002: ID 14e1:6000 Dialogue Technology Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x14e1 Dialogue Technology Corp.
  idProduct          0x6000
  bcdDevice           a4.b4
  iManufacturer           1 DIALOGUE INC
  iProduct                2 PenMount USB
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 full speed
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
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
      iInterface              3 EndPoint1 Interrupt Pipe
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.01
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      76
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
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)


I can successfully use this device as a hid-generic usb mouse, but I need to get
BTN_TOUCH events. What would be the best way to support this device? Shall
I extend usbtouchscreen driver?

thanks
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
