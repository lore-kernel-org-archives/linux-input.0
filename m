From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [Patch 08/10] input: Touchscreen driver for the PCAP
Date: Mon, 7 Jul 2008 22:22:00 +0200
Message-ID: <20080707202200.GB3449@datenfreihafen.org>
References: <20080707184000.411913919@datenfreihafen.org> <20080707184131.286622542@datenfreihafen.org> <20080707161212.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirius.lasnet.de ([78.47.116.19]:55364 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755912AbYGGUR4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Jul 2008 16:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20080707161212.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, Daniel Ribeiro <wyrm@openezx.org>

Hello.

On Mon, 2008-07-07 at 16:13, Dmitry Torokhov wrote:
> 
> On Mon, Jul 07, 2008 at 08:40:08PM +0200, stefan@datenfreihafen.org wrote:
> > +
> > +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > +	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
> > +			     PRESSURE_MAX, 0, 0);
> > +
> > +	input_register_device(pcap_ts->input);
> 
> Please add error handling here, otherwise looks good.

Ok.New patch somes tomorrow. Need sleep now.

> Thanks.

Thanks for the feedback.

regards
Stefan Schmidt
