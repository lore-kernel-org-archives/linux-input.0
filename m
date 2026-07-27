Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57E3DEFF1
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138467; cv=none; b=pEthQiD+I1g5jU+nS+DmN3yU19q8Iiwy/0sILrCf/nNMghlcCyMmCG+Rm+zeCDNIAwXeY/ZkARKxQHIjhpjD9Upy6cN4YEp6PUzc93fo0pfCS17NBaLWei6Cr1V6bSW2Nt3QIvkILjBfej/nXSyjLvr17kpDFVQikN+Kwt3FQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138467; c=relaxed/simple;
	bh=JvxUq/iYUDkBFhAJpNpfuCTuKCodr+3K1ReumsuOTW0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwbkoJr1O7PXKMbZ+K6d63CJp/DzW9OAbMM8GO6x8oEcTeeEAIjnAir4hFOfZ9+22e0v9YFrJEt81n8mnTx4Ak/qpsmRL9VKJ4MIf9pi6eHZdmpIxeMfaWpv6dMYZUoUk+2rTxdlWKzZSJTpLsP0NzyIB3fwyHSLu+prMTC7fiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dygOcY02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dygOcY02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C31F00A3F
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138465;
	bh=LMdxTbEBC7qZA8RQ+1HVgfF515tY7oL1xF/DhlIoUos=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=dygOcY02z65llyPro+EJYoL66pSoqnqRtqA7hO9haGLtHuaclM9d/KARSLDqfwdjI
	 w9+dW3FenZodTOtTUiCF57+wQrbKomlgll2CtIOi9MEC1QhpTiqMdB+OVDoNvPRqYb
	 qN8Ne/nTkeqptawc+MXlfkOAN8tvVBwTG+HVbaigmzGLnZnA/busJJcrOmHIV6BH3w
	 FP5pEfe9MAtwIlRS3VGxiefxfLe6LE/WzQuSfOoS8fKW+QS/lq1irtmn6F/kSuChCt
	 YAjcNbtTOH33M3JO36cnc4tjJuIPP+cXefQk62zqh8EwWEQumyr+68B6dpePIkqAjT
	 1R/4XGP+4XDFA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b2aab18795so2282554e87.2
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 00:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RorV9vHt8N1dN2lwLkb8WyN4p5Rj0bFviEMKKeozjUE854eC1zDnck45F03R3iPaPP5JbZS62JIj/P8QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweBUWTYUJeii/o/go7NfYMvUtZeWi84nvuhTMxXtOd5pxC9lZP
	KmQNm+JmZfNyPt5a7r34HfmRcO4xtTQs7lHvEwvHkTe4tsTRShRrMrOj4KrodYWmidLYp6o5lgN
	Kw+ngxitmdK1G8zkFpIuM2RrdYY/S2izfWJIULu+Trg==
X-Received: by 2002:a05:6512:1191:b0:5b2:8a6a:1dca with SMTP id
 2adb3069b0e04-5b2c1b297b1mr1336942e87.36.1785138464623; Mon, 27 Jul 2026
 00:47:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:47:42 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 00:47:42 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260726141029.GAamYVVeVnJfH5ebH5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726101739.33170-1-farbere@amazon.com> <20260726141029.GAamYVVeVnJfH5ebH5@fat_crate.local>
Date: Mon, 27 Jul 2026 00:47:42 -0700
X-Gmail-Original-Message-ID: <CAMRc=McOT6m1CsmheePCxpZnB+GJmrqYa+D77Dz76Ovy0FPadg@mail.gmail.com>
X-Gm-Features: AUfX_mwvXfjV5Db7FPNy2PNZM2AvQmMoXAOyTg5q8xJTdsDrQvC7kqKotPet8MQ
Message-ID: <CAMRc=McOT6m1CsmheePCxpZnB+GJmrqYa+D77Dz76Ovy0FPadg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] notifier: add device-managed registration APIs
 and convert drivers
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Eliav Farber <farbere@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 16:10:29 +0200, Borislav Petkov <bp@alien8.de> said:
> On Sun, Jul 26, 2026 at 10:17:26AM +0000, Eliav Farber wrote:
>> Many drivers repeat the same boilerplate when registering notifiers with
>> device lifetime:
>
> From: Documentation/process/submitting-patches.rst
>
> Don't get discouraged - or impatient
> ------------------------------------
>
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
>
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> 						     ^^^^^^^^^^^^^^^^^^^^^
> one week before resubmitting or pinging reviewers - possibly longer during
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> busy times like merge windows.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

If the above snippet is not clear enough: *do not send three different versions
of a series on a Sunday*.

Thanks,
Bartosz
