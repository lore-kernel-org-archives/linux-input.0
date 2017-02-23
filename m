From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: tsc2007 - rename function
 tsc2007_calculate_pressure to tsc2007_calculate_resistance because that is
 what it does
Date: Thu, 23 Feb 2017 00:45:10 -0800
Message-ID: <20170223084510.GL18639@dtor-ws>
References: <cover.1487609795.git.hns@goldelico.com>
 <5f185322353e02e93e641f64dc1a83392fe025c2.1487609795.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36580 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdBWIpO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:45:14 -0500
Content-Disposition: inline
In-Reply-To: <5f185322353e02e93e641f64dc1a83392fe025c2.1487609795.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, sre@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org

On Mon, Feb 20, 2017 at 05:56:34PM +0100, H. Nikolaus Schaller wrote:
>p Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/tsc2007_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> index 98dbefc..30b53ca 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -68,7 +68,7 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>  	tsc2007_xfer(tsc, PWRDOWN);
>  }
>  
> -u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
>  {
>  	u32 rt = 0;
>  
> @@ -77,7 +77,7 @@ u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
>  		tc->x = 0;
>  
>  	if (likely(tc->x && tc->z1)) {
> -		/* compute touch pressure resistance using equation #1 */
> +		/* compute touch resistance using equation #1 */
>  		rt = tc->z2 - tc->z1;
>  		rt *= tc->x;
>  		rt *= tsc->x_plate_ohms;
> @@ -125,7 +125,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  		tsc2007_read_values(ts, &tc);
>  		mutex_unlock(&ts->mlock);
>  
> -		rt = tsc2007_calculate_pressure(ts, &tc);
> +		rt = tsc2007_calculate_resistance(ts, &tc);
>  
>  		if (!rt && !ts->get_pendown_state) {
>  			/*
> @@ -138,7 +138,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  
>  		if (rt <= ts->max_rt) {
>  			dev_dbg(&ts->client->dev,
> -				"DOWN point(%4d,%4d), pressure (%4u)\n",
> +				"DOWN point(%4d,%4d), resistance (%4u)\n",
>  				tc.x, tc.y, rt);
>  
>  			input_report_key(input, BTN_TOUCH, 1);
> -- 
> 2.7.3
> 

-- 
Dmitry
