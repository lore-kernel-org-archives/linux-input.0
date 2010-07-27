From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/6] mrst-touchscreen: Fix use before initialize in
	mrst_touch [Fix bug 2561]
Date: Tue, 27 Jul 2010 11:17:04 -0700
Message-ID: <20100727181704.GA29234@kroah.com>
References: <20100723134852.19151.6999.stgit@localhost.localdomain> <20100723135210.19151.19238.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:49887 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab0G0S3e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 14:29:34 -0400
Content-Disposition: inline
In-Reply-To: <20100723135210.19151.19238.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Jul 23, 2010 at 02:52:12PM +0100, Alan Cox wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> The mrst touch screen driver, in mrstouch_adc_init does
> 
>                  dev_err(&tsdev->spi->dev, "Unable to read PMIC id\n");
> 
> which does not work very well since the tsdev->spi member does not get
> initialized until after the call to mrstouch_adc_init
> 
> this patch makes sure the ->spi member is initialized prior to the call
> to mrstouch_adc_init
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Why are there 3 patches attached to this email, all a bit different?

Care to resend this one so I know which to apply?

thanks,

greg k-h
