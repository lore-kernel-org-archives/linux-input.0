From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 06/10] regulator: AXP20x: Add
 support for regulators subsystem
Date: Sat, 29 Mar 2014 18:52:01 +0100
Message-ID: <20140329175201.GD3952@localhost.fastwebnet.it>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-7-git-send-email-carlo@caione.org>
 <20140328133934.GQ30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140328133934.GQ30768@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, Mar 28, 2014 at 01:39:34PM +0000, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 10:29:20PM +0100, Carlo Caione wrote:
> 
> > +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> > +{
> > +	int sel = regulator_map_voltage_iterate(rdev, uV, uV);
> > +
> > +	if (sel < 0)
> > +		return sel;
> > +
> > +	return regulator_set_voltage_sel_regmap(rdev, sel);
> > +}
> 
> This is fairly obviously broken - it's overwriting the normal runtime
> value, this will disrupt the running system if we want the value we use
> on suspend is different to the value we want at runtime.

Ok, silly question: isn't it exactly what we want? Set the voltage for
the regulator when the system is suspended?

> Think about it - if this was a sane thing to do the core would just do
> it without needing driver specific code, we already know how to set the
> voltage for the device.

I thought it was because some regulators can have specific regs for
managing the suspend mode.

BTW, but then what is the difference between my code and (i.e.) the same
routine in da9055-regulator.c?

http://lxr.linux.no/linux+v3.13.5/drivers/regulator/da9055-regulator.c#L276

Thanks,

-- 
Carlo Caione
