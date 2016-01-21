From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: Re: [PATCH v4 1/4] Input: cyttsp - use devres managed resource
 allocations
Date: Thu, 21 Jan 2016 21:22:05 +0100
Message-ID: <20160121202205.GA20324@nl1lxl-107192.ttg.global>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
 <20e9f0188f07fc420912b3defa747303be3cf290.1453403916.git.oreste.salerno@tomtom.com>
 <20160121192924.GB39970@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:7574 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbcAUUWJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 15:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20160121192924.GB39970@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On Thu, Jan 21, 2016 at 11:29:24AM -0800, Dmitry Torokhov wrote:
> Hi Oreste,
> 
> On Thu, Jan 21, 2016 at 08:21:13PM +0100, Oreste Salerno wrote:
> > Use devm_() functions for allocating memory, input device and IRQ.
> > 
> 
> ...
> 
> > @@ -625,11 +620,8 @@ EXPORT_SYMBOL_GPL(cyttsp_probe);
> >  
> >  void cyttsp_remove(struct cyttsp *ts)
> >  {
> > -	free_irq(ts->irq, ts);
> > -	input_unregister_device(ts->input);
> >  	if (ts->pdata->exit)
> >  		ts->pdata->exit();
> > -	kfree(ts);
> 
> This is not quite correct as it changes the operations order... Given
> that it is going to be removed in the next patch I guess it is OK, but
> ideally you can add a custom devm action to shut off the chip.
>

You mean a devm action to call pdata->exit() ? OK, I could do that.

> Thanks.
> 
> -- 
> Dmitry
