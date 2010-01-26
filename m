From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v2] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Tue, 26 Jan 2010 11:29:01 +0100
Message-ID: <1264501741.5260.29.camel@realization>
References: <1262977099.2050.75.camel@climbing-alby>
	 <BD79186B4FD85F4B8E60E381CAEE190902089738@mi8nycmail19.Mi8.com>
	 <1263664125.4350.18.camel@realization>
	 <20100126095217.GC3480@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55268 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab0AZK3K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2010 05:29:10 -0500
In-Reply-To: <20100126095217.GC3480@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel-infradead <linux-arm-kernel@lists.infradead.org>, Sascha linux-arm <s.hauer@pengutronix.de>

Hi Dmitry! Thanks for reviewing!

On mar, 2010-01-26 at 01:52 -0800, Dmitry Torokhov wrote:
> > This algorithm is done via a threaded management of the keypad interrupt source
> > and delayed by a proper (and longer) debounce interval controlled by the 
> > platform initialization.
> 
> This I am not so sure about - the core of the matrix scan routine does
> not sleep so I wonder if starting a separate thread is not too wasteful
> in this case - you can easily do whan you want with a timer, no?

I'm pretty new to kernel programming and, from the university, the 
threaded way looked the better (and unique) for me..
Let me find some documentation on timers and I will restructure the 
interrupt management. Yes I need only to delay the matrix-scan activity
without waste cpu time.

> 
> > +
> > +     /*
> > +      * Search for rows and cols enabled
> > +      */
> > +     keymap_data = (struct matrix_keymap_data *) pdata->keymap_data;
> 
> Why do you need to cast away constness instead of declaring keymap_data
> as const pointer?

In next version will be fixed.

Alberto!


