From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/6] HID: Add a stable method for retrieving the client
 MAC address of a HID device
Date: Fri, 31 Jan 2014 14:10:38 -0500
Message-ID: <CAN+gG=EVcVmQ8rr2YtoapfftSHaDeYnSu5rCnuZjL=S-v1xU4Q@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:41464 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaTKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:10:42 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so3795743lbh.32
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:10:41 -0800 (PST)
In-Reply-To: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Hi Frank,

just a quick review:

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Currently there is no reliable way for a device module or hidraw application to
> retrieve the client MAC address of the associated wireless device.  This series
> of patches adds a stable way of retrieving this information.

Well, if I look at the uevent of a Bluetooth mouse I have:

$ cat /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-2/3-2\:1.0/bluetooth/hci0/hci0\:43/0005\:046D\:B00D.001F/uevent
DRIVER=hid-generic
HID_ID=0005:0000046D:0000B00D
HID_NAME=Ultrathin Touch Mouse
HID_PHYS=00:10:60:ea:df:ae
HID_UNIQ=00:1f:20:96:33:47
MODALIAS=hid:b0005g0001v0000046Dp0000B00D

I would say that HID_UNIQ is the client MAC address set by hidp, no?
So you don't need to duplicate the info by adding a new field in
hid_device.

I also have few general comments on the patches, I'll comment in them.

Cheers,
Benjamin

>
> The first patch adds a new client_addr member to the hid_device struct.  This
> member, when populated, will be guaranteed to contain the client hardware
> address of a connected wireless device.
>
> The second patch modifies HIDP to populate the client_addr member of the
> hid_device struct with the client MAC address of the connected wireless device.
>
> The third patch adds support for setting the client_addr value in a uhid
> device.
>
> The final patches add support for retrieving the client_addr value as a string
> in the hidraw interface via a new ioctl called HIDIOCGRAWCLIENTADDR.  The
> hidraw documentation and example program are also updated.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
