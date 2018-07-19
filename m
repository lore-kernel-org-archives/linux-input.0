From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional
 regulators.
Date: Thu, 19 Jul 2018 21:54:04 +0100
Message-ID: <20180719205403.GA29273@hairyalien>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <20180717210005.GA21416@hairyalien>
 <2353752.vfvcsHJLR6@acerlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2353752.vfvcsHJLR6@acerlaptop>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 18, 2018 at 06:21:30PM +0200, Paweł Chmiel wrote:
> On Tuesday, July 17, 2018 10:00:05 PM CEST Nick Dyer wrote:
> > On Tue, Jul 17, 2018 at 08:16:25PM +0200, Paweł Chmiel wrote:
> > > This patch adds optional regulators, which can be used to power
> > > up touchscreen. After enabling regulators, we need to wait 150msec.
> > > This value is taken from official driver.
> > > 
> > > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> > > 
> > > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > > Changes from v1:
> > >   - Enable regulators only if reset_gpio is present.
> > >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > > ---
> > >  drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > 
> > Hi Pawel-
> > 
> > I see you've borrowed some of the logic from the patch I wrote a while
> > back (see https://github.com/ndyer/linux/commit/8e9687e41ed062 )
> Actually, i was looking at https://github.com/atmel-maxtouch/linux/blob/maxtouch-v3.14/drivers/input/touchscreen/atmel_mxt_ts.c (and didn't saw Your patch till now).
> Are You going to submit it? (it has more functionalities - for example
> suspend mode read from device tree).

Getting that work upstream has stalled for a couple of years because I
changed jobs. I have actually started recently to dust it off again, it
was later on in my queue but if you have the time to work on it that is
great.

> > The correct behaviour according to Atmel should be:
> > 
> > * Make RESET zero
> > * Bring up regulators
> > * Wait for a period to settle (150 msec)
> > * Release RESET
> > * Wait for 100 msec whilst device gets through bootloader
> > * Wait for CHG line assert before reading info block
> > 
> > I can't see the first and last steps in your patch at present.
> About first step - reset_gpio is readed by using
> devm_gpiod_get_optional with GPIOD_OUT_LOW flag, so i think (but might
> be wrong)  that we don't need to set this gpio value again to 0 before
> enabling regulators,

I see what you mean - that is fair enough.

> since currently only place where reset_gpio is used is in driver probe
> (in Your patch it is used in other cases/places - for example in
> mxt_start/stop, when we enable regulators).
> About missing wait after releasing reset, shouldn't this be separate
> patch (since currently driver is not doing it)? I can prepare it and
> send with other in next version.

According to the maxtouch documentation, it isn't ready for comms until
the firmware asserts the CHG line. I've seen a bunch of devices that get
by without an explicit wait because the board file does the power on,
and by the time the driver gets to probe it's a few hundred ms later
anyway, so it doesn't matter. But if we put it all in the driver, it
will attempt to read the info block straight after the 100 msec delay
without waiting for CHG, and I suspect we'll end up with occasional
probe failures. It'll depend on the maxtouch device, though: they have a
range of different power on timings.

Which platform are you doing this for? Is it a Chromebook?

> Thanks for feedback
> > 
> > The only downside with this approach is that there are a lot of
> > delays during driver probe, but I believe the asynchronous probe stuff
> > that's landed since I wrote the original patch should address that.
> > 
> > cheers
> > 
> > Nick
> > 
> > >  	}
> > > @@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *client)
> > >  	struct mxt_data *data = i2c_get_clientdata(client);
> > >  
> > >  	disable_irq(data->irq);
> > > +	if (data->reset_gpio) {
> > > +		regulator_disable(data->avdd_reg);
> > > +		regulator_disable(data->vdd_reg);
> > > +	}
> > >  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> > >  	mxt_free_input_device(data);
> > >  	mxt_free_object_table(data);
> > 
> 
> 
