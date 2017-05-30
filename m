From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - use %ph to form F34
 configuration ID
Date: Tue, 30 May 2017 10:23:58 +0200
Message-ID: <20170530082358.GB1293@mail.corp.redhat.com>
References: <20170530044944.GA33451@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530044944.GA33451@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On May 29 2017 or thereabouts, Dmitry Torokhov wrote:
> Instead of printing bytes one by one, let's use %phN to print the buffer in
> one go.
> 
> Also use hweight8 to count number of partitions instead of inspecting it
> bit by bit.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_f34v7.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
> index ae2db1c3aebf..3991d2943660 100644
> --- a/drivers/input/rmi4/rmi_f34v7.c
> +++ b/drivers/input/rmi4/rmi_f34v7.c
> @@ -9,13 +9,14 @@
>   * the Free Software Foundation.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/rmi.h>
>  #include <linux/firmware.h>
> -#include <asm/unaligned.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
> +#include <asm/unaligned.h>
>  
>  #include "rmi_driver.h"
>  #include "rmi_f34.h"
> @@ -464,7 +465,7 @@ static int rmi_f34v7_read_queries_bl_version(struct f34_data *f34)
>  static int rmi_f34v7_read_queries(struct f34_data *f34)
>  {
>  	int ret;
> -	int i, j;
> +	int i;
>  	u8 base;
>  	int offset;
>  	u8 *ptable;
> @@ -519,9 +520,6 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
>  
>  	if (query_0 & HAS_CONFIG_ID) {
>  		u8 f34_ctrl[CONFIG_ID_SIZE];
> -		int i = 0;
> -		u8 *p = f34->configuration_id;
> -		*p = '\0';
>  
>  		ret = rmi_read_block(f34->fn->rmi_dev,
>  				f34->fn->fd.control_base_addr,
> @@ -531,13 +529,11 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
>  			return ret;
>  
>  		/* Eat leading zeros */
> -		while (i < sizeof(f34_ctrl) && !f34_ctrl[i])
> -			i++;
> +		for (i = 0; i < sizeof(f34_ctrl) - 1 && !f34_ctrl[i]; i++)
> +			/* Empty */;
>  
> -		for (; i < sizeof(f34_ctrl); i++)
> -			p += snprintf(p, f34->configuration_id
> -				      + sizeof(f34->configuration_id) - p,
> -				      "%02X", f34_ctrl[i]);
> +		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
> +			 "%*phN", (int)sizeof(f34_ctrl) - i, f34_ctrl + i);
>  
>  		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "Configuration ID: %s\n",
>  			f34->configuration_id);
> @@ -545,9 +541,7 @@ static int rmi_f34v7_read_queries(struct f34_data *f34)
>  
>  	f34->v7.partitions = 0;
>  	for (i = 0; i < sizeof(query_1_7.partition_support); i++)
> -		for (j = 0; j < 8; j++)
> -			if (query_1_7.partition_support[i] & (1 << j))
> -				f34->v7.partitions++;
> +		f34->v7.partitions += hweight8(query_1_7.partition_support[i]);
>  
>  	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: Supported partitions: %*ph\n",
>  		__func__, sizeof(query_1_7.partition_support),
> -- 
> 2.13.0.219.gdb65acc882-goog
> 
> 
> -- 
> Dmitry
