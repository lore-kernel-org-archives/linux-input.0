From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 1/3] input: Add a driver TSC40 (serial)
Date: Sun, 18 Sep 2011 19:49:34 +0200
Message-ID: <20110918194934.30ea9d01@sk2.org>
References: <CAH9NwWcYWPPShEC4tyH_VQJaNmcmaWHiApkxnKr=0HCnaqZuMw@mail.gmail.com>
	<20110913163210.GA2915@core.coreip.homeip.net>
	<CAH9NwWdee4u5uqzsHzssTBWc05Q6yxs29DYTO3_HxYDHznZ_cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/_mjNFfqqvF5REamworbHgCo"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:41115 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272Ab1IRRtu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Sep 2011 13:49:50 -0400
In-Reply-To: <CAH9NwWdee4u5uqzsHzssTBWc05Q6yxs29DYTO3_HxYDHznZ_cg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, bigeasy@linutronix.de

--Sig_/_mjNFfqqvF5REamworbHgCo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, 14 Sep 2011 14:07:37 +0200, Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
> 2011/9/13 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > All this initialization is much easier done in inputattach.
>=20
> Thats fine for me... is http://git.iplinux.org/inputattach.git the
> official git repo for inputattach?

No, inputattach is maintained as part of the linuxconsole tools at
https://sourceforge.net/projects/linuxconsole/ - I'm still using Subversion
but I'll switch to git within the next few week or so, so if you want to se=
nd
a patch git send-email is fine.

Regards,

Stephen

--Sig_/_mjNFfqqvF5REamworbHgCo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOdi8uAAoJEHWXeKmja0lP17YP/RbAXw0ays9J7zEsbiucw/fv
iO1MYWdPPk3Bo5D03trlyaK5+rosbA2KBFhe1GjegSvMo0cOajA9+cLxiELzdKaD
EEVT6ULmuZvr9vF4BOKXPlLr6N8sB4Hq1HhnHnb8dNNe8Cbopf5X0J5S726PJ/qf
cfl9baawHbpx/y7iWQh70p6GYL0UnUKDjnuGq1wBFQJZbaiXSxxHb5EjZe9YhfXc
oVHWouIxlfSk6VijNUO5PHxG+yzsDJZRnXikIqWL3wXwJJR9ZccnQEJf6fnTsOWr
dYldcnm1sCAlBhiQEkiQojJRj8LxxWart8kMokpMFqKx8/WEnFK3X4ud6x9ftBIS
ZN2C6qsY56DqrXprSgLhPwtwUWiVFuCMZqCzNZmcKmy4Xk3vpDT8DgRe+yR7mgCh
7T19+6qQSckX1MB01RlTzfRVPHE+L1yrmOE12cJcUGLfkDrhG7IvT6pr5cWYAM16
d+ZPWyO4tRtQctlYMSS0io1XARK4N1mIIAgPtUQ6DREAnHHxBzVo+wudCGuN2Ayj
Aa1e3DQCkrzksNpUJLZ0jTZ2aE/EdIgDgY9CYn6TQ1G8I3HnPOtv7MlS5JNOMVyg
ukMbqwC9dpPnYJTXjVGhE1ikRmJvWGMZjlHSakeEdCAwp0aHWzUim/u1iRYhlFPz
fj6zV3/0xEsZb2TPSssN
=1Zq8
-----END PGP SIGNATURE-----

--Sig_/_mjNFfqqvF5REamworbHgCo--
