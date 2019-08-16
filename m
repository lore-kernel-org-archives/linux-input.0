From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 04/63] Input: atmel_mxt_ts - split large i2c transfers
 into blocks
Date: Fri, 16 Aug 2019 10:18:37 -0700
Message-ID: <20190816171837.GG121898@dtor-ws>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
 <20190816082952.17985-5-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816082952.17985-5-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2019 at 05:28:53PM +0900, Jiada Wang wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> On some firmware variants, the size of the info block exceeds what can
> be read in a single transfer.
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> (cherry picked from ndyer/linux/for-upstream commit 74c4f5277cfa403d43fafc404119dc57a08677db)
> [gdavis: Forward port and fix conflicts due to v4.14.51 commit
> 	 960fe000b1d3 ("Input: atmel_mxt_ts - fix the firmware
> 	 update").]
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 27 +++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 9b165d23e092..2d70ddf71cd9 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -40,7 +40,7 @@
>  #define MXT_OBJECT_START	0x07
>  #define MXT_OBJECT_SIZE		6
>  #define MXT_INFO_CHECKSUM_SIZE	3
> -#define MXT_MAX_BLOCK_WRITE	256
> +#define MXT_MAX_BLOCK_WRITE	255
>  
>  /* Object types */
>  #define MXT_DEBUG_DIAGNOSTIC_T37	37
> @@ -659,6 +659,27 @@ static int __mxt_read_reg(struct i2c_client *client,
>  	return ret;
>  }
>  
> +static int mxt_read_blks(struct mxt_data *data, u16 start, u16 count, u8 *buf)

Can we call this __mxt_read_reg() and the original read reg call
__mxt_read_chunk()?

> +{
> +	u16 offset = 0;
> +	int error;
> +	u16 size;
> +
> +	while (offset < count) {
> +		size = min(MXT_MAX_BLOCK_WRITE, count - offset);
> +
> +		error = __mxt_read_reg(data->client,
> +				       start + offset,
> +				       size, buf + offset);
> +		if (error)
> +			return error;
> +
> +		offset += size;
> +	}
> +
> +	return 0;
> +}

Thanks.

-- 
Dmitry
