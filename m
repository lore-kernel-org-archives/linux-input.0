From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] input: bcm5974: Add support for newer MacBookPro8,2
Date: Tue, 16 Aug 2011 16:21:26 +0800
Message-ID: <4E4A2886.8080805@cn.fujitsu.com>
References: <4E4A0C26.1060307@adrake.org> <4E4A1894.4070802@cn.fujitsu.com> <4E4A24CC.6000909@adrake.org>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:64685 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab1HPIWf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 04:22:35 -0400
In-Reply-To: <4E4A24CC.6000909@adrake.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Drake <adrake@adrake.org>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

On 08/16/2011 04:05 PM, Andrew Drake wrote:
> On 08/16/2011 12:13 AM, Wanlong Gao wrote:
>> On 08/16/2011 02:20 PM, Andrew Drake wrote:
>>> I just received a new MacBook Pro, product name MacBookPro8,2. It came
>>> with a newer/higher resolution touchpad than others with the same
>>> product name with USB ID 05ac:0252. The following patch (which applies
>>> on top of 3.1-rc2) adds support for this device.
>>>
>>> <snip>
>> I wonder that why can't I apply this patch?
>> #git am<[path]>
>> Applying: input: bcm5974: Add support for newer MacBookPro8,2
>> fatal: corrupt patch at line 32
>> Patch failed at 0001 input: bcm5974: Add support for newer MacBookPro8,2
>>
>
> Sorry, my mailer wrapped some of the lines. Try this:
>
>
> Signed-off-by: Andrew Drake<adrake@adrake.org>
> ---
>   drivers/input/mouse/bcm5974.c |   20 ++++++++++++++++++++
>   1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 3126983..a0a4964 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -67,6 +67,10 @@
>   #define USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI	0x0245
>   #define USB_DEVICE_ID_APPLE_WELLSPRING5_ISO	0x0246
>   #define USB_DEVICE_ID_APPLE_WELLSPRING5_JIS	0x0247
> +/* Macbook8,2 (unibody) */
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
> +#define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
>
>   #define BCM5974_DEVICE(prod) {					\
>   	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
> @@ -104,6 +108,10 @@ static const struct usb_device_id bcm5974_table[] = {
>   	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI),
>   	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_ISO),
>   	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
> +	/* MacbookPro8,2 */
> +	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI),
> +	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
> +	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
>   	/* Terminating entry */
>   	{}
>   };
> @@ -294,6 +302,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
>   		{ DIM_X, DIM_X / SN_COORD, -4415, 5050 },
>   		{ DIM_Y, DIM_Y / SN_COORD, -55, 6680 }
>   	},
> +	{
> +		USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI,
> +		USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO,
> +		USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS,
> +		HAS_INTEGRATED_BUTTON,
> +		0x84, sizeof(struct bt_data),
> +		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
> +		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
> +		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
> +		{ DIM_X, DIM_X / SN_COORD, -4750, 5280 },
> +		{ DIM_Y, DIM_Y / SN_COORD, -150, 6730 }
> +	},
>   	{}
>   };
>
Applying: input: bcm5974: Add support for newer MacBookPro8,2
error: patch failed: drivers/input/mouse/bcm5974.c:67
error: drivers/input/mouse/bcm5974.c: patch does not apply
Patch failed at 0001 input: bcm5974: Add support for newer MacBookPro8,2


-- 
Thanks
Wanlong Gao
