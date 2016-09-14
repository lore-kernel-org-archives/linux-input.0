From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 6/9] HID: uclogic: Add support for several more tablets
Date: Wed, 14 Sep 2016 12:15:31 +0200
Message-ID: <20160914101531.GJ25951@mail.corp.redhat.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
 <20160913140843.25567-7-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754281AbcINKPg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 06:15:36 -0400
Content-Disposition: inline
In-Reply-To: <20160913140843.25567-7-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Sep 13 2016 or thereabouts, Nikolai Kondrashov wrote:
> Add more product IDs to hid-uclogic.c driver to support several more
> tablet models, including:
> 
> 	UC-Logic DrawImage G3
> 	aka Ugee G3
> 	UC-Logic SP1001
> 	aka Ugee SP1001
> 	aka Yiynova UC-Logic SP-1001
> 	Ugee 1000L
> 	Ugee M708
> 	Yiynova DP10U
> 	aka Yiynova DP10U+
> 	Yiynova MSP19U
> 	Yiynova MSP19U+
> 	Yiynova MVP10U
> 	aka Yiynova MVP10U IPS
> 	Yiynova MVP10UHD+IPS
> 	Yiynova MVP22U+
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
>  drivers/hid/hid-ids.h     | 4 ++++
>  drivers/hid/hid-uclogic.c | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5963cf1..6ef9dbf 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -996,6 +996,10 @@
>  #define USB_DEVICE_ID_UCLOGIC_TABLET_WP1062	0x0064
>  #define USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850	0x0522
>  #define USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60	0x0781
> +#define USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3	0x3031
> +#define USB_DEVICE_ID_UGEE_TABLET_81		0x0081
> +#define USB_DEVICE_ID_UGEE_TABLET_45		0x0045
> +#define USB_DEVICE_ID_YIYNOVA_TABLET		0x004d
>  
>  #define USB_VENDOR_ID_UNITEC	0x227d
>  #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index 73c040d..f4377c4 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -955,6 +955,10 @@ static int uclogic_probe(struct hid_device *hdev,
>  
>  	switch (id->product) {
>  	case USB_DEVICE_ID_HUION_TABLET:
> +	case USB_DEVICE_ID_YIYNOVA_TABLET:
> +	case USB_DEVICE_ID_UGEE_TABLET_81:
> +	case USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3:
> +	case USB_DEVICE_ID_UGEE_TABLET_45:
>  		/* If this is the pen interface */
>  		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
>  			rc = uclogic_tablet_enable(hdev);
> @@ -1023,6 +1027,10 @@ static const struct hid_device_id uclogic_devices[] = {
>  				USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_HUION_TABLET) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_YIYNOVA_TABLET) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_81) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },

For this one and 7/9, I think you forgot the hid-core.c changes to not
bind hid-generic on those.

The reset of the series looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, uclogic_devices);
> -- 
> 2.9.3
> 
