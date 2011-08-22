From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch
 screen support
Date: Sun, 21 Aug 2011 21:31:07 -0700
Message-ID: <20110822043107.GB23010@core.coreip.homeip.net>
References: <1313812912-2848-1-git-send-email-martinez.javier@gmail.com>
 <1313812912-2848-2-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34828 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1HVEbO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 00:31:14 -0400
Content-Disposition: inline
In-Reply-To: <1313812912-2848-2-git-send-email-martinez.javier@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, Henrik Rydberg <rydberg@euromail.se>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Javier,

On Sat, Aug 20, 2011 at 12:01:50AM -0400, Javier Martinez Canillas wrote:
> Cypress TrueTouch(tm) Standard Product controllers are found in
> a wide range of embedded devices. This driver add support for a
> variety of TTSP controllers.
> 
> The driver is composed of a core driver that process the data sent by
> the contacts and a set of bus specific interface modules. This patch
> adds the base core TTSP driver.
> 
> The original author of the driver is Kevin McNeely <kev@cypress.com>
> 
> Since the hardware is capable of tracking identifiable contacts and the
> original driver used multi-touch protocol type A (stateless), multi-touch
> protocol type B (stateful) support was added by Javier Martinez Canillas.
> 

Still reading through the patches, but have one question:

> +
> +	ts->irq = gpio_to_irq(ts->platform_data->irq_gpio);
> +	if (ts->irq <= 0) {
> +		dev_dbg(ts->dev, "%s: Error, failed to allocate irq\n",
> +			__func__);
> +			goto error_init;
> +	}

Why do we need to get gpio/irq from platform data instead of having
board code set up controllers appropriately and use IRQ either from I2C
client structure or from SPI?

Thanks.

-- 
Dmitry
