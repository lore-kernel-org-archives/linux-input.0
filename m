From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom - Add support for DTU-1141
Date: Thu, 23 Apr 2015 10:07:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231007160.3695@pobox.suse.cz>
References: <1429221674-3348-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756711AbbDWIHf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 04:07:35 -0400
In-Reply-To: <1429221674-3348-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, Aaron Skomra <aaron.skomra@wacom.com>

On Thu, 16 Apr 2015, Aaron Skomra wrote:

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 69c7df7..1959b18 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2919,6 +2919,9 @@ static const struct wacom_features wacom_features_0x32F =
>  	{ "Wacom DTU1031X", 22472, 12728, 511, 0,
>  	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>  	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
> +static const struct wacom_features wacom_features_0x336 =
> +	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
> +	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x57 =
>  	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
>  	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> @@ -3272,6 +3275,7 @@ const struct hid_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0x32F) },
>  	{ USB_DEVICE_WACOM(0x333) },
>  	{ USB_DEVICE_WACOM(0x335) },
> +	{ USB_DEVICE_WACOM(0x336) },
>  	{ USB_DEVICE_WACOM(0x4001) },
>  	{ USB_DEVICE_WACOM(0x4004) },
>  	{ USB_DEVICE_WACOM(0x5000) },

Applied to for-4.2/wacom.

-- 
Jiri Kosina
SUSE Labs
