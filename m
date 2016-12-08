From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a
 requested irq
Date: Wed, 7 Dec 2016 17:22:54 -0800
Message-ID: <20161208012254.GB27638@dtor-ws>
References: <20161205014753.2092-1-vz@mleia.com>
 <1481134387.9248.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33064 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbcLHBW5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 20:22:57 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so25100755pgd.0
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 17:22:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1481134387.9248.8.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 07, 2016 at 01:13:07PM -0500, Sylvain Lemieux wrote:
> On Mon, 2016-12-05 at 03:47 +0200, Vladimir Zapolskiy wrote:
> > Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
> > disabled or enabled, in the latter case IRQs are allocated starting
> > at least from the value specified by NR_IRQS and going upwards, so
> > the check of (irq >= NR_IRQ) to decide about an error code returned by
> > platform_get_irq() is completely invalid, don't attempt to overrule
> > irq subsystem in the driver.
> > 
> > The change fixes lpc32xx_keys driver initialization on boot:
> > 
> >   lpc32xx_keys 40050000.key: failed to get platform irq
> >   lpc32xx_keys: probe of 40050000.key failed with error -22
> > 
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > ---
> >  drivers/input/keyboard/lpc32xx-keys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Cosmetic - please update the subject line when doing the commit:
> replace " -" by ":" after lpc32xx-keys
> 
> Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

Applied, thank you.

-- 
Dmitry
