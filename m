From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 15:34:12 +0100
Message-ID: <20100118143412.GA9831@mac.home>
References: <1263824065.20565.2730.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:48138 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0AROmI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 09:42:08 -0500
Received: from mac.home (port-92-206-67-99.dynamic.qsc.de [92.206.67.99])
	by eazy.amigager.de (Postfix) with ESMTPA id EC18AF48052
	for <linux-input@vger.kernel.org>; Mon, 18 Jan 2010 15:34:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263824065.20565.2730.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Tino Keitel <tino.keitel@gmx.de>

On Mon, Jan 18, 2010 at 14:14:25 +0000, Bastien Nocera wrote:

[...]

> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1540,6 +1540,8 @@ static const struct hid_device_id hid_ignore_list[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM2)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },

My impression is that this would break existing lirc setups that use
the macmini lirc userspace driver which relies on a HID device, right?

Regards,
Tino
