From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] Input: LEDs - skip unnamed LEDs
Date: Thu, 23 Jul 2015 07:40:39 +0200
Message-ID: <55B07E57.9090505@suse.cz>
References: <20150722220202.GG14875@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbGWFkm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 01:40:42 -0400
In-Reply-To: <20150722220202.GG14875@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jkosina@suse.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On 07/23/2015 12:02 AM, Dmitry Torokhov wrote:
> Devices may declare more LEDs than what is known to input-leds
> (HID does this for some devices). Instead of showing ugly warnings
> on connect and, even worse, oopsing on disconnect, let's simply
> ignore LEDs that are not known to us.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, I'll test it tomorrow, due to being elsewhere than the machine with the
mouse today.

> ---
>  drivers/input/input-leds.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> index 074a65e..766bf26 100644
> --- a/drivers/input/input-leds.c
> +++ b/drivers/input/input-leds.c
> @@ -71,6 +71,18 @@ static void input_leds_event(struct input_handle *handle, unsigned int type,
>  {
>  }
>  
> +static int input_leds_get_count(struct input_dev *dev)
> +{
> +	unsigned int led_code;
> +	int count = 0;
> +
> +	for_each_set_bit(led_code, dev->ledbit, LED_CNT)
> +		if (input_led_info[led_code].name)
> +			count++;
> +
> +	return count;
> +}
> +
>  static int input_leds_connect(struct input_handler *handler,
>  			      struct input_dev *dev,
>  			      const struct input_device_id *id)
> @@ -81,7 +93,7 @@ static int input_leds_connect(struct input_handler *handler,
>  	int led_no;
>  	int error;
>  
> -	num_leds = bitmap_weight(dev->ledbit, LED_CNT);
> +	num_leds = input_leds_get_count(dev);
>  	if (!num_leds)
>  		return -ENXIO;
>  
> @@ -112,7 +124,7 @@ static int input_leds_connect(struct input_handler *handler,
>  		led->handle = &leds->handle;
>  		led->code = led_code;
>  
> -		if (WARN_ON(!input_led_info[led_code].name))
> +		if (!input_led_info[led_code].name)
>  			continue;
>  
>  		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
> 

