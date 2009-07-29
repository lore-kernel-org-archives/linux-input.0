From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [ARM] pxa/spitz: use GPIO matrix keypad driver
Date: Wed, 29 Jul 2009 17:07:39 +0200
Message-ID: <20090729150738.GH1534@ucw.cz>
References: <1248090115-20571-1-git-send-email-eric.y.miao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54184 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZG2PHt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2009 11:07:49 -0400
Content-Disposition: inline
In-Reply-To: <1248090115-20571-1-git-send-email-eric.y.miao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon 2009-07-20 19:41:54, Eric Miao wrote:
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

Does this make some other driver obsolete? Should we disable the other
one or even remove it completely?



> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index dda310f..e3156a0 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -24,6 +24,7 @@
>  #include <linux/spi/ads7846.h>
>  #include <linux/spi/corgi_lcd.h>
>  #include <linux/mtd/sharpsl.h>
> +#include <linux/input/matrix_keypad.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -111,6 +112,26 @@ static unsigned long spitz_pin_config[] __initdata = {
>  	GPIO105_GPIO,	/* SPITZ_GPIO_CF_IRQ */
>  	GPIO106_GPIO,	/* SPITZ_GPIO_CF2_IRQ */
>  
> +	/* GPIO matrix keypad */
> +	GPIO88_GPIO,	/* column 0 */
> +	GPIO23_GPIO,	/* column 1 */
> +	GPIO24_GPIO,	/* column 2 */
> +	GPIO25_GPIO,	/* column 3 */
> +	GPIO26_GPIO,	/* column 4 */
> +	GPIO27_GPIO,	/* column 5 */
> +	GPIO52_GPIO,	/* column 6 */
> +	GPIO103_GPIO,	/* column 7 */
> +	GPIO107_GPIO,	/* column 8 */
> +	GPIO108_GPIO,	/* column 9 */
> +	GPIO114_GPIO,	/* column 10 */
> +	GPIO12_GPIO,	/* row 0 */
> +	GPIO17_GPIO,	/* row 1 */
> +	GPIO91_GPIO,	/* row 2 */
> +	GPIO34_GPIO,	/* row 3 */
> +	GPIO36_GPIO,	/* row 4 */
> +	GPIO38_GPIO,	/* row 5 */
> +	GPIO39_GPIO,	/* row 6 */
> +
>  	/* I2C */
>  	GPIO117_I2C_SCL,
>  	GPIO118_I2C_SDA,
> @@ -242,9 +263,106 @@ EXPORT_SYMBOL(spitzscoop2_device);
>  /*
>   * Spitz Keyboard Device
>   */
> +#define SPITZ_KEY_CALENDAR	KEY_F1
> +#define SPITZ_KEY_ADDRESS	KEY_F2
> +#define SPITZ_KEY_FN		KEY_F3
> +#define SPITZ_KEY_CANCEL	KEY_F4
> +#define SPITZ_KEY_EXOK		KEY_F5
> +#define SPITZ_KEY_EXCANCEL	KEY_F6
> +#define SPITZ_KEY_EXJOGDOWN	KEY_F7
> +#define SPITZ_KEY_EXJOGUP	KEY_F8
> +#define SPITZ_KEY_JAP1		KEY_LEFTALT
> +#define SPITZ_KEY_JAP2		KEY_RIGHTCTRL
> +#define SPITZ_KEY_SYNC		KEY_F9
> +#define SPITZ_KEY_MAIL		KEY_F10
> +#define SPITZ_KEY_OK		KEY_F11
> +#define SPITZ_KEY_MENU		KEY_F12
> +
> +static const uint32_t spitzkbd_keymap[] = {
> +	KEY(0, 0, KEY_LEFTCTRL),
> +	KEY(0, 1, KEY_1),
> +	KEY(0, 2, KEY_3),
> +	KEY(0, 3, KEY_5),
> +	KEY(0, 4, KEY_6),
> +	KEY(0, 5, KEY_7),
> +	KEY(0, 6, KEY_9),
> +	KEY(0, 7, KEY_0),
> +	KEY(0, 8, KEY_BACKSPACE),
> +	KEY(0, 9, SPITZ_KEY_EXOK),	/* EXOK */
> +	KEY(0, 10, SPITZ_KEY_EXCANCEL),	/* EXCANCEL */
> +	KEY(1, 1, KEY_2),
> +	KEY(1, 2, KEY_4),
> +	KEY(1, 3, KEY_R),
> +	KEY(1, 4, KEY_Y),
> +	KEY(1, 5, KEY_8),
> +	KEY(1, 6, KEY_I),
> +	KEY(1, 7, KEY_O),
> +	KEY(1, 8, KEY_P),
> +	KEY(1, 9, SPITZ_KEY_EXJOGDOWN),	/* EXJOGDOWN */
> +	KEY(1, 10, SPITZ_KEY_EXJOGUP),	/* EXJOGUP */
> +	KEY(2, 0, KEY_TAB),
> +	KEY(2, 1, KEY_Q),
> +	KEY(2, 2, KEY_E),
> +	KEY(2, 3, KEY_T),
> +	KEY(2, 4, KEY_G),
> +	KEY(2, 5, KEY_U),
> +	KEY(2, 6, KEY_J),
> +	KEY(2, 7, KEY_K),
> +	KEY(3, 0, SPITZ_KEY_ADDRESS),	/* ADDRESS */
> +	KEY(3, 1, KEY_W),
> +	KEY(3, 2, KEY_S),
> +	KEY(3, 3, KEY_F),
> +	KEY(3, 4, KEY_V),
> +	KEY(3, 5, KEY_H),
> +	KEY(3, 6, KEY_M),
> +	KEY(3, 7, KEY_L),
> +	KEY(3, 9, KEY_RIGHTSHIFT),
> +	KEY(4, 0, SPITZ_KEY_CALENDAR),	/* CALENDAR */
> +	KEY(4, 1, KEY_A),
> +	KEY(4, 2, KEY_D),
> +	KEY(4, 3, KEY_C),
> +	KEY(4, 4, KEY_B),
> +	KEY(4, 5, KEY_N),
> +	KEY(4, 6, KEY_DOT),
> +	KEY(4, 8, KEY_ENTER),
> +	KEY(4, 9, KEY_LEFTSHIFT),
> +	KEY(5, 0, SPITZ_KEY_MAIL),	/* MAIL */
> +	KEY(5, 1, KEY_Z),
> +	KEY(5, 2, KEY_X),
> +	KEY(5, 3, KEY_MINUS),
> +	KEY(5, 4, KEY_SPACE),
> +	KEY(5, 5, KEY_COMMA),
> +	KEY(5, 7, KEY_UP),
> +	KEY(5, 10, SPITZ_KEY_FN),	/* FN */
> +	KEY(6, 0, KEY_SYSRQ),
> +	KEY(6, 1, SPITZ_KEY_JAP1),	/* JAP1 */
> +	KEY(6, 2, SPITZ_KEY_JAP2),	/* JAP2 */
> +	KEY(6, 3, SPITZ_KEY_CANCEL),	/* CANCEL */
> +	KEY(6, 4, SPITZ_KEY_OK),	/* OK */
> +	KEY(6, 5, SPITZ_KEY_MENU),	/* MENU */
> +	KEY(6, 6, KEY_LEFT),
> +	KEY(6, 7, KEY_DOWN),
> +	KEY(6, 8, KEY_RIGHT),
> +};
> +
> +static struct matrix_keypad_platform_data spitzkbd_pdata = {
> +	.keymap		= spitzkbd_keymap,
> +	.keymap_size	= ARRAY_SIZE(spitzkbd_keymap),
> +	.col_gpios	= {88, 23, 24, 25, 26, 27, 52, 103, 107, 108, 114, -1},
> +	.row_gpios	= {12, 17, 91, 34, 36, 38, 39, -1},
> +	.num_col_gpios	= 11,
> +	.num_row_gpios	= 7,
> +	.col_scan_delay_us	= 10,
> +	.debounce_ms		= 10,
> +	.wakeup			= 1,
> +};
> +
>  static struct platform_device spitzkbd_device = {
> -	.name		= "spitz-keyboard",
> +	.name		= "matrix-keypad",
>  	.id		= -1,
> +	.dev		= {
> +		.platform_data = &spitzkbd_pdata,
> +	},
>  };
>  
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
