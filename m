From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] input: gpio-keys: Add runtime support
Date: Thu, 25 Oct 2012 08:57:09 +0100
Message-ID: <20121025075709.GE971@gmail.com>
References: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
 <1349964927-18619-2-git-send-email-lee.jones@linaro.org>
 <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
 <CACRpkdb+kWW903VD45i5s_LrZ2BKX=k6enGP2R9v2ptSRkvJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb+kWW903VD45i5s_LrZ2BKX=k6enGP2R9v2ptSRkvJ9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Philippe Langlais <philippe.langlais@linaro.org>
List-Id: linux-input@vger.kernel.org

On Fri, 12 Oct 2012, Linus Walleij wrote:

> On Thu, Oct 11, 2012 at 4:22 PM, Shubhrajyoti Datta
> <omaplinuxkernel@gmail.com> wrote:
>=20
> >> @@ -526,6 +527,7 @@ static int gpio_keys_open(struct input_dev *in=
put)
> >>  {
> >>         struct gpio_keys_drvdata *ddata =3D input_get_drvdata(inpu=
t);
> >>
> >> +       pm_runtime_get_sync(input->dev.parent);
> >
> > I am not an expert of the runtime.
> >
> > However would be grateful if you explain me what it actually do.
>=20
> This increase the reference count of the runtime status container
> for the device. _sync makes sure it happens now.
>=20
> Consult:
> Documentation/power/runtime_pm.txt
>=20
> > Also I did not see any runtime suspend/ resume handlers populated.
>=20
> It is not necessary to handle the power state at the driver level,
> it can just as well be handled by the voltage/power domain,
> or at the class, type or bus level.
>=20
> But the individual driver has to notify the system upward if it
> needs to be powered on or when it may or must be relaxed.
>
> Yours,
> Linus Walleij

=46riendly poke.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
