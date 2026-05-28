Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1E26B08F
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945493; cv=pass; b=gLsTTHaPo/SKM7LyCkQSMp+Rla4hNxRb0M76o8ySkpJFh+sPCZo+t1+ZZFUadE7NtvkePhlvQ7RGKeQdLw7cxqtYwIlZQ4EuNvE6yjTpzK6HJbC2T0WcA0UWbM11RTNWgiclRnaVRr/Y1jMXX2+mpYrb4kUUYsSSV5jkAxA3T7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945493; c=relaxed/simple;
	bh=areaKIufC0+d86tvfvrvo4dZTcUhI7C5ogjdZNZnqyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl6ZFI0h46mw4sbA5OVTNPAjM18wFZCOlWmr4KgqFlEciiAPoV1H466BOOH5ptLmrXJQ2ikiSC8XuSzvoB6/fIHvJeEiluNmKzjuJUvVJVGugpQGFS5PWkvhBOvWvgYaaulDxaogs+QY3JtBFQjC8dG47laoBjxJDTxi5nI1CG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O31d1GGs; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O31d1GGs"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso4627288c88.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945491; cv=none;
        d=google.com; s=arc-20240605;
        b=jVCkF+RV0SrddbKAaCVQf3xEWyeedZMR6GJ5odH34Hm3PznVB4VmeuOL58hjjYb4Wv
         yeI1+exlV5GdmYAsI+WDHcOYKiU6W/myJxqs4e75DBYAnB9jPqhY6IBBUsHyuHIWYBVT
         dJZhDPvuQoZWtoe6mPu9s2l/rwBV4rdwCSMoIwbzvDFspfEHcBAuhUYK43qOJvD/2ABm
         ACWsipmlZiFXEu7NDX+K0zePa59vgGmLIWNomAl9TVSalIoDKMLYLa+DshNUKbmIR4Qv
         mWKgt01VjG3zhnbV+NU1wz41TjF0WNQCuZ/FvWotmCPcdAQoI6k1nUcKurrIG6cIxucD
         8JLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=areaKIufC0+d86tvfvrvo4dZTcUhI7C5ogjdZNZnqyE=;
        fh=YGfkv44Ojt3jCyA1Io1lul0BQrFOwLnvk5J8yHUakNk=;
        b=HXWZQEsU/ceF0narcCG1kR8f32YThOOqqHLq3xpQVojNq4yQ228srg613TDsdWfA0P
         432cj3ru5KUzBczuBGlmpLzY5sqwGBzx5HcwxE2EAAsSlLclJD5R3sY8ZSrgnkwazWRd
         HUfvc6ZbyX2rusGL8dXgxK5R7SJAk1yvprSBVQerguwCDoZpR2xhOvPdQ0MwWxp3qr+p
         1L3XHB8W87jbDZJtOMKgoVeK4tCXnU4lA91OnFxeocWLFXaUyRRshSI1ZsoA+ikYwiXL
         i3Do6bLEwd8B+oaUYM7RXg/tCrnPhN5myNJb5gbBu4l56a2UlaPEYPcPdFGfnaBGTw96
         cZGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779945491; x=1780550291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=areaKIufC0+d86tvfvrvo4dZTcUhI7C5ogjdZNZnqyE=;
        b=O31d1GGsez0AtaRwSwqxBrHeSyVWjhLE/UAWc88iBOgcgGt0N1ZCoGtjI0nbHHxc6y
         FJcKH4nDnVs0ySg+3OXXaOQW0QM7BC9bRwuVdI4IUx3EXhAip6JbcALoPdRfCprNBLhd
         u69R3Y78pm3MPbu9ii+UJlAz8JL5RVDOQZTA2LyutjJIFJhodsPtozCEHkv+AvDG2nDP
         UCZez+o6x83DNaXTG3Qekw20De616Zgy8TINZeLHn2H5VOkecU2iEJ7B7S7y5WkHs0M0
         cB9GdSskoGpbdTz4wjq6dK6fIR/J5rpDGzbfmdR25z515oegdRPaUoMr2jWgbAdSWhjW
         Fj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779945491; x=1780550291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=areaKIufC0+d86tvfvrvo4dZTcUhI7C5ogjdZNZnqyE=;
        b=mQ/ddNhMO2mv7HH8rtGZj69osBD90wrvX8EgXMjQx3hf4Q+PgX817dx5OGlEXHzMbK
         7pnqZdYiOgxHFFCxnZlaix1ZLEW0hCXFVt/0sqS46E8/k1K4aafcLwP0s8qSFl6MyUlO
         NB7PQj3rgYMZR4mgmAqIGJ0I2J2yFi3zM0VE7MYLvBV6Y7XZmnipvKP9sLUTD9VL4bGB
         Huzw5vXKeNmFmUitgJTCqK6/pZZ1SwoEeJ3EJle+QsLW9wUhI2fQWAFbom87H6kFc2vE
         A3ZedEOJuLG1OpefRtkMToxkPzvgT4BP5DLraD5iQ7mVBSpYEl3oNLAzrcApR3QENTlb
         zF8g==
X-Forwarded-Encrypted: i=1; AFNElJ/WPvZWre1zY78PRjJ6sPqtxnplxDvpkRnEMzrV6Hz5nmBZBPSftpmCtXvuk1J/w0FMbNYELCnmtzh9GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkaSt/hmja9A+AzE1SZDCXdSSS2nYslV0/29OHR8b3f+n6ibk
	lksjhcI9HCGhy0xh9isNCdUIpIBTlMgTpbE+CCcvte2uKSqXvKqmMdbglCqm2gTYvvBHy0Pl36P
	vrHqcebCfUThzZ7q5cDsSdj5AXv70mRI=
X-Gm-Gg: Acq92OHP4Vcv+HI2F1tKh728813f1yDn3YmVP3KNWmwsPMSavLulkPVncHqhOFN6Evp
	EaMmjVOo6SaIC/mO5Ox6rzzGHpjfBYAYZpnHvPj/xFkuSt9hy7qjOkCqqO79oYpe1DKRcJNWHbm
	qARYg4lFlyXDM+Tz1TgHHPQDXqsNJIxsYhHGPY5qREJVv4FtLD6rdqPnAHW6WwbJWXnkIdfql6b
	Figm1JSkemRZQUN5Rllt7t1g3RJTbZeME8niP0gJt8VhhwRgqQQBg8uWkuYi1kRvavVS+L5KGQq
	HFTboToNUYdVmkJcn/e0cwv2ALucqw==
X-Received: by 2002:a05:693c:2285:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-3044905daafmr13410331eec.22.1779945490943; Wed, 27 May 2026
 22:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520182124.117863-1-clamor95@gmail.com> <20260527151432.GE671544@google.com>
In-Reply-To: <20260527151432.GE671544@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 08:17:59 +0300
X-Gm-Features: AVHnY4IwFtKSnlUuqqQMSGRUcAGiZFh32kg3QDjdUxx72WXz6drvM_0v5ARcn1g
Message-ID: <CAPVz0n2b2LphZgw7FeqMTw1gfKuMdagQ9pt-GJ4sziC5Atx9mA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 18:1=
4 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 20 May 2026, Svyatoslav Ryhel wrote:
>
> > The initial goal was only to add support for the CPCAP used in the Mot
> > Tegra20 board; however, since the documentation was already partially
> > converted, I decided to complete the conversion to schema too.
> >
> > The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
> > from TXT to YAML while preserving the original structure. Mot board
> > compatibility was added to the regulator and core schema. Since these
> > were one-line patches, they were not separated into dedicated commits;
> > however, the commit message notes this for both cases.
> >
> > Finally, the CPCAP MFD was slightly refactored to improve support for
> > multiple subcell compositions.
>
> Once you've fixed the DT issues that Rob pointed out, I'll merge the set.
>

That is already done. The address-cells and size-cells props were
removed from the main node in this iteration.

> --
> Lee Jones
