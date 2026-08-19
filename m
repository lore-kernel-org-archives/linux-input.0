Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D642CB03
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131293; cv=pass; b=ctXLRTYATa6q9dV35KzkiBlsqSTFJoT97+VVWiVIKRcqcfFLNZ0173vI+syC4NWBVFE+rJpk0/hSJS0v9O3nrUdBGbPaIUJsTtAR0jF1HXPL3uqEeiD6cOoSAT7vSPHrC5wtapucAv9z/VCceB+0gRMCIQ651LnVY3dh4UATx24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131293; c=relaxed/simple;
	bh=SRKu1RMP8lCKPR+HYznxClqvbk9Ij8Tx9Yd8BcRgYPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyOQFbe4Xwy2OAjWrqAYP235C77MouUZ587KF5Nr5NURzd5cuRj+U4Evn0Qs3ETf7jnHhlai7e0Ef0vp1jlUgNJ98y54fytYsv75CCTBGTZOUWncl65EoekXnaHvq6UdrhyfdlREq/xDTI4372vhVU7OYf6LIPJHgwRAm1HTc48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt9ETela; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt9ETela"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197eaaab00so132805066b.0
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 02:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787131273; cv=none;
        d=google.com; s=arc-20260327;
        b=nwM2PGQfcMF6FNfY83/UyioXXT0bQAEubhaFQdar1cn/zH2CTRGy3UXoks7DOoynnA
         eTYr6n883eiCVnrIK1TdMOoNEXLxeyfuzDpc+kuLBmF4MnQgz3tkPct+caL+ULKv6Ckz
         QjB+EV3X7owlrYDeBe9LvX2lmVQBcXbAYOLXw98pkyEx7PscbTHsaIb9exGk7xw7d8LY
         0tTWRFxCFXmG+3N37Fbb+0m9wGF/ZXeFy68vnRytBROFXLC48g4qxTBVlzoql9I1fqTx
         CLyaFMjs9Hu/48zqp3auXSFub9MmJV0ADADe/609e6AGL/uAUSnUtKBIhdGGP/ciqfWj
         qYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        fh=VXi4W4ETebt3eb+pL1nE014+HDC2MIjaI05n+g9c6f8=;
        b=dQWCiCFQJmCCcaMelZakG8jAAHu3CnrBlIk0CbQQKLc9Lowk6zjyQ3Al0Zuj69It2Z
         2su9eill1KNQ401+XhWUU/4t5Je86gCb2EG/vjO1q9fKRR3iTqv3Q8OLneT8d6hbUNLo
         fvZ1lO+BAKDAk5KgRHOSjLt+PnQmP0ersylBYrAQK5jEd01kWDrIIYJvncI0L8JSyRXV
         OW32HEotoGczn6Fl3a/xZ1mt/ffNXD+MFtwZFUTZhIO/cGo3zru2TToGunft49Kfp3zH
         VzyY/eJKhbUoQoe68KTRGQ/r4RytJ4V05T7JL05HeH9Q3ByvpbfkkltzhHMM3pOoUZAM
         WLzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787131273; x=1787736073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        b=dt9ETelalYwPNHWrr7GzEURejWE6D9Ja4V/si2XFpml/u2fYfMjWLEllo50zrCZBvN
         GjhrV2jBxWSVkgg0y7IWniXkxNgRpoGLtAuWNG9vY0NXblDMu/xsECF6ohQjMA/GZmUX
         SDLHUkXwJlrxtTgnIK2+ZGwxCPKx60I2SjL5TptNpgGGPK3quZccmkaaG7DdG/mYeMDX
         yTx8JkK3Yzg582kqwzWTk+5j7Syvgwu+Ig0VMuknW0Sc9FeWFFBk2kMEr3PjDPgCJIdB
         Ih4uEmuYPJmCAIOsBWZ6WSGUMQw/kTRfkcwI0qnG/k0dvaPCTGw6c7JSqfFbeC1MphA/
         m39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131273; x=1787736073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vi8ghfGMWZmpwEtSeTZjCsYAT31WP+MRhmUIZU07Nc4=;
        b=R5qlVG/0d/713RgGmENBmsWNI9rEbBbRtA63tmGCAkcg2rCsKjsW9PJMQPvUAqd/cC
         gYy31icny08/PpNI6aJXSMsyhmfTjhN1muLhBa68opszfQt8imxje4T5dkZqqOdu/vA6
         5jMGCm+8gSp9qqp8JKBsUqqmDDyCivXstSlwdm+lmmYceGjq2CJDkCd1acgSvp1aT95g
         G94neYkxq7IxWcNhOyMtB9ijco+k1/PhC0nX4e5pxOwTiyM/mVcdPyTIobNsfs1JKYhE
         1/cueWucEnPUTCPhHh5Uy9yuSInB8FUboQak54H/Gon1VRrjnHJqZSSyZbeqCV0IRmLT
         kVhw==
X-Forwarded-Encrypted: i=1; AHgh+RrRXkXkFZGA3pUnqlM5+LJHRCk7bMVeLtsPlMLTWKDnKdVH/y8473IBG0DbveFtqmTSIONaj+bHJuXdiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpArKiCQ5gGR5WaMIG2DykwUm/bQVMz5QFe3HABfhyTBje3T79
	deUyvquGpV99QfiTtX6hYj94MriE487DrsfYLZ30K3qJ1Y0xyjEnDdunAvD/b5kWvDyE5fV/F70
	W+i7V9dSVTkL1n8C55InCz6QOqr7KafQ=
X-Gm-Gg: AR+sD11q1eb6uAmpW++owlgsDnjqjE19n+bcqR2/fYi6mOGAzqJpKmnjXfSpeg58vU4
	AfS58v85XdZCYccou5IjLk7eH6huiwerVafLdV/PonKUcgfeE2+JHIywnXiRfTk/oxGeoD09KhT
	ZFQnLYGCp7s5xSG+1CrVVYZTm4O5cwY8cYcOIiQyhPGb5UY5vujUNEVw7ZnGNEvC75RIJgTduD9
	S/toCsclqLx/6agmOYJRfnW7F2+hSs7/q5lQIiTGr7MmXpEqkgPO7r31GClnOKghVFF8XaX//XI
	IVmumI8xvj4bqeCMIAIjhFAd/jOfKpeiCuv/lPMRhI3Eh93AVefiljHqUTpQ/YPYO2n7Vkx7U/R
	9DQ==
X-Received: by 2002:a17:907:c16:b0:c1f:bda0:a771 with SMTP id
 a640c23a62f3a-c242e22d850mr188578366b.13.1787131272600; Wed, 19 Aug 2026
 02:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
In-Reply-To: <20260721095233.420823-5-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Aug 2026 12:20:59 +0300
X-Gm-Features: AcwNN1VQ1pRWSA2IPSzjj2VjuH6jUfN6i7gcHLhHAkq5FyaNBjl025TKLUB959w
Message-ID: <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Only Dock keyboard input events are tracked for AltGr pressing.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig                |  10 +
>  drivers/input/keyboard/Makefile               |   1 +
>  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
>

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left.

Thank you!
