Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1235E929
	for <linux-input@vger.kernel.org>; Wed,  6 May 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054475; cv=none; b=jJerglmN7hZb+ahcU92gVPNayL2c1mKbw41EIoUW/cmPRu56ubVY38aYeWl5D7R9f1/nukaBA9v0mIxthzmRZ02O45C0hKxhAN5gfPOTVoCINWsWEY8pcx2dchQxZHw0aL9KteOdnRX+9J8Xx6cAJY3U2ZcMinBh7vzcpj3LA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054475; c=relaxed/simple;
	bh=Oq6YXplbE5ZQmUVit6cOLyosSFS6iId1xCtoNqN68hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNj6taJyZmM4nFcAO6jipOBk+pQhPVCoo2vHjdO/CV85CzrqRDGNQ7LtfmCscg/fwpEYjPm83TarMVXBbUt1taYMyCrpxVWHGifQutnT+7p6ggBpgP/iFK30CIlU6y41LFE6rpnG1CsWZ6FQAlVLZClaXPvp2xWsmev3+Qglts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1mVeIxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1mVeIxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51ABC4AF09
	for <linux-input@vger.kernel.org>; Wed,  6 May 2026 08:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778054474;
	bh=Oq6YXplbE5ZQmUVit6cOLyosSFS6iId1xCtoNqN68hU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1mVeIxwB1DUTOvDFv+st+qLeum8d3thULs5YyMKXuRSF72z0X/pRejqq1qVQb0kI
	 NZkMBxvKi43itbuHU70WnQjicGu/BFm5ZFl0/Aiy43F4+lRHVlpQhT7oZ3Ds/f6X4+
	 lKn+zQmtr4H98d44xt5GiYfracX88OG0qwTlQ1xL+2VihzeA157TikGwXDb25ANgiP
	 zbLK55ZhFe1OYxHnm+/oNiTcXRpVeClRHZdrLM+63T2A0VHmob0VBj9vM4MNsqRaZl
	 GJGFybeTlstntLDiwTvJkrn7+ZVY83DnpoovfohWvcEUx8Ro9Nijl0todXvgY1/Xo6
	 gCKx8czdF5tpA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8891febd2so353010e87.1
        for <linux-input@vger.kernel.org>; Wed, 06 May 2026 01:01:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9+dMG2UH5rHxm6C7FF8Ey09Gdg58YGJvmgFeAZsuGVvGbXF2Q48M5vSmL7aS6mGOX5SHO5oACbbaqjNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOjXxbvTj0AoGqznbYhmT/O67UOeaHRVdw0qCpX/irZ6laUjF
	kUUBopXAB3Fi+SsgcwdhNhuGjYtaHIhKxfiRTAPckSlCwKOtpmKhpTzEqM8bUoX9GJ22MACKwzC
	b9xvqNRjIUyEVpSO8HrZOzPOxPPjB5m0=
X-Received: by 2002:a05:6512:1322:b0:5a8:6e50:b16a with SMTP id
 2adb3069b0e04-5a887ce7380mr883056e87.34.1778054473401; Wed, 06 May 2026
 01:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165243.215979-1-clamor95@gmail.com> <20260503165243.215979-2-clamor95@gmail.com>
 <20260506-nautilus-of-abstract-efficiency-eebe94@quoll>
In-Reply-To: <20260506-nautilus-of-abstract-efficiency-eebe94@quoll>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 6 May 2026 10:01:01 +0200
X-Gmail-Original-Message-ID: <CAD++jL=WodX=O9FXzb0Un8x-vy-_ueaCDAPVJrr9B9ej9y_HtA@mail.gmail.com>
X-Gm-Features: AVHnY4KUawntr5rPL5psFRUWmDoJ9Fp76xzlOvwzksxje1oYwTtLgLLlb2iQBsw
Message-ID: <CAD++jL=WodX=O9FXzb0Un8x-vy-_ueaCDAPVJrr9B9ej9y_HtA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 9:39=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On Sun, May 03, 2026 at 07:52:42PM +0300, Svyatoslav Ryhel wrote:
> > Document the Imagis ISA1200 haptic motor driver, used primarily in mobi=
le
> > handheld devices and capable of supporting up to two motors.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Tested-by: Linus Walleij <linusw@kernel.org> # Samsung GT-I9070 Janice
>
> Drop the tag here, you cannot test a binding. It's not possible or
> otherwise explain how YAML file was tested by this device.

Right, I was probably sloppy and replied Tested-by on the cover
letter.

Yours,
Linus Walleij
