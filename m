From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] Driver for WM97xx touchscreens in streaming mode
	on PXA2xx systems
Date: Mon, 14 Jan 2008 14:42:50 +0000
Message-ID: <20080114144250.GA7443@rakim.wolfsonmicro.main>
References: <1199965870-4629-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-2-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-3-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-4-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-5-git-send-email-broonie@opensource.wolfsonmicro.com> <478B31B6.3050406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752647AbYANOnG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <478B31B6.3050406@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>, Vince Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2008 at 10:56:06AM +0100, Marc Kleine-Budde wrote:
> reMark Brown wrote:

> > Cc: Marc Kleine-Budde <mkl@penugtronix.de>
>                                 ^^
> it's mkl@pengutronix.de

Fixed, sorry about that.

> > +			/* use PEN_DOWN GPIO 13 to assert IRQ on GPIO line 2 */
> > +			wm->pen_irq = MAINSTONE_AC97_IRQ;

> I'm missing some kind of abstraction here, what about non mainstone
> boards with the pen irq wired to some other gpio?

The driver really isn't intended to cope with them.  As you say, other
boards may have things wired up differently and therefore require
different configuration of the wm97xx and other bits of the system.  The
expectation is that other systems will have their own driver.

My initial thought is that the most straightforward way of handling this
would be to rename the driver to mainstone-wm97xx or similar to make it
clear that the driver is only intended to handle Mainstone as-is.  Does
that seem reasonable?
