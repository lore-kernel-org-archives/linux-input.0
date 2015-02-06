From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH v2] Input: da9052_tsi: remove unnecessary worker
Date: Sat, 7 Feb 2015 00:41:24 +0100
Message-ID: <20150206234124.GF1139@pengutronix.de>
References: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
 <1423220748-21778-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150206232448.GC29225@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43159 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbBFXl1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 18:41:27 -0500
Content-Disposition: inline
In-Reply-To: <20150206232448.GC29225@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: support.opensource@diasemi.com, kernel@pengutronix.de, linux-input@vger.kernel.org

On Fri, Feb 06, 2015 at 03:24:48PM -0800, Dmitry Torokhov wrote:
> On Fri, Feb 06, 2015 at 12:05:48PM +0100, Michael Grzeschik wrote:
> > With the datardy irq we get the information if the
> > pen got pulled from the screen. This patch changes
> > the irq by checking this condition every time instead
> > of triggering the worker.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > v1 -> v2: - removed adc_on variable
> > 	  - added locking for irq switch
> > 	  - event reporting in ts_read and irq switchover in datardy_irq
> >  drivers/input/touchscreen/da9052_tsi.c | 119 +++++++++++++++++----------------
> >  1 file changed, 62 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> > index 5a013bb..c28cfee 100644
> > --- a/drivers/input/touchscreen/da9052_tsi.c
> > +++ b/drivers/input/touchscreen/da9052_tsi.c
> > @@ -22,19 +22,24 @@
> >  
> >  #define TSI_PEN_DOWN_STATUS 0x40
> >  
> > +#define TSI_PEN_UP		1
> > +
> >  struct da9052_tsi {
> >  	struct da9052 *da9052;
> >  	struct input_dev *dev;
> > -	struct delayed_work ts_pen_work;
> >  	struct mutex mutex;
> > +	spinlock_t *lock;
> 
> I am gonna go out on a limb and say that you did not test it.

I was testing exactly this. It seems i did miss that pointer and it
still worked.

Beside that, do you think it would be better to split the patch up?

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
