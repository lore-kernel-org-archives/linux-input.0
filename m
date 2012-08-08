From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between DT and non-DT boots
Date: Wed, 8 Aug 2012 08:28:35 +0000
Message-ID: <201208080828.35451.arnd@arndb.de>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com> <20120808080411.GB4728@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab2HHI2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 04:28:44 -0400
In-Reply-To: <20120808080411.GB4728@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

On Wednesday 08 August 2012, Lee Jones wrote:
> Okay, actually this isn't so easy. Currently we have:
> 
> During DT boot:
>  - No platform data is passed, hence no IRQ base for AB8500 is either
>  - No IRQ base means we register a Linear IRQ Domain
>  - MFD sees there is no base and leaves the IRQ resource as a hwirq
>  - AB8500 child devices use *_get_virq() to convert the hwirq to a virq
> 
> During non-DT boot:
>  - Platform data is passed, which contains an IRQ base
>  - If an IRQ base is requested we use it to register a Legacy IRQ Domain
>  - MFD adds the IRQ base to the hwirq and registers it as a virq
>  - AB8500 child devices use *_get_virq() to convert virq to virq - ERROR
> 
> I guess my suggestion falls-back to placing logic in *_get_virq() to only
> call irq_create_mapping() when when !ab8500->irq_base.

In general, it seems easier to use the same domain type for both cases.
I don't think that MOP500_AB8500_VIR_GPIO_IRQ_BASE is used anywhere
else besides the .irq_base definition in board-mop500.c, so I would guess
that you can just remove that identifier and always use the linear
domain.

	Arnd
