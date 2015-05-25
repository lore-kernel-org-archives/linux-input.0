From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
Date: Mon, 25 May 2015 13:54:39 +0800
Message-ID: <20150525055438.GC3264@dragon>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
 <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
 <20150522080749.GI3244@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33385 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbEYFz3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 01:55:29 -0400
Received: by padbw4 with SMTP id bw4so64170469pad.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2015 22:55:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150522080749.GI3244@piout.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Frank.Li@freescale.com, lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On Fri, May 22, 2015 at 10:07:49AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> This looks good to me, a few nits below
> 
> On 22/05/2015 at 00:16:47 +0800, Frank.Li@freescale.com wrote :
> > -	spin_unlock_irqrestore(&data->lock, flags);
> > +	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
> > +			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
> That line is not properly aligned (missing one space)
> 
> [...]
> 
> > +	if (of_device_is_compatible(snvs_np, "syscon")) {
> > +		data->regmap = syscon_node_to_regmap(snvs_np);
> > +		data->offset = 0x34;
> > +	} else {
> > +		pr_warning("snvs rtc: you use old dts file, please update it\n");
> 
> This should be pr_warn()

It should be dev_warn().

Shawn
