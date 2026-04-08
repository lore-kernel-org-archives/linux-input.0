Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9E3D47A5;
	Wed,  8 Apr 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668337; cv=pass; b=ggAy/GKNNv+NodWcCkL/O/40k2C3tV+t9HckkuNQF8TeNLXysD0e/9G68PxLhboyqfJtEk+b9jaGcyuaZSyrdfT4LrmvA5CyMLlT1Y5zD1NFSNImb5hB5V8dzBrbY0ZsU6XrLM4mxJWzr3GlXIRqeKj6gfKZEO5St5I1PDT6PwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668337; c=relaxed/simple;
	bh=sw4U23/BDwEzAjGcSXxTAe0SH3ZOEZ4VKUIAWOe/H1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBA6RrRFRggv2ra4z7/8oIJC7ckYU446Bio6tLUctV/0GYZle7lE8mj7FYe0sTvl4jHOhEazARU6EfZF3qUbhDwpwzGUxh2aHNO1alyuvNQIu22hKvtuOE3fbmkVT9oFKSYNsCIDfFoIL6qyM4RRAJ9bLRvs57D0/FQR334W4R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=NSpC7zR+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NSpC7zR+"
ARC-Seal: i=1; a=rsa-sha256; t=1775668295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4N/JLlRUOlFB2xo44u+ZMYrcs3vP2PA7vnWC39SX9oJjS7XD9B1DsLowD8Klz2MonLxa0npqMlnQ4TFq08Swn+qaYBZ/Z4/RJegWcCzwX3JRlA6xWTQd72F3XfN5qMyTKELXbuyfL/1M+kDr8nGh8KcHRxmiEWFe6XYlBErgRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775668295; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sw4U23/BDwEzAjGcSXxTAe0SH3ZOEZ4VKUIAWOe/H1U=; 
	b=j3Od4SUlU0DrvH1qRlTCzUjMI/8SjwhNgIQkD5kttdpfFVC3zhrCX3eFh1LajHHRypMaEWLmNjaSfKZIiHGSctMaXBy3dWlyfuyTiqI3T4pxQkVARXDgNUVcZIEpxeiZ/zvGJcXQqmV282UoRl0fyJDZec3AbX5xrLFp12ze5B8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775668295;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=sw4U23/BDwEzAjGcSXxTAe0SH3ZOEZ4VKUIAWOe/H1U=;
	b=NSpC7zR+KQtQ2vtE01p5tHBEBvVjOqX5MjwAWa8KLwwQwsbmfVUHJFofvbe5MY7X
	yuubN5SQLs89CcIZWfk68D/FJ/O+hZQkrM5XOkXH+rErpkACUV/JKQLtC1oUmrVcZQl
	nNhXC4mw4Yh6rkUAwJF0MCB9HCkCxaaSasMXEb4I=
Received: by mx.zohomail.com with SMTPS id 1775668294549723.4122281165437;
	Wed, 8 Apr 2026 10:11:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/4] dt-bindings: input: adc-keys: allow linux,input-type
 property
Date: Wed, 08 Apr 2026 19:11:19 +0200
Message-ID: <4589987.mvXUDI8C0e@workhorse>
In-Reply-To: <adaJOEZHHmvZM_cB@google.com>
References:
 <20251215-rock4d-audio-v2-0-82a61de39b4c@collabora.com>
 <20251217133440.GA724723-robh@kernel.org> <adaJOEZHHmvZM_cB@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 8 April 2026 18:59:08 Central European Summer Time Dmitry Tor=
okhov wrote:
> On Wed, Dec 17, 2025 at 07:34:40AM -0600, Rob Herring wrote:
> > On Wed, Dec 17, 2025 at 01:57:46PM +0100, Nicolas Frattaroli wrote:
> > > On Wednesday, 17 December 2025 09:31:15 Central European Standard Tim=
e Krzysztof Kozlowski wrote:
> > > > On Mon, Dec 15, 2025 at 01:29:29PM +0100, Nicolas Frattaroli wrote:
> > > > > adc-keys, unlike gpio-keys, does not allow linux,input-type as a =
valid
> > > > > property. This makes it impossible to model devices that have ADC=
 inputs
> > > > > that should generate switch events.
> > > >=20
> > > > The solution is to use unevaluatedProps instead, which also allows
> > > > dropping other properties.
> > > >=20
> > > > Best regards,
> > > > Krzysztof
> > > >=20
> > > >=20
> > >=20
> > > Hi Krzysztof,
> > >=20
> > > to understand the motivation behind this suggestion correctly:
> > > are the "linux," vendor prefixed properties, especially with regards
> > > to key codes, generally a bit of a thorn in the side of DT bindings
> > > maintainers?
> >=20
> > Not really. Most have existed for decades. New ones get extra scrutiny=
=20
> > and often end up dropping the linux prefix.
> >=20
> > > I'd imagine so since they technically tie the DT to a specific OS
> > > kernel (though of course, others are free to translate those key
> > > codes). And the whole idea of configuring which code is emitted
> > > from something is basically abusing DT for configuring software
> > > rather than describing hardware.
> > >=20
> > > I'm mainly interested because this is a thought that has been in
> > > the back of my mind for a while now, and I'm curious if the DT
> > > binding maintainers happen to have arrived at the same impass=C3=A9,
> > > where linux,input-type et al abuse the DT model for something we
> > > would tell any other vendor not to abuse it for, but no better
> > > solution exists right now to achieve the same thing.
> >=20
> > Not sure what the BSDs do here. It's never come up that I remember. Bes=
t=20
> > I can tell is they just make it a userspace problem. So every possible=
=20
> > keyboard needs a keymap file. Though I'm not sure how that would work=20
> > with GPIO keys as you don't really have a scan code.
>=20
> Is there an update for this binding or should I apply the current
> version? I am OK with the driver changes...
>=20
> Thanks.
>=20
>=20

I will send a new version that doesn't add the property but allows
unevaluatedProps instead. Thanks for reminding me.

Kind regards,
Nicolas Frattaroli


