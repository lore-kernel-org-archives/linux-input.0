From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
Date: Fri, 22 May 2015 10:07:49 +0200
Message-ID: <20150522080749.GI3244@piout.net>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
 <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38875 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783AbbEVIHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 04:07:51 -0400
Content-Disposition: inline
In-Reply-To: <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

Hi,

This looks good to me, a few nits below

On 22/05/2015 at 00:16:47 +0800, Frank.Li@freescale.com wrote :
> -	spin_unlock_irqrestore(&data->lock, flags);
> +	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
> +			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
That line is not properly aligned (missing one space)

[...]

> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;
> +	} else {
> +		pr_warning("snvs rtc: you use old dts file, please update it\n");

This should be pr_warn()


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
