From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: add support for Data Modul
 easyMaxTouch
Date: Thu, 16 May 2013 13:30:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305161330260.31787@pobox.suse.cz>
References: <1368697781-6487-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab3EPLaq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 May 2013 07:30:46 -0400
In-Reply-To: <1368697781-6487-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-input@vger.kernel.org

On Thu, 16 May 2013, Steffen Trumtrar wrote:

> Add vendor ID for Data Modul and their easyMaxTouch device.
> The device has to be configured to multitouch mode prior to using this driver.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/hid/hid-ids.h        | 3 +++
>  drivers/hid/hid-multitouch.c | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 38535c9..0b4598a 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -248,6 +248,9 @@
>  #define USB_DEVICE_ID_CYPRESS_BARCODE_4	0xed81
>  #define USB_DEVICE_ID_CYPRESS_TRUETOUCH	0xc001
>  
> +#define USB_VENDOR_ID_DATA_MODUL	0x7374
> +#define USB_VENDOR_ID_DATA_MODUL_EASYMAXTOUCH	0x1201
> +
>  #define USB_VENDOR_ID_DEALEXTREAME	0x10c5
>  #define USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701	0x819a
>  
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index dc3ae5c..1bea657 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1108,6 +1108,11 @@ static const struct hid_device_id mt_devices[] = {
>  		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
>  			USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
>  
> +	/* Data Modul easyMaxTouch */
> +	{ .driver_data = MT_CLS_DEFAULT,
> +		MT_USB_DEVICE(USB_VENDOR_ID_DATA_MODUL,
> +			USB_VENDOR_ID_DATA_MODUL_EASYMAXTOUCH) },
> +
>  	/* eGalax devices (resistive) */
>  	{ .driver_data = MT_CLS_EGALAX,
>  		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,

Applied, thanks Steffen.

-- 
Jiri Kosina
SUSE Labs
