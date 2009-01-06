From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: Support special keys on laptop by default?
Date: Tue, 06 Jan 2009 17:13:36 +0100
Message-ID: <49638330.2070605@wincor-nixdorf.com>
References: <4963594B.9040705@wincor-nixdorf.com> <alpine.LRH.1.10.0901061526200.24105@twin.jikos.cz> <49636A4B.2050201@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEAC7AC3BFD8B1547268F956"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxpdbe1.wincor-nixdorf.com ([80.154.98.129]:46452 "EHLO
	mxpdbe1.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbZAFQQf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2009 11:16:35 -0500
In-Reply-To: <49636A4B.2050201@wincor-nixdorf.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-laptop@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEAC7AC3BFD8B1547268F956
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niels de Vos wrote:
> Jiri Kosina wrote:
>> On Tue, 6 Jan 2009, Niels de Vos wrote:
>>
>>> on my HP/Compaq nc6400 there are three keys (info, presentation and
>>> battery) not directly recognized. If I press any of the keys, I get:
>>>
>>> atkbd.c: Unknown key released (translated set 2, code 0xd9 on isa0060=
/serio0).
>>> atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.
>> [ ... ]
>>> Where should I start looking for creating a patch for solving problem=
s=20
>>> of this kind? There seem to be quirks in atkbd.c, but I think they ar=
e=20
>>> used for some other workarounds.
>> Please see=20
>> http://people.freedesktop.org/~hughsient/quirk/quirk-keymap-index.html=

>>

Just for the record:

Okay, for these (and a lot more) keys I (and you) need at least
hal-0.5.10 as said in the link above from Jiri. The keys supported by
hal are available in the 30-keymap-*.fdi files from the hal-info git:

http://cgit.freedesktop.org/hal-info/tree/fdi/information/10freedesktop

I hope this helps people with the same questions and problems.

Thanks for your help,
Niels


--------------enigAEAC7AC3BFD8B1547268F956
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJY4Mw5KAkGQPO/QoRAh27AKCtjaI8ktmN15w9XkKZ9w3+cYs3IQCggujP
Yk0Zh4Auz+rZ0zh0zF4FWJs=
=Mp1r
-----END PGP SIGNATURE-----

--------------enigAEAC7AC3BFD8B1547268F956--
