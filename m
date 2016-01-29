From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: quirks: Add no_init_reports for AKAI midi
 controller
Date: Fri, 29 Jan 2016 14:40:46 +0100
Message-ID: <20160129134045.GA30237@mail.corp.redhat.com>
References: <alpine.LNX.2.00.1601272230070.21446@cbobk.fhfr.p>
 <1454074687-17073-1-git-send-email-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59416 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbcA2Nku (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2016 08:40:50 -0500
Content-Disposition: inline
In-Reply-To: <1454074687-17073-1-git-send-email-shorne@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Jan 29 2016 or thereabouts, Stafford Horne wrote:
> The midi controller times-out while initializing reports, this
> causes boot to take an extra 10 seconds. The device descriptor
> advertises that it has an internal HID device but seems to not
> actually do anything useful.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Works for me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
> Resending the same patch for the keyboard to simply disable init reports,
> as discussed with Oliver there might be some hidden functionality which
> I will look into.  At the moment I dont want to worry about time timeouts. 
> 
> Also, I did create and test a patch to use HID_QUIRK_IGNORE which I can 
> send if you feel strongly about it. 
> 
> Changes in v2
>  - use tabs instead of spaces in hid-ids.h
> 
>  drivers/hid/hid-ids.h           | 3 +++
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6ff6e7..74ed730 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -61,6 +61,9 @@
>  #define USB_VENDOR_ID_AIREN		0x1a2c
>  #define USB_DEVICE_ID_AIREN_SLIMPLUS	0x0002
>  
> +#define USB_VENDOR_ID_AKAI		0x2011
> +#define USB_DEVICE_ID_AKAI_MPKMINI2	0x0715
> +
>  #define USB_VENDOR_ID_ALCOR		0x058f
>  #define USB_DEVICE_ID_ALCOR_USBRS232	0x9720
>  
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 7dd0953..055e740 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -55,6 +55,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
>  
>  	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
> -- 
> 2.5.0
> 
