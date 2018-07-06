From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Fri, 6 Jul 2018 10:49:15 +0300
Message-ID: <20180706074915.GA11209@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180704145623.zgei3ehrwdpcu26r@penguin>
 <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
 <20180705075650.GA7683@localhost.localdomain>
 <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
 <20180706070559.GW496@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706070559.GW496@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>linux-kernel <li>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 06, 2018 at 08:05:59AM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Dmitry Torokhov wrote:
> 
> > On July 5, 2018 12:56:50 AM PDT, Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> wrote:
> > >On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
> > >> Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc.,
> > >4
> > >> de jul. 2018 a les 17:10:
> > >> >
> > >> > Hi Enric,
> > >> >
> > >> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra
> > >wrote:
> > >> > > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > >> > > > +       {
> > >> > > > +               .name = "bd71837-clk",
> > >> > > > +       }, {
> > >> > > > +               .name = "bd718xx-pwrkey",
> > >> > > > +               .resources = &irqs[0],
> > >> > > > +               .num_resources = ARRAY_SIZE(irqs),
> > >> > > > +       }, {
> > >> > > > +               .name = "bd71837-pmic",
> > >> > > > +       },
> > >> > > nit: no comma at the end
> > >> >
> > >> > Actually, trailing comma is preferred on structures/arrays without
> > >> > sentinels, because if one needs to add a new entry/new member, then
> > >in
> > >> > the diff there will have only one new line added, instead of one
> > >line
> > >> > being changed (adding now necessary comma) and one added.
> > >> >
> > >> 
> > >> Many thanks for sharing your knowledge! That looks to me a good
> > >> reason.
> > >
> > >So in this specific ecample leaving the comma does not help. The
> > >opening
> > >brace for new array element would be added to same line where the comma
> > >is, right?
> > 
> > Ah, yes,  you are right. We usually have either:
> > 
> >         { /* element 1 */ },
> >         { / *element 2 */ },
> >         ...
> > 
> > or:
> > 
> >         {
> >                 /* element 1 */
> >         },
> >         {
> >                 /* element 2 */
> >         },
> > 
> > but I do not think that it is codified in the CodingStyle.
> 
> FWIW, my *strong* preference for single line entries in the
> aforementioned single line format.  Then Dmitry's explanation rings
> true.

The reasoning given by Dmitry makes perfect sense. And to my eyes:
	{
		/* element 1 */
	},
	{
		/* element 2 */
 	},

actually looks better than:
> 	{
		/* element 1 */
	}, {
		/* element 2 */
 	},

So if first one is not enforced in order to minimize almost empty lines
- then I will try to be using the latter in the future. (In such cases
  where element consists of more than one value).

Thanks for this little lesson =)

Br,
	Matti Vaittinen
