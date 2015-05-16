From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/7] arm: imx: power-off: change to syscon to access
 register
Date: Sat, 16 May 2015 15:54:17 +0200
Message-ID: <20150516135417.GK3338@piout.net>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54294 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbbEPNyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2015 09:54:19 -0400
Content-Disposition: inline
In-Reply-To: <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, sachin.kamat@linaro.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi,

On 15/05/2015 at 21:36:24 +0800, Frank.Li@freescale.com wrote :
>  static int imx_poweroff_probe(struct platform_device *pdev)
>  {
> -	snvs_base = of_iomap(pdev->dev.of_node, 0);
> -	if (!snvs_base) {
> +	struct device_node *nd;
> +
> +	nd = of_get_parent(pdev->dev.of_node);
> +	if (!nd)
> +		return -ENODEV;
> +	snvs = syscon_node_to_regmap (nd);
You should remove that space ---^


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
