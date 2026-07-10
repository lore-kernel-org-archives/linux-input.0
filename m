Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A737F727
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712476; cv=none; b=VQ/KL89FaFLNCYlAsR+2pdwz5tpIMYg3dDGGu+la03bLqaAipRg1rSwp5yLlgoXJVvnXk5rsW0tfLNHsrhXSxfeAEPDbEq98x4LbmsrmGpwr6w4yFeaw0aUrzZqSQUJYL04TFSdsVqCAyFDKAVVsMLRT4wDmHhVRP6N9rkHhHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712476; c=relaxed/simple;
	bh=0BS9a11S/ASQzzUnTlPyCH9spaY57RR0shSO+pm/PGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RllKaY85OPb+xQH1A4JXV6Fc4Fy44b4FtUwBOe/0US77BAIn/OT5+drQm6LRY+uTSOyLBj2HgTKK+ZkYLIC3VXKHUQG7X/kZsCPH5xhsC+Uy93sSCE28mkYafEveEmo5HlcZzySixPl+ohj0KN2fCHrEafy5DqsDMhAM4njsMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/3eTXpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/3eTXpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B141F00A3A
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712475;
	bh=0BS9a11S/ASQzzUnTlPyCH9spaY57RR0shSO+pm/PGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G/3eTXpwb9YtyJg2IHMVyMTz8QCkrCnC84GGVHNcGfz8gz2bzW/RdHZ9KtBEYKE01
	 5Fq7fTf5n/FyAGOL58ZNPi2j86NWC+iwLZu8ihoa3mQ+3rnbZRoAlf+gC2FX5XOHGe
	 QWNbJ/g4K5nwOZZAN/Tq51nvX5XbxMfKIzF7l0ATnU2VyBMoEzdwVmsTeCcgarjgcz
	 susJwHa+pdoZ+NnFfkaWgE1alMxapZ8/OFkKJ2oHJaP9LrL57jXI9Y+VWfae3mmSLl
	 6X6p3ImmFT9Jze9S5q7qLFzmHp5zok9EKwgCKSuliH4TdjpG4PMxtsnq5wG0521gsa
	 YLqHE7dCsofcg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeba09900bso1013404e87.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 12:41:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7YpftxujIw0kwSEtGXO0Rg7wSNaLBgeCPF1j2Y9FqbKCDYl1bi8sCDH/506NShKGNtWcZ5cePIa0tDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzitchnu97J8Squ9yB/sKLE1zEcwIqZR2tRNpxMZrB6mn6ynqlx
	UeLEWLdC9ogrYQ+g+aEB3exwxMNO+UqpPp7d6EGB79nFvJvrqgdzrDdgCd4Oe4jvkiN9eXhcfnd
	VUMLtvuoVnFQCcnsp0/8sDFd6MAwHNaE=
X-Received: by 2002:ac2:5a5d:0:b0:5b0:136c:5cb5 with SMTP id
 2adb3069b0e04-5b0236670d9mr74091e87.20.1783712474237; Fri, 10 Jul 2026
 12:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
In-Reply-To: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:41:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLn7cLCgKLf4RkBFP8yhrLs9qcteygwiAAc9sS3Amih2jQ@mail.gmail.com>
X-Gm-Features: AUfX_mxh6L3gr1zlgEqCXxbqPp1yls-g8dyPSgWL7AUruP9FnQEvhxSQ-OlsUYE
Message-ID: <CAD++jLn7cLCgKLf4RkBFP8yhrLs9qcteygwiAAc9sS3Amih2jQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Remove support for platform data from samsung keypad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
	Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 6:53=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This is a reworked and extended version of the series previously posted
> to convert the Samsung keypad driver and Cragganmore 6410 board to
> generic device properties. The first 8 patches of the original series
> (general cleanups) have been merged into mainline, and this version
> focuses on the remaining keypad rework and extends the board conversion.

Looks good to me!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
