From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: keyboard: allow to select IMX SNVS Power Key
 driver for i.MX 7D
Date: Mon, 28 Jan 2019 10:26:20 -0800
Message-ID: <20190128182620.GB30191@dtor-ws>
References: <20190128160305.22398-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128160305.22398-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: arnd@arndb.de, peng.fan@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 28, 2019 at 05:03:05PM +0100, Stefan Agner wrote:
> The i.MX SNVS Power Key driver supports the i.MX 7D SoC family too.
> Allow to enable the i.MX SNVS Power Key driver even if only i.MX 7D
> SoC is selected.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4713957b0cbb..a878351f1643 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -420,7 +420,7 @@ config KEYBOARD_MPR121
>  
>  config KEYBOARD_SNVS_PWRKEY
>  	tristate "IMX SNVS Power Key Driver"
> -	depends on SOC_IMX6SX
> +	depends on SOC_IMX6SX || SOC_IMX7D
>  	depends on OF
>  	help
>  	  This is the snvs powerkey driver for the Freescale i.MX application
> -- 
> 2.20.1
> 

-- 
Dmitry
