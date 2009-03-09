From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Mon, 9 Mar 2009 14:00:09 +0000
Message-ID: <20090309140009.GA10360@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl> <20090308230741.GA5357@dtor-d630.eng.vmware.com> <20090308231935.GA32624@srcf.ucam.org> <20090309135242.GH10127@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34030 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZCIOAS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2009 10:00:18 -0400
Content-Disposition: inline
In-Reply-To: <20090309135242.GH10127@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Mon, Mar 09, 2009 at 03:52:42PM +0200, Ville Syrj=E4l=E4 wrote:

> If you think this using common sense I think the following would be t=
he
> most obvious mapping:
> sleep =3D STR, hibernate =3D STD, suspend =3D preferred suspend mode

I agree, but this isn't a discussion about user-visible nomenclature -=20
it's a discussion about using the keycodes we have in the kernel. The=20
aim is to ensure that everyone in-kernel uses the correct codes, and if=
=20
we can do that without breaking existing userspace (even if it means th=
e=20
nomenclature differs) then that's preferable.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
