From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: correctly swap clip values if
 axes are swapped
Date: Sun, 15 Jan 2017 15:23:40 -0800
Message-ID: <20170115232340.GF23285@dtor-ws>
References: <20170113174324.3393-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33610 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXXo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 18:23:44 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so3755447pgd.0
        for <linux-input@vger.kernel.org>; Sun, 15 Jan 2017 15:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170113174324.3393-1-l.stach@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On Fri, Jan 13, 2017 at 06:43:24PM +0100, Lucas Stach wrote:
> The clip values need the same swapping as the maximium values if the
> sensor axes are swapped.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_2d_sensor.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
> index 07007ff8e29f..8bb866c7b985 100644
> --- a/drivers/input/rmi4/rmi_2d_sensor.c
> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
> @@ -144,8 +144,13 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
>  	int input_flags = 0;
>  
>  	if (sensor->report_abs) {
> -		if (sensor->axis_align.swap_axes)
> +		if (sensor->axis_align.swap_axes) {
>  			swap(sensor->max_x, sensor->max_y);
> +			swap(sensor->axis_align.clip_x_low,
> +			     sensor->axis_align.clip_y_low);
> +			swap(sensor->axis_align.clip_x_high,
> +			     sensor->axis_align.clip_y_high);
> +		}
>  
>  		sensor->min_x = sensor->axis_align.clip_x_low;
>  		if (sensor->axis_align.clip_x_high)
> -- 
> 2.11.0
> 

-- 
Dmitry
