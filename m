From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Apple SPI keyboard needs CRC16
Date: Tue, 23 Jul 2019 16:42:35 +0300
Message-ID: <20190723134235.GA845@penguin>
References: <20190723115905.2092687-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190723115905.2092687-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 23, 2019 at 01:58:45PM +0200, Arnd Bergmann wrote:
> In some rare randconfig builds, CRC16 is disabled, which leads
> to a link error:
> 
> drivers/input/keyboard/applespi.o: In function `applespi_send_cmd_msg':
> applespi.c:(.text+0x449f): undefined reference to `crc16'
> drivers/input/keyboard/applespi.o: In function `applespi_verify_crc':
> applespi.c:(.text+0x7538): undefined reference to `crc16'
> 
> This symbol is meant to be selected for each user in Kconfig,
> so do that here as well.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 8e9c3ea9d5e7..ebb19e21473e 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -76,6 +76,7 @@ config KEYBOARD_APPLESPI
>  	depends on ACPI && EFI
>  	depends on SPI
>  	depends on X86 || COMPILE_TEST
> +	select CRC16
>  	help
>  	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
>  	  or any MacBookPro13,* or MacBookPro14,*.
> -- 
> 2.20.0
> 

-- 
Dmitry
