From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD
 config option
Date: Thu, 22 Sep 2011 11:35:07 -0600
Message-ID: <20110922173507.GN17168@ponder.secretlab.ca>
References: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
 <1316427553-5033-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316427553-5033-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

On Mon, Sep 19, 2011 at 03:49:12PM +0530, Thomas Abraham wrote:
> For platforms using device tree, the static keypad device instances
> are not required and SAMSUNG_DEV_KEYPAD is not selected. Since,
> samsung keypad driver has dependency on SAMSUNG_DEV_KEYPAD config
> option, the driver is left out of the compilation for dt enabled
> platforms.
> 
> An additional config option 'HAVE_SAMSUNG_KEYPAD' is added
> which the device tree based platforms can select. This config
> option is added as an alternative dependency for keypad driver.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/input/keyboard/Kconfig |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index b4dee9d..7c322a3 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called pmic8xxx-keypad.
>  
> +config HAVE_SAMSUNG_KEYPAD
> +	bool
> +	help
> +	  This will include Samsung Keypad controller driver support. If you
> +	  want to include Samsung Keypad support for any machine, kindly
> +	  select this in the respective mach-xxxx/Kconfig file.
> +
>  config KEYBOARD_SAMSUNG
>  	tristate "Samsung keypad support"
> -	depends on SAMSUNG_DEV_KEYPAD
> +	depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD

It would be better to modify SAMSUNG_DEV_KEYPAD to select
HAVE_SAMSUNG_KEYPAD and then make KEYBOARD_SAMSUNG only depend on
HAVE_SAMSUNG_KEYPAD instead of both.

g.
