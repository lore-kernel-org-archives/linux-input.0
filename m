From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 01/10] Input: atmel_mxt_ts - only use first T9 instance
Date: Fri, 27 Jul 2018 11:54:18 -0700
Message-ID: <20180727185418.GG72640@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 20, 2018 at 10:51:13PM +0100, Nick Dyer wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> The driver only registers one input device, which uses the screen
> parameters from the first T9 instance. The first T63 instance also uses
> those parameters.
> 
> It is incorrect to send input reports from the second instances of these
> objects if they are enabled: the input scaling will be wrong and the
> positions will be mashed together.
> 
> This also causes problems on Android if the number of slots exceeds 32.
> 
> In the future, this could be handled by looking for enabled touch object
> instances and creating an input device for each one.
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Benson Leung <bleung@chromium.org>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> ---

OK, I adjusted patch #7 to use kmemdup_nul() as we discussed, and
skipped #9, applied the rest.

Thanks!

>  drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 54fe190fd4bc..48c5ccab00a0 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1658,10 +1658,11 @@ static int mxt_parse_object_table(struct mxt_data *data,
>  			break;
>  		case MXT_TOUCH_MULTI_T9:
>  			data->multitouch = MXT_TOUCH_MULTI_T9;
> +			/* Only handle messages from first T9 instance */
>  			data->T9_reportid_min = min_id;
> -			data->T9_reportid_max = max_id;
> -			data->num_touchids = object->num_report_ids
> -						* mxt_obj_instances(object);
> +			data->T9_reportid_max = min_id +
> +						object->num_report_ids - 1;
> +			data->num_touchids = object->num_report_ids;
>  			break;
>  		case MXT_SPT_MESSAGECOUNT_T44:
>  			data->T44_address = object->start_address;
> -- 
> 2.17.1
> 

-- 
Dmitry
