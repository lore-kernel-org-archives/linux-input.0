From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [v2] input: wacom - Pass touch resolution to clients through
 input_absinfo
Date: Tue, 25 Jan 2011 11:02:38 +0100
Message-ID: <20110125100238.GA5837@polaris.bitmath.org>
References: <1295910373-2450-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:39119 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab1AYKCF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 05:02:05 -0500
Content-Disposition: inline
In-Reply-To: <1295910373-2450-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Mon, Jan 24, 2011 at 11:06:13PM -0000, Ping Cheng wrote:
> Fixed the workaround used for kernels older than 2.6.35.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> 
> ---
> drivers/input/tablet/wacom_wac.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)

A define or a function would have been nicer than "100", but since
this wasn't obvious from the comments,

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik

> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index f44c822..12d5ccf 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1228,8 +1228,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case TABLETPC:
>  		if (features->device_type == BTN_TOOL_DOUBLETAP ||
>  		    features->device_type == BTN_TOOL_TRIPLETAP) {
> -			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
> -			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
> +			/* set touch resolution in points/mm */
> +			input_abs_set_res(input_dev, ABS_X,
> +				100 * features->x_max / features->x_phy);
> +			input_abs_set_res(input_dev, ABS_Y,
> +				100 * features->y_max / features->y_phy);
>  			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
>  		}
>  
> @@ -1272,6 +1275,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
>  					     0, features->pressure_max,
>  					     features->pressure_fuzz, 0);
> +			/* set touch resolution in points/mm */
> +			input_abs_set_res(input_dev, ABS_X,
> +				100 * features->x_max / features->x_phy);
> +			input_abs_set_res(input_dev, ABS_Y,
> +				100 * features->y_max / features->y_phy);
>  		} else if (features->device_type == BTN_TOOL_PEN) {
>  			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>  			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
