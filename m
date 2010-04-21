From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add support for the Wacom Intuos 4 wireless
Date: Wed, 21 Apr 2010 15:53:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004211553220.7579@pobox.suse.cz>
References: <1271857920.1960.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33456 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab0DUNxz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 09:53:55 -0400
In-Reply-To: <1271857920.1960.5.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Wed, 21 Apr 2010, Bastien Nocera wrote:

> Same command set as the Graphire Bluetooth tablet.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/hid-ids.h   |    1 +
>  drivers/hid/hid-wacom.c |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 66a2ca8..21f360f 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -456,6 +456,7 @@
>  
>  #define USB_VENDOR_ID_WACOM		0x056a
>  #define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH	0x81
> +#define USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH	0xbd
>  
>  #define USB_VENDOR_ID_WISEGROUP		0x0925
>  #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 8d3b46f..91dbae3 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -256,7 +256,7 @@ static void wacom_remove(struct hid_device *hdev)
>  
>  static const struct hid_device_id wacom_devices[] = {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
> -
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, wacom_devices);

Hi Bastien,

has this particular patch been tested?

How about addition of this VID/PID combination to hid_blacklist[]?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
