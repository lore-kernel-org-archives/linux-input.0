From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Fix for the multitouch panel of the Asus T91MT
Date: Tue, 17 Aug 2010 21:37:27 -0400
Message-ID: <1282095447.20340.26.camel@mini>
References: <20100716094611.C9A089520B@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37166 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0HRBhi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 21:37:38 -0400
In-Reply-To: <20100716094611.C9A089520B@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suze.cz
Cc: Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, chatty@enac.fr

On Fri, 2010-07-16 at 11:46 +0200, Stephane Chatty wrote:
> Fixed bug in management of the multitouch panel of the Asus T91MT: it was
> erroneously added to the ignore list instead of the black list.
> 
> Signed-off-by: Stephane Chatty <chatty@enac.fr>
> 
> 
> diff -rupN a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> --- a/drivers/hid/hid-core.c	2010-07-05 05:22:50.000000000 +0200
> +++ b/drivers/hid/hid-core.c	2010-07-16 13:38:24.266220496 +0200
> @@ -1280,6 +1280,7 @@ static const struct hid_device_id hid_bl
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
> @@ -1553,7 +1554,6 @@ static const struct hid_device_id hid_ig
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_LCM)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_LCM2)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },

Jiri,

What's the status of this patch? (Note that this is the second time I'm
asking as I haven't received any response yet :).

Thanks,

-- Chase

