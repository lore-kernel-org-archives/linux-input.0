From: jcbian <jcbian@pixcir.com.cn>
Subject: Re: [PATCH] input: add driver for pixcir i2c touchscreens
Date: Wed, 23 Feb 2011 09:47:23 +0800 (HKT)
Message-ID: <36334f.b3d4.12e50330057.Coremail.jcbian@pixcir.com.cn>
References: <20110223013111.GA23939@opensource.wolfsonmicro.com>
 <20110222034808.GC18299@sirena.org.uk> <4D632AAD.8040405@pixcir.com.cn>
 <f2894b.b085.12e500bb5f2.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail37.corpease.net ([61.145.121.42]:50281 "EHLO corpease.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752789Ab1BWBr2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 20:47:28 -0500
In-Reply-To: <20110223013111.GA23939@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

> > > > + queue_work(pixcir_wq, &tsdata->work.work);
> 
> > > > + return IRQ_HANDLED;
> > > > +}
> 
> > > Use a threaded IRQ handler - genirq can now implement this pattern for
> > > you.
> 
> > I do not use genirq before, what the diffetence? Thanks!
> 
> genirq is the name of the standard kernel interrupt implementation.  If
> you use a threaded IRQ handler using request_threaded_irq() then all the
> workqueue stuff goes away.
> 
Oh,understand,thanks!It seems that request_threaded_irq() is more intelligent :)

Thanks

---
Jcbian





