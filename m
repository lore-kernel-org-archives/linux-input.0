From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Thu, 29 Mar 2012 09:44:35 -0600
Message-ID: <4F748363.6040400@wwwdotorg.org>
References: <cover.1333009670.git.viresh.kumar@st.com> <69c5aad139fbbf4e99134c414a819e1cf3f6dd84.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36574 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527Ab2C2Poj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 11:44:39 -0400
In-Reply-To: <69c5aad139fbbf4e99134c414a819e1cf3f6dd84.1333009670.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org, sr@denx.de

On 03/29/2012 02:33 AM, Viresh Kumar wrote:
> We don't need to allocate memory for keymap in matrix_keyboard_of_fill_keymap(),
> as this would only be used by matrix_keyboard_of_free_keymap(). Instead create
> another routine matrix_keypad_of_build_keymap() which reads directly the
> property from struct device_node and builds keymap.
> 
> With this eariler routines matrix_keyboard_of_fill_keymap() and
> matrix_keyboard_of_free_keymap() go away.
> 
> This patch also fixes tegra driver according to these changes.

> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c

> -static struct tegra_kbc_platform_data * __devinit
> -tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
> +static struct tegra_kbc_platform_data *
> +__devinit tegra_kbc_dt_parse_pdata(struct device_node *np)

I'd be tempted to keep __devinit on the first line, but not a big deal.

> +int matrix_keypad_of_build_keymap(struct input_dev *idev,
> +		unsigned int row_shift, const char *propname)

> +	size = proplen / sizeof(u32);
> +	if (size > idev->keycodemax) {
> +		dev_err(dev, "OF: %s overflow\n", propname);
> +		return -EINVAL;
>  	}

That is checking the number of entries in the property, not the values
of the MATRIX_SCAN_CODE values derived from those entries. I'd say just
remove this check. See below.

> +	keycode = idev->keycode;
>  
> +	for (i = 0; i < size; i++) {
> +		unsigned int key = be32_to_cpup(prop + i);
> +		unsigned int row = KEY_ROW(key);
> +		unsigned int col = KEY_COL(key);
> +		unsigned short code = KEY_VAL(key);
>  
> +		if (col >= col_range) {
> +			dev_err(dev, "OF: %s: column %x overflowed its range %d\n",
> +					propname, col, col_range);
> +			return -EINVAL;
> +		}

That check is good.

> +		keycode[MATRIX_SCAN_CODE(row, col, row_shift)] = code;

But, you also need to do something like:

scancode = MATRIX_SCAN_CODE(row, col, row_shift);
if (scancode >= idev->keycodemax) {
    error out;
}
keycode[scancode] = code;

> +		__set_bit(code, idev->keybit);
>  	}
> +	__clear_bit(KEY_RESERVED, idev->keybit);
> +
> +	return 0;
>  }
