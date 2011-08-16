From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Tue, 16 Aug 2011 12:54:45 +0100 (BST)
Message-ID: <1313495685.73634.YahooMailClassic@web29005.mail.ird.yahoo.com>
References: <4E4A22B2.2080402@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm14-vm1.bullet.mail.ird.yahoo.com ([77.238.189.91]:26110 "HELO
	nm14-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752414Ab1HPLyr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 07:54:47 -0400
In-Reply-To: <4E4A22B2.2080402@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, eric.y.miao@gmail.com, philipp.zabel@gmail.com, mad_soft@inbox.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> > MFP_CFG_OUT(GPIO102, ...) had already moved from the
> patch v1 platform file to patch v2 mfp-pxa27x.h because it
> was suggested that MFP macros should not be used directly.
> > Changing the direction in the platform file would
> surely require using the MFP macros again, so how to keep
> everyone happy? Maybe I should just define a more generic
> name such as GPIO102_GPIO_OUT?
> 
> No, you will not need to use the MFP macros, just
> gpio_direction_*() calls.
> Eric has already answered this and I agree with him.
> Use the MFP to configure the alternate function and other
> MFP related stuff
> and use the gpio_direction_*() calls later to set the
> direction of the GPIO.

OK, will do.

> > Because the underlying hardware is a touchpad
> controller and most of the touchpad drivers live in the
> mouse directory. I could have added a mouse interface to
> this driver but chose not to (at least for now) because the
> hx4700 platform already has a working touchscreen
> controller; a second mouse device was not needed. If future
> platforms require a mouse interface then one could be added
> relatively easily; surely this would be preferable to
> replicating the whole driver.
> 
> So the device is a full touchpad? and can be used for mouse
> pointer?

Yes, that's correct.

> Is the same device used as mouse pointer by some other
> driver?

Not as far as I can see. The word "NavPoint" appears only once in the current kernel source: within the hx4700 platform file. It's possible that other PDA models of similar 2004 vintage used the device, but I don't know whether any of them are supported in the kernel.

> > The suspend and resume functions check that the gpio
> is valid (which is taken to be non-zero) before using it.
> The platform file has already configured the gpio for
> output; it's the GPIO102 discussed earlier.
> 
> What I'm suggesting here is check that the gpio is valid
> here and only once
> and not in the suspend/resume functions. That gpio is not
> going to change,
> so there is no point is checking it each time in
> suspend/resume.
> Also the check for non-zero is not correct. 0 is a valid
> gpio number on most platforms.
> You need to use the gpio_is_valid() call for this.

I understand. My feeling was that other platforms wanting to use this driver would not necessarily use a gpio for power on/off; indeed the gpio field was originally a callback to provide full flexibility. Hence suspend / resume needed to use the gpio conditionally anyway. Nevertheless I'm happy to make the change and leave it for future platform developers to revisit suspend / resume as necessary.

Regards,
Paul
