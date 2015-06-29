From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add hover event for ST format
Date: Mon, 29 Jun 2015 12:44:54 -0700
Message-ID: <20150629194454.GE22166@dtor-ws>
References: <C24448D4-9078-4EE9-8E40-A2C8DC6115A6@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34649 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbF2TpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 15:45:00 -0400
Content-Disposition: inline
In-Reply-To: <C24448D4-9078-4EE9-8E40-A2C8DC6115A6@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Duson,

On Mon, Jun 29, 2015 at 09:19:09AM +0800, duson wrote:
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c |    2 ++

I'd rather we teach input_mt_init_slots() and
input_mt_report_pointer_emulation() do that for us.

Thanks.

>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 62641f2..ce97e28 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -847,6 +847,7 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
>  	}
>  
>  	input_report_key(input, BTN_LEFT, tp_info & 0x01);
> +	input_report_abs(input, ABS_DISTANCE, hover_event != 0);
>  	input_mt_report_pointer_emulation(input, true);
>  	input_sync(input);
>  }
> @@ -922,6 +923,7 @@ static int elan_setup_input_device(struct elan_tp_data *data)
>  	input_abs_set_res(input, ABS_Y, data->y_res);
>  	input_set_abs_params(input, ABS_PRESSURE, 0, ETP_MAX_PRESSURE, 0, 0);
>  	input_set_abs_params(input, ABS_TOOL_WIDTH, 0, ETP_FINGER_WIDTH, 0, 0);
> +	input_set_abs_params(input, ABS_DISTANCE, 0, 1, 0, 0);
>  
>  	/* And MT parameters */
>  	input_set_abs_params(input, ABS_MT_POSITION_X, 0, data->max_x, 0, 0);
> 
> 
> 
> 

-- 
Dmitry
