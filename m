Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE5371867
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157537; cv=none; b=j2RH95UKe52RtIcy9VxGfOUvKOMnXeCgJYVXPpIiPrH240aoqmig/2KC4iZaBNG3Ud+TmlTMwNPtqCZUNMjVupmCYdE0M4+4T6EKrdXTd7vRgcT71TI0vDT4a4LeNB7SpU1vKQvDga2hTh4vbYo/d5eKj+IsQIXvlECRS6ZQ6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157537; c=relaxed/simple;
	bh=F1IxYhAPqVZmHS6mi7kAQp4Eo0e2Ol8GgBG3I3PWaU4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwiPfagDXRZUGYAkmHYkahfZyARH9RtUs8Q0ZR2J2B1Y3gX5i2fUYp5rGOn5zExWeOWeBn6JtJk0DM9nGmfvfXXhTLg87jycr2g6Q+jwCdbKgCFTmjLszHEIo4m0nAYtlVsSNT0j0x52ug6LDCDbOceNMf+6vmIgEAkIKN/l7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiauvbQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiauvbQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAFC1F00ADB
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157535;
	bh=F1IxYhAPqVZmHS6mi7kAQp4Eo0e2Ol8GgBG3I3PWaU4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aiauvbQKCvcPkjSvA8l/Lii4R+v5S6ayvl8BWwzTyZcR3M28z3DS7RXONG6taCvi9
	 ERO28RLBqBJATKWslAwmuJtdA6iALqszUpe0BXEPkUfqvq/O1Jw4Sq5mlzvsKETHCt
	 f2Rp/oK7ON8h8ryagc0c7V+CmN0IxMKV9aTzVtWHfegLqeGHGCEnmvZjlE1uJEIlfb
	 RonbDVjmUyOxn2ZmnuBh8OVN3NAZLZCXYkGReG5l+t6KFRSmQtquorXTPDKQ71mtoi
	 ILkxAh3B9M3gJMNa8w7Ka96nDnwfb9x5jnBykV9b2VpC+1S47iy2u3+9n9hbLAdDKP
	 /tzXPZ21Jn9tQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso2608984e87.2
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 06:05:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqNw3QtY5h949FG8ycAmvbQHitW2hR4cKJcxq8r7iZD6ZzgciE9P46hLIiPBiRceRowOtCXZEu8Y056vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FrlrO87Vj2C/LGX64a5p5aDEQg2zjhtmQ+vaM7l8PX11li2k
	JTOe92ep2vd7i++/86njyspI9m0E+Wg4CMvBexxpgOJXQ5uGGQ0G79tbs1c0Dve0GEVu68dggW1
	xO12kmMxYFAvinCABZ6BVe/K0rU042Rh7RFJXJFlysg==
X-Received: by 2002:a05:6512:1113:b0:5ae:b998:9134 with SMTP id
 2adb3069b0e04-5b2c1af51b2mr1357313e87.1.1785157534083; Mon, 27 Jul 2026
 06:05:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:05:32 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:05:32 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260726101739.33170-13-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726101739.33170-1-farbere@amazon.com> <20260726101739.33170-13-farbere@amazon.com>
Date: Mon, 27 Jul 2026 06:05:32 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md4FHz3KhFAFBVCJb1+rYA8S506WPrEKs=X2ng6+byPuA@mail.gmail.com>
X-Gm-Features: AUfX_mwa8bywtWm7t0TzzfpEly7iY_KFJAx4fJGIW8nzUJC_flDbreg42-ul5w0
Message-ID: <CAMRc=Md4FHz3KhFAFBVCJb1+rYA8S506WPrEKs=X2ng6+byPuA@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
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
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 12:17:38 +0200, Eliav Farber <farbere@amazon.com> said:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> gpio_unbind_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

Assuming I'll get an immutable branch OR it doesn't conflict too much:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Otherwise, this should wait until the next cycle if possible.

Bart
