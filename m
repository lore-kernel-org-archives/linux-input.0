From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature
 Reports from hidraw
Date: Thu, 30 Sep 2010 01:51:04 +0200
Message-ID: <20100930015104.49fc5acf.ospite@studenti.unina.it>
References: <1281442367.12579.206.camel@localhost.localdomain>
	<1281990059-3562-2-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Sep_2010_01_51_04_+0200_iJpZ_nojnzGiTURJ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:34467 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab0I2XwT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 19:52:19 -0400
In-Reply-To: <1281990059-3562-2-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

--Signature=_Thu__30_Sep_2010_01_51_04_+0200_iJpZ_nojnzGiTURJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Aug 2010 16:20:58 -0400
Alan Ott <alan@signal11.us> wrote:

> Per the HID Specification, Feature reports must be sent and received on
> the Configuration endpoint (EP 0) through the Set_Report/Get_Report
> interfaces.  This patch adds two ioctls to hidraw to set and get feature
> reports to and from the device.  Modifications were made to hidraw and
> usbhid.
>=20
> New hidraw ioctls:
>   HIDIOCSFEATURE - Perform a Set_Report transfer of a Feature report.
>   HIDIOCGFEATURE - Perform a Get_Report transfer of a Feature report.
>=20
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---

Some more testing with sixaxis and a question:

HIDIOCGFEATURE on report 0xf5 returns:
<-- 01 00 00 03 c9 87 34 fd
          ^^ a hw addr from here

with the latest six octets being a hw addr; now if I wanted to change
this, *naively*, I'd send this report with HIDIOCSFEATURE:
--> f5 01 00 66 55 44 33 22 11
    ^^ report ID _added_ in front of the whole previous buffer

but then when I get the report again to see if the operation succeeded I
get:
<-- 01 00 00 66 55 44 33 22

I can make it work if I send:
--> f5 00 66 55 44 33 22 11
    ^^ report ID _replaced_ buf[0]

then I get the expected:
<-- 01 00 66 55 44 33 22 11

Am I missing something about the differences about getting a feature
report and setting it?

In the HIDIOCGFEATURE doc I read:
	...
	The report will be returned starting at
	the first byte of the buffer (ie: the report number is not
	returned).

Someone (/me whistling, with hands in pockets) could interpret this
like a buf++ semantic on a quick read, even if this sentence means
"only" that _actual_data_ is from buf[1]; but one question stands: what
is that value returned in buf[0]? Is this unspecified?

Maybe the doc could be made even more explicit about buf[0] to overcame
non native speakers deficiencies.
And while at it, can we get rid of the ambiguity of "first byte" for
"byte 1", the former can even mean buf[0], can't it?

Thanks,
  Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__30_Sep_2010_01_51_04_+0200_iJpZ_nojnzGiTURJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyj0OgACgkQ5xr2akVTsAETCACeLsGvjFxncIISLqhlBcRkAsZ3
1OYAn2XnE94u9oXiF207pOLMCX0e6k2M
=oJbs
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Sep_2010_01_51_04_+0200_iJpZ_nojnzGiTURJ--
