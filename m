From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 1/3] input: touchscreen: ad7879: move header to
 platform_data directory
Date: Tue, 08 Mar 2016 09:48:04 -0800
Message-ID: <afc23aafc04987ce05276122d7a8996f@agner.ch>
References: <1454455218-13004-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:59889 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbcCHRu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 12:50:57 -0500
In-Reply-To: <1454455218-13004-1-git-send-email-stefan@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dimitry,

Any chance this patchset makes it into 4.6?

Best regards,
Stefan

On 2016-02-02 15:20, Stefan Agner wrote:
> The header file is used by the SPI and I2C variant of the driver.
> Therefore, move it to a more generic place under platform_data.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v2:
> - (none)
> Changes since v1:
> - Move to include/linux/platform_data/
> 
>  arch/blackfin/mach-bf527/boards/ezbrd.c    |  2 +-
>  arch/blackfin/mach-bf527/boards/ezkit.c    |  2 +-
>  arch/blackfin/mach-bf527/boards/tll6527m.c |  2 +-
>  arch/blackfin/mach-bf537/boards/stamp.c    |  2 +-
>  arch/blackfin/mach-bf538/boards/ezkit.c    |  2 +-
>  drivers/input/touchscreen/ad7879.c         | 10 ++++----
>  include/linux/platform_data/ad7879.h       | 41 ++++++++++++++++++++++++++++++
>  include/linux/spi/ad7879.h                 | 41 ------------------------------
>  8 files changed, 51 insertions(+), 51 deletions(-)
>  create mode 100644 include/linux/platform_data/ad7879.h
>  delete mode 100644 include/linux/spi/ad7879.h
> 
> diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c
> b/arch/blackfin/mach-bf527/boards/ezbrd.c
> index a3a5723..80bcfd1 100644
> --- a/arch/blackfin/mach-bf527/boards/ezbrd.c
> +++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
> @@ -279,7 +279,7 @@ static const struct ad7877_platform_data
> bfin_ad7877_ts_info = {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  static const struct ad7879_platform_data bfin_ad7879_ts_info = {
>  	.model			= 7879,	/* Model = AD7879 */
>  	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
> diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c
> b/arch/blackfin/mach-bf527/boards/ezkit.c
> index d4219e8..571edfd 100644
> --- a/arch/blackfin/mach-bf527/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf527/boards/ezkit.c
> @@ -477,7 +477,7 @@ static const struct ad7877_platform_data
> bfin_ad7877_ts_info = {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  static const struct ad7879_platform_data bfin_ad7879_ts_info = {
>  	.model			= 7879,	/* Model = AD7879 */
>  	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
> diff --git a/arch/blackfin/mach-bf527/boards/tll6527m.c
> b/arch/blackfin/mach-bf527/boards/tll6527m.c
> index a0f5856..c1acce4 100644
> --- a/arch/blackfin/mach-bf527/boards/tll6527m.c
> +++ b/arch/blackfin/mach-bf527/boards/tll6527m.c
> @@ -29,7 +29,7 @@
>  #include <asm/dpmc.h>
>  
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  #define LCD_BACKLIGHT_GPIO 0x40
>  /* TLL6527M uses TLL7UIQ35 / ADI LCD EZ Extender. AD7879 AUX GPIO is used for
>   * LCD Backlight Enable
> diff --git a/arch/blackfin/mach-bf537/boards/stamp.c
> b/arch/blackfin/mach-bf537/boards/stamp.c
> index c181543..eaec7b4 100644
> --- a/arch/blackfin/mach-bf537/boards/stamp.c
> +++ b/arch/blackfin/mach-bf537/boards/stamp.c
> @@ -776,7 +776,7 @@ static const struct ad7877_platform_data
> bfin_ad7877_ts_info = {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  static const struct ad7879_platform_data bfin_ad7879_ts_info = {
>  	.model			= 7879,	/* Model = AD7879 */
>  	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
> diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c
> b/arch/blackfin/mach-bf538/boards/ezkit.c
> index ae2fcbb..4a03c44 100644
> --- a/arch/blackfin/mach-bf538/boards/ezkit.c
> +++ b/arch/blackfin/mach-bf538/boards/ezkit.c
> @@ -521,7 +521,7 @@ static struct bfin5xx_spi_chip spi_flash_chip_info = {
>  #endif	/* CONFIG_SPI_BFIN5XX */
>  
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_AD7879)
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  static const struct ad7879_platform_data bfin_ad7879_ts_info = {
>  	.model			= 7879,	/* Model = AD7879 */
>  	.x_plate_ohms		= 620,	/* 620 Ohm from the touch datasheet */
> diff --git a/drivers/input/touchscreen/ad7879.c
> b/drivers/input/touchscreen/ad7879.c
> index 16b5cc2..93b8ea2 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -31,7 +31,7 @@
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
>  
> -#include <linux/spi/ad7879.h>
> +#include <linux/platform_data/ad7879.h>
>  #include <linux/module.h>
>  #include "ad7879.h"
>  
> @@ -170,10 +170,10 @@ static int ad7879_report(struct ad7879 *ts)
>  	 * filter.  The combination of these two techniques provides a robust
>  	 * solution, discarding the spurious noise in the signal and keeping
>  	 * only the data of interest.  The size of both filters is
> -	 * programmable. (dev.platform_data, see linux/spi/ad7879.h) Other
> -	 * user-programmable conversion controls include variable acquisition
> -	 * time, and first conversion delay. Up to 16 averages can be taken
> -	 * per conversion.
> +	 * programmable. (dev.platform_data, see linux/platform_data/ad7879.h)
> +	 * Other user-programmable conversion controls include variable
> +	 * acquisition time, and first conversion delay. Up to 16 averages can
> +	 * be taken per conversion.
>  	 */
>  
>  	if (likely(x && z1)) {
> diff --git a/include/linux/platform_data/ad7879.h
> b/include/linux/platform_data/ad7879.h
> new file mode 100644
> index 0000000..69e2e1fd
> --- /dev/null
> +++ b/include/linux/platform_data/ad7879.h
> @@ -0,0 +1,41 @@
> +/* linux/platform_data/ad7879.h */
> +
> +/* Touchscreen characteristics vary between boards and models.  The
> + * platform_data for the device's "struct device" holds this information.
> + *
> + * It's OK if the min/max values are zero.
> + */
> +struct ad7879_platform_data {
> +	u16	model;			/* 7879 */
> +	u16	x_plate_ohms;
> +	u16	x_min, x_max;
> +	u16	y_min, y_max;
> +	u16	pressure_min, pressure_max;
> +
> +	bool	swap_xy;		/* swap x and y axes */
> +
> +	/* [0..255] 0=OFF Starts at 1=550us and goes
> +	 * all the way to 9.440ms in steps of 35us.
> +	 */
> +	u8	pen_down_acc_interval;
> +	/* [0..15] Starts at 0=128us and goes all the
> +	 * way to 4.096ms in steps of 128us.
> +	 */
> +	u8	first_conversion_delay;
> +	/* [0..3] 0 = 2us, 1 = 4us, 2 = 8us, 3 = 16us */
> +	u8	acquisition_time;
> +	/* [0..3] Average X middle samples 0 = 2, 1 = 4, 2 = 8, 3 = 16 */
> +	u8	averaging;
> +	/* [0..3] Perform X measurements 0 = OFF,
> +	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
> +	 */
> +	u8	median;
> +	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
> +	 * requires CONFIG_GPIOLIB
> +	 */
> +	bool	gpio_export;
> +	/* identifies the first GPIO number handled by this chip;
> +	 * or, if negative, requests dynamic ID allocation.
> +	 */
> +	s32	gpio_base;
> +};
> diff --git a/include/linux/spi/ad7879.h b/include/linux/spi/ad7879.h
> deleted file mode 100644
> index 58368be..0000000
> --- a/include/linux/spi/ad7879.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/* linux/spi/ad7879.h */
> -
> -/* Touchscreen characteristics vary between boards and models.  The
> - * platform_data for the device's "struct device" holds this information.
> - *
> - * It's OK if the min/max values are zero.
> - */
> -struct ad7879_platform_data {
> -	u16	model;			/* 7879 */
> -	u16	x_plate_ohms;
> -	u16	x_min, x_max;
> -	u16	y_min, y_max;
> -	u16	pressure_min, pressure_max;
> -
> -	bool	swap_xy;		/* swap x and y axes */
> -
> -	/* [0..255] 0=OFF Starts at 1=550us and goes
> -	 * all the way to 9.440ms in steps of 35us.
> -	 */
> -	u8	pen_down_acc_interval;
> -	/* [0..15] Starts at 0=128us and goes all the
> -	 * way to 4.096ms in steps of 128us.
> -	 */
> -	u8	first_conversion_delay;
> -	/* [0..3] 0 = 2us, 1 = 4us, 2 = 8us, 3 = 16us */
> -	u8	acquisition_time;
> -	/* [0..3] Average X middle samples 0 = 2, 1 = 4, 2 = 8, 3 = 16 */
> -	u8	averaging;
> -	/* [0..3] Perform X measurements 0 = OFF,
> -	 * 1 = 4, 2 = 8, 3 = 16 (median > averaging)
> -	 */
> -	u8	median;
> -	/* 1 = AUX/VBAT/GPIO export GPIO to gpiolib
> -	 * requires CONFIG_GPIOLIB
> -	 */
> -	bool	gpio_export;
> -	/* identifies the first GPIO number handled by this chip;
> -	 * or, if negative, requests dynamic ID allocation.
> -	 */
> -	s32	gpio_base;
> -};
