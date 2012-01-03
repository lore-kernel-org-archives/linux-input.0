From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH v2] input: add support for TI Touchscreen controller
Date: Tue, 3 Jan 2012 06:43:36 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B93201B5E3@DBDE01.ent.ti.com>
References: <1323430182-27626-1-git-send-email-rachna@ti.com>
 <20111230035521.GD17850@core.coreip.homeip.net>
 <4CE347531D4CA947960AF71FF095B93201B58E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2ACGnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2012 01:43:40 -0500
In-Reply-To: <4CE347531D4CA947960AF71FF095B93201B58E@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

On Mon, Jan 02, 2012 at 17:51:59, Patil, Rachna wrote:
> Hi Dmitry,
> Thanks for the patch.
> Please find my comments inline.
> 
> On Fri, Dec 30, 2011 at 09:25:21, Dmitry Torokhov wrote:
> > Hi Rachna,
> > 
> > 
> > On Fri, Dec 09, 2011 at 04:59:42PM +0530, Patil, Rachna wrote:
> > > From: Rachna Patil <rachna@ti.com>
> > > 
> > > This patch adds support for TI's touchscreen controller for a 4/5/8 
> > > wire resistive panel that is directly fed to the ADC.
> > > 
> > > This touchscreen controller will be part of AM335x TI SoC. The TRM 
> > > can be found at:
> > > http://www.ti.com/lit/ug/spruh73a/spruh73a.pdf
> > > 
> > 
> > This looks mostly good, could you also try the patch below (on top of
> > yours) and let me know if the driver still works?
> > 
> > Thanks!
> > 
> > --
> > Dmitry
> > 
> > 
> > Input: ti_tscadc - misc changes
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > - rely on input core to implement defuzzing (filtering out smaller
> >   variations in coordinates);
> > - release the 2nd clock after getting its rate;
> > - IRQF_DISABLE is obsolete;
> > - split filtering of measurements into a separate function;
> > - misc formatting changes;
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> > 
> >  drivers/input/touchscreen/ti_tscadc.c |  244 
> > ++++++++++++++++-----------------
> >  1 files changed, 115 insertions(+), 129 deletions(-)

<SNIP>

> > +	/*
> > +	 * Delta filter is used to remove large variations
> > +	 * in sampled values from ADC. The filter tries to
> > +	 * predict where the next coordinate could be.
> > +	 * This is done by taking a previous coordinate and
> > +	 * subtracting it form current one. Further the
> > +	 * algorithm compares the difference with that of
> > +	 * a present value, if true the value is reported
> > +	 * to the sub system.
> > +	 */
> > +	for (i = 0; i < fifocount - 1; i++) {
> > +		read = tscadc_readl(ts_dev, REG_FIFO0) & 0xfff;
> > +		diff = abs(read - prev_val_x);
> > +		if (diff < prev_diff_x) {
> > +			prev_diff_x = diff;
> > +			*x = read;
> >  		}
> > +		prev_val_x = read;
> >  
> > -		diffx = abs(val_x - (ts_dev->bckup_x));
> > -		diffy = abs(val_y - (ts_dev->bckup_y));
> > -		ts_dev->bckup_x = val_x;
> > -		ts_dev->bckup_y = val_y;
> > -
> > -		z1 = ((tscadc_readl(ts_dev, REG_FIFO0)) & 0xfff);
> > -		z2 = ((tscadc_readl(ts_dev, REG_FIFO1)) & 0xfff);
> > -
> > -		if (ts_dev->pen == 0) {
> > -			if ((z1 != 0) && (z2 != 0)) {
> > -				/* cal pressure using formula
> > -				 * Resistance(touch) = x plate resistance *
> > -				 * x postion/4096 * ((z2 / z1) - 1)
> > -				 */
> > -				z = z2 - z1;
> > -				z *= val_x;
> > -				z *= ts_dev->x_plate_resistance;
> > -				z /= z1;
> > -				z = (z + 2047) >> 12;
> > -
> > -				if ((diffx < 15) && (diffy < 15)
> > -						&& (z <= MAX_12BIT)) {
> 
> Using defuzz alone does not solve the problem. I am trying to filter out odd random values from the ADC that are incorrect (Not only noise). Hence as explained I am using delta algorithm.
> As a part of this algorithm I am checking for value being less than 15.

I will apply your patch on top of the driver and also submit an incremental patch
that will include changes for touchscreen to work as expected on my setup.
This way we can come to a conclusion on the driver. 

> 
> > -					input_report_abs(input_dev,
> > -							ABS_X, val_x);
> > -					input_report_abs(input_dev,
> > -							ABS_Y, val_y);
> > -					input_report_abs(input_dev,
> > -							ABS_PRESSURE, z);
> > -					input_report_key(input_dev,
> > -							BTN_TOUCH, 1);
> > -					input_sync(input_dev);
> > -				}
> > +		read = tscadc_readl(ts_dev, REG_FIFO1) & 0xfff;
> > +		diff = abs(read - prev_val_y);
> > +		if (diff < prev_diff_y) {
> > +			prev_diff_y = diff;
> > +			*y = read;
> > +		}
> > +		prev_val_y = read;
> > +	}
> > +}
> > +

<SNIP>

Regards,
Rachna.

