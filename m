Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E140EBA1
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968793; cv=none; b=ZB+1vzVOe5ujUVOtVOe0j8Bxp1tesyZJzI9hWzOQ+5QWwpHLOjRTOel3y/EueqB3WnQjcJ7Blsgslh4UZyW0+k4dFww152r/mm+eT5P8K5xj8QWhAzfRIFmzS77+JBlT2pFl+l1mbi5x6ZVrb3W+Yd6mfdcVL1iFbXr9tVZenQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968793; c=relaxed/simple;
	bh=fDvF2o86CpX/eUBAtOLTtFXPtLP8pTqWPEOo7SqLNmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tw7T8M/6t/CjpSvmCQFnzuhZiZfIrAxV6ImU+2efF16YPu3rxi6q7E5rQHyDKTozcvB3er/QaGi7X5xvCtOCwZ0gUd6Q1oLRv6eUw92wQO4VnmDO98xMUUkcyzltNRrs4F6BZpmJxChJNgQpCYiOAorydu6Zt8AOUGjNeb4HxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOf6Mp7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOf6Mp7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF971F0156E
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968791;
	bh=fDvF2o86CpX/eUBAtOLTtFXPtLP8pTqWPEOo7SqLNmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FOf6Mp7ILFvlN/SPCqPK/Jo7hW00u/svsJhDlq66Q/HdlgILeLy5JAsuwpmoo+RpY
	 DSYr+vS2b5oCH6L1myCqKIrQL+WxFGdKnmv80vGxnF/13FanSSnegotPCaHWHfI7NL
	 M4yA+1pMbFfRB0Gp6iqtV/r9d8mg32jlh8ZC8QgTOkFtp9TD1w1C2/WcDkb+kJfQau
	 E4n7yngqwuFOgwD6WZ0O0gvxmkRA5CPoBbAPo4lQMJuAxiK2gKB3WjtpaUyJfB+enX
	 ghT9bCcNAQf8oHMMFeZFgFDYPYgaKsfAiXOKvgittj4vO0MpZWIWF1auJ9Mz458iB0
	 6/WQ4+wnsNp4w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso3782525e87.2
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 05:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpnX+k8H6WrjvUSZBJFpZtXPfV+aezdE9/asEmUQikyLvb95iVrXTwFWgUi8a8GR9bDMdz3HQC1Z8uN1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9ZblwHAmi8O4Q4cn6Us2i6gjfabona8sBxwEJclV+q79aNGb
	GI7MaD0kMm0v/1bquESh5uFCfI2/z1oHBpJRsZXwa6mZfZ00DlacD5jqOQP9qrvfuaB2zEd1/KM
	YfJiD2ofyCnijR/9ZShzCTgjVjfR5+iI=
X-Received: by 2002:a05:6512:2382:b0:5b1:4c6f:92f9 with SMTP id
 2adb3069b0e04-5b47067f197mr7540e87.20.1786968789825; Mon, 17 Aug 2026
 05:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-13-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-13-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLn2V3DP=8qQmkKo0KSh87ZdjHy6XGn2DeHdL-Ui0_OM=w@mail.gmail.com>
X-Gm-Features: AcwNN1U4JrOxzsv9KlcvcECVLI6UdHKCqisJUWamsMkkrKOZr3X21Ct07ozVb8o
Message-ID: <CAD++jLn2V3DP=8qQmkKo0KSh87ZdjHy6XGn2DeHdL-Ui0_OM=w@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
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

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> gpio_unbind_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
