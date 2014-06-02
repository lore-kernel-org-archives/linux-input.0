From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: PenMount 6000 usb touch controller
Date: Mon, 2 Jun 2014 08:08:12 +0200
Message-ID: <CAH9NwWfMg6-HwZmjicOZEwCmfJqwu7iFAUbW0GSkda-g_ekL1A@mail.gmail.com>
References: <CAH9NwWe4issOhAzi7KYPRn9KvhjCOyo6coojcUGsmb6_rRZ-ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:53007 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbaFBGIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jun 2014 02:08:34 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so4492864wgh.2
        for <linux-input@vger.kernel.org>; Sun, 01 Jun 2014 23:08:32 -0700 (PDT)
In-Reply-To: <CAH9NwWe4issOhAzi7KYPRn9KvhjCOyo6coojcUGsmb6_rRZ-ww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

2014-05-26 15:18 GMT+02:00 Christian Gmeiner <christian.gmeiner@gmail.com>:
> Hi.
>
>
> I am using the following usb touch controller:
>
> lsusb -s 6:2 -vvv
>
> Bus 006 Device 002: ID 14e1:6000 Dialogue Technology Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x14e1 Dialogue Technology Corp.
>   idProduct          0x6000
>   bcdDevice           a4.b4
>   iManufacturer           1 DIALOGUE INC
>   iProduct                2 PenMount USB
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           41
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          4 full speed
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              3 EndPoint1 Interrupt Pipe
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.01
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      76
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0005  1x 5 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0005  1x 5 bytes
>         bInterval               1
> Device Status:     0x0000
>   (Bus Powered)
>
>
> I can successfully use this device as a hid-generic usb mouse, but I need to get
> BTN_TOUCH events. What would be the best way to support this device? Shall
> I extend usbtouchscreen driver?

ping

--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
