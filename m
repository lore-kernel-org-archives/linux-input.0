From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/4 incremental 1/2] Generalize controller handling to
 support different devices
Date: Sat, 20 Aug 2011 12:11:11 +0200
Message-ID: <20110820121111.bca67bd99fcf162498b1fd02@studenti.unina.it>
References: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
	<1313677340-4441-1-git-send-email-ospite@studenti.unina.it>
	<4E4D2F2E.20105@signal11.us>
	<20110819211449.b17b35611f11979f9d59a8ab@studenti.unina.it>
	<20110819225735.ed1dbaa9aaa2f250d693c030@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__20_Aug_2011_12_11_11_+0200_NhR.CoE9GOxZjj63"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:37388 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1HTKLY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Aug 2011 06:11:24 -0400
In-Reply-To: <20110819225735.ed1dbaa9aaa2f250d693c030@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

--Signature=_Sat__20_Aug_2011_12_11_11_+0200_NhR.CoE9GOxZjj63
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Aug 2011 22:57:35 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

[...]
> About the PNP record, I can find some info about the "PnP Information"
> service in SDP, and I can see something with:
> 	$ sdptool records --tree <device_bdaddr>
>=20
> but I don't know how to get the actual value currently used in the
> plugin.
>

The current PNP_RECORD for sixaxis:

3601920900000A000100000900013503191124090004350D350619010009001135031900 \
11090006350909656E09006A0901000900093508350619112409010009000D350F350D35 \
0619010009001335031900110901002513576972656C65737320436F6E74726F6C6C6572 \
0901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F \
6D707574657220456E7465727461696E6D656E7409020009010009020109010009020208 \
00090203082109020428010902052801090206359A35980822259405010904A101A10285 \
0175089501150026FF00810375019513150025013500450105091901291381027501950D \
0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0 \
050175089527090181027508953009019102750895300901B102C0A10285027508953009 \
01B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C00902073508 \
35060904090901000902082800090209280109020A280109020B09010009020C093E8009 \
020D280009020E2800

is just the same info as in the _first_ record shown decoded by:
	$ sdptool records --tree --raw <device_bdaddr>

which is a HumanInterfaceDeviceService record, so maybe it can even be
named HID record, not PNP...

Unless I am still missing something we need to hardcode it because we need
it _before_ the device talks SDP. I wonder if it can be retrieved via USB,
but I doubt it, maybe a trace of the _very_first_ usb connection of a
controller to a PS3 could revel something...

JFYI if we break it down and look at lib/sdp.h for the field types we can
see the structure in the record:

36 0192
09 0000
0A 00010000
09 0001
35 03
19 1124
09 0004
35 0D
35 06
19 0100
09 0011
35 03
19 0011
09 0006
35 09
09 656E
09 006A
09 0100
09 0009
35 08
35 06
19 1124
09 0100
09 000D
35 0F
35 0D
35 06
19 0100
09 0013
35 03
19 0011
09 0100
25 13 576972656C65737320436F6E74726F6C6C6572
      # String: Wireless Controller
09 0101
25 13 576972656C65737320436F6E74726F6C6C6572
      # String: Wireless Controller
09 0102
25 1B 536F6E7920436F6D707574657220456E7465727461696E6D656E74
      # String: Sony Computer Entertainment
09 0200
09 0100
09 0201
09 0100
09 0202
08 00
09 0203
08 21
09 0204
28 01
09 0205
28 01
09 0206
35 9A
35 98
08 22
25 94 05010904A101A102850175089501150026FF008103750195131500250135004501 \
      05091901291381027501950D0600FF8103150026FF0005010901A1007508950435 \
      0046FF0009300931093209358102C0050175089527090181027508953009019102 \
      750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B1 \
      02C0A10285EF750895300901B102C0C0 # HID descriptor
09 0207
35 08
35 06
09 0409
09 0100
09 0208
28 00
09 02
09 2801
09 020A
28 01
09 020B
09 0100
09 020C
09 3E80
09 020D
28 00
09 020E
28 00


Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__20_Aug_2011_12_11_11_+0200_NhR.CoE9GOxZjj63
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5PiD8ACgkQ5xr2akVTsAHwCgCfbxx5CoMEo8xUKd+XiACuzRSH
0QAAn35fU9uXLiZSfE0UI/Fgl2SKiwJo
=hePo
-----END PGP SIGNATURE-----

--Signature=_Sat__20_Aug_2011_12_11_11_+0200_NhR.CoE9GOxZjj63--
