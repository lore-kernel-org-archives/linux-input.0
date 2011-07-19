From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2] Input: gpio-keys: add device tree probe support
Date: Tue, 19 Jul 2011 11:55:56 +0800
Message-ID: <20110719035555.GE3838@S2100-06.ap.freescale.net>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
 <1311007508-8096-3-git-send-email-shawn.guo@linaro.org>
 <201107181005.52725.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:28797
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260Ab1GSDtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 23:49:01 -0400
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
I just fetched it from linux-next.  Though it seems working for me,
I'm wondering why there are no bindings for following configurations.

struct gpio_keys_button {
	...
        int active_low;
	...
        bool can_disable;
        int value;              /* axis value for EV_ABS */
};

I'm seeing some platforms using them in their gpio_keys platform data.
Does that mean the dt version of the driver will be broken on these
platforms?

BTW, if I have fetched linux-next a little earlier or David Cc list
devicetree-discuss when he posted his patch, I do not have to waste
one day effort :)

-- 
Regards,
Shawn

