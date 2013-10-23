From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv4 2/3] Input: twl4030-pwrbutton: use dev_err for errors
Date: Wed, 23 Oct 2013 11:17:46 -0700
Message-ID: <1382552266.22433.36.camel@joe-AO722>
References: <1382550852-11508-1-git-send-email-sre@debian.org>
	 <1382550852-11508-3-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:42756 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751412Ab3JWSRu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 14:17:50 -0400
In-Reply-To: <1382550852-11508-3-git-send-email-sre@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Wed, 2013-10-23 at 19:54 +0200, Sebastian Reichel wrote:
> Use dev_err() to output errors instead of dev_dbg().
[]
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
[]
> @@ -60,7 +60,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  
>  	pwr = input_allocate_device();
>  	if (!pwr) {
> -		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		dev_err(&pdev->dev, "Can't allocate power button\n");
>  		return -ENOMEM;
>  	}

input_allocate_device uses kzalloc and it will emit a
standardized OOM message along with a dump_stack()
so this dev_err/dev_dbg is redundant and not necessary.


