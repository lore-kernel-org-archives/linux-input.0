Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE573A0E8D
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540963; cv=none; b=N0use8YZfWdWh17sFVudtb+deGgPcQf6t8IZKFMuwe1xR2I3tFHiH4RLr/AiWyF0gxeM3VG9+ddhKvOG1OXpZO3QyWcCthMkIJlWLvzzKGvmYJWPkGLfMe9LeOZ3tArR4X664TVZ1XL92i77Eyul7MlwPw0qRFA8jQHj3lKUE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540963; c=relaxed/simple;
	bh=1hbv3+qsz7CdCFW9e9Eg5avIqTaq6+B/xrpTsHNZWcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta0Cv5pxjz2ckxyVH/82EqLPujBE8gBI2Ahzzjg2oB94cmd6UCjw9xDPVREy2Q39mJug+ycDQlU9CbWT7gpdd686/tYWa0ZC5m5KyM8UD6W6a9YoNoAsIpAhRLU6qSvC7N5nZFrjKrkbcXkI4eUg+T9Y+GLlSd71baxnmYuwmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMKdY2df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMKdY2df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB07C2BCC4
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777540963;
	bh=1hbv3+qsz7CdCFW9e9Eg5avIqTaq6+B/xrpTsHNZWcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMKdY2dfVWcbbZvc918bTL/VkVKqVFw9sXvIrXHI+68s9DTcF8/LPxzvryMLaIVhK
	 W8+UCb0dtRlkwEW02Jf+8aXwn+AWVA4sYHDlgrvxk1b1Q+UAdxYrdjEGt8pJXsmB9+
	 h1r1QOO8DDl2qNUYA5a4pV5fkdIZBQyN7Vf+CvurQ5l5a6is3BVz9F+xFNzmaxt6ou
	 jqykk0YmGCdQrNV+uUBJpDMocDVtIqdtQRdlz7nMvbKWXnJdurdRA0kewf+aE0Js1K
	 oU16Qh3LMIkKIZ6vLb2Ju+69FqaSpKDZUDLUqJgIf2nbxSplxELFU9/NHTPVnhoIeY
	 3NpJgP2fwOW4w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38cc8708d76so6582361fa.3
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 02:22:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++xGJ+ukntWLSNsDfwy8K77xj8uw6H2P+VjlethUjOwcZS4gvJ3PRqXfuFPJPSLPto2+kG17TZJJawbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWmNpvYl06b+XU2Guvftggm0VlKVdau2lcJIhvuB9ZmtiJ5Rx
	rPtO/aRY5nQBPu8SR7EDWMU7/MAf+HmaF8jHzj+xTg7rUtemu0q4ZI5Z10/HInPaojk7Jvt3Qr8
	DP97TSn0PzSYkTXeLOq1llUQSKakINgs=
X-Received: by 2002:a05:6512:10cb:b0:5a4:157:5354 with SMTP id
 2adb3069b0e04-5a8522bc5ffmr721493e87.12.1777540961140; Thu, 30 Apr 2026
 02:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com> <20260428114308.113253-3-clamor95@gmail.com>
In-Reply-To: <20260428114308.113253-3-clamor95@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 30 Apr 2026 11:22:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com>
X-Gm-Features: AVHnY4JNoOOgq4asQaW05QkAmgJoAjyrhDY2aKkW9L0o-hpZE2efG82M63foOSM
Message-ID: <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Svyatoslav,

I just saw this thing:

On Tue, Apr 28, 2026 at 1:43=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:

> +/* HCTRL5 controls the PWM high duty cycle of internal channel */
> +#define ISA1200_HCTRL5                 0x35
(...)
> +struct isa1200_config {
(...)
> +       u32 duty;
> +};
> +       /* Duty cycle */
> +       regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
(...)
> +       if (isa->clk)
> +               regmap_write(isa->map, ISA1200_HCTRL5, config->duty);
(..)
> +       if (isa->clk) {
> +               ret =3D device_property_read_u32(dev, "imagis,period-ns",
> +                                              &config->period);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to get period\n");
> +
> +               config->period /=3D ISA1200_HCTRL6_PERIOD_SCALE;
> +               config->duty =3D config->period >> 1;
> +       }
> +
> +       if (isa->pwm) {
> +               struct pwm_state state;
> +
> +               pwm_init_state(isa->pwm, &state);
> +
> +               if (!state.period)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "PWM period cannot be zero\n=
");
> +
> +               config->freq =3D div64_u64(NANO, state.period * config->c=
lkdiv);
> +               config->duty =3D state.period >> 1;

So you don't need the same code writing
regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
above, just use confg->duty which contains config->period >> 1
(...)
> +       device_property_read_u32(dev, "imagis,duty-cycle-ns", &config->du=
ty);

I'm not sure about this, it works for me when I set this to 100
resulting in a register write of 100 to ISA1200_HCTRL5. But are
we sure that this register is expressed in nanoseconds? I think
some calculation is needed here (and probably another value
in my device tree).

Yours,
Linus Walleij
