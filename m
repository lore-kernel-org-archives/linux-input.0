From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input: add support for TI Touchscreen controller.
Date: Thu, 21 Jul 2011 23:35:35 -0700
Message-ID: <20110722063535.GC16040@core.coreip.homeip.net>
References: <1310619775-29886-1-git-send-email-rachna@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DC70D25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58611 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1GVGfl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 02:35:41 -0400
Received: by iyb12 with SMTP id 12so1641447iyb.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2011 23:35:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DC70D25@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Rachna,

On Wed, Jul 20, 2011 at 06:42:20PM +0530, Patil, Rachna wrote:
> Hi Dmitry,
> 
> This is just a gentle reminder for the patch I had submitted viz. "[PATCH] input: add support for TI Touchscreen controller."
> Can this patch be included in the 3.1 version?
> I know this is a bit late but I presume that this patch just adds a new kind of driver and does not break anything existing.
> 

I am getting the following while building the module:

ERROR: "clk_get_rate" [drivers/input/touchscreen/ti_tscadc.ko]
undefined!
ERROR: "clk_enable" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
ERROR: "clk_get" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
ERROR: "clk_put" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
ERROR: "clk_disable" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
make[1]: *** [__modpost] Error 1

Apparently we need to add some arch or platform dependency... Hmm, maybe
the driver should depend on CONFIG_HAVE_CLK?

Thanks.

-- 
Dmitry
