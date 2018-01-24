From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Delete error messages for a failed
 memory allocation in two functions
Date: Wed, 24 Jan 2018 20:35:32 +0000
Message-ID: <20180124203531.GA5922@lava.h.shmanahar.org>
References: <e6d21a83-6628-66f6-d7ce-bb5bf530faf2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e6d21a83-6628-66f6-d7ce-bb5bf530faf2@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jan 21, 2018 at 10:33:50PM +0100, SF Markus Elfring wrote:
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks!

Signed-off-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..f38711e9c256 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1507,10 +1507,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
>  			MXT_INFO_CHECKSUM_SIZE;
>  	config_mem_size = data->mem_size - cfg_start_ofs;
>  	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
> -	if (!config_mem) {
> -		dev_err(dev, "Failed to allocate memory\n");
> +	if (!config_mem)
>  		return -ENOMEM;
> -	}
>  
>  	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
>  				  config_mem, config_mem_size);
> @@ -1612,10 +1610,8 @@ static int mxt_get_object_table(struct mxt_data *data)
>  
>  	table_size = data->info.object_num * sizeof(struct mxt_object);
>  	object_table = kzalloc(table_size, GFP_KERNEL);
> -	if (!object_table) {
> -		dev_err(&data->client->dev, "Failed to allocate memory\n");
> +	if (!object_table)
>  		return -ENOMEM;
> -	}
>  
>  	error = __mxt_read_reg(client, MXT_OBJECT_START, table_size,
>  			object_table);
> @@ -1714,7 +1710,6 @@ static int mxt_get_object_table(struct mxt_data *data)
>  	data->msg_buf = kcalloc(data->max_reportid,
>  				data->T5_msg_size, GFP_KERNEL);
>  	if (!data->msg_buf) {
> -		dev_err(&client->dev, "Failed to allocate message buffer\n");
>  		error = -ENOMEM;
>  		goto free_object_table;
>  	}
> -- 
> 2.16.0
> 
