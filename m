From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] input: tegra-kbc - Add tegra keyboard driver
Date: Wed, 19 Jan 2011 14:58:34 -0800
Message-ID: <20110119225834.GA29284@core.coreip.homeip.net>
References: <1295476207-15331-1-git-send-email-riyer@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40929 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab1ASW6l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jan 2011 17:58:41 -0500
Content-Disposition: inline
In-Reply-To: <1295476207-15331-1-git-send-email-riyer@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: riyer@nvidia.com
Cc: tsoni@codeaurora.org, pavel@ucw.cz, shubhrajyoti@ti.com, ccross@android.com, konkers@android.com, olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jan 19, 2011 at 02:30:07PM -0800, riyer@nvidia.com wrote:
> +
> +static void tegra_kbc_report_keys(struct tegra_kbc *kbc)
> +{
> +	unsigned char scancodes[KBC_MAX_KPENT];
> +	unsigned short keycodes[KBC_MAX_KPENT];
> +	u32 val = 0;
> +	unsigned int i;
> +	unsigned int num_down = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kbc->lock, flags);
> +	for (i = 0; i < KBC_MAX_KPENT * 4; i++) {

This will cause going beyond scancodes[] and keycodes[] and stomping on
your stack...

-- 
Dmitry
