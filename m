Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500D3A839B
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879250; cv=none; b=cSfk8P9L+fISWBBRAIrmOyEvt9z7uHNpy7GiFCDyg1Ybz+UGFbf+om4O7nyAzzL69QBWXOW4nzdZcY7xV4MoW5D5/Biib/8fNaSvtm0+jH+h3cjABY5V0WX5UGjkDOJ7kfvscZVejs3o0sdI+INPLQp6rJf9tgP9fiqMSHWkOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879250; c=relaxed/simple;
	bh=/BUSaDXK6r6Cr7G8YfpzDdPRTV1US3eERUWJZVmPUEU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvLRg3MzSingQ/SDf8o/9oil4aJG28SkYydqmpyRzOfgSU885JdIerAKkM94WCufuprWcM/OyGNyCoI+vND2cz6X9RhqSD+XRV4+hi2h+qbF0VlONPWt1e8miY3vPRSD+TR5NT3oyZOZ1C4a70/xyAdXMZUURMPfZ5jIX4fVd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwnOTDJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwnOTDJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757C41F01561
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879248;
	bh=/BUSaDXK6r6Cr7G8YfpzDdPRTV1US3eERUWJZVmPUEU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UwnOTDJfeXReRsjs0t8RcPUOPmbDUJdN/qDoEw1H4RV7wfK0tdKY+kujNxYO8ZjnF
	 Ol2NrF4pvuTNvEEzPlMIOAzM0UAkfrPcm0Xt7qe19tlw9db3GYG7kanASwXPYtq3xn
	 GNQmexhHw1q/+Sqn1T2slKo6rPHNC5CwTW15SDJs0hz0eEztDxO12l2ytDuOzUzFls
	 hQAZES3MeffIlWo2k+CjZyR5maNgS6Y+4Pa1YSsKxgadyydV9PISfCU38i0w4xnlZm
	 UkwBugy2BQBPr0qcNsTVm0AOmNwgnbJmVpjkbQ7UyLeM7iH4QCIh2wh0g6CwzVybYv
	 Ua8KSpk0/h1Vg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso717031fa.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:47:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqSAl5BvFAinWcnT0ESOAWTHmI260ynEbB4lLx6Oz9E1lL09pCYKBYHo/SE5WIC4FloFPdO4wcqL9GXbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrocR30yJQ1b1GmEZ+agJdVy9hgj2F6lu0mrIBZ1NpjWV9re5D
	Smn4wLkOOk2umeOzrCEgSQxihBSwFaHG/cMcj+Nxy9x52+7E9vXjaWd3livb81MXA3HS4cSvETh
	9fGRzMCrtbPLtELl0kDhsmiOBuhCwyfTKe75elLN4rA==
X-Received: by 2002:a05:6512:1503:20b0:5b1:5451:d969 with SMTP id
 2adb3069b0e04-5b2b2e57394mr897148e87.25.1784879247206; Fri, 24 Jul 2026
 00:47:27 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:47:26 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:47:26 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175513.39849-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175513.39849-1-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:47:26 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeGKMQJwZyaqfe+Q67nRMybNc6Abmd7EEUbUDm28vAfDw@mail.gmail.com>
X-Gm-Features: AUfX_mx-B-BkBaHknNcFawRpyJtwmEcwMwNOLJMV-ettmOBp8_38aq3y77GfhSI
Message-ID: <CAMRc=MeGKMQJwZyaqfe+Q67nRMybNc6Abmd7EEUbUDm28vAfDw@mail.gmail.com>
Subject: Re: [PATCH 05/12] gpio: adp5585: use devm_blocking_notifier_chain_register()
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

On Thu, 23 Jul 2026 19:55:06 +0200, Eliav Farber <farbere@amazon.com> said:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_gpio_unreg_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
