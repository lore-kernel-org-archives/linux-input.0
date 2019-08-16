From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 06/63] Input: atmel_mxt_ts - output status from T42
 Touch Suppression
Date: Fri, 16 Aug 2019 10:34:26 -0700
Message-ID: <20190816173426.GM121898@dtor-ws>
References: <20190816083130.18250-1-jiada_wang@mentor.com>
 <20190816083130.18250-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816083130.18250-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2019 at 05:30:33PM +0900, Jiada Wang wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Benson Leung <bleung@chromium.org>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> (cherry picked from ndyer/linux/for-upstream commit ab95b5a309999d2c098daaa9f88d9fcfae7eb516)
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index a75c35c6f9f9..9226ec528adf 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -155,6 +155,9 @@ struct t37_debug {
>  #define MXT_RESET_VALUE		0x01
>  #define MXT_BACKUP_VALUE	0x55
>  
> +/* Define for MXT_PROCI_TOUCHSUPPRESSION_T42 */
> +#define MXT_T42_MSG_TCHSUP	BIT(0)
> +
>  /* T100 Multiple Touch Touchscreen */
>  #define MXT_T100_CTRL		0
>  #define MXT_T100_CFG1		1
> @@ -323,6 +326,8 @@ struct mxt_data {
>  	u8 T9_reportid_max;
>  	u16 T18_address;
>  	u8 T19_reportid;
> +	u8 T42_reportid_min;
> +	u8 T42_reportid_max;
>  	u16 T44_address;
>  	u8 T48_reportid;
>  	u8 T100_reportid_min;
> @@ -978,6 +983,17 @@ static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
>  	data->update_input = true;
>  }
>  
> +static void mxt_proc_t42_messages(struct mxt_data *data, u8 *msg)
> +{
> +	struct device *dev = &data->client->dev;
> +	u8 status = msg[1];
> +
> +	if (status & MXT_T42_MSG_TCHSUP)
> +		dev_info(dev, "T42 suppress\n");
> +	else
> +		dev_info(dev, "T42 normal\n");

dev_dbg(). There is no need to flood the logs with this. I'd assume this
is for assisting in bringup. Should there be some more generic way of
monitoring the status?

-- 
Dmitry
