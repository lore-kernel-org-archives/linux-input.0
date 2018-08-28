From: Andi Shyti <andi@smida.it>
Subject: Re: [PATCH] input: olpc_apsp: remove unused pointer 'np'
Date: Tue, 28 Aug 2018 18:14:38 +0300
Message-ID: <20180828151438.GA10857@jack.zhora.eu>
References: <20180828145648.11619-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828145648.11619-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Colin,

On Tue, Aug 28, 2018 at 03:56:48PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'nb' is being assigned but is never used hence it is

'np' here. Other than that,

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi

> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'np' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/input/serio/olpc_apsp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 8e9a4209fcad..8bd8ed25946f 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -172,7 +172,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	struct serio *kb_serio, *pad_serio;
>  	struct olpc_apsp *priv;
>  	struct resource *res;
> -	struct device_node *np;
>  	unsigned long l;
>  	int error;
>  
> @@ -180,7 +179,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	np = pdev->dev.of_node;
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base)) {
> -- 
> 2.17.1
