Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630857;
	b=3qkog7jQDGsRROPY/ANWC6DfdjiKCDwst3Nf/09RO/ngrQ3LnX6WIKW0udQ0xUtkpF11
	 9hcLbFJTBGQ4ZU4ViWBr7Z1PVQ9DfIRpjU3mdkDyKbPWvV1Yn3JYGFF8Ey2VfOFH/H2mF
	 fPbxzQwBL39GtxfSxSDSb6v3rr+kaGZ8LTG0ycKm8pvQeunxX7B8A8OKH3iADH27QNGV+
	 YFVTtXv6jBBsxpbicRWODBZc4UirZ4ahHIQS+nj2456qPCF96vvEn+42jRaHKuAC8u3YW
	 0ryepsdrjMgLk2Djt5hztJMwFUlIQXHUyt2cQYXZGDaZMBKWjhVK26ouJB7Uux1zoWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
	b=OazpXlyXQX05DXXp4c8tydhXUZUBJHetftDbojvgH7p+YDK6Q7JU+n+VfWV5HH6jyTRe
	 Gc2KjLka86dcoQr94YnQrdrWrLSk+IDUyx1AyuiTXPka0gRk9GSiDFaDrZ1VAFduZF3EZ
	 UlKdexAnA4d7dqGNVMLKIpfqsc36PdHPS4TA8hdYFu+2WYbh1siT6AzxJh9763HCOhJjZ
	 8+ECUIQhRO1fJI2zF6nexuOQZrK4o7KQ5T2EDI3I4FHR/+h6va06m6FrZVAgkA3krel4Z
	 oubEhJ56kquUNbMGmIApN8tBkeYe6mZioJN+o0+7Rjd9BbsYcWUGFl6p08kX9zjf/Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOOwiHKI;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D8608361C
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7D8608361C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vOOwiHKI
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2af2ae1258so63533566b.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630856; x=1794235656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
        b=vOOwiHKIig3GV4B3RMpyXaNnJvZaW5WHqMXuZALmn7YyIgw0aneM5TYWVq80XIixV8
         u6RJ5fNn41M/8veQNr5jwps5Ukj8gbzp+KDPFKohS+eLwVXBvdV2KgVdB2NE/Xr6mMEv
         IOSwnRj0EH2SiqK6YOcEsUKaKvoP7KgasR2XVmt47RJox7gaPctJublgkpgb5eWGZPFa
         VxRmjb/10Ns7IOqFCEZg4nXBN9kF+/fZ6DDi/FlUD74LsAHY6q4rm+kUcYUeVDdcDGKv
         KALPkMWB5q0tNLogDjZHsJVT4/wzvBadCiJKYDJhkt9pDx/aS29KY4Pwl1MNLVnUh65X
         o0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630856; x=1794235656;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gFxWaAr4e8pvWdps+x1ea8YchRLnBYcg9irtyuiJvGM=;
        b=H9o7KMY8uDznYKWiU1Tb+MKIVZPh5rZhn7wbzAuwZINvD2qgOeN+wxWeICIE+wbD+U
         rOQNFLgIn36VScLvLlK6h4W6PV3YfNhilnNbJKJGrpWwXhARHkraZQXv5XEHaTgufwBt
         QXn2X4Lo1gQyVXBpAr7KtqD6REQ2FMMGcL8SKDAvbg5lOQ00TJV0R4T76kCWnj/dHjg2
         53qHzhvyPNciiwCSQo18xAfDsbSonqq4SZn3B6Y9Aggq6pWvUU/i5j1YM9HLqJk6nLOB
         9o3Y80iwhczD4AHOyxeuVWxY0HA49iMEQsx62/x1beVKLcDUMiwHWVDVpAhj+e1fG+6V
         O9ew==
X-Forwarded-Encrypted: i=1; AKwUvBwtDrdL1JtS7dYBCjv4oaHOZ96TobV0kzGFQ+Iq89U6ZjAjTN6MIusD2PqqqbbAKniowmuoT05LXBNt2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z++hBcFL0jgpKtD660zooyC4bFeFQLYf0vMYUWTaIP3SaMofuF7
	MMCYLgJa0O7GRLP8+n6ID6T4NnR2fbZOPVC159rh9edd1kloht8FzwuK
X-Gm-Gg: AYBFou2YUNxQJl7S4YNLNYw68hrJQEpr3dHnUlKVCWkJJTOv7pIYe7tG0vhCtMkYiys
	TtZG1NeBGTn2PTdO1W/ci5uQzAFik6KiUegtlt45MU+WV3aVOFsSkveiTW9qLx5s37gpd29oEjZ
	dH4jIHYYw1d2enGn3+JgKKp2EmWdpgCf0bKJh4s4LBTfXwxDCl2BZjzO55UUWQluNVQgYxpkVtF
	Sz8YZcPovl9IFO4EyqHWg8rpk3kFUFdBMq6+OLAa/u8OlRhQf+MTE2QSlWK3WdoVmU/t0IG7q2o
	rZC4jrt1bizndMSSn74nFlLSZXwWxmSHLxp5nK3TaE9lSD2D4bsFLfQr0Vci6eMRQ69jjJwqOgy
	1vO31nyZnsyL0aZVNwP2dA8HkxeRO8QbOHesFLKryv5bZzB7OyaInNegpV1453ght+st5lU3pRx
	fGBuTVAcm9SiIPB7VE+meuTE1VGxOYQp0yYyFW0BhTC3kvHelGMW/W3QiPg3rPmbweiJGzLPPEL
	c2A4Wwz6EKtad10V3yWrrOh6ZYDr2mgHq0drkY5tllBJvvf4qmge123OYTDjq4hdj+nU5wGbrcu
	D6GGuisGtVPshPSNYlvbZtp38RPNwH+iLDpJGFl4QMXoC1WClcB45n2PUAHVsr02JmSG7Wyp8rj
	KaysPnj8cuD5VOQ==
X-Received: by 2002:a17:906:6a88:b0:c2e:3698:dbba with SMTP id a640c23a62f3a-c4ca7a72e75mr879925866b.4.1793630855489;
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4a9a1sm400030766b.58.2026.11.02.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:35 -0800 (PST)
Message-ID: <bb43e80f92a82e1a27077a45606a9c7f2678ddcf.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Oleg Makarenko <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires	 <bentiss@kernel.org>,
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>,  Paul Dino Jones
 <paul@spacefreak18.xyz>, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 15:47:31 +0100
In-Reply-To: <auig8ARnvkEoAagA@kernel>
References: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
	 <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
	 <auig8ARnvkEoAagA@kernel>
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

On Mon, 2026-11-02 at 22:40 +0800, Shengzhuo Wei wrote:
> Hi Tomasz,
>=20
> Thanks for testing and reviewing the patch.
>=20
> > Should we maybe add a warning to the driver that the time exponent migh=
t
> > be out of a sane range? Sane range being, say, 10 to 0? This of course
> > would have to happen during init stage not to spam dmesg.
>=20
> For the initialization-time warning, would -8 to 0 be a reasonable
> exponent range?

Yes, I meant to say -10 (not positive 10 obviously) but -8 seems like a
better fit here.

> - -8 is the lowest exponent in the commonly used signed 4-bit HID
>   encoding.
> - 0 allows a time unit of one second.
> - Positive exponents 1 through 7 would give time units of ten seconds
>   or more, which seem unusually coarse for force-feedback effects.
>=20
> This would only be a warning threshold: the driver would still accept
> the device and leave the rescaling behavior unchanged.
>=20
> Does that match what you had in mind, or would you prefer a different
> range?

Yup, that range is great.

>=20
> Thanks,
> Shengzhuo
