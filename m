From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Sat, 03 Sep 2011 07:34:15 +0200
Message-ID: <1315028055.11839.13.camel@sauron>
References: <1313812912-2848-1-git-send-email-martinez.javier@gmail.com>
	 <1313812912-2848-2-git-send-email-martinez.javier@gmail.com>
	 <20110822043107.GB23010@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63007 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab1ICFeT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Sep 2011 01:34:19 -0400
In-Reply-To: <20110822043107.GB23010@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, Henrik Rydberg <rydberg@euromail.se>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Dmitry,

On Sun, 2011-08-21 at 21:31 -0700, Dmitry Torokhov wrote:
> Hi Javier,
 
> 
> Still reading through the patches, but have one question:
> 
> > +
> > +	ts->irq = gpio_to_irq(ts->platform_data->irq_gpio);
> > +	if (ts->irq <= 0) {
> > +		dev_dbg(ts->dev, "%s: Error, failed to allocate irq\n",
> > +			__func__);
> > +			goto error_init;
> > +	}
> 
> Why do we need to get gpio/irq from platform data instead of having
> board code set up controllers appropriately and use IRQ either from I2C
> client structure or from SPI?
> 
> Thanks.
> 

Right, next version fix this by extracting the IRQ either from the I2C
or SPI client data structure as you suggest.

Best regards,

Javier Martinez Canillas

