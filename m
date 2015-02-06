From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: da9052_tsi: remove unnecessary worker
Date: Fri, 6 Feb 2015 15:54:59 -0800
Message-ID: <20150206235459.GA7927@dtor-ws>
References: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
 <1423220748-21778-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150206232448.GC29225@dtor-ws>
 <20150206234124.GF1139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38090 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbBFXzE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 18:55:04 -0500
Received: by iecvy18 with SMTP id vy18so5213305iec.5
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 15:55:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150206234124.GF1139@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: support.opensource@diasemi.com, kernel@pengutronix.de, linux-input@vger.kernel.org

On Sat, Feb 07, 2015 at 12:41:24AM +0100, Michael Grzeschik wrote:
> On Fri, Feb 06, 2015 at 03:24:48PM -0800, Dmitry Torokhov wrote:
> > On Fri, Feb 06, 2015 at 12:05:48PM +0100, Michael Grzeschik wrote:
> > > With the datardy irq we get the information if the
> > > pen got pulled from the screen. This patch changes
> > > the irq by checking this condition every time instead
> > > of triggering the worker.
> > > 
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > ---
> > > v1 -> v2: - removed adc_on variable
> > > 	  - added locking for irq switch
> > > 	  - event reporting in ts_read and irq switchover in datardy_irq
> > >  drivers/input/touchscreen/da9052_tsi.c | 119 +++++++++++++++++----------------
> > >  1 file changed, 62 insertions(+), 57 deletions(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> > > index 5a013bb..c28cfee 100644
> > > --- a/drivers/input/touchscreen/da9052_tsi.c
> > > +++ b/drivers/input/touchscreen/da9052_tsi.c
> > > @@ -22,19 +22,24 @@
> > >  
> > >  #define TSI_PEN_DOWN_STATUS 0x40
> > >  
> > > +#define TSI_PEN_UP		1
> > > +
> > >  struct da9052_tsi {
> > >  	struct da9052 *da9052;
> > >  	struct input_dev *dev;
> > > -	struct delayed_work ts_pen_work;
> > >  	struct mutex mutex;
> > > +	spinlock_t *lock;
> > 
> > I am gonna go out on a limb and say that you did not test it.
> 
> I was testing exactly this. It seems i did miss that pointer and it
> still worked.

That makes me worried even more - that pointer should have been NULL and
you should have been getting very low address fault when you try to
spin_lock_init(NULL) - so what exactly have you tested?

Thanks.

-- 
Dmitry
