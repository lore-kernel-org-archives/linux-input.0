From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] mc13xxx-ts: use zero as default value if no pdata was
 defined
Date: Tue, 13 Aug 2013 09:46:09 -0700
Message-ID: <20130813164609.GA21548@core.coreip.homeip.net>
References: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:65523 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248Ab3HMQqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Aug 2013 12:46:13 -0400
Content-Disposition: inline
In-Reply-To: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Samuel Ortiz <sameo@linux.intel.com>

Hi Michael,

On Tue, Aug 13, 2013 at 02:14:30PM +0200, Michael Grzeschik wrote:
> In case of devicetree, we currently don't have a way to append pdata for
> the touchscreen. The current approach is to bail out in that case.
> This patch makes it possible to probe the touchscreen without pdata
> and use zero as default values for the atox and ato adc conversion.

I'd rather you added the devicetree support to the driver.

Thanks.

-- 
Dmitry
