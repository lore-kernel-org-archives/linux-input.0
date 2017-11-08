From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] Input: ad7897 - use managed allocated resources
Date: Wed, 8 Nov 2017 16:31:53 +0100
Message-ID: <dda00dd7-5174-4aef-1824-1c1fda0688f6@metafoo.de>
References: <20171108140403.727-1-andi@etezian.org>
 <20171108140403.727-2-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108140403.727-2-andi@etezian.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

On 11/08/2017 03:04 PM, Andi Shyti wrote:
> Use managed allocated resources to simplify error handling during
> probing failure and module exiting.
> 
> With this all the goto labels in the probe function together with
> the cleanups in the remove function are unnecessary, therefore
> removed.
> 
> CC: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/ad7877.c | 42 +++++++++-----------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 0381c7809d1b..c8a143db8681 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -707,12 +707,10 @@ static int ad7877_probe(struct spi_device *spi)
>  		return err;
>  	}
>  
> -	ts = kzalloc(sizeof(struct ad7877), GFP_KERNEL);
> -	input_dev = input_allocate_device();
> -	if (!ts || !input_dev) {
> -		err = -ENOMEM;
> -		goto err_free_mem;
> -	}
> +	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
> +	input_dev = devm_input_allocate_device(&spi->dev);
> +	if (!input_dev)

You removed the check for 'ts' here and only added it back in patch 3.

> +		return -ENOMEM;
>  
>  	spi_set_drvdata(spi, ts);
>  	ts->spi = spi;
[...]
