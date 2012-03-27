From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Tue, 27 Mar 2012 09:45:42 -0600
Message-ID: <4F71E0A6.4080703@wwwdotorg.org>
References: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:53595 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab2C0Ppp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 11:45:45 -0400
In-Reply-To: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org, sr@denx.de

On 03/26/2012 11:38 PM, Viresh Kumar wrote:
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
...
>  static int __devinit tegra_kbc_probe(struct platform_device *pdev)
...
> +	if (pdev->dev.of_node) {
> +		/* FIXME: Add handling of linux,fn-keymap here */
> +		err = matrix_keypad_of_build_keymap(&pdev->dev, KBC_ROW_SHIFT,
> +				input_dev->keycode, input_dev->keybit,
> +				"linux,keymap");

Where do input_dev->keycode/keybit get allocated? As far as I can tell,
matrix_keypad_of_build_keymap() just writes to those and assumes they're
already allocated.

> diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
...
> +int matrix_keypad_of_build_keymap(struct device *dev, unsigned int row_shift,
...
> +		keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
> +		__set_bit(code, keybit);

How bit are keymap and keybit? I think we need range-checking here to
make sure that row/col/row_shift/code are valid and in-range.
