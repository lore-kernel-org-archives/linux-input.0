From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Patch] Add Apple wireless keyboard to the quirk list
Date: Wed, 4 Jul 2012 15:48:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207041548000.17304@pobox.suse.cz>
References: <CACo8zOc24xxmfT4F2nfrMreL28OBXw+HF6=or4vVVMZv90MYDw@mail.gmail.com> <alpine.LNX.2.00.1206051136140.5478@pobox.suse.cz> <CACo8zOd77ZJNNzmwNWTJGM4H9U3F5Je90ADcO+PiK=jqESQixQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38371 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2GDNsX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jul 2012 09:48:23 -0400
In-Reply-To: <CACo8zOd77ZJNNzmwNWTJGM4H9U3F5Je90ADcO+PiK=jqESQixQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Jeremy Fitzhardinge <jeremy@goop.org>

On Wed, 4 Jul 2012, Daniel Nicoletti wrote:

> Ok sorry for the delay (too much stuff),
> I'm used to have commit access on the stuff I contribute so
> I didn't know this git format-patch thing, which someone pointed out to me.
> Should I use git send-email too?
> 
> Thanks.
> 
> >From cc0225ce44f037f7ce9ecb876e65b5e8079d5665 Mon Sep 17 00:00:00 2001
> From: Daniel Nicoletti <dantti12@gmail.com>
> Date: Wed, 4 Jul 2012 10:20:31 -0300
> Subject: [PATCH 1/1] hid-input: Add Apple's Wireless keyboard
>  (USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI), to the quirk
>  list since it report wrong feature type and wrong
>  percentage range.
> 
> 
> Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
> ---
>  drivers/hid/hid-input.c |    3 +++
>  1 file changed, 3 insertions(+)
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

Daniel,

the patch has been whitespace damaged. I have fixed it now and applied, 
but please fix your workflow (likely e-mail client) for further 
submissions in this respect.

-- 
Jiri Kosina
SUSE Labs
