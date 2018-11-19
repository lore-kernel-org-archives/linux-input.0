From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Add pointstick support for Cirque
 Touchpad
Date: Mon, 19 Nov 2018 16:28:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811191628050.21108@cbobk.fhfr.pm>
References: <20181114053520.7229-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114053520.7229-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 14 Nov 2018, Kai-Heng Feng wrote:

> Cirque Touchpad/Pointstick combo is similar to Alps devices, it requires
> MT_CLS_WIN_8_DUAL to expose its pointstick as a mouse.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-ids.h        | 3 +++
>  drivers/hid/hid-multitouch.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c0d668944dbe..9f59a0a1500b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -275,6 +275,9 @@
>  
>  #define USB_VENDOR_ID_CIDC		0x1677
>  
> +#define I2C_VENDOR_ID_CIRQUE		0x0488
> +#define I2C_PRODUCT_ID_CIRQUE_121F	0x121F
> +
>  #define USB_VENDOR_ID_CJTOUCH		0x24b8
>  #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
>  #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f7c6de2b6730..dca0a3a90fb8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1814,6 +1814,12 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
>  			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
>  
> +	/* Cirque devices */
> +	{ .driver_data = MT_CLS_WIN_8_DUAL,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			I2C_VENDOR_ID_CIRQUE,
> +			I2C_PRODUCT_ID_CIRQUE_121F) },
> +
>  	/* CJTouch panels */
>  	{ .driver_data = MT_CLS_NSMU,
>  		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
