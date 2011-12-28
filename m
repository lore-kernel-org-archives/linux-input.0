From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Wed, 28 Dec 2011 17:30:32 -0600
Message-ID: <4EFBA698.6080601@gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325112771-31941-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Olof,

On 12/28/2011 04:52 PM, Olof Johansson wrote:
> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This adds a basic device tree binding for simple key matrix data.
> 
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> ---
> 
> Based on email exchange this morning, this is a first cut at a shared
> definition and helper function to parse and fill in the keymap data.
> 
> Instead of doing the direct parsing into the final keymap format, I
> chose to fill in the pdata-equivalent since that is how the OF pdata
> fillers work right now if code is to be kept common with the legacy
> platform_device probe interface.
> 
> This is a prerequisite for a revised version of the tegra-kbc device
> tree support that I will repost separately once this interface is stable.
> 
> 
> -Olof
> 
>  .../devicetree/bindings/input/matrix-keymap.txt    |   35 ++++++++++++
>  include/linux/input/matrix_keypad.h                |   55 ++++++++++++++++++++
>  2 files changed, 90 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> new file mode 100644
> index 0000000..894f786
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> @@ -0,0 +1,35 @@
> +For matrix keyboards there are two kinds of layout bindings using
> +linux key codes.
> +
> +Required properties:
> +- compatible: "matrix-keyboard-controller"

Seems like this is not really needed. You've already matched the node
before you call matrix_keyboard_of_fill_keymap.

> +
> +For simple keyboards with just a few buttons, you can specify each key
> +as a subnode of the keyboard controller, with the following
> +properties:
> +
> +- keypad,row: the row number to which the key is connected.
> +- keypad,column: the column number to which the key is connected.
> +- linux,code: the key-code to be reported when the key is pressed
> +  and released.
> +
> +Example:
> +
> +	key_1 {
> +		keypad,row = <0>;
> +		keypad,column = <3>;
> +		linux,code = <2>;
> +	};
> +
> +
> +For a more complex keyboard, such as a full laptop, a more compact
> +binding can be used instead, with the following property directly in
> +the keyboard controller node:
> +
> +- linux,keymap: an array of 3-cell entries containing the equivalent
> +  of the three separate properties above: row, column and linux
> +  key-code.
> +
> +Example:
> +	linux,keymap = < 0 3 2
> +			 0 4 5 >;
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> index fe7c4b9..ff13cd3 100644
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
> @@ -106,4 +107,58 @@ matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
>  	__clear_bit(KEY_RESERVED, keybit);
>  }
>  
> +#ifdef CONFIG_OF
> +static inline struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np)
> +{

Seems a bit large to inline.

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
> +	for_each_child_of_node(np, knp)
> +		kd->keymap_size++;
> +
> +	keymap = kzalloc(kd->keymap_size * sizeof(u32), GFP_KERNEL);
> +	if (!keymap) {
> +		kfree(kd);
> +		return NULL;
> +	}

Looks like memory leaks would be very likely. Is the caller expected to
free these? If so, a matching free function should be provided. Perhaps
trying to keep platform_data compatibility is not the best approach if
it would simplify this.

Rob

> +
> +	kd->keymap = keymap;
> +
> +	for (i = 0; i < proplen/3; i++){
> +		/* property format is < row column keycode > */
> +		row = be32_to_cpup(prop++);
> +		col = be32_to_cpup(prop++);
> +		key_code = be32_to_cpup(prop++);
> +		*keymap++ = KEY(row, col, key_code);
> +	}
> +
> +	for_each_child_of_node(np, knp) {
> +               of_property_read_u32(knp, "keypad,row", &row);
> +               of_property_read_u32(knp, "keypad,column", &col);
> +               of_property_read_u32(knp, "linux,code", &key_code);
> +               *keymap++ = KEY(row, col, key_code);
> +	}
> +
> +	return kd;
> +}
> +#else
> +static inline struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif /* _MATRIX_KEYPAD_H */
