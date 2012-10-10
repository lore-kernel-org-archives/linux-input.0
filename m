From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/4] input: Convert struct i2c_msg initialization to C99
 format
Date: Wed, 10 Oct 2012 11:02:28 +0200
Message-ID: <20121010110228.3cbccde3@endymion.delvare>
References: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
	<1349782278-9023-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349782278-9023-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 9 Oct 2012 17:01:18 +0530, Shubhrajyoti D wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/input/touchscreen/cy8ctmg110_ts.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
> index 464f1bf..f4cfedf 100644
> --- a/drivers/input/touchscreen/cy8ctmg110_ts.c
> +++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
> @@ -99,9 +99,19 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
>  	int ret;
>  	struct i2c_msg msg[2] = {
>  		/* first write slave position to i2c devices */
> -		{ client->addr, 0, 1, &cmd },
> +		{
> +			.addr = client->addr,
> +			.flags = 0,

You can actually omit fields with value 0, that's one of the benefits
of C99-style struct initialization.

> +			.len = 1,
> +			.buf = &cmd
> +		},
>  		/* Second read data from position */
> -		{ client->addr, I2C_M_RD, len, data }
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = len,
> +			.buf = data
> +		}
>  	};
>  
>  	ret = i2c_transfer(client->adapter, msg, 2);

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
