Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25A1EB19B
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879179; cv=none; b=pjMs4er09aj5yvTGJ7LVQO/b1JzVqBZx3ciHfr8NItj8mFHCw1LRd0z6dx4RUpyKveSq6n0SIpBrsdhrazCgz7cpqcg8eMFruQSZOh2gaOFvgMlApODSWDV/KyEzCrKW/nrv0gP1LJAoyf3j7kXqyGn/heFKlpSPATyqxbygTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879179; c=relaxed/simple;
	bh=j6/fHiKSlowXTIF7ftKZpJh31EB2s4w6tFTulHJrrLY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beKJ3UC7hPhJn+/LAhxvp9QhBNV4wI0QpyBLKSpP3NtXtz51Ou/jr8Fqc/OoUUzIWBtPqO7DMR78h3zdExyWIdPN4TFqC0BiUtZG+AnQR8L4RluWIMD90tPiUglY7I8u65YvZg+iMdFupfqRv9x5GdHTgRfiXCHY/93MSDQtVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9gC0Ih3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9gC0Ih3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638871F01559
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879177;
	bh=5WZbUGleVOSpBn4ZbRf07IEslchh3FUMGtTBiKonZI4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=F9gC0Ih3uso9K+BAgneoM8/i0E2gNCbRw2vhrBcx0+p73hOAQ5c5RVwapUtWxz1IX
	 zhwtkluKWNgk8mAFjcWtY6Ig3at1MVIf5/LAAu11kYO+8O1McBxgs1R/abRlypiJq7
	 e+f8WjUMoCbjLIuhh5k+tyMtOBAPF3etShNz9uVpZ/vH44m+TksFwls/BQnKtLhTn3
	 +axbIP+Q5S95nnR+movpEvYr+mBDh/g17LVQlx5ySTDcfkqmxHEvo2S5r33JCge/cU
	 c3uuwuHyB/8ounaWJwmAbKOxcDf40r/kdU7Bpq5nLbt1CWGaX6WcMKrdPXXphcfkLI
	 pUM4MErClGQ9w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so1245181fa.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqRNJywgIwTHMq210kewDe0WeeFr8rKRhqBsH0eXTa08Yj6lXaU8U4hm97ReN0C4PNeE5oJbRaxkdUYQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpla86bTZ6TDNKa1jv+cIZz5y15t+V6KFBoll3cPFGKhb+7a7
	g/u/ng8Zn9aGsQkNMuiPk9wQKTuaqEHzkI8UcFbs+T7VRNTIZZIpwHs2upeCXtsu+R4r529IydG
	xTya55U0XDzDB3xSUGpI9i4y/WnXe2s+qv7iZBX1c5g==
X-Received: by 2002:a05:651c:2cb:b0:39c:9241:af75 with SMTP id
 38308e7fff4ca-39f07c8c174mr9612131fa.5.1784879176135; Fri, 24 Jul 2026
 00:46:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:15 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:14 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175325.37397-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175325.37397-1-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:46:14 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfw0OXWF_1yU=5mBuXJscDv2H+JP1n4YicDUeMLwfjibg@mail.gmail.com>
X-Gm-Features: AUfX_myaS5o5pZ_K1kZfydIbb_RAyDJwRVdT4TDBui6jxs8IutTlBmRloNm5ZKw
Message-ID: <CAMRc=Mfw0OXWF_1yU=5mBuXJscDv2H+JP1n4YicDUeMLwfjibg@mail.gmail.com>
Subject: Re: [PATCH 00/12] notifier: add device-managed registration APIs and
 convert drivers
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, 
	jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 19:53:13 +0200, Eliav Farber <farbere@amazon.com> said:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
>
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
>
> This series adds devm_atomic_notifier_chain_register(),
> devm_blocking_notifier_chain_register(), and
> devm_raw_notifier_chain_register() that automatically unregister the
> notifier when the device is unbound, then converts 11 drivers to use
> them.
>
> Each conversion eliminates a per-driver unregister callback and the
> associated devm_add_action_or_reset() call, reducing code by ~15 lines
> per driver.
>
> The implementation follows the established devres pattern used by other
> device-managed kernel APIs.
>
> Checkpatch reports 6 CHECKs (0 errors, 0 warnings) on patch 1:
> - "extern prototypes should be avoided in .h files"
> - "Alignment should match open parenthesis"
>
> Both are intentional to match the existing coding style in notifier.h,
> where all declarations use 'extern' and tab-indented continuation lines.
>

What is the merging strategy? Acks and all patches go through driver core?

Bartosz
