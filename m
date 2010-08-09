From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: XPad driver, unrecognized controller
Date: Mon, 09 Aug 2010 18:10:29 +0200
Message-ID: <1281370229.20805.54.camel@lovely.krouter>
References: <AANLkTinNW2ZJZt9w19q4_eSdhTUHFHrPeOetwcSH1Gta@mail.gmail.com>
	 <1281357500.20805.41.camel@lovely.krouter>
	 <AANLkTikJSzLE7=rXs3O4uya4VE0FMZ4TP-NymsQAh0D=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34401 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0HIQH2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Aug 2010 12:07:28 -0400
Received: by bwz3 with SMTP id 3so1330164bwz.19
        for <linux-input@vger.kernel.org>; Mon, 09 Aug 2010 09:07:27 -0700 (PDT)
In-Reply-To: <AANLkTikJSzLE7=rXs3O4uya4VE0FMZ4TP-NymsQAh0D=@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: tsuraan <tsuraan@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 2010-08-09 at 08:54 -0500, tsuraan wrote:
> > What does lsusb -v tells about your device?
> 
> It gives me this:
> 
> Bus 002 Device 023: ID 045e:028f Microsoft Corp. Xbox360 Wireless Controller
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass       255 Vendor Specific Subclass
>   bDeviceProtocol       255 Vendor Specific Protocol
>   bMaxPacketSize0         8
>   idVendor           0x045e Microsoft Corp.
>   idProduct          0x028f Xbox360 Wireless Controller
>   bcdDevice            1.05
>   iManufacturer           0
>   iProduct                0
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           18
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass     93
>       bInterfaceProtocol    255
>       iInterface              0
> Device Status:     0x0000
>   (Bus Powered)

I was told that you can't use a Xbox360 Wireless Controller with a
Play&Charge cable plugged into your host. You need the Wireless
Receiver.

thanks,
 chf

