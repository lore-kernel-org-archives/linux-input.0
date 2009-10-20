From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Tue, 20 Oct 2009 10:41:32 +0100
Message-ID: <20091020094132.GA17240@sirena.org.uk>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org> <4ADC4D4D.5020508@gmail.com> <20091019120744.GB7412@n2100.arm.linux.org.uk> <2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com> <20091020073946.GB723@n2100.arm.linux.org.uk> <2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54346 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZJTJlf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 05:41:35 -0400
Content-Disposition: inline
In-Reply-To: <2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nelson Castillo <arhuaco@freaks-unidos.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, dtor@mail.ru, Shine Liu <shinel@foxmail.com>, dmitry.torokhov@gmail.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 20, 2009 at 03:21:17AM -0500, Nelson Castillo wrote:

> Can the s3c driver send the events at full speed? (Maximum possible ADC rate?).

> Even if it's possible I think we would monopolize the adc driver
> needlessly because we don't need all that conversions when there is
> not much noise. Please read on.

There's currently no facility to push sample rate requests down into the
kernel from userspace.  However, this is a good idea in general - there
was some recent (brief) discussion of doing this on the linux-input list.
Since different use cases have different sample rate requirements (such
as the difference between handwriting recognition which can need 200
samples/second and a simple finger operated menu which may be happy with
10) there's value in being able to vary the sample rate at run time.  I
was intending to look at this shortly as part of some touchscreen driver
development I need to do soon or perhaps someone else will pick up the
idea, if it does get implemented then obviously tslib would also be able
to use it here.
