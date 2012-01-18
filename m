From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 18 Jan 2012 01:12:53 -0800
Message-ID: <20120118091253.GC32285@core.coreip.homeip.net>
References: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61573 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab2ARJM7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 04:12:59 -0500
Received: by iagf6 with SMTP id f6so5694721iag.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 01:12:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326508373-23444-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Hi Javier,

On Sat, Jan 14, 2012 at 03:32:51AM +0100, Javier Martinez Canillas wrote:
> +
> +static int __cyttsp_disable(struct cyttsp *ts)
> +{
> +	u8 sleep_mode = 0;
> +	int retval = 0;
> +
> +	if (ts->pdata->use_sleep && ts->power_state == CY_ACTIVE_STATE) {
> +		sleep_mode = ts->pdata->use_sleep;
> +		retval = ttsp_write_block_data(ts, CY_REG_BASE,
> +					       sizeof(sleep_mode), &sleep_mode);
> +		if (retval >= 0) {
> +			ts->power_state = CY_SLEEP_STATE;
> +			disable_irq(ts->irq);
> +		}

I thought we agreed that we should put the device to sleep
unconditionally and not have use_sleep option?

Thanks.

-- 
Dmitry
