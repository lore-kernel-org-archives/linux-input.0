Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1813C918
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779669; cv=none; b=K5s8Wm9WkmowIAh3O+9ElgX4IECwHUeNRReUGQHaiQ14kFQ2JJSgWV7N2FXIZrKbu1ZNJVlbL7xATFCxCopvaUmXu35dl/lhx8oKYaasCS1XinumCbBFJ5hr5ePNfOq4rzjYhKW1d3qpEc29VzTvdr0YQ1HKWdfdsRyCpVxM7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779669; c=relaxed/simple;
	bh=w+OASR4gUq80s1qt1EdBwvEN8I6E5gpIulaCj1uX/kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsazVZ940Oua4gmJ0GPpFoZweFPRutEitrNgAEN7uxHApcw5zR/+WXAh+HlMxBulFb8pSWKP0Tt0M86ipBQ6bjH9LZp0D/1QmlJpeaPxCPWnAhe1tkFFCxz2d0tdRRXZXUu6+3lTwVsqKVZYaoYTu7cISRmOkuX3sE1SkgC5IB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBaDIe04; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBaDIe04"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304f590dd91so3334911eec.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779666; x=1781384466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VK2W13StNrhEGTuZWNfCX3Wh/LpjhB5vz/xbRiyV1rI=;
        b=lBaDIe04QXxpnCHSLQ176TUGlCQugRbe6ytHGgCxihtZtp1NbIS87YVpgT9uarA4zn
         ZbgiAbkSqVLp2+uQGDt0zkT8HyZm/GzIgcTBxeeD+ILuG9vYUHw3/IV7Vq3cwfI94PNm
         3h1lMXs0actBhRXKiOxJmfRDxjIZ+8pFWFM/IjipWZKXU3Lge9ku7Y+9etNYN2NDtQQQ
         rsVSv0TEb8xp/c5/zy81LLpOQ4BPruJZVM/KJUueRWhRvlVNNHcJbFXKWJ04AidLLQvW
         DsxE8aekAFmBeAqagd/onj9XMRJ759rtAtuhEQHZle6bLDkA+PAVZoI/6DvIb56X5tKS
         pllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779666; x=1781384466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK2W13StNrhEGTuZWNfCX3Wh/LpjhB5vz/xbRiyV1rI=;
        b=IReRixBhEoiI/PHG9nTgfVv4qqh7W+tJhgh8BkNCbkesFTvWVRiYvd7EmZ5ZlzpIl5
         PGGqYaoRKC2FxSKoma6yO2u+WAY+e/DhJppL+LXnk2TkOIQJPMXAHUWuknBqnKuOi9Iq
         yvukMUmfjfU/Qm6aGxbVH2btRHvcNr3HaYh0hZD6p8jRvqvE5dnPUL0F4PcrdiY8V8wA
         jk+Mu36DDWSKHs2CPQh9qh2+nyQKn1+Stk5ff/R9NafFni6NS+vgO78mpWfOFlGbwlga
         sfHFhFz9qLgUX2zISKOcZBmz4RM1TzV++A9VOf+yHKVqLlmPtBPJiCZUEDaNQ9vbP6rQ
         aVuQ==
X-Gm-Message-State: AOJu0YwSA87QUr/53URDVb8bamufUcpmh188RuF6Fqkl35c8opnmbThB
	x1TozP8oM9mS0z0YkCRWEJB0ZS6SfGtCVoiOTRROXeTLUqQTdUoe2ijC
X-Gm-Gg: Acq92OF9U7y4a75jDqc46av8jWHczq17ez27fuWs5+UaoUfjZf4yhMbKA5jGOYj2Ljq
	tjraieJa+I5CgCICh9hA6m2K21l+hSJb61BNX1lDBdyyZ1mtt4Bs2QZzq5R8mzk3Webxpc61NBN
	cLHtPyxSpYYpEUkzfYQEDP0WP2q57i8/g620hg6JvgTFi4O3dlbvKI9JdGpbB4Noifl7qGIr6ts
	jCVOzDbiP7uCdEiISlKDW7zOPBmHhZnLuSJhjCd/cbKkYwcqZC/lPWfSNPcvhsxpJE9lkd3Q0/n
	7nLkqSiUT3kjLct0zpSiN67mb1V/QUvUA0zHOV2duAcUFakRKCzbuMGWEqwHFkJF4SwuPWzWXiE
	BLmFB7deQYJzvuWxhBtLuFDF6RUXPiWDClmGqSdaH3NfmHvlO+nopWU/mt7yk5LBcnVurl4qfNm
	+HpRxb1RwEEHlPSsIuZHzNtvcUoiGmUvG72293m7gBQe4ZpMU+FVDXe1cek5jzPagf/nRXPIwfr
	ws=
X-Received: by 2002:a05:7300:d4ce:b0:304:e2a5:689c with SMTP id 5a478bee46e88-3077b709e7emr4986494eec.21.1780779665666;
        Sat, 06 Jun 2026 14:01:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm15143534eec.6.2026.06.06.14.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:01:05 -0700 (PDT)
Date: Sat, 6 Jun 2026 14:01:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: apbps2: Simplify resource mapping and IRQ
 retrieval
Message-ID: <aiSKijPLq7nMVazw@google.com>
References: <20260603192415.6679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603192415.6679-1-rosenp@gmail.com>

On Wed, Jun 03, 2026 at 12:24:15PM -0700, Rosen Penev wrote:
> Simplify resource mapping by using devm_platform_ioremap_resource()
> instead of the longer devm_platform_get_and_ioremap_resource() helper
> as the last argument is NULL.
> 
> Additionally, use platform_get_irq() to retrieve the interrupt
> instead of irq_of_parse_and_map() and propagate its error code on
> failure. irq_of_parse_and_map() requires irq_dispose_mapping, which is
> missing.
> 
> Assisted-by: Antigravity:Gemini-3.5-Flash
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied, thank you.

-- 
Dmitry
