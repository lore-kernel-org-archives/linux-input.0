From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Lenovo ThinkPad USB Keyboard: delayed release of Shift/Ctrl/Alt
Date: Wed, 14 Jul 2010 21:54:28 +0300
Message-ID: <20100714185428.GA6884@shutemov.name>
References: <20100712090847.GB25456@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shutemov.name ([188.40.19.243]:56207 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab0GNSy3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 14:54:29 -0400
Content-Disposition: inline
In-Reply-To: <20100712090847.GB25456@shutemov.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Mon, Jul 12, 2010 at 12:08:47PM +0300, Kirill A. Shutemov wrote:
> I've bought Thinkpad USB Keyboard (P/N 55Y9086) last week.
> 
> Unfortunately, it has very annoying issue. When you type fast enough
> and you want to type one capitalized (Shift + a letter) you'll get two or
> even three capitalized letters (e.g. WOrd instead of Word). The same
> problem with Alt and Ctrl keys.
> 
> Windows users also complains about the issue. So it looks like a hardware
> (or firmware?) issue.
> 
> Is it possible to workaround the issue in the driver or I have to return
> the keyboard to the store?

Any ideas?

> lsusb -vvv output:
> 
> Bus 001 Device 009: ID 17ef:6009 Lenovo 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         8
>   idVendor           0x17ef Lenovo
>   idProduct          0x6009 
>   bcdDevice            1.22
>   iManufacturer           1 Lite-On Technology Corp.
>   iProduct                2 ThinkPad USB Keyboard with TrackPoint
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           59
>     bNumInterfaces          2
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
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      1 Keyboard
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      65
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
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
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
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     185
>          Report Descriptors: 
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
> Device Status:     0x0000
>   (Bus Powered)
> 
> -- 
>  Kirill A. Shutemov
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
 Kirill A. Shutemov
