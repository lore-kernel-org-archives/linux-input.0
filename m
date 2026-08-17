Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2343FA5E7
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968742; cv=none; b=S1udan7QmGJ79nezn5zluu2yDg+RUE9IPy87PWSetC7o74d8ETBgaU5Col3aUItiF/a++UG27AIu9DFcQKwB9sPIAlDMVjd9igUQyTFwQad1fmmyUSGhbJknIcDCtCXuK1mdbHAQUSEjAxCDMbGwK0D8iE+6ZeoVY++kaAnA5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968742; c=relaxed/simple;
	bh=DEkbgaD44ZoggJjAhvSo/y4n4yYMUEQL8GL/jSTDmCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlWMcdArxHF9h9t+DnSwFhY37/9LweVvIxbCYJlCtktWiXk6ocORn/qbHb/M8RA6oRuW2droMn7coY9eZAmnwMb1rRXulPLfbJb/YVtPBymMkVqE/+l5qeOFi/3GwDcL5Gf9qeo3ug4OShalq76OC6k2rpQVYRqEdca/s3oBuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHHpzJw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHHpzJw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7950B1F01558
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968739;
	bh=DEkbgaD44ZoggJjAhvSo/y4n4yYMUEQL8GL/jSTDmCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AHHpzJw/qNymPPxcwejiU1TSYVPrw75zTUfA1EpG/cwFIMpBp6RWuJo5d/JSJKn+J
	 VnvdIj7gM+DO26Dkn3jF33jvGb+3E5NhHjHeZL48cLydPwfC5FbQuTjfkXl3zTKKZT
	 0/6ihsPrV+bOrSBeEhEKi6Z9SrVRa2k16DNGD1NoogZgkCtWpgnGXCInd3kMNhd4SM
	 EFxY7gu8TX/lsH+PIazVacXW0ouSzSHtUJ88IQ0FtLnLuJem6Te9UF1HqE2kDSa15W
	 HifVXltxSO+o+mb1Dj2DYaKWEh/oHL2PVT310EaeEsG6Om2PngrPr6XKntT8EcP3Cs
	 ZnUoauAw5L1cA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so2867960e87.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 05:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqfYcJ7LgYP5jsEbzuBFzB8evZhs68rSHZ+wrPXjjqrmc0wDIFOrH5VpBCOb6IF0BMTyex41yeNgKYZxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNd2+w36WMTBqhn93uZeRHExfx4JcvwKnfyQnB13qUnr/EvE/
	ysK9GEkkQYyT0zsgOpb++UNkV3A+EzwHMWU61OY4j+aEHi9xAL4xALOeUjv3JpGe1y9S06GGCh0
	Dn0nBfqIlioyziOhkmYid48cjchfAX1I=
X-Received: by 2002:a05:6512:acf:b0:5b2:b808:6913 with SMTP id
 2adb3069b0e04-5b459102739mr3660264e87.11.1786968738185; Mon, 17 Aug 2026
 05:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-6-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-6-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=_Ajiq=OCS1zOjYJSmF_A6hvLWkLeDq1sgopv++sD5FQ@mail.gmail.com>
X-Gm-Features: AcwNN1WwEcW3n9VIxXHtEWS4W77KSOONP6e7TWlR43QzddLucvP_-QdrsayA2i4
Message-ID: <CAD++jL=_Ajiq=OCS1zOjYJSmF_A6hvLWkLeDq1sgopv++sD5FQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] gpio: adp5585: use devm_blocking_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 8:08=E2=80=AFAM Eliav Farber <farbere@amazon.com> w=
rote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_gpio_unreg_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashikos comment is probably correct but can be fixed in another
patch by whoever wants to.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
