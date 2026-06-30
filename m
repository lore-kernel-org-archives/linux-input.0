Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E45421EFB
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829059; cv=none; b=SBgFbhcuya3XZTJ6iNeAUFoL2zXq2qg44crFgO/CditrV6vF/zZRTdSmZBBfcmgo1x9MOTZsJJj4o41NYNiL4K0dV8skecLbqcrc/Y5I2/ew1QumzizW0FjWXT4ZlrsUoqhWsiCtJ/GF/cBaDfvyAPs6Jhqe2rAef11aF9RO2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829059; c=relaxed/simple;
	bh=kzGbN6aMPEi6epmc0Dym/QucqWf60zZaYskH3TdzwNw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbd3vtB9j79Ndu5pqzmYaooLPRo95k0ikoV3evkjPqLg8pGIGtHk+v7D3zSjgpqDrHwa/rz0RmurWbWm4CI9kJ3Aiem/+CzNII3pP9mf3aBtP8kgSZXzTjSgmBvKI0dLbNSk+yHKkDYTRxbN7WJVt0ixQ8b6HIOpaWbIJp/RuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P637Hau/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P637Hau/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1131F00ADB
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829058;
	bh=3RVh7ELT7+ihJdj5fgzKjSJM96uGbDJC2dUuDhp5cEw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=P637Hau/niy511z7KS9YXNOCl/Dbi3sP9CPxfVkhCzCIaT2kVOmowDD1rqQ+tiGon
	 NvzB7ud8I+Mbxp47bo/GtEfWLx3S1T4dKLecht1Fjh9ueOnr9b8zmO9oHSe8giKfD9
	 yEZEY+GB96wOQjB9xmx4lotOZV1RxnU3Lk+aJYSAE3SULx+QPTwyFzxY9q4K07Bvbl
	 Qtc/1Ssh5y5w0RbT74x4pvCuIhyqqUjp4Jjbo1tGezZ36eKXCzpTsiusEA0U4wPuko
	 xkMbrqaubNskzx+ic8J1sIu9R/nCZp6PyznqBCaZInuJP8xdeTLVs5xbu/APu71HVy
	 ZvM+mjFeTc9Yg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2064139e87.2
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 07:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqrUW58qpGCMb5m1YUhJ4/hqe8IKgJistuc95B6QzVxGmlZNmTnIF9lCAxtYn3fGpj1vq7Sb9245cf8wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3ik9IIL8XrfQQP77x56L+tPGLuNEQ5pRQXRds34G1ij+HY3z
	cz56wwe5bli+O/fGWcbTzQPQ3BXPvcm8OA/IQPUk2uYgYO1hJVy0bAQDLZ6ORqIl6IJTZNJ7rjl
	PNytMbi9FdJkU94kBIQ5mZ2jWPizN7FvrAskwQmFQew==
X-Received: by 2002:a05:6512:ba6:b0:5ae:b900:15b7 with SMTP id
 2adb3069b0e04-5aebdbd3532mr1090636e87.55.1782829055964; Tue, 30 Jun 2026
 07:17:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:17:33 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:17:33 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260629130329.1291953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629130329.1291953-1-arnd@kernel.org>
Date: Tue, 30 Jun 2026 07:17:33 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfh_2CDcq19XLozgZbyq=u4o+KjnBNi1HAOec0gW3CGDg@mail.gmail.com>
X-Gm-Features: AVVi8CfXTc1e_mSHjfkWFS-QUSVUX85SudluvtZvZQ5siNjxDoww7y3bpjgfSpk
Message-ID: <CAMRc=Mfh_2CDcq19XLozgZbyq=u4o+KjnBNi1HAOec0gW3CGDg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] gpiolib: fence off legacy interfaces
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 15:03:23 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is the remainder of the series previously posted as v2
> in [1]. I've changed the version to v5 for all patches to
> not confuse b4 too much, but the patches are mostly unchanged.
>
> The patch "Input: soc_button_array - select CONFIG_GPIOLIB_LEGACY"
> was not part of the series last time, but the build bots reported
> this as a regression since I had dropped that since v1.
>
> I hope that all that remains now can just get merged through the
> gpio tree. The gpio-keys patch needs a bit coordination with
> another patch addressing the same issue that is already in
> flight, so I expect that I'll rebase my series once more when
> that is in a stable branch, but the state I have here should
> just work as-is on top of v7.2-rc1.
>
>      Arnd
>
> [1] https://lore.kernel.org/all/20260520183815.2510387-1-arnd@kernel.org/
>
> Arnd Bergmann (6):
>   [v5] sh: select legacy gpiolib interface
>   [v5] x86/olpc: select GPIOLIB_LEGACY
>   [v5] Input: soc_button_array - select CONFIG_GPIOLIB_LEGACY
>   [v5] Input: gpio-keys: make legacy gpiolib optional
>   [v5] leds: gpio: make legacy gpiolib interface optional
>   [v5] gpiolib: turn off legacy interface by default

Why this weird formatting?

Anyway, for the series:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
