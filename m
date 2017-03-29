From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 1/3] Input: max11801_ts: Add missing of_match_table
Date: Wed, 29 Mar 2017 00:26:27 -0700
Message-ID: <20170329072627.GE38261@dtor-ws>
References: <1490209518-20790-1-git-send-email-jagan@openedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490209518-20790-1-git-send-email-jagan@openedev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@openedev.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>, Matteo Lisi <matteo.lisi@engicam.com>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 23, 2017 at 12:35:16AM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Added missing of_match_table for max11801_ts driver with
> compatible as "maxim,max11801_ts"
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thank you.

> ---
> Changes for v8:
> - use the compatible as maxim,max11801 with remove suffix _ts since
>   i2c node follow the same.
> Changes for v7:
> - newly added patch
> 
>  drivers/input/touchscreen/max11801_ts.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
> index a595ae5..d3c7fc0 100644
> --- a/drivers/input/touchscreen/max11801_ts.c
> +++ b/drivers/input/touchscreen/max11801_ts.c
> @@ -224,9 +224,16 @@ static int max11801_ts_probe(struct i2c_client *client,
>  };
>  MODULE_DEVICE_TABLE(i2c, max11801_ts_id);
>  
> +static const struct of_device_id max11801_ts_dt_ids[] = {
> +	{ .compatible = "maxim,max11801" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max11801_ts_dt_ids);
> +
>  static struct i2c_driver max11801_ts_driver = {
>  	.driver = {
>  		.name	= "max11801_ts",
> +		.of_match_table	= max11801_ts_dt_ids,
>  	},
>  	.id_table	= max11801_ts_id,
>  	.probe		= max11801_ts_probe,
> -- 
> 1.9.1
> 

-- 
Dmitry
