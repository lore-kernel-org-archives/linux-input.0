From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] ads7846: Add possibility to use external vref on ads7846
Date: Thu, 05 May 2011 10:08:18 +0100
Message-ID: <4DC26902.3050201@cam.ac.uk>
References: <1304584346-10407-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:41385 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1EEJFx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 05:05:53 -0400
In-Reply-To: <1304584346-10407-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 05/05/11 09:32, Alexander Stein wrote:
> Just set vref_mv in your platform config to use external vref. Otherwise
> the internal one is used.
Would be nicer to see this done with the regulator framework. But then if you
have a use case on a board where that isn't available, then fair enough.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> This slight semantic change of vref_mv should not introduce a regression.
> All boards using the 7846 model didn't set vref_mv which results in the
> expected behavior.
> 
> Alexander
>  drivers/input/touchscreen/ads7846.c |    8 +++-----
>  include/linux/spi/ads7846.h         |    3 ++-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 1de1c19..a19e340 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -109,6 +109,7 @@ struct ads7846 {
>  	u16			pressure_max;
>  
>  	bool			swap_xy;
> +	bool			use_internal;
>  
>  	struct ads7846_packet	*packet;
>  
> @@ -307,7 +308,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  	struct ads7846 *ts = dev_get_drvdata(dev);
>  	struct ser_req *req;
>  	int status;
> -	int use_internal;
>  
>  	req = kzalloc(sizeof *req, GFP_KERNEL);
>  	if (!req)
> @@ -315,11 +315,8 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  
>  	spi_message_init(&req->msg);
>  
> -	/* FIXME boards with ads7846 might use external vref instead ... */
> -	use_internal = (ts->model == 7846);
> -
>  	/* maybe turn on internal vREF, and let it settle */
> -	if (use_internal) {
> +	if (ts->use_internal) {
>  		req->ref_on = REF_ON;
>  		req->xfer[0].tx_buf = &req->ref_on;
>  		req->xfer[0].len = 1;
> @@ -509,6 +506,7 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
>  		if (!ts->vref_mv) {
>  			dev_dbg(&spi->dev, "assuming 2.5V internal vREF\n");
>  			ts->vref_mv = 2500;
> +			ts->use_internal = true;
>  		}
>  		break;
>  	case 7845:
> diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
> index 92bd083..c64de9d 100644
> --- a/include/linux/spi/ads7846.h
> +++ b/include/linux/spi/ads7846.h
> @@ -14,7 +14,8 @@ enum ads7846_filter {
>  struct ads7846_platform_data {
>  	u16	model;			/* 7843, 7845, 7846, 7873. */
>  	u16	vref_delay_usecs;	/* 0 for external vref; etc */
> -	u16	vref_mv;		/* external vref value, milliVolts */
> +	u16	vref_mv;		/* external vref value, milliVolts
> +					 * ads7846: if 0, use internal vref */
>  	bool	keep_vref_on;		/* set to keep vref on for differential
>  					 * measurements as well */
>  	bool	swap_xy;		/* swap x and y axes */

