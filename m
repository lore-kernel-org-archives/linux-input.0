From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7877: Remove bitrotted comment
Date: Thu, 24 Apr 2014 23:38:41 -0700
Message-ID: <20140425063841.GD10433@core.coreip.homeip.net>
References: <1398201501-13470-1-git-send-email-broonie@kernel.org>
 <20140423003928.GB22547@core.coreip.homeip.net>
 <20140423101623.GL12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47898 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaDYGin (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 02:38:43 -0400
Received: by mail-pb0-f53.google.com with SMTP id jt11so1102848pbb.26
        for <linux-input@vger.kernel.org>; Thu, 24 Apr 2014 23:38:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140423101623.GL12304@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org

On Wed, Apr 23, 2014 at 11:16:23AM +0100, Mark Brown wrote:
> On Tue, Apr 22, 2014 at 05:39:28PM -0700, Dmitry Torokhov wrote:
> > On Tue, Apr 22, 2014 at 10:18:21PM +0100, Mark Brown wrote:
> 
> > > Remove the bitrotted comment, though in actual fact the use case mentioned
> > > is a great use for spi_async() since it would cut down on latency handling
> > > the interrupt by saving us a context switch before we start SPI.
> 
> > > This was previously implemented, it was removed in commit b534422b2d11
> > > (Input: ad7877 - switch to using threaded IRQ) for code complexity reasons.
> > > It may be better to revert that commit instead.
> 
> > Hmm, maybe.. although I think original would cause device 'stuck' if
> > call to spi_async() fails, so probably not a straight revert...
> 
> Probably best just to apply this, then - someone can always reimplement
> if they need to.

OK, applied.

Thanks.

-- 
Dmitry
