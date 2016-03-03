From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] input: cygnus-update touchscreen dt node document
Date: Thu, 3 Mar 2016 16:04:12 -0600
Message-ID: <20160303220412.GA27797@rob-hp-laptop>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-2-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39392 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756736AbcCCWER (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Mar 2016 17:04:17 -0500
Content-Disposition: inline
In-Reply-To: <1456556396-4759-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On Sat, Feb 27, 2016 at 12:29:54PM +0530, Raveendra Padasalagi wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So touch screen driver is enhanced to support
> register access using syscon framework API's to take care of
> mutually exclusive access.In addition to this existing touchscreen
> node name "tsc" is renamed to "touchscreen".
> 
> Hence touchscreen dt node bindings document is updated to take care
> of above changes in the touchscreen driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../input/touchscreen/brcm,iproc-touchscreen.txt    | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
