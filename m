From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Date: Thu, 5 Jul 2018 13:44:34 +0100
Message-ID: <20180705124434.GP496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705092444.GL496@dell>
 <20180705103919.GB8426@localhost.localdomain>
 <20180705104919.GM496@dell>
 <20180705115143.GC8426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705115143.GC8426@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com, sboyd@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> On Thu, Jul 05, 2018 at 11:49:19AM +0100, Lee Jones wrote:
> > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > On Thu, Jul 05, 2018 at 10:24:44AM +0100, Lee Jones wrote:
> > > > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > > 
> > > > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
> > > > >  1 file changed, 67 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > > > > +		clock-names = "my-clock";
> > > > > +		clocks = <&pmic>;
> > > > > +	};
> > > > 
> > > > Do you have a real example to give?
> > > 
> > > For clock consumer? Sorry, no I don't.
> > 
> > Might be better to drop it for the time being then.
> 
> I have tested the clk driver using this dummy consumer. So in a sense it
> "works" and can be used as an example on how to write a real clock
> consumer node. Thus I see some value in this example node - even if it
> does not match to any real world HW. If I had to use the clk from this
> PMIC and write HW description I would appreciate this dummy exaple. I
> can drop it if you insist - but I would at least like to hear what is
> the downside on having it here?

My suggestion then would be to make it look as authentic as possible.

It is only an example, so it doesn't *really* matter, but the current
foo,bar one just looks a bit crumby.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
