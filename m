From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Thu, 29 Dec 2011 15:14:46 -0600
Message-ID: <4EFCD846.40901@gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net> <1325184146-3527-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47032 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab1L2VOt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 16:14:49 -0500
In-Reply-To: <1325184146-3527-1-git-send-email-olof@lixom.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, Rakesh Iyer <riyer@nvidia.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/29/2011 12:42 PM, Olof Johansson wrote:
> This adds a simple device tree binding for simple key matrix data.
> 
> Changes since v1:
>  * Removed samsung-style binding support
>  * Added linux,fn-keymap and linux,fn-key optional properties
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  .../devicetree/bindings/input/matrix-keymap.txt    |   25 ++++++
>  drivers/input/keyboard/Makefile                    |    1 +
>  drivers/input/keyboard/keymap.c                    |   78 ++++++++++++++++++++
>  include/linux/input/matrix_keypad.h                |   34 +++++----
>  4 files changed, 123 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
>  create mode 100644 drivers/input/keyboard/keymap.c
> 
> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> new file mode 100644
> index 0000000..480ca46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> @@ -0,0 +1,25 @@
> +For matrix keyboards there are two kinds of layout bindings using
> +linux key codes.

Need to update this.

> +
> +Required properties:
> +- compatible: "matrix-keyboard-controller"
> +- linux,keymap: an array of 3-cell entries containing the equivalent
> +  of the three separate properties above: row, column and linux
> +  key-code.
> +

How about just embedding the row/column information as the array
position in the keymap? Then you only need 1 cell per key. Sparsely
populated matrices are probably the exception. If more than 1/3 of the
keys are present, you come out ahead in terms of data usage. You would
need to specify the number of rows and columns, but that is probably
easier than determining the max from the keymap.

Rob

> +Optional properties:
> +- linux,fn-keymap: A separate array of 3-cell entries similar to
> +  linux,keymap but only to be used when the function key modifier is
> +  active. This is used for keyboards that have a software-based modifier
> +  key for 'Fn' but that need to describe the custom layout that should
> +  be used when said modifier key is active.
> +
> +- linux,fn-key: a 2-cell entry containing the < row column > of the
> +  function modifier key used to switch to the above linux,fn-keymap
> +  layout.
> +
> +Example:
> +	linux,keymap = < 0 3 2
> +			 0 4 5 >;
> +	linux,fn-key = < 2 1 >;
> +	linux,fn-keymap = < 0 3 1 >;
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index df7061f..83e6eed 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -4,6 +4,7 @@
>  
>  # Each configuration option enables a list of files.
>  
> +obj-$(CONFIG_INPUT_KEYBOARD)		+= keymap.o
>  obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
> diff --git a/drivers/input/keyboard/keymap.c b/drivers/input/keyboard/keymap.c
> new file mode 100644
> index 0000000..80d1074
> --- /dev/null
> +++ b/drivers/input/keyboard/keymap.c
> @@ -0,0 +1,78 @@
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/input.h>
> +#include <linux/of.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/slab.h>
> +
> +void matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
> +				unsigned int row_shift,
> +				unsigned short *keymap, unsigned long *keybit)
> +{
> +	int i;
> +
> +	for (i = 0; i < keymap_data->keymap_size; i++) {
> +		unsigned int key = keymap_data->keymap[i];
> +		unsigned int row = KEY_ROW(key);
> +		unsigned int col = KEY_COL(key);
> +		unsigned short code = KEY_VAL(key);
> +
> +		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
> +		__set_bit(code, keybit);
> +	}
> +	__clear_bit(KEY_RESERVED, keybit);
> +}
> +EXPORT_SYMBOL_GPL(matrix_keypad_build_keymap);
> +
> +#ifdef CONFIG_OF
> +struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np)
> +{
> +	struct matrix_keymap_data *kd;
> +	struct device_node *knp;
> +	int proplen = 0, i;
> +	u32 *keymap, row, col, key_code;
> +	const __be32 *prop = of_get_property(np, "linux,keymap", &proplen);
> +
> +	if (!of_device_is_compatible(np, "matrix-keyboard-controller"))
> +		return NULL;
> +
> +	kd = kmalloc(sizeof(*kd), GFP_KERNEL);
> +	if (!kd)
> +		return NULL;
> +	kd->keymap_size = proplen / 3;
> +
> +	keymap = kzalloc(kd->keymap_size * sizeof(u32), GFP_KERNEL);
> +	if (!keymap) {
> +		kfree(kd);
> +		return NULL;
> +	}
> +
> +	kd->keymap = keymap;
> +
> +	for (i = 0; i < kd->keymap_size; i++){
> +		/* property format is < row column keycode > */
> +		row = be32_to_cpup(prop++);
> +		col = be32_to_cpup(prop++);
> +		key_code = be32_to_cpup(prop++);
> +		*keymap++ = KEY(row, col, key_code);
> +	}
> +
> +	/* FIXME: Need to add handling of the linux,fn-keymap property here */
> +
> +	return kd;
> +}
> +EXPORT_SYMBOL_GPL(matrix_keyboard_of_fill_keymap);
> +
> +void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
> +{
> +	if (!kd)
> +		return;
> +	if (kd->keymap)
> +		kfree(kd->keymap);
> +	kfree(kd);
> +}
> +EXPORT_SYMBOL_GPL(matrix_keyboard_of_free_keymap);
> +#endif
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> index fe7c4b9..ac999c6 100644
> --- a/include/linux/input/matrix_keypad.h
> +++ b/include/linux/input/matrix_keypad.h
> @@ -3,6 +3,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/input.h>
> +#include <linux/of.h>
>  
>  #define MATRIX_MAX_ROWS		32
>  #define MATRIX_MAX_COLS		32
> @@ -87,23 +88,26 @@ struct matrix_keypad_platform_data {
>   * an array of keycodes that is suitable for using in a standard matrix
>   * keyboard driver that uses row and col as indices.
>   */
> +void matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
> +				unsigned int row_shift,
> +				unsigned short *keymap, unsigned long *keybit);
> +
> +#ifdef CONFIG_OF
> +struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np);
> +
> +void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd);
> +#else
> +static inline struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np)
> +{
> +	return NULL;
> +}
> +
>  static inline void
> -matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
> -			   unsigned int row_shift,
> -			   unsigned short *keymap, unsigned long *keybit)
> +matrix_keyboard_of_free_keymap(const struct matrix_keymap_data *kd)
>  {
> -	int i;
> -
> -	for (i = 0; i < keymap_data->keymap_size; i++) {
> -		unsigned int key = keymap_data->keymap[i];
> -		unsigned int row = KEY_ROW(key);
> -		unsigned int col = KEY_COL(key);
> -		unsigned short code = KEY_VAL(key);
> -
> -		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
> -		__set_bit(code, keybit);
> -	}
> -	__clear_bit(KEY_RESERVED, keybit);
>  }
> +#endif
>  
>  #endif /* _MATRIX_KEYPAD_H */

