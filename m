From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Wed, 20 Jul 2016 23:41:40 -0700
Message-ID: <20160721064140.GA17658@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35399 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcGUGlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 02:41:44 -0400
Content-Disposition: inline
In-Reply-To: <20160721062950.GB5993@lukather>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Thu, Jul 21, 2016 at 08:29:50AM +0200, Maxime Ripard wrote:
> On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> > +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> > +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> > +					   sunxi_gpadc_tp_up_irq_handler, 0,
> > +					   "tp_up", info);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev,
> > +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> > +		goto err;
> > +	}
> 
> You enable the interrupts...
> 
> > +	info->tp_up_irq = irq;
> > +	disable_irq(irq);
> > +
> > +	ret = input_register_device(input);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to register input device\n");
> > +		goto err;
> > +	}
> 
> ... but your driver isn't registered yet. How does input_report and
> input_sync behave in such a case?

This is explicitly allowed:

"
...
 * NOTE: input_event() may be safely used right after input device was
 * allocated with input_allocate_device(), even before it is registered
 * with input_register_device(), but the event will not reach any of the
 * input handlers. Such early invocation of input_event() may be used
 * to 'seed' initial state of a switch or initial position of absolute
 * axis, etc.
 */
"

Thanks.


-- 
Dmitry
