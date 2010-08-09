From: tsuraan <tsuraan@gmail.com>
Subject: Re: XPad driver, unrecognized controller
Date: Mon, 9 Aug 2010 08:54:18 -0500
Message-ID: <AANLkTikJSzLE7=rXs3O4uya4VE0FMZ4TP-NymsQAh0D=@mail.gmail.com>
References: <AANLkTinNW2ZJZt9w19q4_eSdhTUHFHrPeOetwcSH1Gta@mail.gmail.com>
	<1281357500.20805.41.camel@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47863 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab0HINyU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Aug 2010 09:54:20 -0400
Received: by qwh6 with SMTP id 6so7247637qwh.19
        for <linux-input@vger.kernel.org>; Mon, 09 Aug 2010 06:54:19 -0700 (PDT)
In-Reply-To: <1281357500.20805.41.camel@lovely.krouter>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input@vger.kernel.org

> What does lsusb -v tells about your device?

It gives me this:

Bus 002 Device 023: ID 045e:028f Microsoft Corp. Xbox360 Wireless Controller
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x028f Xbox360 Wireless Controller
  bcdDevice            1.05
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           18
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
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass     93
      bInterfaceProtocol    255
      iInterface              0
Device Status:     0x0000
  (Bus Powered)
