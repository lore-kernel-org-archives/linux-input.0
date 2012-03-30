From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V4 Resend 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Fri, 30 Mar 2012 12:45:34 -0600
Message-ID: <4F75FF4E.4040602@wwwdotorg.org>
References: <cover.1333009670.git.viresh.kumar@st.com> <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34627 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760089Ab2C3Spi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 14:45:38 -0400
In-Reply-To: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org, sr@denx.de

On 03/29/2012 09:40 PM, Viresh Kumar wrote:
> We don't need to allocate memory for keymap in matrix_keyboard_of_fill_keymap(),
> as this would only be used by matrix_keyboard_of_free_keymap(). Instead create
> another routine matrix_keypad_of_build_keymap() which reads directly the
> property from struct device_node and builds keymap.
> 
> With this eariler routines matrix_keyboard_of_fill_keymap() and
> matrix_keyboard_of_free_keymap() go away.
> 
> This patch also fixes tegra driver according to these changes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

The error checking looks good now, so once the issues mentioned below
are fixed:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
...
>  #else
> -static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
> -	struct platform_device *pdev)
> +static struct tegra_kbc_platform_data * __devinit
> +tegra_kbc_dt_parse_pdata(struct device_node *np)

This one should be "inline" and not "__devinit", i.e. like it was before.

> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
...
>  #else
> -static inline struct matrix_keymap_data *
> -matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname)
> +int matrix_keypad_of_build_keymap(struct input_dev *idev,
> +		unsigned int row_shift, const char *propname)
>  {
>  	return NULL;
>  }

This one should also be "static inline".
