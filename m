From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Mon, 3 Apr 2017 15:30:49 +0100
Message-ID: <20170403143049.qyi4dagwi4cdenok@dell>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
 <20170403141214.q6ndii6c47pqfqx6@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B183@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD6B183@SW-EX-MBX02.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 03 Apr 2017, Steve Twiss wrote:

> On 03 April 2017 15:12, Lee Jones wrote:
> 
> > > @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	chip->regmap = devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> > > +	switch (chip->chip_type) {
> > > +	case(COMPAT_TYPE_DA9061):
> > 
> > Brackets around the case value?
> > 
> > That's a new one on me.
> 
> Hm. Do you want me to resend it without braces?

Yes please.  And a space after the 'case'.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
