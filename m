Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375635AC16;
	Mon, 27 Jul 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121991; cv=none; b=lD91lxVaZYXoITJHICU+QFM0KlEvsn87G3SaDrem4bG3fTNC7bmoGnxa8SrGxjHJjVQZz6CbY03R0l75Rz2TpMvYX7JBk5+wYW+ho73MVta2COzOowKMZGuNicxz4ZZq4+9T/7c9kJ1oM1pa6spPcWplZt95xDS0O51bKsxJrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121991; c=relaxed/simple;
	bh=0ckSlAeWZGH5WlXALnVcyoq46mz5u82EFT2kJklHZU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsEysWAWOzsFjkRRxHygTy+T7DjJLCj41K+naLaHiLkQcq7qvQ519GMXOM4w1/QPvplFMGh90r+B3Vhi6vOYSgNSqb/YEebhu5YoP4Eqsp/iTNRLZZRw33I8Xdq0htuztThpvA5ob5MKr/LhcWZGo8Sz+7OHcWPdA6EbmULM8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C/x8z990; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C/x8z990"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785121982; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7cx4tkFQnMb16XGT7+w04RZ9UaK35xZo714kCs7v9gs=;
	b=C/x8z990MuNlFZHqz9VsYV1dcwr2dQYTn0xwPYRzPJtpF0/e2a5IhfcH13lgOvy9z/XReZdQFazViifq3/Z8coC8wwgQy+zepWHOztpUBv+mlh7exhDDwNZF9pVXlfMFU5qZt3atPGRN5Edqh+LJLxLIKO1iK8A1OkUoHEoaU0U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0X7ojItC_1785121978;
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X7ojItC_1785121978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 11:13:00 +0800
Message-ID: <db3ecd09-fc0c-4bb5-a2da-422c36a2feb4@linux.alibaba.com>
Date: Mon, 27 Jul 2026 11:12:58 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] gpio: eic-sprd: use
 devm_atomic_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, lenb@kernel.org,
 laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
 orsonzhai@gmail.com, zhang.lyra@gmail.com, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
 kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br,
 paulmck@kernel.org, frederic@kernel.org, kees@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-12-farbere@amazon.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260726101739.33170-12-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/26 6:17 PM, Eliav Farber wrote:
> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

