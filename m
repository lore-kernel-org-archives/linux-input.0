From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a
 requested irq
Date: Wed, 07 Dec 2016 13:51:32 -0500
Message-ID: <1481136692.5635.1.camel@localhost>
References: <20161205014753.2092-1-vz@mleia.com>
         <1481134387.9248.8.camel@localhost>
         <7AAD38C5-E1CF-40EF-8E5B-8BCB9B5897C4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35533 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcLGSve (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 13:51:34 -0500
Received: by mail-io0-f196.google.com with SMTP id h133so30109203ioe.2
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 10:51:34 -0800 (PST)
In-Reply-To: <7AAD38C5-E1CF-40EF-8E5B-8BCB9B5897C4@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2016-12-07 at 10:46 -0800, Dmitry Torokhov wrote:
> On December 7, 2016 10:13:07 AM PST, Sylvain Lemieux <slemieux.tyco@gmail.com> wrote:
> >On Mon, 2016-12-05 at 03:47 +0200, Vladimir Zapolskiy wrote:
> >> Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
> >> disabled or enabled, in the latter case IRQs are allocated starting
> >> at least from the value specified by NR_IRQS and going upwards, so
> >> the check of (irq >= NR_IRQ) to decide about an error code returned
> >by
> >> platform_get_irq() is completely invalid, don't attempt to overrule
> >> irq subsystem in the driver.
> >> 
> >> The change fixes lpc32xx_keys driver initialization on boot:
> >> 
> >>   lpc32xx_keys 40050000.key: failed to get platform irq
> >>   lpc32xx_keys: probe of 40050000.key failed with error -22
> >> 
> >> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >> ---
> >>  drivers/input/keyboard/lpc32xx-keys.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >Cosmetic - please update the subject line when doing the commit:
> >replace " -" by ":" after lpc32xx-keys
> 
> Why? The format on all input patches is "Input: <driver> - <subject>" and had been this for 10+ years.
> 
My mistake; did not look at the tree "subject line" commit log 

You can dropped my comment.

Regards,
Sylvain
> 
> Thanks.
> 


