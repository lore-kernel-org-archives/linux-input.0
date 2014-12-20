From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Sat, 20 Dec 2014 20:56:30 +0100
Message-ID: <CAMsZVf-Gt2Y1h5u+vwozqmtC59UfZ2_tH4DPXGiP3sD4V97LuQ@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
	<CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
	<CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
	<CAMsZVf_K1ji75K3CcqGjED01Lppbk8gFSw0ADB-QOG=wVYiF_g@mail.gmail.com>
	<CANq1E4Qw3_0M7BCgDJTX0WGHU+CnFdnuASX0JfEK-Btkc=7Rsg@mail.gmail.com>
	<CAMsZVf-r6GvPOUEUye9wcLrT-g8SXkk5b3HKBDDTyHjAj38aKQ@mail.gmail.com>
	<CANq1E4Rw7q9QpA1UYsjuu9umB_AE2qE6JhNKQ9e8W3xp+m_2EA@mail.gmail.com>
	<CAMsZVf-2_eFKoqgO1+bEB4ziA1e9-z4rYviy_r9ksjmAUAe5Sg@mail.gmail.com>
	<m71jo1$i0n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:42877 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaLTT4b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Dec 2014 14:56:31 -0500
Received: by mail-qa0-f47.google.com with SMTP id n4so1933632qaq.34
        for <linux-input@vger.kernel.org>; Sat, 20 Dec 2014 11:56:30 -0800 (PST)
In-Reply-To: <m71jo1$i0n$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: RH <r@hirner.at>, David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

> Did you already find someone with a US keyboard?

Yes as mentioned in thread it does not seem possible to write a
hwdb-rule that works for both US and non-US keyboard. Also it is a
general problem that affects other keyboards than Corsair, again see
previous mails in this thread.

David, it would be great if you could get your patch ready so this one
could be closed. If you don't have the time to do it, perhaps my
original patch could be considered again. I fully aggree that it is a
hack but it does solve the problem with little risk of bad side
effects. It can always be removed later we you have a proper fix.

Regards,

Fredrik


On Fri, Dec 19, 2014 at 5:28 PM, RH <r@hirner.at> wrote:
> Hello,
>
> I experience the same issue with my new keyboard:
> *Corsair Raptor K30 (German version)*
>
> The issue can be fixed/worked around with this rule in hwdb:
>
> ---------------
> #keyboard:name:*Corsair*:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
> keyboard:usb:v1B1Cp1B0A*
>  KEYBOARD_KEY_70031=reserved
> ---------------
>
> So you think the US version won't work with this anymore? I guess they
> will send both scancodes, too.
>
> This is the output of lsusb:
> ---------------
> Bus 004 Device 008: ID 1b1c:1b0a Corsair
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1b1c Corsair
>   idProduct          0x1b0a
>   bcdDevice            1.03
>   iManufacturer           1 Corsair
>   iProduct                2 Corsair K30A Gaming Keyboard
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           84
>     bNumInterfaces          3
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              500mA
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
>           bcdHID               1.11
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
>         bInterval               1
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
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      25
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
>         wMaxPacketSize     0x0004  1x 4 bytes
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
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      37
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
>         wMaxPacketSize     0x000f  1x 15 bytes
>         bInterval               1
> Device Status:     0x0000
>   (Bus Powered)
> ---------------
>
> Did you already find someone with a US keyboard? Shall I write in the
> corsair forums or to the support to find out whether US keyboards have
> the same product IDs? If this is not the case, we could safely use vendor/
> product IDs for the workaround.
>
> I'd really like to submit working hwdb lines to the udev database to save
> other users from having these troubles.
>
> Also, do you know why
>
> Greetings,
> RH
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
