From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] input: keyboard: gpio-keys: Try to parse IRQ from device
 tree
Date: Fri, 05 Oct 2012 09:59:57 +0200
Message-ID: <25463817.uuiAvzsyb8@amdc1227>
References: <1349263201-422-1-git-send-email-t.figa@samsung.com>
 <20121005062315.GB11112@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20121005062315.GB11112@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, tomasz.figa@gmail.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Thursday 04 of October 2012 23:23:15 Dmitry Torokhov wrote:
> Hi Tomasz,
> 
> On Wed, Oct 03, 2012 at 01:20:00PM +0200, Tomasz Figa wrote:
> > On modern platforms using device tree and non-legacy IRQ domains there
> > is usually no way to perform direct translation between GPIO and IRQ,
> > because the IRQ of interest is not mapped yet into sparse IRQ
> > namespace.
> > 
> > This patch modifies the gpio_keys driver to parse IRQ from device tree
> > and use gpio_to_irq only as a fallback.
> 
> This means that this change would need to be applied to every driver
> that currently maps gpio to IRQ. Why can't gpio_to_irq() be fixed
> instead?
> 

Now when I think of it again, there is a possibility of creating an IRQ 
mapping in .to_irq callback of GPIO chip, if it does not exist yet. This 
should be a better solution indeed. I will send a patch for pinctrl-samsung 
driver adding it.

Please disregard this patch.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
