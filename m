From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 01/12] mfd: rk808: fix up the chip id get failed
Date: Tue, 8 Aug 2017 11:45:16 +0100
Message-ID: <20170808104516.46v7xotwq5brr6k6@dell>
References: <1501762841-20262-1-git-send-email-chenjh@rock-chips.com>
 <1501762841-20262-2-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501762841-20262-2-git-send-email-chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wdc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.egorov-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 03 Aug 2017, Joseph Chen wrote:

> From: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> the rk8xx chip id is:
> ((MSB << 8) | LSB) & 0xfff0
> 
> Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Joseph Chen <chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/mfd/rk808.c       | 21 +++++++++++++++------
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index fd087cb..3334a2a 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -325,7 +325,7 @@ static int rk808_probe(struct i2c_client *client,
>  	void (*pm_pwroff_fn)(void);
>  	int nr_pre_init_regs;
>  	int nr_cells;
> -	int pm_off = 0;
> +	int pm_off = 0, msb, lsb;
>  	int ret;
>  	int i;
>  
> @@ -333,14 +333,23 @@ static int rk808_probe(struct i2c_client *client,
>  	if (!rk808)
>  		return -ENOMEM;
>  
> -	rk808->variant = i2c_smbus_read_word_data(client, RK808_ID_MSB);
> -	if (rk808->variant < 0) {
> -		dev_err(&client->dev, "Failed to read the chip id at 0x%02x\n",
> +	/* read Chip variant */

Nit: This should read "Read chip variant"

However, I realise that the rest of the comments do not use correctly
formatted English grammar either, so just s/Chip/chip/.

Once fixed you can apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
