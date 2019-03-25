From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] HID: core: move Usage Page concatenation to
 hid_parser_main()
Date: Mon, 25 Mar 2019 16:12:07 +0100
Message-ID: <905227ab6992fb9a1caeb54a90b458e3926c8b41.camel@suse.de>
References: <20190312093652.12829-1-nsaenzjulienne@suse.de>
         <CAO-hwJKo84vMDubVZM8Tye9wyGYkLC9sOVNUw=hUbzH1ktGv1A@mail.gmail.com>
         <CAO-hwJ+_CBJ1tkUpcedMM8dgbzyHk2GPdhnFxFN+bAckwQytmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SLv9rWdLlUzZ1lBFfhPQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+_CBJ1tkUpcedMM8dgbzyHk2GPdhnFxFN+bAckwQytmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, oneukum@suse.de, "Junge, Terry" <Terry.Junge@plantronics.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-SLv9rWdLlUzZ1lBFfhPQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin, Thanks for the review!

On Mon, 2019-03-25 at 16:08 +0100, Benjamin Tissoires wrote:
> On Mon, Mar 25, 2019 at 11:39 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > Hi Nicolas,
> >=20
> > On Tue, Mar 12, 2019 at 10:37 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > As seen on some USB wireless keyboards manufactured by Primax, the HI=
D
> > > parser was using some assumptions that are not always true. In this c=
ase
> > > it's s the fact that, inside the scope of a main item, an Usage Page
> > > will always precede an Usage.
> > >=20
> > > The spec is not pretty clear as 6.2.2.7 states "Any usage that follow=
s
> > > is interpreted as a Usage ID and concatenated with the Usage Page".
> > > While 6.2.2.8 states "When the parser encounters a main item it
> > > concatenates the last declared Usage Page with a Usage to form a
> > > complete usage value." Being somewhat contradictory it was decided to
> > > match Window's implementation, which follows 6.2.2.8.
> > >=20
> > > In summary, the patch moves the Usage Page concatenation from the loc=
al
> > > item parsing function to the main item parsing function.
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> >=20
> > Patch looks good to me.
> >=20
> > Terry, did you have time to review it?
> >=20
> > Cheers,
> > Benjamin
> >=20
> > > Note: A PR in hid-tools shoud show up anytime soon
> > >=20
> > >  drivers/hid/hid-core.c | 30 ++++++++++++++++++------------
> > >  include/linux/hid.h    |  1 +
> > >  2 files changed, 19 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 9993b692598f..158468ef23a6 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct
> > > hid_parser *parser, unsigned type)
> > >   * Add a usage to the temporary parser table.
> > >   */
> > >=20
> > > -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> > > +static int hid_add_usage(struct hid_parser *parser, unsigned usage, =
__u8
> > > size)
> > >  {
> > >         if (parser->local.usage_index >=3D HID_MAX_USAGES) {
> > >                 hid_err(parser->device, "usage index exceeded\n");
> > >                 return -1;
> > >         }
> > >         parser->local.usage[parser->local.usage_index] =3D usage;
> > > +       parser->local.usage_size[parser->local.usage_index] =3D size;
> > >         parser->local.collection_index[parser->local.usage_index] =3D
> > >                 parser->collection_stack_ptr ?
> > >                 parser->collection_stack[parser->collection_stack_ptr=
 - 1]
> > > : 0;
> > > @@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser
> > > *parser, struct hid_item *item)
> > >                         return 0;
> > >                 }
> > >=20
> > > -               if (item->size <=3D 2)
> > > -                       data =3D (parser->global.usage_page << 16) + =
data;
> > > -
> > > -               return hid_add_usage(parser, data);
> > > +               return hid_add_usage(parser, data, item->size);
> > >=20
> > >         case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
> > >=20
> > > @@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *pa=
rser,
> > > struct hid_item *item)
> > >                         return 0;
> > >                 }
> > >=20
> > > -               if (item->size <=3D 2)
> > > -                       data =3D (parser->global.usage_page << 16) + =
data;
> > > -
> > >                 parser->local.usage_minimum =3D data;
> > >                 return 0;
> > >=20
> > > @@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *pa=
rser,
> > > struct hid_item *item)
> > >                         return 0;
> > >                 }
> > >=20
> > > -               if (item->size <=3D 2)
> > > -                       data =3D (parser->global.usage_page << 16) + =
data;
> > > -
> > >                 count =3D data - parser->local.usage_minimum;
> > >                 if (count + parser->local.usage_index >=3D HID_MAX_US=
AGES) {
> > >                         /*
> > > @@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *pa=
rser,
> > > struct hid_item *item)
> > >                 }
> > >=20
> > >                 for (n =3D parser->local.usage_minimum; n <=3D data; =
n++)
> > > -                       if (hid_add_usage(parser, n)) {
> > > +                       if (hid_add_usage(parser, n, item->size)) {
> > >                                 dbg_hid("hid_add_usage failed\n");
> > >                                 return -1;
> > >                         }
> > > @@ -553,8 +545,22 @@ static int hid_parser_local(struct hid_parser
> > > *parser, struct hid_item *item)
> > >=20
> > >  static int hid_parser_main(struct hid_parser *parser, struct hid_ite=
m
> > > *item)
> > >  {
> > > +       unsigned int usages;
> > >         __u32 data;
> > >         int ret;
> > > +       int i;
> > > +
> > > +       usages =3D max_t(unsigned, parser->local.usage_index,
> > > +                                parser->global.report_count);
> > > +
> > > +       /*
> > > +        * As per specification, 6.2.2.8:
> > > +        * "When the parser encounters a main item it concatenates th=
e
> > > last
> > > +        * declared Usage Page with a Usage to form a complete usage
> > > value."
> > > +        */
> > > +       for (i =3D 0; i < usages; i++)
> > > +               if (parser->local.usage_size[i] <=3D 2)
> > > +                       parser->local.usage[i] +=3D parser-
> > > >global.usage_page << 16;
>=20
> Actually, the good thing of having a test suite, is that it raises bugs :=
)
>=20
> You are also missing the computation of the usage in hid_scan_main().
> This makes the autoloading of hid-multitouch fail, and thus the test
> suite failing.

Ok, I'll look into it and send a follow-up.

> Cheers,
> Benjamin
>=20
> > >         data =3D item_udata(item);
> > >=20
> > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > index f9707d1dcb58..d1fb4b678873 100644
> > > --- a/include/linux/hid.h
> > > +++ b/include/linux/hid.h
> > > @@ -417,6 +417,7 @@ struct hid_global {
> > >=20
> > >  struct hid_local {
> > >         unsigned usage[HID_MAX_USAGES]; /* usage array */
> > > +       __u8 usage_size[HID_MAX_USAGES]; /* usage size array */
> > >         unsigned collection_index[HID_MAX_USAGES]; /* collection inde=
x
> > > array */
> > >         unsigned usage_index;
> > >         unsigned usage_minimum;
> > > --
> > > 2.21.0
> > >=20


--=-SLv9rWdLlUzZ1lBFfhPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlyY78cACgkQlfZmHno8
x/5wZQf+Jdefhgf0sspCsOfM/70PZW6uL2w5Suwf0+TdVK5YBuO60d5eKr5lNn7P
IjeP7f9tQroHyYgKShCjBNBWJjMnrp5iO1tQcLiWkx2gqTqTLs0QQEPedKX4Nxik
agL9XGADTrjTolXdUl98VkBJGqvg0qCZ+OfcC3cdoYK9N/MujAeysQAmZrvtCo+M
meUmgp2erpp3C9XmiuAQHOaGbaNg8oGmBx5ZkOM4bbYKIb/03OYNH0drrzUhS+O3
R3frLtW5GgTbs+WuoExCkbSqCkPSuzhBKDwMTacRAuPdxgqfpnaiWuKfl8FFapar
GE1W+rB0h3JpI8VMHoLbGu1SAP9/eA==
=w53c
-----END PGP SIGNATURE-----

--=-SLv9rWdLlUzZ1lBFfhPQ--
