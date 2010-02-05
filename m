From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Fri, 5 Feb 2010 10:40:35 +0100
Message-ID: <20100205104035.dda70313.ospite@studenti.unina.it>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__5_Feb_2010_10_40_35_+0100_.6BOwIxKRgikPEhm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out30.alice.it ([85.33.2.30]:1028 "EHLO
	smtp-out30.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0BEJu6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 04:50:58 -0500
In-Reply-To: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com

--Signature=_Fri__5_Feb_2010_10_40_35_+0100_.6BOwIxKRgikPEhm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Feb 2010 22:52:43 -0500
Rafi Rubin <rafi@seas.upenn.edu> wrote:

> Improvements to multitouch handling:
> 	enabled mt input events were were masked off
> 	adjusted interpretation of some hid events
> 	added finger tracking
>=20
> Pen and touch sensors moved to separate event nodes (HID_QUIRK_MULTI_INPU=
T) and related changes removing unnecessary code and events that supported =
the multiplexed streams.  Added names to represent the sensor associated wi=
th each event node.  Split event handlers for the sensors to make the code =
a bit more readable.
>

Just a style-question, isn't the commit message supposed to be wrapped
at 72-80 chars as well? This is not stated explicitly in
Documentation/SubmittingPatches Section 15.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Fri__5_Feb_2010_10_40_35_+0100_.6BOwIxKRgikPEhm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktr55MACgkQ5xr2akVTsAFU0wCfRp4ZUAgdsxfNIBcbVK2PJzuk
fCsAoJbeFxZEJqt7oNkZyjSFoPe0DndG
=gQiz
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Feb_2010_10_40_35_+0100_.6BOwIxKRgikPEhm--
