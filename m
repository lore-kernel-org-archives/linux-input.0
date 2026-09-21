Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90742B316
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976059; cv=pass; b=sfQg/+CR6jlLGEh/ztDM8TwWiPga0ggTY0jatE+NhFOx163nwrNGEkhPN0IdXjPsky3pf0CWNaPdv6B1bOwI/DKo7/FNmI7dCj/GFoSgDRsQc7EaOD6yqk/oJNt+8ooRwHZcBmmJo6c2oHDpCHddn7tacA23OlKPxsBhYWxcLhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976059; c=relaxed/simple;
	bh=57Sok7jJDa/57dP/GDfeHEhYnwuYZlpWnaikd4BSZrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crniq+feB5WmMHNDANb/c2OA1NuEKdbR/FlV1v4ni+xNe8bWgkwedSTmGmruPKR86QphKorQx0b0D8tStmDP2lU26xxYWr5+qyoVEDrXgAfyCRwvR9L6M2BUViUDyEFf1qBqzM4nLZQwVod6GofcsaSOfsF93zOhexxBggPAeUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRho8oHk; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRho8oHk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2322592a91.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 00:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789976057; cv=none;
        d=google.com; s=arc-20260327;
        b=cIWhDeCKvk1TmKAQJbYAu+XagtWk3E3oYrBanQ8nR1EcolvvbCqqmpj5CRVMCcWBaV
         1Jv6y0uUBbK55+Xbkr9nSKSSsMscyv4p04ZIW9/qYVsL4d4e7/Gw0VA/oAkZlq+EzqSZ
         0WJGhy5XhG/ZKWcOmn8nWd9sHVpW94ra+sK322/TTWnLjdUA1jwT1CLUWwnP+x3u0OZ6
         EK7eRX5VFlSQu9EF1lzbDhne+L25ETNqB+bhwYeyQ5tpWGoC69WO6Tex8RQ3+/Ace/Oq
         hvQ5SbtjZ4DzX73f8VhQu1984ua8wGAf0lp10salCAikXBKNyAF0UeNyH2S3vSGQJfeu
         PgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        fh=RHoiIRGJxagBBaSL2ov/wEaPRnz5x73H6flD0Tg1IBw=;
        b=a2DIDuxZGLrNYCw8Y03Ywiulq6ulfIGAWzNVGfIzT7uxlb9jeCnYKSMaxFVge2da/c
         LirWXEeyo/MaW3+3GBZ1tsbMM+fkDmnurmLAExrC/xtMo3tk1gqyWOSDwYmQ7rfHs7Ed
         YNlyDDypuzv9z9FBz7ZAnQTZZP7GKNoRK68XXUNbmPgdsqpjEwKMcNNTxvhRrnsYET7g
         HGVkRqDFFova4PbChThrtWqqvNyM9j4IboiJXAh7quKiXmR4sYzXIBpGJYXg4MawB4lX
         9uoD+ly5a8Zg+GNl8sZkNvovwCGNh9EKwSfrSmpYVE836jLt0qv9YkE9fdqXdKpCMeJU
         GO1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976057; x=1790580857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        b=bRho8oHkSZ6eNFFlMVFarqQ5ou6tGwP6n0eX0AMCacl0jOnq/EcGvM7lHBlgkmMQP7
         zLLh08JXmiwSrxOeMNy0Tw7uLfdHnUz1OHewAdYTttaeLiZZIRbpdqKAm1exhBXt0SJ2
         uwLkghVLI+wKYXaKcDPzLNu4LmatZLIhyK9LSr7vpCufUr4zYs+7bCeFlZ0tLLW0hSZD
         TgyIWK0sBY2F98z5zFIvPOsTthpcp0n1jNIxNiXIZlkb07px7TcCrRNBMw8uaYpQmBZT
         ni3Oas86iQDAeF7bEgd4d758qslkBQczuds/1ZuAokt+/PN415MLqRAZdPxSP20gQeeM
         UVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976057; x=1790580857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/KB7XKvlLtdNPe51SuZ6hkHW35ikyi0W/vUmCBDQwM=;
        b=d3OT60VQdl+2wJ2ki1H0/BJpxfnFla8B1Wy1sO2lli5B6eEO3X8IPFdn5PsHROkDoI
         yC9pY+8mlxzee42PLgXzETHNRCn5RhfV59k64VLfnoT/3PuSI5h2axcey5zJuN7cROJL
         2Rl+Vz3e4XCGgBILYW+yMxRvP3Uc2HTQOL3PJv9FXQz6TuYeJ5+oQfBUd8kVycHSEhh/
         e1mywrcyhz3dpiaIDlxMJTAj1giZnCEAy+JejvAjD9uXK5Bl+GTRNadtA/R7w9RBPNm0
         BX6TJQDMk5L2/L8SjkPJri15Nl0Fhh/KKE/DhTuAaeD/iF7ROAAIyqgKpWjSPVsFvZhf
         Z0PQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0fqUqnagnP3H/hyGAftUtuqNz6na8DzHmmyyq9rZC5+lyLXe4sUE2rxrSSP9CEonGNohhe95luZ8z0w==@vger.kernel.org
X-Gm-Message-State: AFuF++lp/19cFp8CxB9WRTkgDML6SuZtrFx3LZbdwLX3tPLyd3ZCQCjv
	jx0FCeABXSgZzO0TkfXYbOTBBl1VRbUdjdr1Ti9vxYpaj3E2jP8Suzcako8FUlnw84P7mAVHmQs
	mRKW2oRhDVv1ArTyD6X+JrevEZ1dVqtA=
X-Gm-Gg: AYBFou2LrQThdU2RD7niVFt7RN7DMkgsd5kOSwUbnVmDMK1MZl79COJzBUKg+IFd4oV
	TshRbBEdmdv1T300xvx7O2pyXXYKhUpvym6NBK06GqreG4VYQlMloxi6ZKFWpgqS2MQWSr33D25
	MChvCjlP+xvvBbA6/dq5Yt1QaoUlCbeu9149dt0qKUEBoyi3WmxPSinMHMRQAD3VkfMWn0p4P3f
	2m6VT7x/DwYKd79YBayQG6aMd1bk9LySPsNTLS1AgaKPIYSMLQLBd5tMlpxtCF6jJCtwpItJgZf
	ayRwJzgaPUSInLYbB6bYbJ0bNrrV9bo3VZKTNufCqri5lYH3oEc+GKd1qdp67Th5HDB7RBK46k1
	+e0oLSLRhdIcX
X-Received: by 2002:a17:90b:4b87:b0:39e:345b:3323 with SMTP id
 98e67ed59e1d1-39e54fb121dmr14066759a91.22.1789976057124; Mon, 21 Sep 2026
 00:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
 <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com> <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
In-Reply-To: <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 21 Sep 2026 10:34:04 +0300
X-Gm-Features: AcwNN1W6gcxmcfy1bLN5jucC74BzWiaaqHA32OWE3YHnq2Or7J12ypc4KJW69uA
Message-ID: <CAPVz0n2ZeYk8WbWfW7L1kLsQN4e0mdQ7nM4Lozy16z9X8kPCWA@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 6 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 20:22 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 19 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12=
:20 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 =
Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > Add support for multimedia top button row of ASUS Transformer's Mobil=
e
> > > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > > default which suits average Linux use better and with pressing
> > > ScreenLock + AltGr function keys layout is switched to multimedia key=
s.
> > > Only Dock keyboard input events are tracked for AltGr pressing.
> > >
> > > Co-developed-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/input/keyboard/Kconfig                |  10 +
> > >  drivers/input/keyboard/Makefile               |   1 +
> > >  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++=
++
> > >  3 files changed, 321 insertions(+)
> > >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> > >
> >
> > Hello Dmitry!
> >
> > May you please take a look? ATM only ACK on input patches left.
> >
> > Thank you!
>
> Hello Dmitry!
>
> May you please take a look? ATM only ACK on input patches left. I
> would like this patch set to move forward.
>
> Thank you!

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left. I
would like this series to move forward. Thank you!
