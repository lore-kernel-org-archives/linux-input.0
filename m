From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] input: mc13783: Prepare driver to support MC13892
 and OF
Date: Fri, 12 Jul 2013 23:46:38 -0700
Message-ID: <20130713064638.GB20979@core.coreip.homeip.net>
References: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45274 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3GMGql (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jul 2013 02:46:41 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so9699539pac.15
        for <linux-input@vger.kernel.org>; Fri, 12 Jul 2013 23:46:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Hi Alexander,

On Sat, Jul 13, 2013 at 08:25:49AM +0400, Alexander Shiyan wrote:
> +
> +	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++)
> +		if (priv->enabled & BIT(i)) {
> +			ret = mc13xxx_irq_request(priv->mc13xxx,
> +						  priv->devtype->btn_def[i].irq,
> +						  mc13xxx_pwrbutton_irq, NULL,
> +						  priv);
> +			if (!ret)
> +				continue;

I'd rather we continued requesting interrupts in probe() as opposed to
open(). I believe the driver should acquire all resources it needs when
binding, instead of later.

Thanks.

-- 
Dmitry
