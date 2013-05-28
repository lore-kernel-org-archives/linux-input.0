From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Tue, 28 May 2013 00:58:09 -0700
Message-ID: <20130528075808.GA19496@core.coreip.homeip.net>
References: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:64223 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246Ab3E1H6O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 03:58:14 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so7575554pbc.31
        for <linux-input@vger.kernel.org>; Tue, 28 May 2013 00:58:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi Barry,

On Tue, May 28, 2013 at 10:47:38AM +0800, Barry Song wrote:
> +	/*
> +	 * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
> +	 * to queue a SUSPEND APM event
> +	 */
> +	input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
> +	input_sync(pwrcdrv->input);
> +
> +	/*
> +	 * Todo: report KEY_POWER event for Android platforms, Android PowerManager
> +	 * will handle the suspend and powerdown/hibernation
> +	 */
> +
...

> +
> +	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
> +	set_bit(KEY_POWER, pwrcdrv->input->keybit);

Why are we setting up KEY_POWER if we do not send this event?

Thanks.

-- 
Dmitry
