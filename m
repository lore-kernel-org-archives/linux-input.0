From: xavier hervy <xavier.hervy@bluebottle.com>
Subject: Re: Support Touchscreen SoundGraph
Date: Fri, 10 Oct 2008 12:08:38 +0100
Message-ID: <1223636918.6353.1.camel@xavier-desktop>
References: <1220632423.6207.26.camel@xavier-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mi1.bluebottle.com ([206.188.25.14]:53143 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYJJLIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2008 07:08:43 -0400
Received: from fe2.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m9AB8gjF017714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Fri, 10 Oct 2008 11:08:43 GMT
Received: from [192.168.1.152] (82-69-180-249.dsl.in-addr.zen.co.uk [82.69.180.249])
	(authenticated bits=0)
	by fe2.bluebottle.com (8.13.1/8.13.1) with ESMTP id m9AB8elW031617
	for <linux-input@vger.kernel.org>; Fri, 10 Oct 2008 11:08:41 GMT
In-Reply-To: <1220632423.6207.26.camel@xavier-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Fri, 2008-09-05 at 17:33 +0100, xavier hervy wrote:
> Hi,
> I am trying to make my touch screen work (Zalman HD160XT Plus) but I
> could not find any suitable driver for it.
> The Touch screen is an USB Device which consist of :
> - a touch screen
> - a knob
> - few buttons in a front panel
> - A remote control
> lsusb -v
> 
> Bus 004 Device 004: ID 15c2:0034 SoundGraph Inc. 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         8
>   idVendor           0x15c2 SoundGraph Inc.
>   idProduct          0x0034 
>   bcdDevice            0.12
>   iManufacturer           0 
>   iProduct                0 
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           59
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0 
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.01
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     121
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
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      50
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
> I am currently running Ubuntu 7.10
> Two input device are created when plugged:
> lrwxrwxrwx 1 root root   9 2008-09-04 22:56 usb-15c2_0034-event-mouse
> -> ../event1
> lrwxrwxrwx 1 root root   9 2008-09-04 22:56 usb-15c2_0034-mouse
> -> ../mouse1
> 
> As well as  /dev/usb/hiddev0
> 
> The input device does give me anything usefull but the hiddev0 device
> provide me some infos:
> A packet seems to be 64 Bytes  (in opposite two 2 * 8 Bytes according to
> lsusb)
> The knob and buttons seem quiet easily to decode:
> Example knob -: (the 5th bytes is equal to 1)
> [03 00 cd ff 01 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 12 00 00 00] 
> [04 00 cd ff ee ff ff ff] 
> 
> Example knob -: (the 13th bytes is equal to 1)
> [03 00 cd ff 00 00 00 00] 
> [04 00 cd ff 01 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 00 00 00 00] 
> [04 00 cd ff 12 00 00 00] 
> [04 00 cd ff ee ff ff ff] 
> For the front panel button the 29th bytes change (I suppose the remote
> work the same way but I didn't try for a while)
> 
> For the touch screen it self, I did not manage to understand fully what
> is been sent but my packet look like
> [03 00 cd ff dd ff ff ff ... 
> with the 5th byte value changing according to Y (or X) axe and  the 6th,
> 7th and 9th to FF
> 
> Does anybody know a driver capable to support this protocol.
> If not, I am willing to write the drive for it but I will need a lot of
> help too as I never wrote any driver before.
> How does it work when the same device is used like a keyboard and a
> touch screen ?
> 
> Why the wMaxPacketSize is set at 8 Bytes when the size seems to be 64 ?
> 
> Where should I start ?
> 
> Regards,
> 
> Xavier

Anybody is willing to give me a hint where to start ?

Xavier

