Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA93B4E97;
	Wed,  6 May 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104820; cv=none; b=K9fT4fRd2vr76hta9aFIZGYO/bYQbU8wSFeK6NrzMZDPXiUi0wgASFryR8hjpb45UVh8TUsjLe0O/Cu5M5ZAI9xtca7YFnz6dLkzg55rZT4nfcRGveMenU3FayNiFNkioRdIivgUpCgesKqitRLNGQlSBaKdEg8TSEPdtLqx76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104820; c=relaxed/simple;
	bh=pRk+0GUsP7OxDUKdiRni4/QgRg+s/d3zn8yZDYP/Shc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc8VUMsUNlrfRXWeyLiyPiV2Jt8064E6MdMQjWW2qlRKNo6BSQQ9+UZ/jEfTvOdzqRGvKuVRzG3Np1hn0JfOsrURM5K3NBZgGuo5d6aPLPLpYaPywPIm6RB0bzRevD41gLM0f/6irpAgnFcquzAt7NcP6En/Mnltf/g9mkfcuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3+hYISfi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3+hYISfi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+QxodlG0Uok48ATN92m6eCENYUT3VVrtU03JGIKfWIc=; b=3+hYISfiHah3lE1wjrd1S/RpQQ
	dMzNtURFy2efgQc0Pp70abOdWV9C8sssj2XPUVbONhA3mLtA3RYr+t2dZ6/mM/of4GtfP4skTydvW
	7GKTNOC77g78RicyrgmDTsW/hcuo8P9QVpI63S9fkgzfIUTqFgRtci6btP1OrRH8ge8Lz+rFONvgK
	s/w3m0Kb0jWsGUgfHgfKXqzZc1hM9nCq339/gwPsGM49A55suKAs1/KSKzTh/vkTXeh1x51jGdPLc
	9fHNz0Pj2mT5n2f/YbDerWD0nZFtk4kXXh8ZpzHcfSTpW2vfNmibLZNsWqpBdkkOg68hG3X8YVVH2
	0BBXUF9A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKkHr-000000029LG-3mzM;
	Wed, 06 May 2026 22:00:11 +0000
Message-ID: <74997f70-f9d7-4a9f-b781-bc977ae54c86@infradead.org>
Date: Wed, 6 May 2026 15:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] HID: asus: export asus_hid_fnlock_notify() for
 direct fn-lock control
To: =?UTF-8?Q?Marcus_Gren=C3=A4ngen?= <marcus@grenangen.se>,
 platform-driver-x86@vger.kernel.org, denis.benato@linux.dev
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 luke@ljones.dev, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 jikos@kernel.org, bentiss@kernel.org, corentin.chary@gmail.com
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
 <20260506193326.5862-2-marcus@grenangen.se>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260506193326.5862-2-marcus@grenangen.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/26 12:33 PM, Marcus Grenängen wrote:
> +/**
> + * asus_hid_fnlock_notify() - Set fn-lock state directly via HID feature report.
> + * @enabled: true to lock fn (F1-F12 primary), false to unlock.
> + *
> + * Called by asus-armoury on platforms where the WMI DEVS path for fn-lock is
> + * non-functional (e.g. ASUS ProArt P16, N-Key keyboard product ID 0x19B6).
> + *
> + * Returns 0 on success, -ENODEV if no fn-lock capable HID device is present.

    * Returns: ...

> + */
> +int asus_hid_fnlock_notify(bool enabled)
> +{

-- 
~Randy

