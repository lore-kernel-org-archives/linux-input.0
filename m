From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 148/304] Input: rotary-encoder - don't log
 EPROBE_DEFER to kernel log
Date: Mon, 28 Jan 2019 10:24:05 -0800
Message-ID: <20190128182405.GA30191@dtor-ws>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-148-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128154341.47195-148-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Sasha,

On Mon, Jan 28, 2019 at 10:41:05AM -0500, Sasha Levin wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> [ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]
> 
> When a driver fails to bind because a resource it still missing it's not
> helpful to report this as (usually) probing is repeated later.

I do not think that patch that merely suppresses a harmless warning in
dmesg belongs in stable.

> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/misc/rotary_encoder.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 30ec77ad32c6..d748897bf5e9 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -240,8 +240,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  
>  	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
>  	if (IS_ERR(encoder->gpios)) {
> -		dev_err(dev, "unable to get gpios\n");
> -		return PTR_ERR(encoder->gpios);
> +		err = PTR_ERR(encoder->gpios);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "unable to get gpios: %d\n", err);
> +		return err;
>  	}
>  	if (encoder->gpios->ndescs < 2) {
>  		dev_err(dev, "not enough gpios found\n");
> -- 
> 2.19.1
> 

Thanks.

-- 
Dmitry
