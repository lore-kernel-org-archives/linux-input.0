Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147A373C1D
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879232; cv=none; b=o3n/tb8iKlOml07U3Uv4zNUYrK6aqcl587rvu8kHy5KFf79M1q/1tyBaxVdGcR+cwbVSKHD/PPbOpadVWJMMMhza3EZdiru25r/LEA6PcVoRL7ewahXYyyhJjn3EmVTG0bbuYhPpBmqHVUvOHNCfJKmHT4Bx2wqofxW8V4+57Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879232; c=relaxed/simple;
	bh=VKvmsdynWHHxiKiqHSvpoY73jZ2qPZhhyWjJeUOOmGs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4YB2g/FQbvIFVPEYmHVlzQbxKUPjX8n4ZGKWR51MME/2G8uJmO/t9xILO5sI27YiDn85Q42Pqx+t9G21ZAz6BNRwWiEgW311mnbTpDu0W9SI2oJZlXKUHtS4RPYK2s73mBpFV6sAQFU7EuX+oVBFLe1mXqtTO9YCUICcsF6mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9guBN7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9guBN7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A7C1F0155C
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879228;
	bh=VKvmsdynWHHxiKiqHSvpoY73jZ2qPZhhyWjJeUOOmGs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=V9guBN7tXc6PezDLLrSq4LgmWSQPsklFPdtlL6qlf2qvZocMYqJedRuGf1+z9//Kq
	 pImbUi327ONahpD34UFLzmR2VpJq+oDArf+q3/wye3zzaU81ZjF8vTzT8f3Y1S6ALi
	 flw52y4Llyo0LN1dmPXdkSMZOBQ0v0WY+jA5W4+2JIYoLT4DyWiy3blLEqlOvbj7Co
	 6O2bmwlX4d2l0W9NhKjNdhfasIytFe3f5orCcYI+jqzEhUa037r2x6UYF9A+wUJTOx
	 PV83uE0j4vy3ExkEx9QL63zlQVzkc26juWkQFuMdnR8y3n+nz/23cB1LSTDZYX0lj4
	 UowzbfRxigHbw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so161093e87.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:47:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8lwD13WS+25Uk2utnMdLFHVoaUrheiPe3iGqjUhkYJela0ywoVqu66vS82N6VYJdfz/ZJN/MOIWYmpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnPSM6NQthj5cUviwfA/Kf54/evqSeNCvgnN58SRYOq4E79x7
	yy+pjcpfHAinnvzQvyp3LHprG3vGuiOtHqAsSpiqAPxVN0XFwxH6XuXxU7rwpwqYkDdiIhC+F3y
	Uun+23XxZzLlEbLrca6uelxgRAfBu5Vu5orGFNlZSsQ==
X-Received: by 2002:ac2:456c:0:b0:5b0:17c9:a4f3 with SMTP id
 2adb3069b0e04-5b2b2f7c71fmr1094999e87.60.1784879227601; Fri, 24 Jul 2026
 00:47:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:47:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:47:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175632.44812-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175632.44812-1-farbere@amazon.com> <20260723175632.44812-2-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:47:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfi69735cg9LQM0g4Osc6WK4Prux-95O3dAG5Zp3RJv3g@mail.gmail.com>
X-Gm-Features: AUfX_mx79AKNj1qCS6C9H0NjCOtAQc3vPy-utnofV6xM24xjALKd5AgheCkuKq8
Message-ID: <CAMRc=Mfi69735cg9LQM0g4Osc6WK4Prux-95O3dAG5Zp3RJv3g@mail.gmail.com>
Subject: Re: [PATCH 11/12] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
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

On Thu, 23 Jul 2026 19:56:31 +0200, Eliav Farber <farbere@amazon.com> said:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> gpio_unbind_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

This could conflict with the changes I already have queued so either it waits
until the next cycle or I'd need an immutable branch with patch 1/12.

Bartosz
