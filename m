From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Linux joystick driver bugreport
Date: Mon, 27 Jun 2011 12:38:16 -0700
Message-ID: <20110627193814.GB13829@core.coreip.homeip.net>
References: <20110625011015.6f397f6f@Giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34349 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab1F0TjE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 15:39:04 -0400
Received: by pwj7 with SMTP id 7so3141922pwj.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 12:39:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110625011015.6f397f6f@Giskard>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cabrera <binchmod777@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>

Hi Pablo,

On Sat, Jun 25, 2011 at 01:10:15AM -0300, Pablo Cabrera wrote:
> Hello Linux maintainer, I want to report a bug.
> 
> Sorry if my English is not good, I'm not native speaker.
> 
> The joystick driver incorrectly maps axes for some devices.
> 
> I tried two different sticks on different computers with very similar
> results. In both cases, the driver detects more axes which each
> joystick has, and does not map the 'arrow buttons' correctly.
> For device 0079:0011 DragonRise Inc. arrows buttons are mapped to axes 3
> and 4.
> For device 0e8f: 0002 GreenAsia Motion Inc. arrows buttons are mapped
> to axes 2 and 3

Jiri Kosina (CCed) normally takes care of USB devices...

> 
> Note: joysticks I've tried only have the 4 'arrow buttons' and 10
> 'standard buttons'. However I am sure that (in the case of DragonRise
> Inc.) there is another 'version' of the joystick wich does have analog
> sticks. Perhaps this is causing the problem.
> 
> All tests were done in 32bit Debian testing.
> The tests for DragonRise were done under linux 2.6.38
> The tests for GreenAsia were done under linux 2.6.32
> The lines preceded by ## are my comments.
> 
> ----------------------------------------
> steamfactory@steamfactory:~$ jstest --event /dev/input/js0
> Driver version is 2.1.0.
> Joystick (USB Gamepad ) has 6 axes (X, Y, Z, Rx, Ry, (null))
> and 10 buttons (Trigger, ThumbBtn, ThumbBtn2, TopBtn, TopBtn2,
> PinkieBtn, BaseBtn, BaseBtn2, BaseBtn3, BaseBtn4).
> Testing ... (interrupt to exit)
> Event: type 129, time -115044, number 0, value 0
> Event: type 129, time -115044, number 1, value 0
> Event: type 129, time -115044, number 2, value 0
> Event: type 129, time -115044, number 3, value 0
> Event: type 129, time -115044, number 4, value 0
> Event: type 129, time -115044, number 5, value 0
> Event: type 129, time -115044, number 6, value 0
> Event: type 129, time -115044, number 7, value 0
> Event: type 129, time -115044, number 8, value 0
> Event: type 129, time -115044, number 9, value 0
> Event: type 130, time -115044, number 0, value -32767
> Event: type 130, time -115044, number 1, value 0
> Event: type 130, time -115044, number 2, value 0
> Event: type 130, time -115044, number 3, value 0
> Event: type 130, time -115044, number 4, value 0
> Event: type 130, time -115044, number 5, value 32767
> 
> ## Press left arrow ##
> Event: type 2, time -109668, number 3, value -32767
> 
> ## Release left arrow ##
> Event: type 2, time -99148, number 3, value 0
> 
> ## Press right arrow ##
> Event: type 2, time -92548, number 3, value 32767
> 
> ## Release right arrow ##
> Event: type 2, time -88032, number 3, value 0
> 
> ## Press up arrow ##
> Event: type 2, time -85680, number 4, value -32767
> 
> ## Release up arrow ##
> Event: type 2, time -71304, number 4, value 0
> 
> ## Press down arrow ##
> Event: type 2, time -67688, number 4, value 32767
> 
> ## Release down arrow ##
> Event: type 2, time -66552, number 4, value 0
> ----------------------------------------
> 
> Device info (from 'lsusb -v' as root )
> 
> Bus 005 Device 002: ID 0079:0011 DragonRise Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0079 DragonRise Inc.
>   idProduct          0x0011
>   bcdDevice            1.06
>   iManufacturer           0
>   iProduct                2 USB Gamepad
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
>     MaxPower              100mA
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
>           wDescriptorLength     101
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
> ----------------------------------------
> pablo@Giskard:~$ jstest --event /dev/input/js0
> Driver version is 2.1.0.
> Joystick (USB Joystick      USB Joystick     ) has 6 axes (X, Y, Z, Rx,
> (null), (null)) and 10 buttons (Trigger, ThumbBtn, ThumbBtn2, TopBtn,
> TopBtn2, PinkieBtn, BaseBtn, BaseBtn2, BaseBtn3, BaseBtn4). Testing ...
> (interrupt to exit) Event: type 129, time -219972, number 0, value 0
> Event: type 129, time -219972, number 1, value 0
> Event: type 129, time -219972, number 2, value 0
> Event: type 129, time -219972, number 3, value 0
> Event: type 129, time -219972, number 4, value 0
> Event: type 129, time -219972, number 5, value 0
> Event: type 129, time -219972, number 6, value 0
> Event: type 129, time -219972, number 7, value 0
> Event: type 129, time -219972, number 8, value 0
> Event: type 129, time -219972, number 9, value 0
> Event: type 130, time -219972, number 0, value 0
> Event: type 130, time -219972, number 1, value 0
> Event: type 130, time -219972, number 2, value 0
> Event: type 130, time -219972, number 3, value 0
> Event: type 130, time -219972, number 4, value 32767
> Event: type 130, time -219972, number 5, value 32767
> 
> ## Press left arrow ##
> Event: type 2, time -212312, number 2, value -32767
> 
> ## Release left arrow ##
> Event: type 2, time -212104, number 2, value 0
> 
> ## Press right arrow ##
> Event: type 2, time -210216, number 2, value 32767
> 
> ## Release right arrow ##
> Event: type 2, time -210088, number 2, value 0
> 
> ## Press up arrow ##
> Event: type 2, time -208904, number 3, value -32767
> 
> ## Release up arrow ##
> Event: type 2, time -208776, number 3, value 0
> 
> ## Press down arrow ##
> Event: type 2, time -207624, number 3, value 32767
> 
> ## Release down arrow ##
> Event: type 2, time -207544, number 3, value 0
> 
> ----------------------------------------
> Device info (from 'lsusb -v' as root)
> 
> Bus 001 Device 002: ID 0e8f:0002 GreenAsia Inc. 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         8
>   idVendor           0x0e8f GreenAsia Inc.
>   idProduct          0x0002 
>   bcdDevice            1.07
>   iManufacturer           1 USB Joystick     
>   iProduct                2 USB Joystick     
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
>           wDescriptorLength     101
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
>         bInterval              17
> cannot read device status, Broken pipe (32)
> ----------------------------------------
> 
> I hope that my report will be useful. 

-- 
Dmitry
