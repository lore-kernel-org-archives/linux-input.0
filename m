From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 2/3] Input: goodix - fix simultaneous axes inversion
 and swap
Date: Fri, 26 Jan 2018 10:44:48 +0100
Message-ID: <1516959888.2592.1.camel@hadess.net>
References: <20180125190829.8968-1-m.niestroj@grinn-global.com>
         <20180125190829.8968-3-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57775 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeAZJow (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 04:44:52 -0500
In-Reply-To: <20180125190829.8968-3-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

On Thu, 2018-01-25 at 20:08 +0100, Marcin Niestroj wrote:
> goodix_ts_data structure contains abs_x_max and abs_y_max members,
> which contain already swapped maximum ranges. That causes reporting
> touch events with invalid position (out of range values).
> 
> Problem occurs for example when ts->inverted_x and ts->swapped_x_y
> are
> true, but ts->inverted_y is false. Assuming we have 720x1280 touch
> panel, ts->abs_x_max == 1279 and ts->abs_y_max == 719 (because we
> inverted that in goodix_read_config()). Now let's assume that we
> received event from (0:0) position (in touch panel original
> coordinates). In function goodix_ts_report_touch() we calculate
> input_x as 1279, but after swapping input_y takes that value (which
> is
> more that maximum 719 value reported during initialization).
> 
> Take into account that abs_x_max and abs_y_max are already swapped
> in goodix_ts_report_touch(), so position for inverted axes will be
> calculated correctly.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> Fixes: ad48cf5e9597 ("Input: goodix - add axis swapping and axis
> inversion support")
> ---
> Changes v2 -> v3 (suggested by Bastien):
>  - add explanation about when the problem occurs
> 
> Changes v1 -> v2 (suggested by Bastien):
>  - patch splitted off from patch 3
> 
>  drivers/input/touchscreen/goodix.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index 7896097ca69b..dc832890f6d3 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -296,12 +296,18 @@ static void goodix_ts_report_touch(struct
> goodix_ts_data *ts, u8 *coor_data)
>  	int input_w = get_unaligned_le16(&coor_data[5]);
>  
>  	/* Inversions have to happen before axis swapping */
> -	if (ts->inverted_x)
> -		input_x = ts->abs_x_max - input_x;
> -	if (ts->inverted_y)
> -		input_y = ts->abs_y_max - input_y;
> -	if (ts->swapped_x_y)
> +	if (!ts->swapped_x_y) {
> +		if (ts->inverted_x)
> +			input_x = ts->abs_x_max - input_x;
> +		if (ts->inverted_y)
> +			input_y = ts->abs_y_max - input_y;
> +	} else {
> +		if (ts->inverted_x)
> +			input_x = ts->abs_y_max - input_x;
> +		if (ts->inverted_y)
> +			input_y = ts->abs_x_max - input_y;
>  		swap(input_x, input_y);
> +	}
>  
>  	input_mt_slot(ts->input_dev, id);
>  	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
> true);
