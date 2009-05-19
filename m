From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 19 May 2009 22:57:37 +0200
Message-ID: <4A131D41.3030305@gmail.com>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:59626 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZESU6N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 16:58:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so23365fkq.5
        for <linux-input@vger.kernel.org>; Tue, 19 May 2009 13:58:13 -0700 (PDT)
In-Reply-To: <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 05/19/2009 07:13 AM, Jeremy Huddleston wrote:
> I'm sending this to you since you're the most recent maintainer listed
> in hid_apple.c ... please let me know if I should look somewhere else...
> 
> I've found a weird issue using hid_apple in a recent linux-2.6 git. 
> Pressing 3 arrow keys at once causes a problem whereby the third press
> and the first release are interpreted as Fn instead of the actual key.
> 
> From evtest.c (http://people.freedesktop.org/~whot/evtest.c):
> 
> # press right
> Event: time 1242708001.840682, type 4 (Misc), code 4 (ScanCode), value
> 7004f
> Event: time 1242708001.840700, type 1 (Key), code 106 (Right), value 1
> Event: time 1242708001.840704, -------------- Report Sync ------------
> Event: time 1242708002.089283, type 1 (Key), code 106 (Right), value 2
> ... REPEAT ...
> Event: time 1242708002.489293, type 1 (Key), code 106 (Right), value 2
> Event: time 1242708002.489302, -------------- Report Sync ------------
> 
> press down
> Event: time 1242708002.496684, type 4 (Misc), code 4 (ScanCode), value
> 70051
> Event: time 1242708002.496699, type 1 (Key), code 108 (Down), value 1
> Event: time 1242708002.496704, -------------- Report Sync ------------
> Event: time 1242708002.745939, type 1 (Key), code 108 (Down), value 2
> ... REPEAT
> Event: time 1242708003.545937, type 1 (Key), code 108 (Down), value 2
> Event: time 1242708003.545945, -------------- Report Sync ------------
> 
> press left
> Event: time 1242708003.568680, type 1 (Key), code 464 (?), value 1
> Event: time 1242708003.568690, -------------- Report Sync ------------
> Event: time 1242708003.815938, type 1 (Key), code 464 (?), value 2
> ... REPEAT
> Event: time 1242708004.582630, type 1 (Key), code 464 (?), value 2
> Event: time 1242708004.582639, -------------- Report Sync ------------
> 
> release right  (somehow this release is causing the Fn release and right
> never releases)
> Event: time 1242708004.592685, type 1 (Key), code 102 (Home), value 1
> Event: time 1242708004.592697, type 1 (Key), code 464 (?), value 0
> Event: time 1242708004.592699, -------------- Report Sync ------------
> 
> release down
> Event: time 1242708009.040671, type 4 (Misc), code 4 (ScanCode), value
> 70051
> Event: time 1242708009.040685, type 1 (Key), code 108 (Down), value 0
> Event: time 1242708009.040689, -------------- Report Sync ------------
> 
> release left
> Event: time 1242708013.568663, type 1 (Key), code 102 (Home), value 0
> Event: time 1242708013.568671, -------------- Report Sync ------------

Didn't you crop some 'type 4 (Misc)' lines from that output? It looks
like the kbd controller doesn't emit hid events for the releases. It all
looks like the controller got pretty crazy after pressing those 3
buttons at a time. Jiri, any ideas here?

I don't understand 'code 464' lines as well, how they did get there? I
would have suspected the autorepeat code if there hadn't been a 'value
1' entry. But this look like we get a mess from the keyboard.

What it is expected to output when you press fn+arrow?

> ---
> 
> Bus 002 Device 003: ID 05ac:020e Apple, Inc. Internal Keyboard/Trackpad
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x05ac Apple, Inc.
>   idProduct          0x020e Internal Keyboard/Trackpad
>   bcdDevice            0.28
>   iManufacturer           1 Apple Computer
>   iProduct                2 Apple Internal Keyboard/Trackpad
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength        21504
>     bNumInterfaces          3
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower               40mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      1 Keyboard
>       iInterface              5 Keyboard
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      73
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0800  2x 0 bytes
>         bInterval              10
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              6 Touchpad
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      35
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
>         wMaxPacketSize     0x2000  1x 0 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              7 Consumer
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      20
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0100  1x 256 bytes
>         bInterval              10
> Device Status:     0x0000
>   (Bus Powered)
> 

