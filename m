From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: omap-keypad - fix error handling code
Date: Mon, 10 Apr 2017 20:48:48 -0700
Message-ID: <20170411034848.GF4346@dtor-ws>
References: <20170408171858.7266-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170408171858.7266-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 08, 2017 at 07:18:58PM +0200, Christophe JAILLET wrote:
> According to the previous error handling code, it is likely that
> 'goto err_free_keymap' is expected here in order to avoid a memory leak
> in error handling path.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

> ---
>  drivers/input/keyboard/omap4-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index ebc67ba41fe2..940d38b08e6b 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -358,7 +358,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
>  				     "omap4-keypad", keypad_data);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register interrupt\n");
> -		goto err_free_input;
> +		goto err_free_keymap;
>  	}
>  
>  	device_init_wakeup(&pdev->dev, true);
> -- 
> 2.11.0
> 

-- 
Dmitry
