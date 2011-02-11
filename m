From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/4] input - wacom : process pen data in its own routine
Date: Fri, 11 Feb 2011 20:27:54 +0100
Message-ID: <20110211192754.GB1905@polaris.bitmath.org>
References: <1297387943-13685-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55904 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757988Ab1BKT2s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 14:28:48 -0500
Content-Disposition: inline
In-Reply-To: <1297387943-13685-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Thu, Feb 10, 2011 at 05:32:23PM -0800, Ping Cheng wrote:
> So it would be easier for patch reviewers to follow the data path

Please develop the commit message a bit.

> 
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_wac.c |   73 +++++++++++++++++++++-----------------
>  1 files changed, 40 insertions(+), 33 deletions(-)
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 5488c61..15bab99 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -722,13 +722,47 @@ static void wacom_tpc_touch_in(struct wacom_wac *wacom, size_t len)
>  	}
>  }
>  
> -static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
> +static int wacom_tpc_pen(struct wacom_wac *wacom)
>  {
>  	struct wacom_features *features = &wacom->features;
>  	char *data = wacom->data;
>  	struct input_dev *input = wacom->input;
> -	int prox = 0, pressure;
> -	int retval = 0;
> +	int prox, pressure;
> +
> +	prox = data[1] & 0x20;
> +
> +	if (!wacom->shared->stylus_in_proximity) { /* first in prox */
> +		/* Going into proximity select tool */
> +		wacom->tool[0] = (data[1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> +		if (wacom->tool[0] == BTN_TOOL_PEN)
> +			wacom->id[0] = STYLUS_DEVICE_ID;
> +		else
> +			wacom->id[0] = ERASER_DEVICE_ID;
> +
> +		wacom->shared->stylus_in_proximity = true;
> +	}
> +	input_report_key(input, BTN_STYLUS, data[1] & 0x02);
> +	input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
> +	input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
> +	input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> +	pressure = ((data[7] & 0x01) << 8) | data[6];
> +	if (pressure < 0)
> +		pressure = features->pressure_max + pressure + 1;

Hm... what if data[6] was u8 instead?

> +	input_report_abs(input, ABS_PRESSURE, pressure);
> +	input_report_key(input, BTN_TOUCH, data[1] & 0x05);
> +	if (!prox) { /* out-prox */
> +		wacom->id[0] = 0;
> +		wacom->shared->stylus_in_proximity = false;
> +	}
> +	input_report_key(input, wacom->tool[0], prox);
> +
> +	return 1;
> +}
> +
> +static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
> +{
> +	char *data = wacom->data;
> +	int prox = 0;
>  
>  	dbg("wacom_tpc_irq: received report #%d", data[0]);
>  
> @@ -757,37 +791,10 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  		}
>  		/* keep prox bit to send proper out-prox event */
>  		wacom->id[1] = prox;
> -	} else if (data[0] == WACOM_REPORT_PENABLED) { /* Penabled */
> -		prox = data[1] & 0x20;
> -
> -		if (!wacom->shared->stylus_in_proximity) { /* first in prox */
> -			/* Going into proximity select tool */
> -			wacom->tool[0] = (data[1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> -			if (wacom->tool[0] == BTN_TOOL_PEN)
> -				wacom->id[0] = STYLUS_DEVICE_ID;
> -			else
> -				wacom->id[0] = ERASER_DEVICE_ID;
> +	} else if (data[0] == WACOM_REPORT_PENABLED)
> +		return wacom_tpc_pen(wacom);

mixed if {} and else ;

>  
> -			wacom->shared->stylus_in_proximity = true;
> -		}
> -		input_report_key(input, BTN_STYLUS, data[1] & 0x02);
> -		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
> -		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
> -		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> -		pressure = ((data[7] & 0x01) << 8) | data[6];
> -		if (pressure < 0)
> -			pressure = features->pressure_max + pressure + 1;
> -		input_report_abs(input, ABS_PRESSURE, pressure);
> -		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
> -		if (!prox) { /* out-prox */
> -			wacom->id[0] = 0;
> -			wacom->shared->stylus_in_proximity = false;
> -		}
> -		input_report_key(input, wacom->tool[0], prox);
> -		input_report_abs(input, ABS_MISC, wacom->id[0]);
> -		retval = 1;
> -	}
> -	return retval;
> +	return 0;
>  }
>  
>  static int wacom_bpt_touch(struct wacom_wac *wacom)
> -- 

Thanks,
Henrik
