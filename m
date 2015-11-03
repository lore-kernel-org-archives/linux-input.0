From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: tsc2005 - Separate SPI and core functions
Date: Mon, 2 Nov 2015 17:49:46 -0800
Message-ID: <20151103014946.GB32018@dtor-ws>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
 <1446252086-24334-2-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35884 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbKCBtu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 20:49:50 -0500
Content-Disposition: inline
In-Reply-To: <1446252086-24334-2-git-send-email-mwelling@ieee.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Oct 30, 2015 at 07:41:23PM -0500, Michael Welling wrote:
> This patch separates the SPI functionality from core functionality
> that overlaps with the tsc2004.
> 
> Prepares kernel for new tsc2004 driver without much redundant code.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>  drivers/input/touchscreen/Kconfig                  |   4 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/tsc2005.c                | 709 +--------------------
>  .../touchscreen/{tsc2005.c => tsc200x-core.c}      | 226 ++-----
>  drivers/input/touchscreen/tsc200x-core.h           |  78 +++
>  5 files changed, 162 insertions(+), 856 deletions(-)
>  copy drivers/input/touchscreen/{tsc2005.c => tsc200x-core.c} (72%)
>  create mode 100644 drivers/input/touchscreen/tsc200x-core.h

This was giving me:

Kernel: arch/x86/boot/bzImage is ready  (#1451)
  MODPOST 1447 modules
ERROR: "tsc200x_regmap_config" [drivers/input/touchscreen/tsc2005.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

I'll fix it up locally by exporting the symbol.

Thanks.

-- 
Dmitry
