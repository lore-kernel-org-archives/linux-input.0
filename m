From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: olpc_apsp - assign priv->dev earlier
Date: Wed, 16 Jan 2019 23:12:23 -0800
Message-ID: <20190117071223.GB8109@dtor-ws>
References: <20190116094438.1921667-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116094438.1921667-1-lkundrak@v3.sk>
Sender: stable-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 16, 2019 at 10:44:38AM +0100, Lubomir Rintel wrote:
> The dev field needs to be set when serio_register_port() is called,
> because the open callback may use it (in the error handling path).
> 
> Cc: stable@vger.kernel.org # v4.18+
> Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open(), not probe()")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied, thank you.

> ---
>  drivers/input/serio/olpc_apsp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 0aece9777087..554f4b8228d2 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -198,6 +198,8 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->dev = &pdev->dev;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base)) {
> @@ -261,7 +263,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> -	priv->dev = &pdev->dev;
>  	device_init_wakeup(priv->dev, 1);
>  	platform_set_drvdata(pdev, priv);
>  
> -- 
> 2.20.1
> 

-- 
Dmitry
