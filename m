From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: imx: use
 devm_platform_ioremap_resource() to simplify code
Date: Mon, 20 May 2019 22:12:10 -0700
Message-ID: <20190521051210.GE183429@dtor-ws>
References: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 01, 2019 at 05:28:12AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/imx_keypad.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 539cb67..cf08f4a 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -422,7 +422,6 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  			dev_get_platdata(&pdev->dev);
>  	struct imx_keypad *keypad;
>  	struct input_dev *input_dev;
> -	struct resource *res;
>  	int irq, error, i, row, col;
>  
>  	if (!keymap_data && !pdev->dev.of_node) {
> @@ -455,8 +454,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  	timer_setup(&keypad->check_matrix_timer,
>  		    imx_keypad_check_for_events, 0);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
> +	keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(keypad->mmio_base))
>  		return PTR_ERR(keypad->mmio_base);
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
