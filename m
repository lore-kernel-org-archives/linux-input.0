From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Thu, 05 Jul 2018 23:38:35 -0700
Message-ID: <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com> <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com> <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com> <20180704145623.zgei3ehrwdpcu26r@penguin> <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com> <20180705075650.GA7683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705075650.GA7683@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.or
List-Id: linux-input@vger.kernel.org

On July 5, 2018 12:56:50 AM PDT, Matti Vaittinen <matti=2Evaittinen@fi=2Ero=
hmeurope=2Ecom> wrote:
>On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
>> Missatge de Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom> del dia dc=
=2E,
>4
>> de jul=2E 2018 a les 17:10:
>> >
>> > Hi Enric,
>> >
>> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra
>wrote:
>> > > Hi Matti,
>> > >
>> > > Thanks for the patch, a few comments below, some are feedback I
>> > > received when I sent some patches to this subsystem=2E
>> > >
>> > > Missatge de Matti Vaittinen <matti=2Evaittinen@fi=2Erohmeurope=2Eco=
m>
>del
>> > > dia dt=2E, 19 de juny 2018 a les 12:57:
>> > > > +};
>> > > > +
>> > > > +/* bd71837 multi function cells */
>> > > > +static struct mfd_cell bd71837_mfd_cells[] =3D {
>> > > > +       {
>> > > > +               =2Ename =3D "bd71837-clk",
>> > > > +       }, {
>> > > > +               =2Ename =3D "bd718xx-pwrkey",
>> > > > +               =2Eresources =3D &irqs[0],
>> > > > +               =2Enum_resources =3D ARRAY_SIZE(irqs),
>> > > > +       }, {
>> > > > +               =2Ename =3D "bd71837-pmic",
>> > > > +       },
>> > > nit: no comma at the end
>> >
>> > Actually, trailing comma is preferred on structures/arrays without
>> > sentinels, because if one needs to add a new entry/new member, then
>in
>> > the diff there will have only one new line added, instead of one
>line
>> > being changed (adding now necessary comma) and one added=2E
>> >
>>=20
>> Many thanks for sharing your knowledge! That looks to me a good
>> reason=2E
>
>So in this specific ecample leaving the comma does not help=2E The
>opening
>brace for new array element would be added to same line where the comma
>is, right?

Ah, yes,  you are right=2E We usually have either:

        { /* element 1 */ },
        { / *element 2 */ },
        =2E=2E=2E

or:

        {
                /* element 1 */
        },
        {
                /* element 2 */
        },

but I do not think that it is codified in the CodingStyle=2E


Thanks=2E

--=20
Dmitry
