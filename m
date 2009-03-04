From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Wed, 4 Mar 2009 10:50:53 +0100
Message-ID: <20090304095053.GA6098@buzzloop.caiaq.de>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de> <20090304084851.GB7394@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:45641 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbZCDJu7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 04:50:59 -0500
Content-Disposition: inline
In-Reply-To: <20090304084851.GB7394@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>

On Wed, Mar 04, 2009 at 12:48:52AM -0800, Dmitry Torokhov wrote:
> On Tue, Mar 03, 2009 at 10:59:27AM +0100, Daniel Mack wrote:
> > This patch adds a generic driver for rotary encoders connected to GPIO
> > pins of a system. It relies on gpiolib and generic hardware irqs. The
> > documentation that also comes with this patch explains the concept and
> > how to use the driver.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > ---
> >  New version with Dmitry's change requests included:
> > 
> >   * calling input_free_device() in case input_register_device() fails
> >   * calling input_unregister_device() in all other cases
> >   * made the axis information part of the platform data
> > 
> 
> I fiddled with the driver a little bit more changing formatting, please
> take a look and if you are still OK with it I will apply to 'next'.

Ok for me, except for one thing ...

> +	case 0x0:
> +		if (encoder->armed) {
> +			if (encoder->dir) {
> +				/* turning counter-clockwise */
> +				encoder->pos += pdata->steps;
> +				encoder->pos--;
> +				encoder->pos %= pdata->steps;
> +			} else {
> +				/* turning clockwise */
> +				encoder->pos++;
> +				encoder->pos %= pdata->steps;
> +			}
> +			input_report_abs(encoder->input,
> +					 pdata->axis, encoder->pos);
> +			input_sync(encoder->input);
> +			encoder->armed = 0;
> +		}

I really prefer early exits ("if (!encoder->armed) break;") as it saves
one indentation level and makes the code more readable.

Thanks,
Daniel

