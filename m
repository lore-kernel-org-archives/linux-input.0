From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCHv2 3/3] Input: edt-ft5x06: Add DT support
Date: Fri, 17 Jan 2014 10:36:42 +0900
Message-ID: <000101cf1324$932c0600$b9841200$%han@samsung.com>
References: <1389859338-11685-1-git-send-email-LW@KARO-electronics.de>
 <1389859338-11685-4-git-send-email-LW@KARO-electronics.de>
 <20140117002649.GA837@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140117002649.GA837@core.coreip.homeip.net>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?'Lothar_Wa=DFmann'?= <LW@KARO-electronics.de>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Simon Budig' <simon.budig@kernelconcepts.de>, 'Rob Herring' <robh+dt@kernel.org>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Ian Campbell' <ijc+devicetree@hellion.org.uk>, 'Kumar Gala' <galak@codeaurora.org>, 'Rob Landley' <rob@landley.net>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Grant Likely' <grant.likely@linaro.org>, 'Jonathan Cameron' <jic23@kernel.org>, 'Shawn Guo' <shawn.guo@linaro.org>, 'Silvio F' <silvio.fricke@gmail.com>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>, 'Fugang Duan' <B38611@freescale.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Friday, January 17, 2014 9:27 AM, Dmitry Torokhov wrote:
> On Thu, Jan 16, 2014 at 09:02:18AM +0100, Lothar Wa=DFmann wrote:
> >
> > Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> > ---
> >  .../bindings/input/touchscreen/edt-ft5x06.txt      |   29 +++++
> >  drivers/input/touchscreen/edt-ft5x06.c             |  121 ++++++++=
+++++++++---
> >  2 files changed, 132 insertions(+), 18 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchsc=
reen/edt-ft5x06.txt
> >

[.....]

> > +	if (gpio_is_valid(tsdata->reset_pin)) {
> >  		/* this pulls reset down, enabling the low active reset */
> > -		error =3D devm_gpio_request_one(&client->dev, reset_pin,
> > +		error =3D devm_gpio_request_one(&client->dev, tsdata->reset_pin,
> >  					GPIOF_OUT_INIT_LOW,
> >  					"edt-ft5x06 reset");
> >  		if (error) {
> >  			dev_err(&client->dev,
> >  				"Failed to request GPIO %d as reset pin, error %d\n",
> > -				reset_pin, error);
> > +				tsdata->reset_pin, error);
> >  			return error;
> >  		}
> >
> > -		mdelay(50);
> > -		gpio_set_value(reset_pin, 1);
> > -		mdelay(100);
> > +		mdelay(5);
> > +		gpio_set_value(tsdata->reset_pin, 1);
> > +		mdelay(300);
>=20
> Hmm, this change seems unrelated to DT support.

Right, modifying delay timing is not related to DT support.
In this case, this patch should be split, and the patch should
address the reason why delay timing is modified.
Also, 300 msec is a huge delay. Thus, comment will be helpful.

Best regards,
Jingoo Han
