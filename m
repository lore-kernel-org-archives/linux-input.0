From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
Date: Wed, 13 May 2015 19:29:19 +0200 (CEST)
Message-ID: <953071056.79336.1431538159562.JavaMail.open-xchange@oxbsltgw06.schlund.de>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55716 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934018AbbEMR3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 13:29:23 -0400
In-Reply-To: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com, lznuaa@gmail.com
Cc: linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, dmitry.torokhov@gmail.com

Hi Frank,

looks like a typo in your subject line. keyboard?

> Frank.Li@freescale.com hat am 13. Mai 2015 um 16:47 geschrieben:
>
> [...]
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c
> b/drivers/input/keyboard/snvs_pwrkey.c
> new file mode 100644
> index 0000000..e4c2de3
> --- /dev/null
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -0,0 +1,239 @@
> +/*

a small driver description here would be nice.

> + * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> [...]
> +static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> +{
> [...]
> +
> + pdata->wakeup = !!of_get_property(np, "linux,wakeup", NULL);

of_property_read_bool() ?

> +
> [...]
> +
> + ret = input_register_device(input);
> + if (ret < 0) {
> + dev_err(&pdev->dev, "failed to register input device\n");
> + input_free_device(input);

input_free_device() shouldn't be necessary since you are using
devm_input_allocate_device().

Thanks

Best regards
Stefan
