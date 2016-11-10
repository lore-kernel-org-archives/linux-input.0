From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device
 defects
Date: Thu, 10 Nov 2016 09:40:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611100940020.29400@cbobk.fhfr.pm>
References: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53423 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752287AbcKJIkw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 03:40:52 -0500
In-Reply-To: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Thu, 10 Nov 2016, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> Rename i2c_hid_blacklist as i2c_hid_quirks.
> Make the syntax changes of macro & for_loop slightly.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> ---
>  drivers/hid/hid-ids.h         |  5 ++++
>  drivers/hid/i2c-hid/i2c-hid.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 6cfb5ca..787afdf 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1033,6 +1033,11 @@
>  #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
>  #define USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET	0x0502
>  
> +#define	USB_VENDOR_ID_WEIDA		0x2575
> +#define	USB_DEVICE_ID_WEIDA_8756	0x8756

The patch looks good to me now, thanks for incorporating all the feedback. 
My only remaining question -- why is 0x8756 being added into hid-ids.h, 
but then not actually used for defining a quirk?

-- 
Jiri Kosina
SUSE Labs

