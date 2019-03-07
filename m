From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Date: Thu, 07 Mar 2019 17:20:35 +0100
Message-ID: <d473feac52a9411a7ffb585aa61e2614df890972.camel@suse.de>
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
         <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
         <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
         <CAO-hwJ+9ft070W-shhEwxfTq9B5XyVB2v6Qx0b4nC4LdTiTEDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-A1MyYkJzgvepcTVgytdG"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+9ft070W-shhEwxfTq9B5XyVB2v6Qx0b4nC4LdTiTEDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Junge, Terry" <Terry.Junge@plantronics.com>, Jiri Kosina <jikos@kernel.org>, "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-A1MyYkJzgvepcTVgytdG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-01 at 10:48 +0100, Benjamin Tissoires wrote:
> On Thu, Feb 28, 2019 at 7:01 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Thu, 2019-02-28 at 17:02 +0000, Junge, Terry wrote:
> > > This could also be a parser error. In the HID specification section
> > > 6.2.2.8 it
> > > states that the last declared Usage Page is applied to Usages when th=
e
> > > Main
> > > item is encountered.
> > >=20
> > > "If the bSize field =3D 1 or 2 then the Usage is interpreted as an un=
signed
> > > value
> > > that selects a Usage ID on the currently defined Usage Page. When the
> > > parser
> > > encounters a main item it concatenates the last declared Usage Page w=
ith a
> > > Usage to form a complete usage value. Extended usages can be used to
> > > override the currently defined Usage Page for individual usages."
> > >=20
> >=20
> > Hi Terry, thanks for the comment.
> > Just for the record the paragraph I cited on my patch is the following:
> >=20
> >         6.2.2.7 Global Items
> >=20
> >         [...]
> >=20
> >         Usage Page: Unsigned integer specifying the current Usage Page.
> > Since a
> >         usage are 32 bit values, Usage Page items can be used to conser=
ve
> > space
> >         in a report descriptor by setting the high order 16 bits of a
> >         subsequent usages. Any usage that follows which is defines* 16 =
bits
> > or
> >         less is interpreted as a Usage ID and concatenated with the Usa=
ge
> > Page
> >         to form a 32 bit Usage.
> >=20
> >         * This is a spec errata, I belive it should say "defined"
> >=20
> > As you can see they use the word "follows" which in my opinion contradi=
cts
> > the
> > paragraph you pointed out. That said I may be wrong, I'm not too good a=
t
> > reading specs :).
>=20
> I think you are both right (that is some decision making skills :-P).
>=20
> I never saw a case where the Usage Page was after the Usage. And I
> would lean towards Nicolas interpretation.
> However, Terry's point is valid too, and by re-reading the two
> paragraphs, one could argue that the "follows" of 6.2.2.7 could be
> applied when the Main item is processed as in 6.2.2.8.
>=20
> So I am going to base my decision on the "reference" driver. How well
> behaves Windows with this particular keyboard?
>=20
> If it behaves properly, then we better use the 6.2.2.8 version where
> the Usage Page is only appended when there is a Main item. This means
> we need to remember what size was the last Usage (and Min/Max), to
> know if we should concatenate the 2.
>=20
> Note that for every change that involves the generic parser, I'd like
> a few tests added to `tests/test_keyboard.py in
> https://gitlab.freedesktop.org/libevdev/hid-tools
> Also note that the HID parser implementation in hid-tools follows the
> kernel, so we might need to adjust it there too if we want to add high
> level events. If you directly call `.call_input_event()` with raw
> events, it should be fine.

Thanks for the reply. I might get my hands on one of the faulty keyboards s=
oon
so I'll be able to check windows' behaviour and test the patches.

Regards,
Nicolas


--=-A1MyYkJzgvepcTVgytdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlyBRNMACgkQlfZmHno8
x/6SlAf/YZwwiqqBsPw7FViHUQGH1jBUpw29GTSN9eUy2fZDnrWFvGvkhKprL6Pw
8xM6js1Y/BQQwSfA32gltRK2dp854TANTCwscNoHrr7RIh+muwGIV9nV11GbzKsD
+dVjlFCT3wz4nO0nUmBu5WvYCkZz7Iv/WdKLwkvgcMDOgdvmsr6u1gCD9iXMRvlm
yXetjgH1P0Y6CV41AmX21Fv6cIUDSQXp8wr3MnrWfjdaFuFAVXOH3OUXPkozKf8a
yiSgapCiH7+r8Z1qfmVNNAQSQWgNAs5n+kIpSMS3bcvo8YfIPrPDHR5qJO4JTxbg
3Zb7qMaXyLA8S0OLliQ4tCyq2AvGbQ==
=hUGm
-----END PGP SIGNATURE-----

--=-A1MyYkJzgvepcTVgytdG--
