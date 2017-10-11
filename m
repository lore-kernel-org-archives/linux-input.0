From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] drivers: Adding driver support for "One by Wacom
 CTL472/672" (parameters transferred from CTL471/671 since only difference
 is the force resolution)
Date: Wed, 11 Oct 2017 15:24:56 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710111524210.14384@jbgna.fhfr.qr>
References: <SG2PR03MB1519A67D9FD33585E560743DD9770@SG2PR03MB1519.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR03MB1519A67D9FD33585E560743DD9770@SG2PR03MB1519.apcprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ? ?? <jingmingxuan@outlook.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Sun, 8 Oct 2017, ? ?? wrote:

> Signed-off-by: Mx Jing <jingmingxuan@outlook.com>

Changelog is missing, please provide one.

Adding Jason and Ping to CC.

> ---
>  drivers/hid/wacom_wac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index aa692e28b2cd..920f3d6bbc71 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -4376,6 +4376,12 @@ static const struct wacom_features wacom_features_0x360 =
>  static const struct wacom_features wacom_features_0x361 =
>  	{ "Wacom Intuos Pro L", 62200, 43200, 8191, 63,
>  	  INTUOSP2_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 10 };
> +static const struct wacom_features wacom_features_0x37A =
> +	{ "One by Wacom CTL472", 14720, 9225, 2047, 63,
> +	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0x37B =
> +	{ "One by Wacom CTL672", 21648, 13530, 2047, 63,
> +	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  
>  static const struct wacom_features wacom_features_HID_ANY_ID =
>  	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
> @@ -4544,6 +4550,8 @@ const struct hid_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0x343) },
>  	{ BT_DEVICE_WACOM(0x360) },
>  	{ BT_DEVICE_WACOM(0x361) },
> +	{ USB_DEVICE_WACOM(0x37A) },
> +	{ USB_DEVICE_WACOM(0x37B) },
>  	{ USB_DEVICE_WACOM(0x4001) },
>  	{ USB_DEVICE_WACOM(0x4004) },
>  	{ USB_DEVICE_WACOM(0x5000) },
> -- 
> 2.11.0
> 

-- 
Jiri Kosina
SUSE Labs
