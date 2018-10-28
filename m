From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] HID: moving to group maintainership model
Date: Sun, 28 Oct 2018 12:15:33 +1100
Message-ID: <20181028121202.3efcbee5@canb.auug.org.au>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X2xECjmDpLIudRSbuvfwmpn"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

--Sig_/X2xECjmDpLIudRSbuvfwmpn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Sat, 27 Oct 2018 14:19:02 +0200 (CEST) Jiri Kosina <jikos@kernel.org> wr=
ote:
>
> Stephen, could you please update the hid.git URL for linux-next as below?=
=20
> Thanks.

Done, also added Benjamin as a contact.

[for Benjamin's benefit ...]

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/X2xECjmDpLIudRSbuvfwmpn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvVDbUACgkQAVBC80lX
0Gxxbwf/a+o3mYCPDkfx6dbJfVhQ6J7k6OnbkwoTDAbdxb9RsrPFkBhSx7n7bxMG
jrkBK9wZW89Lh2OPFhTna/kE3PDtBu/w34b3ilR93dt6F/T2dGR61kSQl1VW7cCx
PiHg7LqUgkiEC2yj3jq2+gRiA361vtQ7Amp7/yxGSnn4UJitK3olqphAt0uavw3E
IObQiDQhHDXdA5jWqTeOquhrG/rIGld6rT/Uoq8rgi+JJUdzq/WoBb734JIpaH5U
d9Srl6SYZA219UQUvospAkfxck9/EJVkRClmyDcDrmlopu1ieRWZ342l+O03ATh7
5puqTsi0UDTti67BnhhyUeFlxYRYug==
=AhaS
-----END PGP SIGNATURE-----

--Sig_/X2xECjmDpLIudRSbuvfwmpn--
