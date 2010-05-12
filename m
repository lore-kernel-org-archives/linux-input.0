From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 GPIO
Date: Wed, 12 May 2010 13:30:26 +0100
Message-ID: <20100512123026.GA8082@rakim.wolfsonmicro.main>
References: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41116 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752274Ab0ELMa2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 08:30:28 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, May 12, 2010 at 01:47:12PM +0200, Manuel Lauss wrote:

> I'm playing with the GPIO interface on a WM9712G, specifically GPIO1
> and 2 of the chip.
> However I'm unable to get the chip to toggle any of these pins.

> Setting a pin with
> wm97xx_set_gpio(wm, WM97XX_GPIO_1, WM97XX_GPIO_HIGH);

> reads back 0x0820 from GPIO status reg, sets bit 1,writes back 0x1044 (<<1),
> but a read following immediately after yields 0x0820 again, and the pin
> never changes.

> Am I missing something?

The WM9712 does not support this feature.  It only supports setting the
GPIO status by use of AC'97 slot 12 for which there's currently no
standard glue on Linux.  Setting slot 12 needs to be done in the AC'97
controller.

> Also I need this patch to get wm97xx_set_gpio() to actually set a bit in the
> gpio register:

Please just submit this patch, it looks good.
