From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Add support for Google Rose Touchpad
Date: Wed, 21 Jun 2017 09:31:16 +0200
Message-ID: <20170621073116.GA23046@mail.corp.redhat.com>
References: <20170621024325.37966-1-wnhuang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbdFUHbZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 03:31:25 -0400
Content-Disposition: inline
In-Reply-To: <20170621024325.37966-1-wnhuang@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew de los Reyes <adlr@google.com>, Shecky Lin <sheckylin@google.com>, Rong Chang <rongchang@google.com>, jikos@kernel.org, linux-input@vger.kernel.org

On Jun 21 2017 or thereabouts, Wei-Ning Huang wrote:
> Add Google Rose Touchpad USB PID and required quirks.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> ---

Looks good to me

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-ids.h        |  3 +++
>  drivers/hid/hid-multitouch.c | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8ca1e8ce0af2..91c4a89615d7 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -425,6 +425,9 @@
>  #define USB_VENDOR_ID_GOODTOUCH		0x1aad
>  #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
>  
> +#define USB_VENDOR_ID_GOOGLE		0x18d1
> +#define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE	0x5028
> +
>  #define USB_VENDOR_ID_GOTOP		0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2		0x007f
>  #define USB_DEVICE_ID_GOGOPEN		0x00ce
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 24d5b6deb571..5052aca8b984 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -161,6 +161,7 @@ static void mt_post_parse(struct mt_device *td);
>  #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
>  #define MT_CLS_LG				0x010a
>  #define MT_CLS_VTL				0x0110
> +#define MT_CLS_GOOGLE				0x0111
>  
>  #define MT_DEFAULT_MAXCONTACT	10
>  #define MT_MAX_MAXCONTACT	250
> @@ -278,6 +279,12 @@ static struct mt_class mt_classes[] = {
>  			MT_QUIRK_CONTACT_CNT_ACCURATE |
>  			MT_QUIRK_FORCE_GET_FEATURE,
>  	},
> +	{ .name = MT_CLS_GOOGLE,
> +		.quirks = MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
> +			MT_QUIRK_SLOT_IS_CONTACTID |
> +			MT_QUIRK_HOVERING
> +	},
>  	{ }
>  };
>  
> @@ -1569,6 +1576,11 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_XIROKU,
>  			USB_DEVICE_ID_XIROKU_CSR2) },
>  
> +	/* Google MT devices */
> +	{ .driver_data = MT_CLS_GOOGLE,
> +		HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_GOOGLE,
> +			USB_DEVICE_ID_GOOGLE_TOUCH_ROSE) },
> +
>  	/* Generic MT device */
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID, HID_ANY_ID) },
>  
> -- 
> 2.12.2
> 
