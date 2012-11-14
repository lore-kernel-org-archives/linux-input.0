From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH] Input: marix-keymap - automatically allocate memory for
 keymap
Date: Wed, 14 Nov 2012 10:40:59 +0100
Message-ID: <20121114104059.7442d460@avionic-0020.adnet.avionic-design.de>
References: <20121108164519.GA9334@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61157 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab2KNJlD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 04:41:03 -0500
In-Reply-To: <20121108164519.GA9334@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 8 Nov 2012 08:45:21 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> In device tree enabled setups requiring preallocated memory for storing keymap
> is quite often awkward, so let's provide an option of allocating it directly
> in matrix_keypad_build_keymap().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/matrix-keymap.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
> index 443ad64b..da04f13 100644
> --- a/drivers/input/matrix-keymap.c
> +++ b/drivers/input/matrix-keymap.c
> @@ -122,6 +122,11 @@ static int matrix_keypad_parse_of_keymap(const char *propname,
>   * it will attempt load the keymap from property specified by @keymap_name
>   * argument (or "linux,keymap" if @keymap_name is %NULL).
>   *
> + * If @keymap is %NULL the function will automatically allocate managed
> + * block of memory to store the keymap. This memory will be associated with
> + * the parent device and automatically freed when device unbinds from the
> + * driver.
> + *
>   * Callers are expected to set up input_dev->dev.parent before calling this
>   * function.
>   */
> @@ -132,12 +137,27 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
>  			       struct input_dev *input_dev)
>  {
>  	unsigned int row_shift = get_count_order(cols);
> +	size_t max_keys = rows << row_shift;
>  	int i;
>  	int error;
>  
> +	if (WARN_ON(!input_dev->dev.parent))
> +		return -EINVAL;
> +
> +	if (!keymap) {
> +		keymap = devm_kzalloc(input_dev->dev.parent,
> +				      max_keys * sizeof(*keymap),
> +				      GFP_KERNEL);

In my tree GFP_KERNEL isn't defined at that point. Is an include
missing in this patch or is my tree (3.6+some next cherry picks)
missing a commit?

> +		if (!keymap) {
> +			dev_err(input_dev->dev.parent,
> +				"Unable to allocate memory for keymap");
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	input_dev->keycode = keymap;
>  	input_dev->keycodesize = sizeof(*keymap);
> -	input_dev->keycodemax = rows << row_shift;
> +	input_dev->keycodemax = max_keys;
>  
>  	__set_bit(EV_KEY, input_dev->evbit);
>  

Otherwise that look good to me.

Alban
