From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
 after .probe exits
Date: Tue, 19 Jul 2011 09:17:26 +0800
Message-ID: <20110719011725.GB3838@S2100-06.ap.freescale.net>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
 <1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
 <201107181002.45170.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:14630
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977Ab1GSBLe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 21:11:34 -0400
Content-Disposition: inline
In-Reply-To: <201107181002.45170.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Phil Blundell <pb@handhelds.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Jul 18, 2011 at 10:02:44AM -0700, Dmitry Torokhov wrote:
> On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> > The patch makes a copy of platform data into driver data, so that any
> > reference to platform_data after .probe exits can be avoided.
> 
> And why is this beneficial? I am of the opinion that platform data should
> stay on (and be accessed through a const pointer to ensure that the driver
> will not alter it).
> 
To me, it's a common sense that platform data should not be referenced
after .probe exits, so that any platform code providing the data can
claim the data as __initconst.  When we build multiple platforms which
all have their own platform data for gpio_keys in the kernel, there is
only one of them will be used by gpio_keys driver, others should be
freed after init, no?

-- 
Regards,
Shawn

