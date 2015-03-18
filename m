From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: eglx_ts, remove irq trigger flags
Date: Wed, 18 Mar 2015 09:50:03 -0700
Message-ID: <20150318165003.GA11485@dtor-ws>
References: <1426171816-26609-1-git-send-email-mpa@pengutronix.de>
 <1426173483.14455.73.camel@pengutronix.de>
 <20150312153701.GB13382@pengutronix.de>
 <20150312162813.GA4720@dtor-ws>
 <20150313071447.GA16614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150313071447.GA16614@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 13, 2015 at 08:14:47AM +0100, Markus Pargmann wrote:
> On Thu, Mar 12, 2015 at 09:28:13AM -0700, Dmitry Torokhov wrote:
> > On Thu, Mar 12, 2015 at 04:37:01PM +0100, Markus Pargmann wrote:
> > > Hi,
> > > 
> > > On Thu, Mar 12, 2015 at 04:18:03PM +0100, Philipp Zabel wrote:
> > > > Hi Markus,
> > > > 
> > > > Am Donnerstag, den 12.03.2015, 15:50 +0100 schrieb Markus Pargmann:
> > > > > The trigger settings for a given irq are parsed from DT. Defining them
> > > > > as flag for devm_request_threaded_irq() overwrites these settings. This
> > > > > results in wrong trigger settings for boards which have different irq
> > > > > triggers.
> > > > > 
> > > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > > ---
> > > > >  drivers/input/touchscreen/egalax_ts.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> > > > > index 4c56299284ef..b0e6448b743c 100644
> > > > > --- a/drivers/input/touchscreen/egalax_ts.c
> > > > > +++ b/drivers/input/touchscreen/egalax_ts.c
> > > > > @@ -218,7 +218,7 @@ static int egalax_ts_probe(struct i2c_client *client,
> > > > >  
> > > > >  	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > > > >  					  egalax_ts_interrupt,
> > > > > -					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > > > +					  IRQF_ONESHOT,
> > > > >  					  "egalax_ts", ts);
> > > > >  	if (error < 0) {
> > > > >  		dev_err(&client->dev, "Failed to register interrupt\n");
> > > > 
> > > > There are three device trees which have eeti,egalax_ts nodes with
> > > > interrupt flags 0:
> > > > 
> > > > arch/arm/boot/dts/imx53-tx53-x13x.dts (twice),
> > > > arch/arm/boot/dts/imx6dl-tx6u-811x.dts, and
> > > > arch/arm/boot/dts/imx6q-tx6q-1110.dts.
> > > > 
> > > > Will these still work after this change?
> > > 
> > > Oh right, thanks, these should be fixed as well.
> > 
> > If by fixing you mean changing DTS I do not think we can do that. Maybe
> > the driver should check if there is non-empty trigger flags in the
> > interrupt description and fall back to IRQF_TRIGGER_LOW if they are
> > absent.
> 
> I think this is more of a driver/dts bug. The devicetree binding
> documentation for the egalax_ts [1] does not describe the interrupts
> flags that should be set or that the flag should be 0. Even the example
> shows the interrupt flags being '2'(trigger high-to-low edge). These
> flags are described by the interrupt-controller. The generic
> interrupt-controller bindings describe the second parameter for
> interrupts as interrupt trigger flags [2].
> 
> So I think having a '0' as second parameter in the 'interrupts' field is a
> wrong representation of the actual hardware. This of course works as
> long as the driver ignores the trigger settings from DT which is not
> specified in the bindings.

The point is that we should not break boards with existing DTS. Yes, DTS
may be wrong, not optimal, whatever, but if it used to work we need to
keep it working.

Thanks.

-- 
Dmitry
