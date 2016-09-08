From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] mfd: tps65217: Add support for IRQs
Date: Thu, 8 Sep 2016 16:17:48 -0700
Message-ID: <20160908231747.t6rbrrlteosad4nv@atomide.com>
References: <20160908095900.30975-1-m.niestroj@grinn-global.com>
 <20160908095900.30975-2-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41679 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbcIHXRx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Sep 2016 19:17:53 -0400
Content-Disposition: inline
In-Reply-To: <20160908095900.30975-2-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Bin Liu <b-liu@ti.com>

* Marcin Niestroj <m.niestroj@grinn-global.com> [160908 02:59]:
> Add support for handling IRQs: power button, AC and USB power state
> changes. Mask and interrupt bits are shared within one register, which
> prevents us to use regmap_irq implementation. New irq_domain is created in
> order to add interrupt handling for each tps65217's subsystem. IRQ
> resources have been added for charger subsystem to be able to notify about
> AC and USB state changes.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Gave this a try with the peripheral USB port on BeagleBone black,
works fine for me to detect cable events. Will post the musb dsps
related patches after some clean up in few days. Anyways, feel
free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
