From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH] Input: da9052_tsi: remove unnecessary worker
Date: Tue, 20 Jan 2015 12:04:30 +0100
Message-ID: <20150120110430.GC7404@pengutronix.de>
References: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150120072100.GB36091@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36843 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbbATLEc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 06:04:32 -0500
Content-Disposition: inline
In-Reply-To: <20150120072100.GB36091@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, support.opensource@diasemi.com, kernel@pengutronix.de

On Mon, Jan 19, 2015 at 11:21:00PM -0800, Dmitry Torokhov wrote:
> Hi Michael,
> 
> On Sun, Jan 18, 2015 at 04:36:08PM +0100, Michael Grzeschik wrote:
> > With the datardy irq we get the information if the
> > pen got pulled from the screen. This patch changes
> > the irq by checking this condition every time instead
> > of triggering the worker.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  drivers/input/touchscreen/da9052_tsi.c | 68 ++++++++++++++--------------------
> >  1 file changed, 27 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> > index 5a013bb..e6019dd 100644
> > --- a/drivers/input/touchscreen/da9052_tsi.c
> > +++ b/drivers/input/touchscreen/da9052_tsi.c
> > @@ -25,7 +25,6 @@
> >  struct da9052_tsi {
> >  	struct da9052 *da9052;
> >  	struct input_dev *dev;
> > -	struct delayed_work ts_pen_work;
> >  	struct mutex mutex;
> >  	bool stopped;
> >  	bool adc_on;
> > @@ -47,8 +46,6 @@ static irqreturn_t da9052_ts_pendwn_irq(int irq, void *data)
> >  		da9052_enable_irq(tsi->da9052, DA9052_IRQ_TSIREADY);
> >  
> >  		da9052_ts_adc_toggle(tsi, true);
> > -
> > -		schedule_delayed_work(&tsi->ts_pen_work, HZ / 50);
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > @@ -89,6 +86,33 @@ static void da9052_ts_read(struct da9052_tsi *tsi)
> >  	y = ((y << 2) & 0x3fc) | ((v & 0xc) >> 2);
> >  	z = ((z << 2) & 0x3fc) | ((v & 0x30) >> 4);
> >  
> > +	/* Check for last TSI_READY irq */
> > +	if (!(ret & TSI_PEN_DOWN_STATUS)) {
> > +
> > +		/* Pen UP */
> > +		da9052_ts_adc_toggle(tsi, false);
> 
> Now it is racy WRT tsi->adc_on checks in da9052_ts_input_close();
> previously we'd disable pendown IRQ and cancel the work, so no one
> would be touching tsi->adc_on.

I have been testing this and did not run into any race.
But ok, that resource should probably be surrounded by some
locking. I will give it a try.

> Also I'd rather we did event reporting in this function, but do IRQ
> switchover in da9052_ts_datardy_irq().

Sounds good in aspect of code structure.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
