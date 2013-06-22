From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v1 02/12] input: matrix-keymap: func call coding style nit
Date: Sat, 22 Jun 2013 04:18:59 +0200
Message-ID: <201306220418.59722.marex@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-3-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59200 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab3FVCTI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 22:19:08 -0400
In-Reply-To: <1371838198-7327-3-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>

Dear Gerhard Sittig,

> make the matrix_keypad_map_key() routine return an error code
> instead of boolean, as its name suggests an action and not a query
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/input/matrix-keymap.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
> index 08b61f5..b7091f2 100644
> --- a/drivers/input/matrix-keymap.c
> +++ b/drivers/input/matrix-keymap.c
> @@ -27,9 +27,10 @@
>  #include <linux/module.h>
>  #include <linux/input/matrix_keypad.h>
> 
> -static bool matrix_keypad_map_key(struct input_dev *input_dev,
> -				  unsigned int rows, unsigned int cols,
> -				  unsigned int row_shift, unsigned int key)
> +/* translates packed row/col/code specs to the corresponding keycode[]
> item */ +static int matrix_keypad_map_key(struct input_dev *input_dev,
> +				 unsigned int rows, unsigned int cols,
> +				 unsigned int row_shift, unsigned int key)
>  {
>  	unsigned short *keymap = input_dev->keycode;
>  	unsigned int row = KEY_ROW(key);
> @@ -40,13 +41,13 @@ static bool matrix_keypad_map_key(struct input_dev
> *input_dev, dev_err(input_dev->dev.parent,
>  			"%s: invalid keymap entry 0x%x (row: %d, col: %d, rows: 
%d, cols:
> %d)\n", __func__, key, row, col, rows, cols);
> -		return false;
> +		return -ERANGE;
>  	}
> 
>  	keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
>  	__set_bit(code, input_dev->keybit);
> 
> -	return true;
> +	return 0;
>  }
> 
>  #ifdef CONFIG_OF
> @@ -109,8 +110,8 @@ static int matrix_keypad_parse_of_keymap(const char
> *propname, for (i = 0; i < size; i++) {
>  		unsigned int key = be32_to_cpup(prop + i);
> 
> -		if (!matrix_keypad_map_key(input_dev, rows, cols,
> -					   row_shift, key))

ret = matrix_keypad_map_key(input_dev, rows, cols, row_shift, key);
if (ret)
	return ret;

Now that you return correct error codes from above, you should propagate them 
through.

Best regards,
Marek Vasut
