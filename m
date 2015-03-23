From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH v5 1/2] Input: touchscreen-iproc: Add Broadcom iProc touchscreen
 driver
Date: Mon, 23 Mar 2015 18:14:17 +0800
Message-ID: <550FE779.8010703@atmel.com>
References: <1426899446-16873-1-git-send-email-jonathar@broadcom.com> <1426899446-16873-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nasmtp02.atmel.com ([204.2.163.16]:14103 "EHLO
	SJOEDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752268AbbCWKOX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 06:14:23 -0400
In-Reply-To: <1426899446-16873-2-git-send-email-jonathar@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>
Cc: Scott Branden <sbranden@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Hi Jonathan Richardson,

On 03/21/2015 08:57 AM, Jonathan Richardson wrote:
> +static struct platform_driver iproc_ts_driver = {
> +	.probe = iproc_ts_probe,

Just a little curious, is the .remove function missing or it doesn't 
need it.

Thanks.

> +	.driver = {
> +		.name	= IPROC_TS_NAME,
> +		.of_match_table = of_match_ptr(iproc_ts_of_match),
> +	},
> +};
> +
> +module_platform_driver(iproc_ts_driver);
> +
> +MODULE_DESCRIPTION("IPROC Touchscreen driver");
> +MODULE_AUTHOR("Broadcom");
> +MODULE_LICENSE("GPL v2");

Best Regards,
Bo Shen
