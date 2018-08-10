From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 3/4] HID: multitouch: drop reports containing invalid
 values
Date: Thu, 9 Aug 2018 17:27:47 -1000
Message-ID: <20180810032747.fawrnvyacl27ss6t@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6giaonrkbn22nqk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org


--p6giaonrkbn22nqk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:13:54AM +0200, Benjamin Tissoires wrote:
> Hi Joey,
> You can't really use plain values like that. There is a tiny chance
> these values are valid on an other device.
> IIRC, MS spec says that we should ignore out of band values if they
> are tagged as such. Such input are tagged with NULL values
> (http://www.usb.org/developers/hidpage/HID1_11.pdf page 31) and MS
> spec mentioned this.
>=20
> All in all, if you have this bit set, you need to compare the value
> with the logical_max/min for each field.
>=20
> I never encountered a device that required this, so you are probably
> the lucky one :)

Ah, you are completely right. After giving that pdf a read over
I will definitely be dropping this patch from the v2.

--=20
Cheers,
Joey Pabalinas

--p6giaonrkbn22nqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttBjAACgkQruvLfWhy
VBmYBg//Tx0H6f8Hv8oFN1auCMamQLSw2L9HGoCbxXK/IR9zFMY2SMKAIzlEZLYo
9YXUBciotRybA2qasN+WETU7DMEG2wX+NXPGIPKST/3hxjBvt2w2+PND6xMiAJXo
0nEKNhtGbNMcDWullwxY/fOT8KKU/wtsXnG7V15V5TS/kxO7VKJruexefX6LxU4E
LB9JQyprhWYnfGNSCMqc7FeLTqN8Tbg04nCcnrchtMgYbsZ87XEkW4tSVZkK/Nor
JR/ugNRZUCI4FHlHhFPwggegZyc4A8bnHRE8xS+d1GJO6x0//AZC5qktaBE+tkDk
lOHTFufgMwTiPGc8TFOpPz1hJsRFPR0HgldK9YqD79RcLQK7WxJRjZ8Yt7T7xBa2
+MfMNnD8o8ONWs7TkdiNCloQE2B53ixR2L4fcXoAkznKS7xvoZp98f728OykUVUv
04TA5PwsLKwKh01CcqUYwu+UkREh1kOsMdUES7OpgCgUh0q/ljVL3l8Q/JGIFnGd
624LuMqtQM/Yghfl12Aqyl2JQs0HjHm6CfWVzx53DGov48Uc+TWD+EJLlnp+CtVs
Pi/mTVfuc+d8nfQap/K5ile1h1u9QyDxlcEvrfhKNNfyp6q+xCEEstK2oAauu+k5
4UyODDPVZvTYzXtDTYCkW4WFsXEfmnROfbM8naOPGZqy47Yemvk=
=ig1x
-----END PGP SIGNATURE-----

--p6giaonrkbn22nqk--
