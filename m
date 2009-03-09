From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: suspend / hibernate nomenclature
Date: Mon, 9 Mar 2009 17:10:01 +0200
Message-ID: <20090309151001.GI10127@sci.fi>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl> <20090308230741.GA5357@dtor-d630.eng.vmware.com> <20090308231935.GA32624@srcf.ucam.org> <20090309135242.GH10127@sci.fi> <20090309140009.GA10360@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090309140009.GA10360@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 09, 2009 at 02:00:09PM +0000, Matthew Garrett wrote:
> On Mon, Mar 09, 2009 at 03:52:42PM +0200, Ville Syrj=E4l=E4 wrote:
>=20
> > If you think this using common sense I think the following would be=
 the
> > most obvious mapping:
> > sleep =3D STR, hibernate =3D STD, suspend =3D preferred suspend mod=
e
>=20
> I agree, but this isn't a discussion about user-visible nomenclature =
-=20
> it's a discussion about using the keycodes we have in the kernel. The=
=20
> aim is to ensure that everyone in-kernel uses the correct codes, and =
if=20
> we can do that without breaking existing userspace (even if it means =
the=20
> nomenclature differs) then that's preferable.

I don't think that invalidates my point. There's always the possibility
of re-creating the same mess in the future if the definitions aren't
crystal clear. The less room there is for personal interpretation of th=
e
definitions the better.

I understand that backwards compatibility is critical but perhaps that
is reason enough to create a completely a new set of definitions and
just map the old definitions in the best way possible.

Something like this?
KEY_SUSPEND_TO_RAM
KEY_SUSPEND_TO_DISK
KEY_SUSPEND_TO_PREFERRED

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
