Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418901;
	b=vSa6mz9SJau4JDnLfn72GGSLstShnAnZInHcDJyyjNHCd6l8aZfOTRJEXowgVgciZCqz
	 oE8ve3yQPVyBgHNL0E02Q7CdE8WW0gsGaSHqL+EzE5lDXW5UFcGcRdBA48QT9TtFc0Ejo
	 3g84z1OIBMrTGGZobplT2H5O4DTDYP9syAGyQjIpZ2TAoBklio0jBqx2L3pQqg5QA4b+c
	 TMmLOCWmQO9xibnuaBd6rW8t6rvRXK9iopJbFl5Or1+zachMYG8SG0Np4yLCt3iE1eIl8
	 SHvSoUgZIQowtnrcjjz8Zgic2qWusE1O8C5U3/rOFbGWN9jdU8QqAbWxop62C/2Zs+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418901;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=iqjriVRV+XaVhh5T/bP5TLkCUtH+I0gT57VpXww08Ts=;
	b=wDE12LD0nibRA2YYtBXeXzHtPqfm8GqNHht8U4s/QzMOhigjkujrQtm07kWc818qjCYF
	 yuadzEBjuY2H6KKtG2Mzw6cnmFh/xuXeVIwLhn2LNwWTrvxn4rEIDdluLT2HPmmyxpO7e
	 ZFUlflP3xRvb0ekHBGbe3oyWoIFf3sqmlOb7UDh0c89392/RWCYrFDKoyIiZfGroCGzsS
	 sTklBlPf+1sNKE2YB1hbUmdAFa5q4hL2ekieKQ9RksqbSrtlIXG9XVcgMHRY4UqC6NYui
	 /3KoL3dzIwlLQN82lDpPY8D1p0ULRqVI33w41mB4tLYXJu309i6DNXk5l8bMeDjjJeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=GQAG+RSi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356B606A331;
	Wed, 11 Nov 2026 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C356B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=GQAG+RSi
ARC-Seal: i=1; a=rsa-sha256; t=1794418886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wz+9A2bJsK1w1aCWKBDxj/F9POezsA0iczu87wUfwlQ5T94JTw3hZ0Wea0WPz/40Ytgn1AEKgM9rZPz5GbQFxHjD5FWggGJkKz9yfGWiuNHRYmRGbXvPQMoTvJ3G+CxfUKkNl+QX3rAWyeddedtk6cycznag6yoocp59BAVB2KA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794418886; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iqjriVRV+XaVhh5T/bP5TLkCUtH+I0gT57VpXww08Ts=; 
	b=CZQ9ZwJUcWcDp3sQmd1t0GhN4buM2apamNQwJggpMjYOpKMX6vFZL9GUn1fBzDJJziy7JSsV70bCF1DgpzGGDzRKraQKQuh+dPM0nVFQbaBrv2aYsqG5WqavV/D1TjJd/APlyHIfnf+CAFHV/3wic6z64YubrIaVdv7clNk6o64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=GQAG+RSi9TiIBnyVIMRoyJfyca8aX9lHAoLUgQgAFx6j6fEtPuQXaA+7fiNEk3wW0zNF585CbxufYjIr8H7HXNp5eEZ/kQn0i7t4oKg79OxleSqjcDbwBV+pfKD7oZUxLNPwZiecQYx5pJZzegUV4Uhs+n6iEhasqL8CWp4XaqGRO3UMWJ5LWByaQrXKKJ2YERWOxb9BNE2cV2B0zdCb3SU1cRB3YFb8Lj6QEFnZ1VtyBDOvOZHWWo7qHhnXnVYZHflqo8GHej3B5NTCotv14uT4JKkkld7gcFxoXaDz6d7tSvPPUwic8DYQRczI1LQAWDswp2VD/s/NgxzifLhmXw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=iqjriVRV+XaVhh5T/bP5TLkCUtH+I0gT57VpXww08Ts=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794418885665864.7927191318593;
	Wed, 11 Nov 2026 09:41:25 -0800 (PST)
Message-ID: <47e0364e0de6b9c22b21019d3d7e506defe58964.camel@rong.moe>
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight
 driver for Legion Gen 10
From: Rong Zhang <i@rong.moe>
To: Ciro Pedrini <ciro.pedrini@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark"	
 <derekjohn.clark@gmail.com>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede	
 <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>,
 Aaron Erhardt	 <aer@tuxedocomputers.com>,
 platform-driver-x86@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <CAPKD0HfHuv4vKWeff_uhGxXosuU279qB+kkmXNPXJYL2kxFR2w@mail.gmail.com>
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
	 <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
	 <9002537db845b7a0a900612fe3a4a3638f06cd37.camel@rong.moe>
	 <CAPKD0HfHuv4vKWeff_uhGxXosuU279qB+kkmXNPXJYL2kxFR2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:36:18 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Ciro,

On Wed, 2026-11-11 at 14:12 -0300, Ciro Pedrini wrote:
> Hi Rong,
>=20
> Thanks for the review. I'll fix the rest in v3, but before I go on with
> it I would like to hear from you on these.
>=20
> On Wed, 2026-11-11 at 20:09 +0800, Rong Zhang wrote:
> > On Tue, 2026-11-10 at 20:29 +0000, Ciro Pedrini via B4 Relay wrote:
> > > Its hardware brightness, 0..9, is stored in the controller and applie=
s to
> > > every LED of the machine (keys, front strip, rear vents, lid logo).
> >=20
> > I don't know if it's appropriate to represent so many things with the
> > name "legion::kbd_backlight".
>=20
> I gave splitting it some thought, and looked (with the help of an LLM)
> at how other drivers handle this. We could register one LED per zone,
> but that seems to be usually rejected, because they would not be
> independent: the controller has a single brightness for all zones, so
> writing any of them would change all of them.

My opinion is that we'd better figure out another representative name, as
it actually affects other things...

>=20
> Per-zone control is only possible through the LampArray (c193). It has
> 319 lamps, each with its own colour, and they are grouped by zone (keys,
> front strip, rear vents, lid logo), so a LampArray driver could light
> or dim each zone on its own. That needs c197 to hand the LEDs over
> first, as discussed in the other thread.
>=20
> Also, going with kbd_backlight seems like a good idea so that UPower
> and the desktops pick it up automatically.
>=20
> Thoughts? I'd like a confirmation from someone who knows how this is
> usually handled in Linux, as I don't have much experience with it.

...though I won't insist if you still prefer kbd_backlight, as long as
others are not opposed to it.

>=20
> > Just curious, can the software select which effect to use, or listen to
> > an event when Fn+Space is pressed?
>=20
> Yes. 0xCA reads the current effect and 0xC8 sets it. On Fn+Space the
> controller sends report 5 as 05 01 P (P =3D the new effect), then
> 05 02 B (B =3D the brightness).

Got it. We can figure out a way to coordinate LampArray autonomous mode
with it in the future.

>=20
> > I wonder, what if we set the report with a short report size, say,
> > struct_size(msg, params, len)? Could the device handle it properly in
> > this case? If so, there is a chance that we don't need to sleep for 100=
ms
> > later (I guess the device is processing too much data, causing the
> > massive delay).
>=20
> You were right. I tried it on the laptop: it takes the short request,
> and it only ever answers 5 bytes anyway, even when asked for 960. The
> answer is there right away, I read it with delays from 100 ms down to 0
> and it was always correct. So a brightness read goes from ~115 ms to
> ~2 ms.
>=20
> Setting the brightness with a short request works too, and reading it
> right after returns the new value.

In this case you don't need the pre-allocated buffer, too. Let's allocate
a tiny buffer on stack.

>=20
> In v3 I'll send and read short reports and drop the msleep().
>=20
> > Ditto, what if we get the report with struct_size(msg, params, 1)?
>=20
> Same, that works.

Great :-)

Thanks,
Rong

>=20
> Thanks,
> Ciro
