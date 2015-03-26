From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: proposal for deletion of drivers/hid/hid-ids.h
Date: Thu, 26 Mar 2015 10:06:27 -0400
Message-ID: <CAN+gG=EJUwfzvNeud76RNa-hMQrttbNm03uKYJhqfTeJxjjF5Q@mail.gmail.com>
References: <1427370288.2075.19.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34585 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbCZOG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 10:06:28 -0400
Received: by yhch68 with SMTP id h68so26334664yhc.1
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2015 07:06:27 -0700 (PDT)
In-Reply-To: <1427370288.2075.19.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, pavel@ucw.cz

On Thu, Mar 26, 2015 at 7:44 AM, Oliver Neukum <oneukum@suse.de> wrote:
> Hi,
>
> I would like to kill drivers/hid/hid-ids.h and replace it
> with numerical IDs in the files using it.
>
> There are two reasons for that.
>
> 1. It is a layering violation. There should not be a private
> data base for USB IDs in HID.

Technically, this DB is not only for USB devices. We also have
Bluetooth and I2C devices here.

>
> 2. It serves no purpose and adds work. Anyone who adds a quirk
> or a special case for devices needs to operate on the numbers,
> as those are what he gets from the descriptors. Looking up or
> adding a symbolic name for a device is just more work without
> a benefit. These numbers have no intrinsic meaning beyond
> being unique and it rarely matters (and should not matter)
> for which vendor a particular fix is intended.

I disagree. This list might not be useful for the
drivers/hid/usbhid/hid-quirks.c by itself in most cases.
However, we mainly rely on this list to add the device in
hid_have_special_driver and hid_ignore in hid-core and in the
submodule that should handle it.

Many times, already having the VID/PID registered in hid-ids.h saved
some time when debugging and adding a subdriver for a special device
because if the VID/PID is already in hid-ids.h, that means that
someone already dealt with it, and it gives us a way to clean it when
the quirk was not appropriate. For instance, many multitouch devices
were added before the creation of hid-multitouch and were registered
with the quirk MULTI_INPUT.

Cheers,
Benjamin

>
> In the rare cases it does matter when it does matter searching
> the official list of USB IDs is less work.
>
> So let's kill this utterly useless step of indirection.
>
>         Regards
>                 Oliver
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
