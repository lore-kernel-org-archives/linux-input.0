From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: tegra-kbc - Add tegra keyboard driver
Date: Mon, 10 Jan 2011 14:16:24 -0800
Message-ID: <20110110221624.GA16445@core.coreip.homeip.net>
References: <1294422307-19107-1-git-send-email-riyer@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60647 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab1AJWQc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 17:16:32 -0500
Content-Disposition: inline
In-Reply-To: <1294422307-19107-1-git-send-email-riyer@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: riyer@nvidia.com
Cc: jj@chaosbits.net, tsoni@codeaurora.org, shubhrajyoti@ti.com, ccross@android.com, konkers@android.com, olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Rakesh,

On Fri, Jan 07, 2011 at 09:45:07AM -0800, riyer@nvidia.com wrote:
> +
> +struct tegra_kbc {
> +	void __iomem *mmio;
> +	struct input_dev *idev;
> +	int irq;
> +	unsigned int wake_enable_rows;
> +	unsigned int wake_enable_cols;
> +	spinlock_t lock;
> +	unsigned int repoll_time;
> +	unsigned long cp_dly_jiffies;
> +	int fifo[KBC_MAX_KPENT];
> +	const struct tegra_kbc_platform_data *pdata;
> +	int *plain_keycode;
> +	int *fn_keycode;

There should not be separate keycodes for FN and normal kys - FN is just
a modifier, like SHIFT or CTRL or ALT are and shoudl be handled in upper
layers.

Also you should wire up keycode/keycodemax/keycodesize in input_dev
structuire so that keymap can be retrieved via EVIOCGKEYCODE and
modified via EVIOGSKEYCODE. Also, because keymap is modifiable, the
original keymap should be copied in per-device structure, leaving
original intact. It (the original) also should be marked as const.

Since this papears to be a matrix keypad consider using definitions from
linux/input/matrix_keypad.h

Thank you.

-- 
Dmitry
