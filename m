From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: joydev bug with playstation USB adapter
Date: Sat, 2 Feb 2013 01:11:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302020107580.26996@pobox.suse.cz>
References: <20130202004320.408ac7c3@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50534 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab3BBALY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Feb 2013 19:11:24 -0500
In-Reply-To: <20130202004320.408ac7c3@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: renato <rennabh@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

On Sat, 2 Feb 2013, renato wrote:

> Hi, I have two playstation USB adpters, one of them with this [1] "lsusb
> -v" (the other I don't have access to ATM) and they both give me the
> following buggy behaviour: the range of the sticks is limited - i.e.
> value 32767 is reached when the stick is only about half-way through
> its run, leaving a big dead zone after that. This happens on all axes
> and recalibrating with "jscal -c" didn't help.
> 
> I'm on an up-to-date Archlinux, kernel 3.7.5, and have tried various
> kernel versions down to 3.0.1 with same results.
> 
> Is there any other info I can provide?

[ adding Anssi to CC ]

Hi renato,

there is a driver for this particular device (hid-pl), written by Anssi 
Hannula.

So before I'll be digging into this any further -- Anssi, does this 
limited range sound familiar to you when it comes to 0x0810/0x001 device?

Thanks.

> 
> thanks,
> renato
> 
> 
> [1]
> Bus 002 Device 002: ID 0810:0001 Personal Communication Systems, Inc.
> Dual PSX A daptor
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0810 Personal Communication Systems, Inc.
>   idProduct          0x0001 Dual PSX Adaptor
>   bcdDevice            1.06
>   iManufacturer           0
>   iProduct                2 Twin USB Joystick
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           34
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode           33 US
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     202
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
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
> Device Status:     0x0000
>   (Bus Powered)
> 

-- 
Jiri Kosina
SUSE Labs
