From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore
 list
Date: Fri, 8 Sep 2017 15:13:46 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709081512370.3285@jbgna.fhfr.qr>
References: <1504614196-25107-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755523AbdIHNNs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Sep 2017 09:13:48 -0400
In-Reply-To: <1504614196-25107-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vincent Palatin <vpalatin@chromium.org>

On Tue, 5 Sep 2017, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Two Jabra speakerphone devices were added to the ignore list in 2013
> because, at the time, the device HID interfaces didn't work well with
> kernel usbhid driver, and could reportedly cause volume key event
> storm.

Also apparently there was an userspace application that made use of these 
keys, and required the usbhid driver to be unbound from them.

How come this is not the case any more?

Adding original quirk entry author (Vincent) to CC (and keeping the rest 
of message below for reference).

> 
> See the original commit:
> Commit 31b9779cb292 ("HID: ignore Jabra speakerphones HID interface")
> 
> Testing the devices today reveals no such problems, and the
> blacklisting can safely be removed.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
>  drivers/hid/hid-core.c | 2 --
>  drivers/hid/hid-ids.h  | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9bc9116..b49d7c4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2697,8 +2697,6 @@ static const struct hid_device_id hid_ignore_list[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1006) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_GN9350E) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b397a14..12b9179 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -578,8 +578,6 @@
>  #define USB_DEVICE_ID_ITE8595		0x8595
>  
>  #define USB_VENDOR_ID_JABRA		0x0b0e
> -#define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
> -#define USB_DEVICE_ID_JABRA_SPEAK_510	0x0420
>  #define USB_DEVICE_ID_JABRA_GN9350E	0x9350
>  
>  #define USB_VENDOR_ID_JESS		0x0c45
> -- 
> 2.7.4
> 

-- 
Jiri Kosina
SUSE Labs

