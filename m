From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: usbtouchscreen: Add new model from IRTOUCHSYSTEMS
Date: Tue, 24 Mar 2015 09:29:14 -0700
Message-ID: <20150324162914.GC34117@dtor-ws>
References: <1427200704-20438-1-git-send-email-poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427200704-20438-1-git-send-email-poeschel@lemonage.de>
Sender: linux-kernel-owner@vger.kernel.org
To: poeschel@lemonage.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 24, 2015 at 01:38:24PM +0100, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This adds support for another model of IRTOUCH SYSTEMS Co.,LtD infrared
> touchscreens. The USB vendorID/deviceID is 6615/0012. It is also sold
> under the label "Elektrosil".
> The datasheet states that coordinates for x and y are in the range from
> 0 to 32767.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/usbtouchscreen.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index a096633..f2c6c35 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -132,6 +132,7 @@ enum {
>  	DEVTYPE_GUNZE,
>  	DEVTYPE_DMC_TSC10,
>  	DEVTYPE_IRTOUCH,
> +	DEVTYPE_IRTOUCH_HIRES,
>  	DEVTYPE_IDEALTEK,
>  	DEVTYPE_GENERAL_TOUCH,
>  	DEVTYPE_GOTOP,
> @@ -198,6 +199,7 @@ static const struct usb_device_id usbtouch_devices[] = {
>  #ifdef CONFIG_TOUCHSCREEN_USB_IRTOUCH
>  	{USB_DEVICE(0x595a, 0x0001), .driver_info = DEVTYPE_IRTOUCH},
>  	{USB_DEVICE(0x6615, 0x0001), .driver_info = DEVTYPE_IRTOUCH},
> +	{USB_DEVICE(0x6615, 0x0012), .driver_info = DEVTYPE_IRTOUCH_HIRES},
>  #endif
>  
>  #ifdef CONFIG_TOUCHSCREEN_USB_IDEALTEK
> @@ -1177,6 +1179,15 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
>  		.rept_size	= 8,
>  		.read_data	= irtouch_read_data,
>  	},
> +
> +	[DEVTYPE_IRTOUCH_HIRES] = {
> +		.min_xc		= 0x0,
> +		.max_xc		= 0x7fff,
> +		.min_yc		= 0x0,
> +		.max_yc		= 0x7fff,
> +		.rept_size	= 8,
> +		.read_data	= irtouch_read_data,
> +	},
>  #endif
>  
>  #ifdef CONFIG_TOUCHSCREEN_USB_IDEALTEK
> -- 
> 2.1.4
> 

-- 
Dmitry
