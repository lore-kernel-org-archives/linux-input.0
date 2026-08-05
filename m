Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398646D092
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934391; cv=none; b=REA3mA1qRa7cRjSr4I9h+aq/qmSAsqcf/O3lmrljKH9wwUkr5L+id0uwSqXt17pdakhqHaPdaXr3N2fi4rsHxN/a0rHTAByHeEZqM6kT1YWgARFbKQEBKZpDFMR9iLQOjT08uF7+2sZiY9W/gSUGiXof9al6LJ6TBF7gqD6DG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934391; c=relaxed/simple;
	bh=BYe6zc82GTs3J/SUP4vWeJClhRuTndcNfqQt85wuyms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMIKgu8T2wLm8BT3iloNI9/DKMkrge2fIOppdC+9o77wWQB3UgEvtb2hXBLprcVNPmeuYs7Oa4Qk9Md5DNwIO6PpK9m1jC+ICO7k/P7fWj+dAJ9AXL2WUNCXC2IoyboKJ3xMTCKikF5o4g/uglBB4t45qzIL/B6Ke97ALJ6bG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=e1Ty7GZ3; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="e1Ty7GZ3"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6acad9fa466so563268eaf.0
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785934386; x=1786539186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bpxSNiQeQ7TmkvPjHCYe2jjUsLTGYc3Ttja2z5fpQU=;
        b=e1Ty7GZ3REH4oOFzCK4YmcPLmL5ikBo/raQ7uAj23tHE7J3FNOMBvm1L4V9diaYFb4
         WmnOHv2RCTS9dFbqkR5J0rJ/CAdKzc32avRVACF4p3Tw2thyfXSnV/n2TkdGTbDaq2YQ
         LY+mHPWr+N7+KozYgr7seuvGkz87EW+mL/7LUXXBERGO65BOgQEaO2enApfPeBp1DYmH
         /HQxeAkFymaS0wSz8Of1dM+oyZy+V2DngkMDDCS219knNCsXg4N34NMbAoYmgeo3fXrA
         TqjjPv6VVuAPrBiitf9GaOm53/KRSu3dlmRdSjDoHomq8h2w5bPXf7jUXjbZYbhDWD7J
         wUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934386; x=1786539186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bpxSNiQeQ7TmkvPjHCYe2jjUsLTGYc3Ttja2z5fpQU=;
        b=hSpvMJbPwYXGk+DIZYtL7z2cEpO+6/Oz/IvEEdr7tW3NKyxIx/xYkaVf1aNiK7lzSG
         ZdXIs+TqQB+S6miSW1bJynFCR6otuJ+K9WR3hSytQV4Zm6xLu/GNz+PU7XjDluTkNOhh
         HqHUJdWgm+gEkYwrdda/J5W877L+DXlbAqmqkwVNaok0OhbQHrVchdXQTJVHnWQh5Obi
         saidOqt75uW6DhwZ3m4GqTdhOjOKaaarLg3bt0fe20wvdyvgEZj/9Z2zFlpStvSm9wKf
         3Im+YjIKhiDoiaHwz7bHhWEK7TPuv2kOSgmVTb7zbBjh4DUQeUNCbehc9TCHkbgLGwae
         PWEA==
X-Forwarded-Encrypted: i=1; AHgh+RqO5pRlgTbBGGD5TfEr7drAuwsC1r8hR5NzkoTz64p/bXG4WeTywcXgEh+k1x5iq/DTTYnnh4W4tAGE1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjk0LAq4PJQhL+BUrOyKiDc27cVl4LeDS3RZwxAdS+s+ISJGc+
	C1DLx+CXtEnaU+SZ3G+UNFujNsSPElKtOHrpbNBaOtUbFyxbrl68wl379ceFbPtC4oQ=
X-Gm-Gg: AR+sD12xhUAC55pMVK/2bTcaH/soi6Ski2kRw8e/cD4OMNchV8xRD9PAPC4675lpyzb
	RbYqXYMROXn/ICXPymppXKF/O2ONnkt7WvLOxkMFGWNb5tmLZnREr30fAkT+A4X0Z2urbDu6uUz
	PEjiqm8hby6LPTbAAfZqAcqtVxTKLpxFmhDtmzN5Z6x0Tl6xy4PMw/eQvlySYIEnpTWmmggMBN2
	6aZVvWdCMRawp1gTFykjKvSeB09TYcu5cZA7d7X4lXNQMmGLv5uB6/bQiX9X44T6WSpP2+EXumN
	dsqq+aa0Y6jd6KhYROzXNIUHGjqQvK5HLmNM284D1LLpfsAcW/PJUxqqtHHuic9gvdCnp6xCiHj
	LEZ9kqDO8MOjGhNvC/eN67kUt1ya0McFq4zp8Nv8sQDDd/9IAnatW4TSTALbLj9xkeEQK/dNboM
	pGgB23K9tjyKcPsMHCoJeOZAPnPW/5XVv6p41ZNXwt6sYGKNYOEcB/0xgNmHrQBQgnadwaFzqxh
	S4DBA6pwMjOmZsl5KYm2DVJVWheeZ4K2gaN8Vc=
X-Received: by 2002:a05:6820:4b07:b0:6a3:7a25:c09b with SMTP id 006d021491bc7-6ae96ef02c6mr3601813eaf.20.1785934386181;
        Wed, 05 Aug 2026 05:53:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ebef:9550:d591:36ac? ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae94054df8sm2649815eaf.12.2026.08.05.05.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 05:53:05 -0700 (PDT)
Message-ID: <2f9d39b3-efc2-4d50-98f2-71bc19e78ab6@baylibre.com>
Date: Wed, 5 Aug 2026 07:53:04 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Daniel Schaefer <dhs@frame.work>, Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?=
 <sven@xn--vainkla-r2a.ee>, linux@frame.work
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
 <20260727221338.29f1da9b@jic23-huawei>
 <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
 <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 8:23 PM, Daniel Schaefer wrote:
>>  I'll queue it up on the testing branch of iio.git but more eyes welcome if
> anyone has time to take a look.
> 
> Sorry I'm not sure what that means. Is the patch applied or
> should I send another one with commit message update?

It means that it is accepted/applied.

The iio/testing branch is the first step where various CI bots
will do some automatic checks. If they find something, you will
be notified. Otherwise nothing more for you to do (unless a serious
concern is raised later).

And it means there is still time for further review too in case
anyone wants to add their e.g. reviewed-by tag.
