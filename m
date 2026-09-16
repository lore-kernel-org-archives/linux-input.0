Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A857D22F
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577576; cv=none; b=Dlhq6XB7G3ZiTjz+Td0l4ruLIHQI2jl5kYanpDZdK9Kgho0mcYwsayfbiTkXBs0tQSJ8ro+t87tLupBGecx1pZGd+EYsp4fs6kBNP9buHeWyh5kxU9fAJtXtkh9sJ7udYp2/eoN7QOnJO2EpNBWgToSa/N1WCZrpTgUtMatrL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577576; c=relaxed/simple;
	bh=iIGcosXdsqHKF2ZHJfMci5sHM1xFoCT4RjNBihYG63k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk4gsRjCBw0/1qV83wV6X2yAeSvWrsa4WqmHR4YfH1/fFrFZDXodfZm0Fhfmi5/vro9tpHGPbctZq1HgzrTOql0YwgUhCKP6LHYBTvRoFrWGxtJ+9JkUM/ufI/NqRUvVtiLdzQs9sLEV54yO+UGSISU4gVgpcXiPQ3h0wrJV+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAhjYlUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAhjYlUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E41F00899
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577566;
	bh=iIGcosXdsqHKF2ZHJfMci5sHM1xFoCT4RjNBihYG63k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KAhjYlUJz4B3vlKbDDlDmaEOmLi6tMe6vOLCW5EZoCs26rLbd8glXJaTpSZ5ZncRt
	 G1EQC5qwpstgB2j2XaL86slCFiWMTfVHspK6M+fbSkz9IsAkX78GqJs2dpYzkU2az5
	 pLiawOJCLQ408ODC/MdUIRjzmGWlpTCTWUmaGZ7quTrO+c5iLtuE4rqYPtVgHEdkO0
	 Kc8fUuOuvuraydHFdXnnYj5vBz5OVYt8cGxLANsZDmJmv0dsmNq5PvmvLSGGl3QqPP
	 P7KD/vfJErAG9yROB1uqphrZwuUor23SdPagQu0WaDDl3rLRb2sksX4etGG4xRFK33
	 rCWMVsGN5e/Og==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso2362040e87.1
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 09:52:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx73t+m9ibK8+8blCmD8OFQ3OLD/kWRGOZm9VC/SKJ+fbzCmycEDp0MisFHKE4tz4CnvKvkLi+wQ3HWRw==@vger.kernel.org
X-Gm-Message-State: AFuF++kTkGjRB8XPfRqQ7QB+XVOJE6ju34JmfGjMPzVMR2GjZ6liiAeG
	t12bz1Rem6xvFrgMcNSEFUlj0EZ2qg56zmES+amSUHmxbdQqUgKGAvuvSyHiblTmb7QTsFv9qtR
	uZgi3c+x3rrCyxV2/er673GCHaqJ/PGs=
X-Received: by 2002:ac2:5299:0:b0:5b8:9a95:e251 with SMTP id
 2adb3069b0e04-5b8ba710651mr51799e87.25.1789577565097; Wed, 16 Sep 2026
 09:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-14-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-14-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:52:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xmdqnt0f8Pu7UGQOVbB8vXW7jTvbrrYbhRnZP_VjfrieoeJn1KmD2hzRE
Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Menelaus was a companion chip for the omap24xx platform, which has
> been remvoed from the kernel, so now the menelaus driver is unused
> and can be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
