From: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Fri, 01 Jul 2016 15:10:18 +0200
Message-ID: <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com> <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com> <20160628162834.GF29166@dell> <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
Content-ID: <1234.1467378617.1@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-input@vger.kernel.org

Hi Ksenija!

Ksenija Stanojevi=C4=87 writes:
> On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> >> +static int mxs_lradc_add_device(struct platform_device *pdev,
> >> +                             struct mxs_lradc *lradc, char *name,=
 int i)
> >> +{
> >> +     struct mfd_cell *cell;
> >> +
> >> +     cell =3D &lradc->cells[i];
> >> +     cell->name =3D name;
> >> +     cell->platform_data =3D lradc;
> >> +     cell->pdata_size =3D sizeof(*lradc);
> >> +
> >> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0=
, NULL);
> >> +}
> >
> > Please don't roll your own API.
> >
> > Use 'struct mfd_cell' like everyone else does.
>=20
> It has been suggested in previous reviews to use separate function to
> register mfd device, and to make mfd_cell allocate dynamically becaus=
e
> struc mxs-lradc is allocated dynamically.
> But I can revrse changes and make mfd_cells allocate staticaly
> wthout separate function.

I think making mfd_cells members of struct mxs-lradc will address all
review comments.

HTH,
Harald
