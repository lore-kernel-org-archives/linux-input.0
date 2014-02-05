From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Wed, 05 Feb 2014 01:03:46 +0100
Message-ID: <11410308.cAygrS0hGQ@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <CADbOyBS8C+OR5D6EhNCY4O-nMsb5XXdHmkN+8wzj=vT7kXy4pw@mail.gmail.com> <2759650.caO9v0gpIz@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:39515 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbaBEADs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 19:03:48 -0500
In-Reply-To: <2759650.caO9v0gpIz@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org

On Wednesday 05 of February 2014 00:54:45 Michal Mal=FD wrote:
> Hi,
>=20
> I have simply taken what we have right now and ported it over to ff-m=
lnx.
> I believe that any improvements based on the previous investigation s=
hould
> go into another series because we most certainly don't want to introd=
uce any
> regressions.
>=20
> Michal

Ahh... please disregard this. 2/5 should have the same fix for zero for=
ce as=20
we have right now - it should effectively stop the effect when the forc=
e is=20
zero.

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
