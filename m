From: Kees Cook <keescook@chromium.org>
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Wed, 16 Apr 2014 16:04:40 -0700
Message-ID: <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42491 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbaDPXEl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2014 19:04:41 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so13123951obc.38
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2014 16:04:41 -0700 (PDT)
In-Reply-To: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

On Wed, Apr 16, 2014 at 3:35 PM,  <simon@mungewell.org> wrote:
> Hi Kees and all,
> I've got a report from an end user that their Logitech F710 wireless
> gamepad is not functioning correctly. This device has a switch to select
> between 'X' mode (X-Pad, works OK) and 'D' mode (HID using hid-logitech,
> doesn't work).
>
> After some discussion off list, Elias and I think that this is related to
> checking the report descriptor (attached).
>
> Kernel log shows
> --
> [15961.607787] usb 5-5: USB disconnect, device number 12
> [15962.235373] usb 5-5: new full-speed USB device number 13 using ohci-pci
> [15962.412284] usb 5-5: New USB device found, idVendor=046d, idProduct=c219
> [15962.412287] usb 5-5: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [15962.412289] usb 5-5: Product: Logitech Cordless RumblePad 2
> [15962.412291] usb 5-5: Manufacturer: Logitech
> [15962.424343] input: Logitech Logitech Cordless RumblePad 2 as
> /devices/pci0000:00/0000:00:13.0/usb5/5-5/5-5:1.0/input/input26
> [15962.424477] logitech 0003:046D:C219.0012: input,hidraw5: USB HID v1.11
> Gamepad
> [Logitech Logitech Cordless RumblePad 2] on usb-0000:00:13.0-5/input0
> [15962.424480] logitech 0003:046D:C219.0012: missing HID_OUTPUT_REPORT 0
> --
>
> Last message comes from here (I believe):
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-lgff.c?id=refs/tags/v3.15-rc1#n137
>
> Can anyone see what might be wrong with the report, to cause this code to
> spit out an error?

I don't know the lg driver very well, but it looks like it's expecting
a single report ID (0), but the device is showing two report IDs: 1
and 2. So, from the perspective of the driver, this is correct: it
wouldn't know how to deal with things since it is only expecting
Report ID 0. It seems like the driver needs to be updated for this
different device.

-Kees

-- 
Kees Cook
Chrome OS Security
