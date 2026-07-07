Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC2302146
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391111; cv=none; b=JVGJxc4v8Q5NNj4uS4Z7tB3uzcpnRdlWThRw2QKoPzp2OoM1lV4PEz6gnlCFElUcWZGZD0zfUQx82HGVRNks/THq5tIhyJZOJlPcDqnQmAkQbYLII8OCvhgtDswRPmBDjBtvO7pNxFEt+A9Fv/zm7P/Q58qSN7NDwTcYaT8j1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391111; c=relaxed/simple;
	bh=2KmZ7Hb3On5nh1GAU6ccvCHBoNxXzKsIit/vgYPVkic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsFZlQVaiyoeE5GNPv0MWNlaMJTflqB3/UhJPo5nYat3GvRODc4XYgDWFIqiRYFADBOgxtlhyv8O0m5wpdVF1YuOVaW1SYYOMaQCitp/UnAvGKLsvuSCX/2ci7TY6E1sbGGvUFZQssrag9LXNVd7IywZ2GTKP5AWcrGl/1vfxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7szU3LS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7szU3LS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381018b9375so3750544a91.0
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783391109; x=1783995909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IWwXV2NoQ084hyR/IchuMFSWerplFFVpf5f6Ij6vjU0=;
        b=n7szU3LS+bhgNJgWgskrhYxfjug4wTGvWS6pWZWrj10H12XKcFhFmU3Et+ChAhmd4Y
         W8xgQTCdf2q1RxOuNf4MMgTerSGTQSNR3SQdp7pv5p0YkyGMHPMU/onPJA6Xj2M+lKBf
         hncDXR83ASEMnJLnRB3woWx/ccnfMIbKBhAfh6kPvaZboAKcSrXiqrgWiSn0G0/8JWMm
         FmrCa1+A7ugbOWIS/bDnv44cOvOb69JAAlCEx7ePexjO62C5OSARwOjBl5tAQnhQacUi
         XMq1spAZqezMq04lxhv95kg2bfIliKGqXS2DfVKcZx+aJj481FHv03OLh2vEbq/CcFIr
         tulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391109; x=1783995909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWwXV2NoQ084hyR/IchuMFSWerplFFVpf5f6Ij6vjU0=;
        b=CcuGF5tNeGIQ/aTzZoaTQgQZBWD3vYDj/M+3OrlyIllhI+/AdqYdOwcPrTkr/6QCCG
         UUJdM8syru7LE47sOHcS3KFOKm8FhuxDkQOJ0YnmR44gh5ENXQ7TIkzldu74nlRoK7aj
         7/epKvzVnHj1SDFouAG8VEoQFnx2rBP/WSbdRRTT54hW3WaiGJwdl1klei68IsLmpA3R
         RLmzCLw19XwjutpQlEz3naPIDOp0HMAL7fWbsPXA9hRwSgFLR47AafoYF9PiRua5gyOq
         zH+aYYCGnCmqSXE0HkfVbyLKvQ8mnOXszTLCMKhwJwOwzgc5hLhEpZ1SGoAsIxYTsalS
         9p6A==
X-Forwarded-Encrypted: i=1; AHgh+RokPRMHbXO/atdH2O6Qqm3Rzj8A2UnDgVvlinE8ENVU8r55uP5CpaJR/ij0rsKcQu8hflTMEieob9JSrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhntVCIYW4hU7ZP+5+f1RBbg2FEIWVpJ40iCAr6DgBBAgtFtYr
	zO7r9AhAI6SiOTUcENliwvX6b5T/aYnIr//phI6Gfh2eV5iA6v8d1WKk
X-Gm-Gg: AfdE7ckmwxiN+BoVek2clbfS2rhAUSf/bK1Se+lmQBvw81moba6P8JubIH3VRWFreMR
	8KpyMv+UiuQTACiuE8OGKUe8D362YEXQNkeY2YX7pU0u7cJXF1S/1AmwTnuJCFvGhbi4biNIWTk
	uGKYXAEy+JWH54FY1kfrsFipNFHzE3wR6ZCwlxFUPfm3gOBtDkdhyfnL4uejdns5da+jifexYEV
	U2H2C4IzoqZKmXQtYdsMontX4xp73M3M4kMaVUpnGmmEA6Sh5zdVxffCmNwhVcP8R+ndZEIGsLD
	j4rw0QanoQNxwEhK4PsvCIpjBqmgslSiYr7gmyew2N/FJSJ8UlxAY6NpPDKbEXZpdsHfztA3vPX
	+QAYidwfum4oet2iDUlGCSIY78LEP0sDTsWw5AhB/HUILnxF89khOJBi8Ds1rTOZKE/VogVuLYf
	+Y8bP785em2C4F6UOgaFe7NMebbVyWiMnOuDRJzpJVCK3ogTh8MMhz+g==
X-Received: by 2002:a17:90b:2dcd:b0:37f:c683:e643 with SMTP id 98e67ed59e1d1-3875920ccabmr3345962a91.24.1783391108945;
        Mon, 06 Jul 2026 19:25:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d89b:1fdd:a8f2:dbeb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm2378094eec.16.2026.07.06.19.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 19:25:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:25:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 0/6] gpiolib: fence off legacy interfaces
Message-ID: <akxjQtCTcx2TOQMk@google.com>
References: <20260629130329.1291953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629130329.1291953-1-arnd@kernel.org>

On Mon, Jun 29, 2026 at 03:03:23PM +0200, Arnd Bergmann wrote:
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
> 
>  arch/sh/Kconfig                           |  1 +
>  arch/sh/boards/Kconfig                    |  8 ++++
>  arch/sh/boards/mach-highlander/Kconfig    |  1 +
>  arch/sh/boards/mach-rsk/Kconfig           |  3 ++
>  arch/x86/Kconfig                          |  1 +
>  arch/x86/platform/olpc/olpc-xo1-sci.c     |  2 +-
>  drivers/gpio/Kconfig                      |  9 +++-
>  drivers/input/keyboard/gpio_keys.c        |  9 ++--
>  drivers/input/keyboard/gpio_keys_polled.c |  4 +-
>  drivers/input/misc/Kconfig                |  3 ++
>  drivers/input/misc/soc_button_array.c     |  2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Could this be done as an immutable branch?

Thanks.

-- 
Dmitry
