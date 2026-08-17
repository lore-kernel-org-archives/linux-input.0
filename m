Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228D3E95AE
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968769; cv=none; b=NRXhzzGyR5Jrs4ynOn76fNkXwYaCO13XbUADnDy/eC0mATumAK2PyG2X8h3wt6hMfWKuFVk0fuf2D2Q0SED+lsZAlvNhPfcn6HPLi+71gK4bvbBB/MesjKWZ9a2pyVAaxeqr83bg/dtIYHZCQdBvHRRFZrvkeBkThWA0Df3E6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968769; c=relaxed/simple;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTiMVsMk3FX2a9L5MGfXar9W5Stu+IEEXnbxIeJnKNr3l9dRByT1xbXCcicPFugY49HuMfnu5wJhpqqLWrFup7VAYjeCVJFEO4HwOrSCkgNQ0/C3UK7CYyBLX5jJtwPOaO/gjCJ48ITi8dcmAc/DfX5W3mGyrQrrN1r6XablA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifDuM5Vw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifDuM5Vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74CB1F0155D
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968768;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ifDuM5VwHxUSb/StIYGDd7jesHwIYBIScLI6ScgI6+LzbPqLkzCNcSi7UsoNiJ2R5
	 PUOyp5gTEAZPBNlpRlmzipD8e0Ke4sQreByNHZ0BcAi9tpTVBxzjsx5aqS+TNXbGFT
	 IrCp4f345rbf3VcguFUZeHag1S9tTljAKt1o1j06F1rHX0bsqCWnGzPJLqMFZFSiD8
	 wiVowB9iX9UtG9GZ2DEPklyslSfEjq9bEuAF12e+WWjnxFBcoxyPxLrEviT7w3TK1o
	 sr326ThWj8A7jNlxhXFqfUtjbjPi2c5bMA7InIOIL0EBC2bvGUDfsdIDLl7CZyJoHl
	 47qegal1UJihA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2811383e87.2
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 05:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RruN4YfQPxoBCA0Y15jXh87L1FeZhiHd6htAod27PyHJTR5D4NEVG+p4HpJpx9ddbI02AP0BTZMy+3+FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbY3u+9jKd7LUcz+RkgvkVfcesTYOgcu0B72dNMiSwpRfxCH2
	QiM9zsuDDlsGs8y5IHBbHt7YZZdqyiOIk3RD7N4gliFEegaKmEpTLXxDBOp5UAum9CCpIA1OGpM
	IXSxg5yuIY1Ly6LHRW6N9DYl5oTVoNQA=
X-Received: by 2002:a05:6512:3985:b0:5b2:a55f:2ce1 with SMTP id
 2adb3069b0e04-5b45918bfbcmr2928871e87.37.1786968767385; Mon, 17 Aug 2026
 05:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-12-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-12-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:34 +0200
X-Gmail-Original-Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
X-Gm-Features: AcwNN1UtCvrDpVC9uuvoUfBmhVJEvfMufMk34D8Z0GoJ1ENEbtfx026qmqKhJwc
Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
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

On Sun, Aug 16, 2026 at 8:09=E2=80=AFAM Eliav Farber <farbere@amazon.com> w=
rote:

> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
