From: roswest <roswest@cisco.com>
Subject: USB vulnerabilities
Date: Thu, 28 Jul 2016 12:23:09 -0400
Message-ID: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XTvegEcSJLweEspmh75fxWXdkGg9lgeIv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:52977 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbcG1Qck (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 12:32:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XTvegEcSJLweEspmh75fxWXdkGg9lgeIv
Content-Type: multipart/mixed; boundary="rJtSCX40Fb49RM8iq5Nm4qVP7LPBGKw8i"
From: roswest <roswest@cisco.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>
Message-ID: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
Subject: USB vulnerabilities

--rJtSCX40Fb49RM8iq5Nm4qVP7LPBGKw8i
Content-Type: multipart/mixed;
 boundary="------------E0B37820B284EF98CD1375D3"

This is a multi-part message in MIME format.
--------------E0B37820B284EF98CD1375D3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Dmitry,

Hi, I am an engineer at Cisco Systems, and this summer we tasked some
interns with performing USB fuzzing. One of the interns, Anirudh Bagde,
was able to crash the USB stack due to an error in the iforce module and
discovered a buffer over-read in the usbtouchscreen module.  Please see
the attachment for details.

Thank you,
Rosie Hall

--------------E0B37820B284EF98CD1375D3
Content-Type: text/plain; charset=UTF-8;
 name="input_issues.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="input_issues.txt"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOZXcgSXNzdWVzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KCkhlYWRsaW5lOiAgICAgICAgIEJ1ZmZlciBv
dmVyLXJlYWQgaW4gdXNidG91Y2hzY3JlZW4gbW9kdWxlClBsYXRmb3JtczogICAgICAgIFVi
dW50dQpWZXJzaW9uczogICAgICAgICAxNi4wNCBMVFMgKEtlcm5lbCA0LjQuMCkKQ1ZTUyBT
Y29yZTogICAgICAgMC4wCkNWU1MgVmVjdG9yOiAgICAgIEFWOkwvQUM6TS9BdTpOL0M6Ti9J
Ok4vQTpOCkZpbGVkIERlZmVjdHM6ICAgIApSZWxhdGVkIERlZmVjdHM6ICAKQ1dFIFRhZ3M6
ICAgICAgICAgCkN5Y2xlOiAgICAgICAgICAgIApGb3VuZCBieTogICAgICAgICBBbmlydWRo
IEJhZ2RlCgoKVGhlIHVzYnRvdWNoc2NyZWVuIG1vZHVsZSBjYW4gYmUgbGVkIHRvIGV4Y2Vl
ZCB0aGUgYm91bmRzIG9mIGFuIGFycmF5IGJ5IApwcm92aWRpbmcgbGFyZ2UgbnVtYmVycyBp
biBhIGRhdGEgcGFja2V0LiBUaGlzIGhhcHBlbnMgaW4gdGhlIG5leGlvX3JlYWRfZGF0YSAK
ZnVuY3Rpb24sIHdoaWNoIGlzIGNhbGxlZCB3aGVuIGEgZGF0YSBwYWNrZXQgaXMgc2VudCBi
eSBhIE5leGlvIGlOZXhpbyAKdG91Y2hzY3JlZW4gZGV2aWNlLiBUaGUgZGF0YSBwYWNrZXQg
Y29udGFpbnMgMTYtYml0IGludGVnZXJzIHJlcHJlc2VudGluZyB0aGUgCmxlbmd0aCBvZiBh
biBhcnJheSB3aXRoaW4gdGhlIGRhdGEgcGFja2V0LCBhbmQgdGhlIGZ1bmN0aW9uIGl0ZXJh
dGVzIHRocm91Z2ggdGhlIApidWZmZXIgdXNpbmcgdGhpcyBhcnJheSBsZW5ndGggd2l0aG91
dCBjaGVja2luZyBpdHMgYm91bmRzLgoKVGhpcyBidWZmZXIgb3ZlcmZsb3cgZG9lcyBub3Qg
aGF2ZSBtdWNoIGltcGFjdCwgc2luY2UgdGhlIGNvbnRlbnRzIG9mIHRoZSAKYnVmZmVyIGFy
ZSBvbmx5IHVzZWQgYnkgYSBmZXcgY29uZGl0aW9uYWxzLiBUaGUgYnVmZmVyIGlzIG9ubHkg
cmVhZCwgbm90IHdyaXR0ZW4gCnRvLCBzbyB0aGUgc3lzdGVtIGdlbmVyYWxseSBzaG91bGQg
bm90IGNyYXNoLiBBZGRpdGlvbmFsbHksIG5vIGRhdGEgZnJvbSB0aGUgCm92ZXJmbG93aW5n
IGJ1ZmZlciBpcyBzZW50IGJhY2sgdG8gdGhlIGRldmljZSwgc28gdGhlcmUgaXMgbm8gZGF0
YSBsZWFrYWdlIAplaXRoZXIuCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpIZWFk
bGluZTogICAgICAgICBDcmFzaCBVU0Igc3RhY2sgd2l0aCBudWxsIHBvaW50ZXIgZGVyZWZl
cmVuY2UgaW4gaWZvcmNlIG1vZHVsZQpQbGF0Zm9ybXM6ICAgICAgICBVYnVudHUKVmVyc2lv
bnM6ICAgICAgICAgMTYuMDQgTFRTIChLZXJuZWwgNC40LjApCkNWU1MgU2NvcmU6ICAgICAg
IDEuOQpDVlNTIFZlY3RvcjogICAgICBBVjpML0FDOk0vQXU6Ti9DOk4vSTpOL0E6UApGaWxl
ZCBEZWZlY3RzOiAgICAKUmVsYXRlZCBEZWZlY3RzOiAgCkNXRSBUYWdzOiAgICAgICAgIApD
eWNsZTogICAgICAgICAgICAKRm91bmQgYnk6ICAgICAgICAgQW5pcnVkaCBCYWdkZQoKClRo
ZSBpZm9yY2UgTGludXgga2VybmVsIG1vZHVsZSBhc3N1bWVzIHRoZXJlIGFyZSBhdCBsZWFz
dCB0d28gZW5kcG9pbnRzIGluIGEgVVNCIApkZXZpY2UgdGhhdCBtYXRjaGVzIHRoZSBkcml2
ZXIncyBWSUQvUElELiBJZiB0aGUgZGV2aWNlIGhhcyBmZXdlciB0aGFuIHR3byAKZW5kcG9p
bnRzLCB0aGlzIHdpbGwgY2F1c2UgYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gdGhl
IG1vZHVsZS4KClRoaXMgYnVnIHdpbGwgdXN1YWxseSBjcmFzaCB0aGUgZW50aXJlIHN5c3Rl
bSwgdGhvdWdoIG9jY2FzaW9uYWxseSBpdCBjcmFzaGVzIApvbmx5IHRoZSBVU0Igc3RhY2ss
IGxlYXZpbmcgdGhlIHJlc3Qgb2YgdGhlIHN5c3RlbSBmdW5jdGlvbmFsLiBJZiBpdCBkb2Vz
IGNyYXNoIApvbmx5IHRoZSBVU0Igc3RhY2ssIG5ld2x5IGNvbm5lY3RlZCBkZXZpY2VzIHdp
bGwgbm90IGJlIGRldGVjdGVkLCBhbmQgYW55IHVzZXIgCnByb2dyYW1zIHRoYXQgaW50ZXJh
Y3Qgd2l0aCB0aGUgVVNCIHN0YWNrIChzdWNoIGFzIGxzdXNiKSB3aWxsIGhhbmcgcGVybWFu
ZW50bHkuCgoKCgo=
--------------E0B37820B284EF98CD1375D3--

--rJtSCX40Fb49RM8iq5Nm4qVP7LPBGKw8i--

--XTvegEcSJLweEspmh75fxWXdkGg9lgeIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAleaMW0ACgkQBAXm4T8ynGufAQCePKNHZ4VM+DhsaJiAtpwOC494
teoAmgIg6ci6NMo94Sp/SnQLlXEZTkTW
=lO/Y
-----END PGP SIGNATURE-----

--XTvegEcSJLweEspmh75fxWXdkGg9lgeIv--
