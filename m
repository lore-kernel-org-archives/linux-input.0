Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563713;
	b=D1aWBtK+m3aqavG10GXyMNuC0C0I3aTz4OS0z0kQvMSHxhmbZICMlTEgSst6uHwD3P2a
	 LIGfS20QdVN8aw7ScIUgk0PfpQ7RlMeZl13cko7fipZCcwlv3jYQqi+qOW8z+BXWqmYPL
	 pd2Zn3H+zZLHpU9cx5eUkMc9YabxMmSE4Nh9AN+DyaiSgOieGSkMhHZA1KGhmJOsamv35
	 yE8oafTxhVQVRdyUJC97U5zKe8s3KO1LA+LgDYZ33qb/CUIe9DN/qJwMpVICB8tgeDPsQ
	 cxXiYLM/WlZbn1jiiHd/syrTQ6zC0LErQHzPOe80qnC1qxTsqqjxzaX+67jjsUqvb0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563713;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=DSxYOaCEQUN98hO0auoHWXR5OBU2d9UCjSU81ozd6Vw=;
	b=E1XwNxh9Mea7lQrydepT3BL2CADVWQZOMeGCFU/sOMXmiWlcqczgqOVhNFuLqltQ5G41
	 syNbzIydJysH8NBhX6OuKGpkzD2GFoSULe1yy6KiMGoA9K99jkbg754L4fIwIYcm3M21j
	 7yokkdIUnb5Wfg83Qpn3WADD7UXPFMwK9Mw1XGrkyAfJmR1QbiSvb5GVjlPGLouY7OgGJ
	 EuICGuYDIlW0ToxMC1CZzm53LVw3FSALpSUUINzREV1lIokw1REWoUj6HKRY2WzKQ09oH
	 +et2HYyywYMjpPo1evdqR9ibfBmqbMm8CKgRP30FtRSfKdHoxQfidRTDB6ql7Cc0gXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=EGfWTiK3;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BD606A332;
	Fri, 13 Nov 2026 09:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8BD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=EGfWTiK3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=DSxYOaCEQUN98hO0auoHWXR5OBU2d9UCjSU81ozd6Vw=; t=1794563711;
	x=1795168511; b=EGfWTiK3ifpjW/ySH1THz/wwUiQESm+W4OCd4TPjqCMMfcTa3zVWMU2Clbf9Z
	gqZa5RzGowO63DT3S7qiycaFyN7BDez50qR4ZX50CBQeMMPbXbuqBntt6Kf30lTBaF4yO+gxULjZP
	H0MlIW0fwNdwqrAHZC8mha/lGIpAlYN0UUUvfM5Jzf15T26oAnD47uItCzx9gnYf8w4xvHBsW3n63
	YqE1OADboJ+M+V6cVa90zsEgHqizeSqSbw+sF6XEg+SbnRNFEMRmpj2YOBksHgfZehRbthtPV7QS0
	oOK8lidqBoas/qnVjnqr1MLsfQnY/e1LQH2ub0CxAqd9Oa/Cow==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xRnzo-00000002wpb-2rN9; Fri, 13 Nov 2026 10:55:00 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xRnzo-00000003r0U-1ePu; Fri, 13 Nov 2026 10:55:00 +0100
Message-ID: <5e3fbef26b8500de7c4192bd6cb6eb5248496e14.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and
 cleanups
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Dmitry Torokhov
	 <dmitry.torokhov@gmail.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy
 Shevchenko	 <andy.shevchenko@gmail.com>, Andreas Kemnade
 <andreas@kemnade.info>,  Johannes Kirchmair
 <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, Geert
 Uytterhoeven	 <geert+renesas@glider.be>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, 	linux-input@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:58 +0100
In-Reply-To: <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
	 <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Svyatoslav,

On Fri, 2026-11-13 at 11:33 +0200, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 12 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08=
:50 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >=20
> > Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> > have been converted to generic device properties, this series drops
> > legacy platform data support and its header file, removes redundant
> > memory barriers, fixes minor coding style issues, skips registering a
> > non-functional input device when no interrupt is wired (when the chip i=
s
> > used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
> > threaded interrupt.
> >=20
> > Thanks.
> >=20
> > Dmitry Torokhov (5):
> >   Input: tsc2007 - drop platform data support
> >   Input: tsc2007 - remove unneeded memory barriers
> >   Input: tsc2007 - fix minor coding style issues
> >   Input: tsc2007 - do not register input device without IRQ
> >   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
> >=20
> >  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
> >  drivers/input/touchscreen/tsc2007.h      |   5 +-
> >  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
> >  include/linux/platform_data/tsc2007.h    |  23 ---
> >  4 files changed, 60 insertions(+), 152 deletions(-)
> >  delete mode 100644 include/linux/platform_data/tsc2007.h
> >=20
> > --
> > 2.56.0.567.gdb80ae8cd5-goog
> >=20
>=20
> Hello Dmitry!
>=20
> I have tested this series on top of the latest next/master on the LG
> Optimus Vu P895. My device uses this chip as an ADC for battery
> temperature measurements.
>=20
> Your patches works as expected. Input device was no longer registered,
> ADC part was present and worked as intended. Thank you!
>=20
> All series
>=20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895

Interesting. What kind of device is this? Is this a SuperH-based phone?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
