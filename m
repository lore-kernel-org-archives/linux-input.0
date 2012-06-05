From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Patch] Add Apple wireless keyboard to the quirk list
Date: Tue, 5 Jun 2012 11:39:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206051136140.5478@pobox.suse.cz>
References: <CACo8zOc24xxmfT4F2nfrMreL28OBXw+HF6=or4vVVMZv90MYDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44178 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536Ab2FEJjT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jun 2012 05:39:19 -0400
In-Reply-To: <CACo8zOc24xxmfT4F2nfrMreL28OBXw+HF6=or4vVVMZv90MYDw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Jeremy Fitzhardinge <jeremy@goop.org>

On Mon, 28 May 2012, Daniel Nicoletti wrote:

> some time ago I sent the patch to probe the battery status of devices,
> but Jeremy improved it to go to hid-input and created a quirk list,
> at that time I was quite busy with other projects that I didn't had the
> chance to put my model on that list, so, now that the patch got upstream
> I'm having I/O errors when reading that...
> 
> I'd also suggest to include all the other keyboard models between his and
> mine, but I don't know if doing this without testing is ok.

Daniel,

I'd prefer adding those only after verification that the battery status is 
reported on those devices in compatible way as well.

> I've tested and with this, it works just fine, thanks.

Thanks for the patch. It's however missing your Signed-off-by: line, could 
you please resend the patch including it, so that I could apply it?

Thanks.

> 
> Daniel.
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 132b001..33d88d1 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -301,6 +301,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>                                USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
>           HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> +                              USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
> +         HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
>         {}
>  };

-- 
Jiri Kosina
SUSE Labs
