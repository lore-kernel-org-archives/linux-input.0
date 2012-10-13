From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] input: Convert struct i2c_msg initialization to C99
 format
Date: Fri, 12 Oct 2012 23:19:22 -0700
Message-ID: <20121013061922.GC10969@core.coreip.homeip.net>
References: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
 <1349782278-9023-2-git-send-email-shubhrajyoti@ti.com>
 <20121010110228.3cbccde3@endymion.delvare>
 <CAM=Q2ctFe29-Dyi+jn6s=-ybQBzXoNERSXeXCQwSCsKUAv8=XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctFe29-Dyi+jn6s=-ybQBzXoNERSXeXCQwSCsKUAv8=XA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 10, 2012 at 05:05:39PM +0530, Shubhrajyoti Datta wrote:
> On Wed, Oct 10, 2012 at 2:32 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Tue, 9 Oct 2012 17:01:18 +0530, Shubhrajyoti D wrote:
> [...]
> >
> > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> 
> thanks updated patch below
> From 6638ecfa7982f95815382922c50573712c9626d7 Mon Sep 17 00:00:00 2001
> From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Date: Mon, 17 Sep 2012 19:37:17 +0530
> Subject: [PATCHv2 1/2] input: Convert struct i2c_msg initialization to C99
>  format
> 
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Applied both, thanks Shubhrajyoti.

> ---
>  drivers/input/touchscreen/cy8ctmg110_ts.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c
> b/drivers/input/touchscreen/cy8ctmg110_ts.c
> index 464f1bf..ad6a664 100644
> --- a/drivers/input/touchscreen/cy8ctmg110_ts.c
> +++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
> @@ -99,9 +99,18 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
>  	int ret;
>  	struct i2c_msg msg[2] = {
>  		/* first write slave position to i2c devices */
> -		{ client->addr, 0, 1, &cmd },
> +		{
> +			.addr = client->addr,
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
> -- 
> 1.7.5.4

-- 
Dmitry
