From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RESEND v4] input: keyboard: Add keys driver for the LPC32xx
 SoC
Date: Tue, 12 Jun 2012 10:58:01 +0530
Message-ID: <4FD6D361.2020305@ti.com>
References: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46063 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751857Ab2FLF2M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jun 2012 01:28:12 -0400
Received: by obhx4 with SMTP id x4so8941049obh.34
        for <linux-input@vger.kernel.org>; Mon, 11 Jun 2012 22:28:10 -0700 (PDT)
In-Reply-To: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: dmitry.torokhov@gmail.com, axel.lin@gmail.com, riyer@nvidia.com, michael.hennerich@analog.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

On Tuesday 12 June 2012 01:14 AM, Roland Stigge wrote:
> +
> +struct lpc32xx_kscan_drv {
> +	struct input_dev *input;
> +	struct lpc32xx_kscan_cfg *kscancfg;
> +	struct clk *clk;
> +	void __iomem *kscan_base;
> +	int irq;
Do you really need this irq field?  It is used in the probe and remove only.

> +	u8 lastkeystates[8];
> +	u32 io_p_start;
> +	u32 io_p_size;
> +};

