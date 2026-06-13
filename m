Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CF2F5313
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353430; cv=none; b=koAUJJ1v/FsMW/tXEqfy9VKJZKQNyBhez9tF96J7tgyH6EfZ1VBU45VciLuSvNOV6saKRtJe/OWamx/YqG4ZpCcj6rRgeK6O0suMnKLk7iPa9uD/NLRNzgy9boPtqXholZcIH3cZx8ABikG7KuCKoeiK1MU+hUislnzyoeQNw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353430; c=relaxed/simple;
	bh=UA2EXYJYCNN2s2fDBflhY/TwvwPeAThnGXq65LNlvwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzQcZbo+nq3SFs0q82FdjZcWVbmfUmFEU4d+bdaNrh7/nPEUXSfIQKUsyRBVys7oAho2Zk898c8yxn6wDSrY/O8SIGxQq5w8VxJDhYYpeXCiE1e1jtDOi/0ZGKawgydiX5T5AuIyQFOsT73EIKfkc+ubRIBzigACgHFR7KxkPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCHvPKm1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCHvPKm1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so24121905e9.1
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781353427; x=1781958227; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UA2EXYJYCNN2s2fDBflhY/TwvwPeAThnGXq65LNlvwY=;
        b=MCHvPKm1n9AVsWDxU8v4oFSI+ArOMWuzAFXYrUlYoPudPo1YyAKxoz9/sL38jLa9Ry
         hYhfBxeU13IR8VKYqG5TIe50A/fbIiQ8U3KNobweetXTe+A8XgI5Mj2pKAW27VSpgyIk
         XkmfeTzcs4LVFScMp0evRk8IiNYxpHDOpHdDj/B/i9WiCQVNEJqRUSchZVYl7il2zTL/
         BDkyh9tIk4zC7d+8tm8tm5VrWMXElAaVxXYWhWLypQ0yFuXwVyjCBotW/sQSpc0ORuus
         1EV1ZyCIovS5d2WVErf82unDeBC7uuxVnPMqaQOoduv0rc+4mY/wC6zCJMWinWkp8QhJ
         u9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781353427; x=1781958227;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA2EXYJYCNN2s2fDBflhY/TwvwPeAThnGXq65LNlvwY=;
        b=FJxhU/GYyhlUprtEU1/KJY++W6fRbAp45GVw3qO29J3yYxQEqyhO53HxDGEvoM9CAh
         PKhl+9TfCra5yq4e22FsW6o9DRokVM1DKjnSg7ky+3EJ5Hhh5uEo5l/jh22Lu7gMeNfF
         tpkdRWNgbrMlGFKVagWXoFME026/b9vY+FH7XG30kLlvowDU5XY+EgOdkIrVhIMZ7jW5
         +MTb4xJuHe8NsLjzn263Awqkr4/slIBPOwXDsxbfGdL9WgXhpTfo2GFjyDNN96HUJVJ1
         eTN6qBQwFAAE3dHCjnrVLFF0kOprIbLPT2eGO7gVKzhhbZkI1IJ9isWV1uFf9gy31jI0
         cnCA==
X-Forwarded-Encrypted: i=1; AFNElJ8CYmUrH02yR/5dbmcfvlJEBd3/EEdg+r0y3GsWLC/0zX/JKtOrgXAikxkTRrgvhcWvWNzIOaNuTjiERg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4sxswooViwmFwmCJ6qfjsBe0pi8+Y//Jb4c6KUu30HfEik3E
	wxJ+Hs6dJm4lyu5bO1NRAkMe9vbdIbMCE/gv2OLpbcsw9i/BqTAYrJEe
X-Gm-Gg: Acq92OEpYVGMcp+I0fw0lcaItkvPS5qxrsWR4ywTBMzXgby08LwOa8xLw17JFpiH03A
	4FCPs/0AMBaA967iyHdfWtiSmlIgYlu/Oes+qasU1KE9Z4CjO/OtKjv3Qj/37U5T0Xp6SH1Ue1f
	TAd6NfAnDr/lG2l8nP+3BaeylycKdxg8IyLk78Z06JSN4SlHUn+HN5qyFr/8zbVOBb6WEy9YU7S
	XHYi8zqiuhB0DdyxOYmbbgnZUhdWuiL7IBusVlqO/wxovZkETQrk0wmhFH+Yt5I50JKirKTawtW
	+WGKr6NaUB5N61d3M8SrrULyA2gPQTDPd81RaPk0sbL66i+qNZV8unNfwjKT5rOJdOK+iQk1dH+
	pFVKYqEDpB6a9160BNfN85wXT+yCwOiFAs1SIDwB47TsMDuyRlPly/azBwI9EIa6Fjb/6Bs6UjE
	5fZuu5gP+QTZr+nXxgjidY2Jh8yKxK0UTIgK8r0BzvB886KzUrNDQpRjEFi9gQCTadMQtJrvdjW
	OwniII=
X-Received: by 2002:a05:600d:8446:20b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-490ec4d77afmr50099355e9.12.1781353427306;
        Sat, 13 Jun 2026 05:23:47 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4b2e8esm101605395e9.0.2026.06.13.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 05:23:46 -0700 (PDT)
Message-ID: <039295d3542deda8c56151252fe5e50c88c13deb.camel@gmail.com>
Subject: Re: [PATCH v4 6/7] arm64: dts: allwinner: a100: reserve RAM for ATF
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Samuel
 Holland <samuel@sholland.org>,  Hans de Goede <hansg@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Andre Przywara	
 <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>, Lukas Schmid	
 <lukas.schmid@netcube.li>, "J." =?ISO-8859-1?Q?Neusch=E4fer?=
 <j.ne@posteo.net>,  Eric Biggers <ebiggers@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Luca Weiss <luca@lucaweiss.eu>,  Sven Peter
 <sven@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Sat, 13 Jun 2026 14:23:46 +0200
In-Reply-To: <FE7Vh4yfTmGMM24i18Wwwg@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
	 <_6NEZ78hR8a_3V2bhBAGoQ@gmail.com>
	 <b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com>
	 <FE7Vh4yfTmGMM24i18Wwwg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jernej,

On Sat, 2026-06-13 at 11:38 +0200, Jernej =C5=A0krabec wrote:
> > > > Add reserved-memory node carving out Trusted Firmware-A region span=
ning
> > > > fixed 256K from physical address 0x40000000. Even though Allwinner =
ATF
> > > > itself passes the address range in the fdt to U-Boot, U-Boot curren=
tly
> > > > only reserves this memory internally, but doesn't carve out the reg=
ion
> > > > in the fdt passed to Linux.
> > > >=20
> > > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > >=20
> > > NAK. It is job of boot procedure to properly inject TF-A reserved nod=
e.
> > > Any issue should be fixed there.
> >=20
> >=20
> > like in commit 0d17c865118881609ea7e381c7cadbb7979cc596
> > ("arm64: dts: allwinner: Add Allwinner H616 .dtsi file")
> > =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Jernej Skrabec <jernej.skrabec@=
gmail.com>
> >=20
> > ? ;-)
>=20
> I was against that too.
>=20
> It's time to be fixed in bootloader.

I agree, I was wondering about this shortcut as well... I'll implement
some sort of generic reserved memory handling in U-Boot.

--=20
Alexander Sverdlin.
