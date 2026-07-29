Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF403403E3
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311226; cv=none; b=uRzFQ4PK89UCADPbQq4Gv4bluvhLcIS92H6IfTSOU5Rob0G+GxFTnmrhVpdth3skj6Cx3vBhQeUTNFfq32392/rRIp3iTGQLfzikFT+s+7vy1Al88N0Acq/Qm87TdV66r8xCEs3tS+QMHyJ7DLHD5Y7GXUc+z6+wjPFk3Q6r+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311226; c=relaxed/simple;
	bh=CnDfjy0gxmr2Cbj6LcfLZcNzLV1wsZsbYNBRZJUebR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmLjKI7o5HEbOv7s4lLkNcnOQw5tNoq9RpOwaaBGfLEuwPGTZYQiu32YBxjGpaJPKmOy2Ktayds/E18rbY7x9aMxS1EbX+PpYpkLhe2NIGqeOde9i+LfDFKMjZhD2x2JdXIQquakTJQI6NcsNzFxpj3I128NX9GjwIfYMuOKQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGgyo5g0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGgyo5g0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37DA1F000E9
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785311216;
	bh=CnDfjy0gxmr2Cbj6LcfLZcNzLV1wsZsbYNBRZJUebR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WGgyo5g0P6oM+zvZ7jMoAzErZdJUVVjpA+j8GT/Q/LYb6QbknoBCh44P32vpS/wig
	 1JQdITrCnegvoQ9VOtpwyz+SWxd2AwmpPBBSUipobSdVUo5qOa+F+o7FsmGJ1I6uVi
	 SB0Fw7f3OiMDr29m33K5RbkjHLfpk7+6CWaaGMqCS7zdgHGJZN8VDNdScRuV/r89aj
	 TbnDkkA4hHl5rkgMShmuwEYdiXXP/o4wmTJ3r3lN+KYl+2Tq92fZTWFBI8YEK+f31T
	 pcPG5co9FMGSJHrSErxRam34rpBECpzoEFU5eAOk2OXvnsiUaClriCU1dHlkKJA0/2
	 qxagxr6IFp1PA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so492874e87.2
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:46:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqFIAvLIe5IooKj+H/2OdHjQhtBmxtoHdYazEDCE9CMU8+jgbpgxu/9T07vBllQu/a8scU2WFuEeFLpfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXz05pEVWhWBTJAQvth8QS9vFbxvhLvwxOhbR8yG2i3RVOYsTl
	FkFRGR2RAbGiqkfO1mGCHdnyFGJSKAW3hNmVWmqvSysKmKSPve6qyJSsZNcdBLTGix9LVVOfgK2
	9YNLedyIRyC3CDzHDkfWVJXOkSBAlxug=
X-Received: by 2002:a05:6512:3d28:b0:5b2:b7f2:f7fc with SMTP id
 2adb3069b0e04-5b2d0274201mr1124477e87.59.1785311215686; Wed, 29 Jul 2026
 00:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 29 Jul 2026 09:46:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLkRsHTL-vy0BcKL80onEocp3Js7UKgx=kKqFn8DEH8H8g@mail.gmail.com>
X-Gm-Features: AUfX_mz6x0cLcw53qb2d4v30_RvCZ1PIlNE2O6iglWvSmm_YIQGxQudd43yM1KA
Message-ID: <CAD++jLkRsHTL-vy0BcKL80onEocp3Js7UKgx=kKqFn8DEH8H8g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Support zinitix touch modes 0 and 1, dt changes to
 Galaxy J6 (j6lte)
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Srba <Michael.Srba@seznam.cz>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:24=E2=80=AFPM Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:

> The zinitix family of touchscreens support at least three modes, called
> 0, 1, and 2. At least some digitizers (including, but not limited to
> ZT7548) are able to support multiple modes. Currently, the driver in
> linux supports mode 2 only. This series aims to add support for modes 0
> and 1, accompanied with necessary architectural changes.

I wanted to test the patches on my hardware but didn't find the time,
anyway it all looks fine so it's OK to merge.

Yours,
Linus Walleij
