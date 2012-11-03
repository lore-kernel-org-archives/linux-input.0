From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: pwm-beeper: Add devicetree probing support
Date: Sat, 3 Nov 2012 12:03:01 -0700
Message-ID: <20121103190301.GB11349@core.coreip.homeip.net>
References: <1351845842-15652-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KCTDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Nov 2012 15:03:07 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3095647pbb.19
        for <linux-input@vger.kernel.org>; Sat, 03 Nov 2012 12:03:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351845842-15652-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Thierry Reding <thierry.reding@avionic-design.de>, kernel@pengutronix.de

Hi Sascha.

On Fri, Nov 02, 2012 at 09:44:02AM +0100, Sascha Hauer wrote:
>  
> -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> +	beeper->pwm = pwm_get(&pdev->dev, NULL);
> +	if (IS_ERR(beeper->pwm)) {
> +		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");

This is not an error, I'll switch it over to dev_dbg().

Thanks.

-- 
Dmitry
