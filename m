From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 13 Jul 2016 13:49:35 +0100
Message-ID: <20160713124935.GC11154@dell>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1bIyD4-0000Jw-2c-rvrRdOlaWMmli2aaYNgTVBW+3FKk/ZpWT2auq/jSWdo@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
Cc: Ksenija =?utf-8?Q?Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek =?utf-8?B?VmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 01 Jul 2016, Harald Geyer wrote:

> Hi Ksenija!
>=20
> Ksenija Stanojevi=C4=87 writes:
> > On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> w=
rote:
> > >> +static int mxs_lradc_add_device(struct platform_device *pdev,
> > >> +                             struct mxs_lradc *lradc, char *nam=
e, int i)
> > >> +{
> > >> +     struct mfd_cell *cell;
> > >> +
> > >> +     cell =3D &lradc->cells[i];
> > >> +     cell->name =3D name;
> > >> +     cell->platform_data =3D lradc;
> > >> +     cell->pdata_size =3D sizeof(*lradc);
> > >> +
> > >> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL,=
 0, NULL);
> > >> +}
> > >
> > > Please don't roll your own API.
> > >
> > > Use 'struct mfd_cell' like everyone else does.
> >=20
> > It has been suggested in previous reviews to use separate function =
to
> > register mfd device, and to make mfd_cell allocate dynamically beca=
use
> > struc mxs-lradc is allocated dynamically.
> > But I can revrse changes and make mfd_cells allocate staticaly
> > wthout separate function.
>=20
> I think making mfd_cells members of struct mxs-lradc will address all
> review comments.

No, please don't do that either.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
