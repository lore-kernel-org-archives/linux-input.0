From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3] HID: core: move Usage Page concatenation to Main item
Date: Wed, 27 Mar 2019 11:15:16 +0100
Message-ID: <0226eb8f5b20acd07e1bdd49c855e692ecad6306.camel@suse.de>
References: <20190326200331.25934-1-nsaenzjulienne@suse.de>
         <BYAPR02MB560738248E330DF46CAA199A8A5F0@BYAPR02MB5607.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0MzzpiNQ/MdpCQZBnVyu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR02MB560738248E330DF46CAA199A8A5F0@BYAPR02MB5607.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Junge, Terry" <terry.junge@poly.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-0MzzpiNQ/MdpCQZBnVyu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Terry, thanks for the review!

On Tue, 2019-03-26 at 22:43 +0000, Junge, Terry wrote:
> Hi Nicolas,
>=20
> This patch looks good except for one comment/question below.
>=20
> Thanks,
> Terry
>=20
> On Tuesday, March 26, 2019 1:04 PM Nicolas Saenz Julienne <
> nsaenzjulienne@suse.de> wrote:
> > As seen on some USB wireless keyboards manufactured by Primax, the HID
> > parser was using some assumptions that are not always true. In this cas=
e
> > it's s
> > the fact that, inside the scope of a main item, an Usage Page will alwa=
ys
> > precede an Usage.
> >=20
> > The spec is not pretty clear as 6.2.2.7 states "Any usage that follows =
is
> > interpreted as a Usage ID and concatenated with the Usage Page".
> > While 6.2.2.8 states "When the parser encounters a main item it concate=
nates
> > the last declared Usage Page with a Usage to form a complete usage valu=
e."
> > Being somewhat contradictory it was decided to match Window's
> > implementation, which follows 6.2.2.8.
> >=20
> > In summary, the patch moves the Usage Page concatenation from the local
> > item parsing function to the main item parsing function.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > v2->v3: - Update patch title
> >=20
> > v1->v2: - Add usage concatenation to hid_scan_main()
> > 	- Rework tests in hid-tools, making sure no-one is failing
> >=20
> > drivers/hid/hid-core.c | 40 ++++++++++++++++++++++++++++------------
> > include/linux/hid.h    |  1 +
> > 2 files changed, 29 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index
> > 9993b692598f..40c836ce3248 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct
> > hid_parser *parser, unsigned type)
> >  * Add a usage to the temporary parser table.
> >  */
> >=20
> > -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> > +static int hid_add_usage(struct hid_parser *parser, unsigned usage,
> > +__u8 size)
> > {
> > 	if (parser->local.usage_index >=3D HID_MAX_USAGES) {
> > 		hid_err(parser->device, "usage index exceeded\n");
> > 		return -1;
> > 	}
> > 	parser->local.usage[parser->local.usage_index] =3D usage;
> > +	parser->local.usage_size[parser->local.usage_index] =3D size;
> > 	parser->local.collection_index[parser->local.usage_index] =3D
> > 		parser->collection_stack_ptr ?
> > 		parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
> > @@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *par=
ser,
> > struct hid_item *item)
> > 			return 0;
> > 		}
> >=20
> > -		if (item->size <=3D 2)
> > -			data =3D (parser->global.usage_page << 16) + data;
> > -
> > -		return hid_add_usage(parser, data);
> > +		return hid_add_usage(parser, data, item->size);
> >=20
> > 	case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
> >=20
> > @@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *pars=
er,
> > struct hid_item *item)
> > 			return 0;
> > 		}
> >=20
> > -		if (item->size <=3D 2)
> > -			data =3D (parser->global.usage_page << 16) + data;
> > -
> > 		parser->local.usage_minimum =3D data;
> > 		return 0;
> >=20
> > @@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *pars=
er,
> > struct hid_item *item)
> > 			return 0;
> > 		}
> >=20
> > -		if (item->size <=3D 2)
> > -			data =3D (parser->global.usage_page << 16) + data;
> > -
> > 		count =3D data - parser->local.usage_minimum;
> > 		if (count + parser->local.usage_index >=3D HID_MAX_USAGES) {
> > 			/*
> > @@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *pars=
er,
> > struct hid_item *item)
> > 		}
> >=20
> > 		for (n =3D parser->local.usage_minimum; n <=3D data; n++)
> > -			if (hid_add_usage(parser, n)) {
> > +			if (hid_add_usage(parser, n, item->size)) {
> > 				dbg_hid("hid_add_usage failed\n");
> > 				return -1;
> > 			}
> > @@ -547,6 +539,26 @@ static int hid_parser_local(struct hid_parser *par=
ser,
> > struct hid_item *item)
> > 	return 0;
> > }
> >=20
> > +/*
> > + * Concatenate Usage Pages into Usages where relevant:
> > + * As per specification, 6.2.2.8: "When the parser encounters a main
> > +item it
> > + * concatenates the last declared Usage Page with a Usage to form a
> > +complete
> > + * usage value."
> > + */
> > +
> > +static void hid_concatenate_usage_page(struct hid_parser *parser) {
> > +	unsigned usages;
> > +	int i;
> > +
> > +	usages =3D max_t(unsigned, parser->local.usage_index,
> > +				 parser->global.report_count);
>=20
> I don't think we need to worry about global.report_count here,
> just concatenate for the usages currently in the local queue so could
> this be simplified by removing usages and just using local.usage_index?
>=20
>         for (i =3D 0; i < local.usage_index; i++)

Sounds about right.

>=20
> > +
> > +	for (i =3D 0; i < usages; i++)
> > +		if (parser->local.usage_size[i] <=3D 2)
> > +			parser->local.usage[i] +=3D parser->global.usage_page
> > << 16; }
> > +
> > /*
> >  * Process a main item.
> >  */
> > @@ -556,6 +568,8 @@ static int hid_parser_main(struct hid_parser *parse=
r,
> > struct hid_item *item)
> > 	__u32 data;
> > 	int ret;
> >=20
> > +	hid_concatenate_usage_page(parser);
> > +
> > 	data =3D item_udata(item);
> >=20
> > 	switch (item->tag) {
> > @@ -765,6 +779,8 @@ static int hid_scan_main(struct hid_parser *parser,
> > struct hid_item *item)
> > 	__u32 data;
> > 	int i;
> >=20
> > +	hid_concatenate_usage_page(parser);
> > +
> > 	data =3D item_udata(item);
> >=20
> > 	switch (item->tag) {
> > diff --git a/include/linux/hid.h b/include/linux/hid.h index
> > f9707d1dcb58..d1fb4b678873 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -417,6 +417,7 @@ struct hid_global {
> >=20
> > struct hid_local {
> > 	unsigned usage[HID_MAX_USAGES]; /* usage array */
> > +	__u8 usage_size[HID_MAX_USAGES]; /* usage size array */
> > 	unsigned collection_index[HID_MAX_USAGES]; /* collection index
> > array */
> > 	unsigned usage_index;
> > 	unsigned usage_minimum;
> > --
> > 2.21.0


--=-0MzzpiNQ/MdpCQZBnVyu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlybTTQACgkQlfZmHno8
x/7/Vgf/UiRVrv2IOVhaj2wOpE6rYHjnqeLs8LA7Y0SpFKwc51HAPwSRzjTO+L8l
byxiE/sdqDwGtoK+1cDYO2m4zvsb41IhiE/+6yLINeV90UsEcXmN5jLA+qvHTG87
UOCvB+UZbTjyMC7g9U+xxLKmQC12x3phKNbWL8kzyITPtzGA0hQgx7iJ0Zo/9Zcf
MoiQR9au1prHJZ05GnjNZ/84geuKsDFWnlieJQUnHZMTTY37p9jeJRwIi6jZVghJ
ZBeywdrV4rl5+sHkPgaX3YPO4g5mldwEbV0AMuUDuQHumUftb8ASwHiSN9T4hOph
5MZLbTLmnZEQpBH0Pfjwp4M/yf+J2g==
=BW3o
-----END PGP SIGNATURE-----

--=-0MzzpiNQ/MdpCQZBnVyu--
