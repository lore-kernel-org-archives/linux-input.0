From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2] Input: gpio-keys: add device tree probe support
Date: Tue, 19 Jul 2011 09:22:52 +0800
Message-ID: <20110719012251.GC3838@S2100-06.ap.freescale.net>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
 <1311007508-8096-3-git-send-email-shawn.guo@linaro.org>
 <201107181005.52725.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:58454
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab1GSBQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 21:16:00 -0400
Content-Disposition: inline
In-Reply-To: <201107181005.52725.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Phil Blundell <pb@handhelds.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 18, 2011 at 10:05:52AM -0700, Dmitry Torokhov wrote:
> Hi Shawn,
> 
> On Monday, July 18, 2011 09:45:08 AM Shawn Guo wrote:
> > It adds device tree probe support for gpio-keys driver.
> 
> There is already a patch by David Jander adding device tree support to
> the driver; I intend to apply it.
> 
Sorry, I was not aware of David's patch.  No problem, you can pick
whichever you want.  All I want to see is gpio_keys gets device tree
support, because I need to convert several board files to device tree
and the gpio_keys seems to be the only one missing device tree support
there.

-- 
Regards,
Shawn

