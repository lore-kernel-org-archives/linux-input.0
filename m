From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a
 requested irq
Date: Wed, 07 Dec 2016 13:13:07 -0500
Message-ID: <1481134387.9248.8.camel@localhost>
References: <20161205014753.2092-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36376 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbcLGSNM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 13:13:12 -0500
Received: by mail-io0-f193.google.com with SMTP id s82so15337751ioi.3
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 10:13:12 -0800 (PST)
In-Reply-To: <20161205014753.2092-1-vz@mleia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2016-12-05 at 03:47 +0200, Vladimir Zapolskiy wrote:
> Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
> disabled or enabled, in the latter case IRQs are allocated starting
> at least from the value specified by NR_IRQS and going upwards, so
> the check of (irq >= NR_IRQ) to decide about an error code returned by
> platform_get_irq() is completely invalid, don't attempt to overrule
> irq subsystem in the driver.
> 
> The change fixes lpc32xx_keys driver initialization on boot:
> 
>   lpc32xx_keys 40050000.key: failed to get platform irq
>   lpc32xx_keys: probe of 40050000.key failed with error -22
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/input/keyboard/lpc32xx-keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Cosmetic - please update the subject line when doing the commit:
replace " -" by ":" after lpc32xx-keys

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>


