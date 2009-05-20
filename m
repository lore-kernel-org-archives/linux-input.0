From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: A tablet driver question
Date: Wed, 20 May 2009 18:24:36 +0200
Message-ID: <4A142EC4.70202@gmail.com>
References: <7f83a3ba0905192149k338f3932u25e2d0f1b2d70e2f@mail.gmail.com>	 <20090520051222.GA11638@kroah.com>	 <7f83a3ba0905192316u4753fbefi37257a7e3d20f3ef@mail.gmail.com>	 <4A13AEEC.7010707@gmail.com> <7f83a3ba0905200858l7f78e5c7s675fea46b4ceb1c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:50425 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbZETQYf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 12:24:35 -0400
Received: by bwz22 with SMTP id 22so515925bwz.37
        for <linux-input@vger.kernel.org>; Wed, 20 May 2009 09:24:35 -0700 (PDT)
In-Reply-To: <7f83a3ba0905200858l7f78e5c7s675fea46b4ceb1c5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Hunt <srhlefty@gmail.com>
Cc: Greg KH <greg@kroah.com>, devel@linuxdriverproject.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 05/20/2009 05:58 PM, Steven Hunt wrote:
> On Wed, May 20, 2009 at 12:19 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
>> On 05/20/2009 08:16 AM, Steven Hunt wrote:
>>> On Tue, May 19, 2009 at 10:12 PM, Greg KH <greg@kroah.com> wrote:
>>>> On Tue, May 19, 2009 at 09:49:22PM -0700, Steven Hunt wrote:
>>>>> I bought myself a super-cheap USB drawing tablet, and (shocker)
>>>>> there's no linux driver that supports it.
>>>>
>>>> What device is it?
>>>
>>> On the product packaging, it says "Hanvon Drawing Tablet"; however
>>> dmesg reports:
>>> HanWang co. HW Micro Drawing Tablet
>>> with a vendor ID of 0B57, and a product ID of 8019.
>>>
>>> Full output from 2.6.28-11-generic at device connect:
>>> [ 1673.776066] usb 2-2: new low speed USB device using uhci_hcd and address 5
>>> [ 1673.961620] usb 2-2: configuration #1 chosen from 1 choice
>>> [ 1673.982901] generic-usb 0003:0B57:8019.0005: hiddev96,hidraw1: USB
>>> HID v1.00 Device [HanWang co. HW Micro Drawing Tablet] on
>>> usb-0000:00:1d.0-2/input0
>>
>> Hmm, It looks like it is a standard HID device and got registered in the
>> input layer. Could you attach lsusb -v of that device and
>> /proc/bus/input/devices?

Actually I missed there is no "input" at 1673.982901, so the input is
not claimed. You still can read the events through hidraw (or via
deprecated hiddev).

Jiri, any ideas? Looks like there are no useful applications. A report
dump will tell us whether we can handle it through standard path (with
forced connect) or it has to be handled by hidraw, am I correct?

Thanks.

> Here's lsusb -v :
> ---------------------------------------------------------------------------------------------------------
> $ lsusb -v
> Bus 002 Device 002: ID 0b57:8019 Beijing HanwangTechnology Co., Ltd
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0b57 Beijing HanwangTechnology Co., Ltd
>   idProduct          0x8019
>   bcdDevice            1.11
>   iManufacturer           1 HanWang co.
>   iProduct                2 HW Micro Drawing Tablet
>   iSerial                 3 V1.0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           34
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower               50mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      41
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
> Device Status:     0x0003
>   Self Powered
>   Remote Wakeup Enabled
> ---------------------------------------------------------------------------------------------------------
> Here's all of /proc/bus/input/devices, because I couldn't figure out
> which part was specific to the tablet:
> ---------------------------------------------------------------------------------------------------------
> $ cat /proc/bus/input/devices
> I: Bus=0019 Vendor=0000 Product=0002 Version=0000
> N: Name="Power Button (FF)"
> P: Phys=LNXPWRBN/button/input0
> S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> U: Uniq=
> H: Handlers=kbd event0
> B: EV=3
> B: KEY=100000 0 0 0
> 
> I: Bus=0019 Vendor=0000 Product=0005 Version=0000
> N: Name="Lid Switch"
> P: Phys=PNP0C0D/button/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
> U: Uniq=
> H: Handlers=event1
> B: EV=21
> B: SW=1
> 
> I: Bus=0019 Vendor=0000 Product=0003 Version=0000
> N: Name="Sleep Button (CM)"
> P: Phys=PNP0C0E/button/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> U: Uniq=
> H: Handlers=kbd event2
> B: EV=3
> B: KEY=4000 0 0 0 0
> 
> I: Bus=0017 Vendor=0001 Product=0001 Version=0100
> N: Name="Macintosh mouse button emulation"
> P: Phys=
> S: Sysfs=/devices/virtual/input/input3
> U: Uniq=
> H: Handlers=mouse0 event3
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
> 
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> S: Sysfs=/devices/platform/i8042/serio0/input/input4
> U: Uniq=
> H: Handlers=kbd event4
> B: EV=120013
> B: KEY=4 2000000 3803078 f800d001 feffffdf ffefffff ffffffff fffffffe
> B: MSC=10
> B: LED=7
> 
> I: Bus=0003 Vendor=046d Product=c019 Version=0111
> N: Name="Logitech USB Optical Mouse"
> P: Phys=usb-0000:00:1d.2-1/input0
> S: Sysfs=/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input5
> U: Uniq=
> H: Handlers=mouse1 event5
> B: EV=17
> B: KEY=ff0000 0 0 0 0 0 0 0 0
> B: REL=143
> B: MSC=10
> 
> I: Bus=0010 Vendor=001f Product=0001 Version=0100
> N: Name="PC Speaker"
> P: Phys=isa0061/input0
> S: Sysfs=/devices/platform/pcspkr/input/input6
> U: Uniq=
> H: Handlers=kbd event6
> B: EV=40001
> B: SND=6
> 
> I: Bus=0019 Vendor=0000 Product=0006 Version=0000
> N: Name="Video Bus"
> P: Phys=/video/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:02/input/input7
> U: Uniq=
> H: Handlers=kbd event7
> B: EV=3
> B: KEY=3f000b 0 0 0 0 0 0 0
> 
> I: Bus=0019 Vendor=17aa Product=5054 Version=4101
> N: Name="ThinkPad Extra Buttons"
> P: Phys=thinkpad_acpi/input0
> S: Sysfs=/devices/virtual/input/input8
> U: Uniq=
> H: Handlers=kbd event8
> B: EV=33
> B: KEY=18840000 0 2 100000 0 0 0 1101b 2005 0 1104000 e0000 0 0 0
> B: MSC=10
> B: SW=8
> 
> I: Bus=0011 Vendor=0002 Product=000a Version=0000
> N: Name="TPPS/2 IBM TrackPoint"
> P: Phys=isa0060/serio1/input0
> S: Sysfs=/devices/platform/i8042/serio1/input/input9
> U: Uniq=
> H: Handlers=mouse2 event9
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
