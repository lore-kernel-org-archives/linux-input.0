From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: suspend / hibernate nomenclature
Date: Mon, 9 Mar 2009 15:52:42 +0200
Message-ID: <20090309135242.GH10127@sci.fi>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl> <20090308230741.GA5357@dtor-d630.eng.vmware.com> <20090308231935.GA32624@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.welho.com ([213.243.153.38]:56951 "EHLO smtp4.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbZCIOYW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Mar 2009 10:24:22 -0400
Content-Disposition: inline
In-Reply-To: <20090308231935.GA32624@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sun, Mar 08, 2009 at 11:19:35PM +0000, Matthew Garrett wrote:
> On Sun, Mar 08, 2009 at 04:07:50PM -0700, Dmitry Torokhov wrote:
>=20
> > - KEY_SLEEP - leave the keycode, the action should be the default
> > system state defined by either platform or user. I expect that the =
vast
> > majority of system have default state similar to S3 so there should=
 not
> > be anysurprises.
> >=20
> > - KEY_SUSPEND - provide better comment for its intended usage and m=
aybe
> > add KEY_HIBERNATE alias.
> >=20
> > - KEY_SUSPEND2RAM - add a new definition.
> >=20
> > Do you think this would this work?
>=20
> I think that would be fine, though I'm not entirely convinced that we=
=20
> need KEY_SUSPEND2RAM as a separate keycode.

If you think this using common sense I think the following would be the
most obvious mapping:
sleep =3D STR, hibernate =3D STD, suspend =3D preferred suspend mode

Both sleep and hibernate are biological processes and the difference
between them should be obvious for everyone. Suspend on that other hand
just says that your work is suspended.

I don't know if common sense has any room in these discussions though.

I would at least avoid mixing the suspend2ram and hibernate definitions=
=2E
The first one comes from the technical aspect and the second comes from
the biological aspect so mixing them IMO just creates more confusion.

Of course the API is a technical thing anyway so perhaps just go for
something explicit like suspend2ram, suspend2disk and suspend2preferred=
=2E
The old definitions would of course need to be mapped to the new
definitions somehow.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
