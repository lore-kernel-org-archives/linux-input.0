Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BD3AE191
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879192; cv=none; b=kzPr2IBOVliOUhvwRoDJh5IDXQaE8W7ymCSyThtEyUnY34bWv0wl0stcjjVBDoNlKMi4EmiU9A4+quFcJENpZcAp4N0yKO3JobCGRr8uE+qElBmg7THyTXf7BlBvts0ZG6yDeQFeo1JbbpTk0oMDxMhj8DOr9JE85wrgNKt/vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879192; c=relaxed/simple;
	bh=q+SoAChfHihj2C1OY6mAEkJV8Ndl18NofL/2g0AVns8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvvB3jmIrDIkq0S2QJTJsYO/JcXFUZtlRLhRbhHGRNzeoObGAtaBzB83qF/hmZX5mTgzRgMTY4f2xgKm7FwZw2vekCDQPUcHvOqWZNVoih0g2vyvvhqkhTjJkNPSRKPwTkABemq8+umliE9mvrf8bD+4VSrmDj20t4V4ggUvW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRV0nOdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRV0nOdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2237D1F00A3D
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879190;
	bh=q+SoAChfHihj2C1OY6mAEkJV8Ndl18NofL/2g0AVns8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TRV0nOdfcybaTzF2XN+uSDKG/q0YmUw+TY/hMce1fU9c9WVx8GLRSern/xD9hiNl8
	 s43vmxoCYlnzJQSanNSWTLCXmZBcvulJqItHzF+Bjw7gKySb+nj9RU4yH0Xf4utZkh
	 fqHWMvULRIntJwY2CszZB9x+3t/Z8FLuFBiXUUFbYyEddsdGTxexvPpDD6oQ//2V78
	 wZ4pm2kO4BgCYwWeID0w9C7N2rgGrfIYcICojGvOa+KGNdEMuLpgUuRqfPVLHkjRuM
	 zO4HiCMoTCI2YnyYgXD0UgQc7HkoMg6zhe3zRRBMYjzTuttKfz0amGC/OHtkSclSxR
	 VB8IWN63Xq+ZA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeba09900bso105714e87.2
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrw4aP3dBYmaXqxWcytvn8FyX7thy813k2pfiQhOzkTOiYmzLmQrtpreVo/h1rNKzXwagoMySUAarrC+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57mPohEXqP5Qm+BUsdNbBcfHHZ0++HHUpZ/rqRdKL1md3Qmd+
	ieDFEcwmAMfLwhCI80uvg4trpjll+xuUcCkg1CScI01s/9gGbD/ci1jZUTuWwLmLFCFF/LKqbRR
	4YbLMR+8uvdMmO+HMBJOhHXkp7JgXms2sIiyr4uRBrA==
X-Received: by 2002:a05:6512:1518:20b0:5b1:5351:712 with SMTP id
 2adb3069b0e04-5b2b2e59542mr980925e87.28.1784879188912; Fri, 24 Jul 2026
 00:46:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175632.44812-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175632.44812-1-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:46:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfmFwx4U4D_FXMUyf-jVh7r8nWvyxJE2yi1LEkUh9ik8g@mail.gmail.com>
X-Gm-Features: AUfX_mxVD-CwkTGspLVy2DW1kerTLycxmmZGgKBMf7USBKBu13VE2iFPbK51l48
Message-ID: <CAMRc=MfmFwx4U4D_FXMUyf-jVh7r8nWvyxJE2yi1LEkUh9ik8g@mail.gmail.com>
Subject: Re: [PATCH 10/12] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
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

On Thu, 23 Jul 2026 19:56:30 +0200, Eliav Farber <farbere@amazon.com> said:
> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
