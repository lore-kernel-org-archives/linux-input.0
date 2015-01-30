From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
Date: Fri, 30 Jan 2015 10:57:21 -0800
Message-ID: <20150130185721.GA11695@dtor-ws>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
 <54CA4320.4030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37644 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbA3S51 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 13:57:27 -0500
Content-Disposition: inline
In-Reply-To: <54CA4320.4030607@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Thu, Jan 29, 2015 at 07:56:40PM +0530, Varka Bhadram wrote:
> Hi,
> 
> On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> >This is a driver for the imx25 ADC/TSC module. It controls the
> >touchscreen conversion queue and creates a touchscreen input device.
> >The driver currently only supports 4 wire touchscreens. The driver uses
> >a simple conversion queue of precharge, touch detection, X measurement,
> >Y measurement, precharge and another touch detection.
> >
> >This driver uses the regmap from the parent to setup some touch specific
> >settings in the core driver and setup a idle configuration with touch
> >detection.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >Signed-off-by: Denis Carikli <denis@eukrea.com>
> >Acked-by: Dmitry Torokhov <dtor@vmware.com>
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  drivers/input/touchscreen/Kconfig         |   6 +
> >  drivers/input/touchscreen/Makefile        |   1 +
> >  drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++++++++++++
> >  3 files changed, 594 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> >
> (...)
> 
> >+	ret = request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_thread,
> >+				   IRQF_ONESHOT, pdev->name, priv);
> 
> We can use devres API for request_thread_irq()...
> 
> >+	if (ret) {
> >+		dev_err(dev, "Failed requesting IRQ\n");
> >+		goto err_clk_unprepare;
> >+	}
> >+
> >+	ret = mx25_tcq_init(priv);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to init tcq\n");
> >+		goto error_free_irq;
> >+	}
> >+
> >+	platform_set_drvdata(pdev, priv);
> >+
> >+	return 0;
> >+
> >+error_free_irq:
> >+	free_irq(priv->irq, priv);
> 
> This is not required if we use devres API

Yes it does - you do not really want to stop clocks in the middle of
servicing interrupt.

Thanks.

-- 
Dmitry
