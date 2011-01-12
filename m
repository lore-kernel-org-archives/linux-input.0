From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (fourth version)
Date: Tue, 11 Jan 2011 21:50:02 -0800
Message-ID: <20110112055002.GB22944@core.coreip.homeip.net>
References: <4D27735C.6000105@armadeus.com>
 <20110108093040.GA8671@core.coreip.homeip.net>
 <4D2ACA17.5060708@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51150 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1ALFuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 00:50:09 -0500
Content-Disposition: inline
In-Reply-To: <4D2ACA17.5060708@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabien Marteau <fabien.marteau@armadeus.com>
Cc: Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 10, 2011 at 09:57:59AM +0100, Fabien Marteau wrote:
> Hi Dmitry,
> 
> Thanks for the patch, I tested it on my platform and there is a little bug in irq request for the button :
> 
> +	error = request_threaded_irq(as5011->button_irq,
> +				     NULL, as5011_button_interrupt,
> +				     IRQF_TRIGGER_RISING | IRQF_TRIGGER_RISING,
> +				     "as5011_button", as5011);
> 
> Should be :
> 
> +	error = request_threaded_irq(as5011->button_irq,
> +				     NULL, as5011_button_interrupt,
> +				     IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				     "as5011_button", as5011);
> 
> With this modification the patch is ok.
> 

Great, I applied it.

Thanks.

-- 
Dmitry
