From: Benoit Parrot <bparrot@ti.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - simplify event reporting code
Date: Fri, 28 Jun 2019 12:37:02 -0500
Message-ID: <20190628173702.6wr453fmcyfdxoid@ti.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
 <20190623063153.261546-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190623063153.261546-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote on Sat [2019-Jun-22 23:31:53 -0700]:
> Now that input_mt_report_slot_state() returns true if slot is active we no
> longer need a temporary for the slot state.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Appears to work fine in my test:

Tested-by: Benoit Parrot <bparrot@ti.com>

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index ec770226e119..3cc4341bbdff 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -229,7 +229,6 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  
>  	for (i = 0; i < tsdata->max_support_points; i++) {
>  		u8 *buf = &rdbuf[i * tplen + offset];
> -		bool down;
>  
>  		type = buf[0] >> 6;
>  		/* ignore Reserved events */
> @@ -247,16 +246,12 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
>  			swap(x, y);
>  
>  		id = (buf[2] >> 4) & 0x0f;
> -		down = type != TOUCH_EVENT_UP;
>  
>  		input_mt_slot(tsdata->input, id);
> -		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
> -
> -		if (!down)
> -			continue;
> -
> -		touchscreen_report_pos(tsdata->input, &tsdata->prop, x, y,
> -				       true);
> +		if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,
> +					       type != TOUCH_EVENT_UP))
> +			touchscreen_report_pos(tsdata->input, &tsdata->prop,
> +					       x, y, true);
>  	}
>  
>  	input_mt_report_pointer_emulation(tsdata->input, true);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
