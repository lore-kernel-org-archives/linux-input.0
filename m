Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715D349CFD
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746492; cv=none; b=eQsjKcRSEkqXZDgxNOY1J9EjyyxWssawuLvV6D+MKSsPgUTgwqzS1gGNnflfKJIgpfAh18Ih+v4EA/S+J4jZMEfmxME4uii9MtYMPXCCCObU5nr2sWoweCbKlz75U37c9eDh9XVOgfKdzPXBrABo4ZXnrWKJorqZD/Hw85HQmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746492; c=relaxed/simple;
	bh=2QyNWmp1hztpxmrpukYXG2ZnOTcS6rMAjzh9m2F9QEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub23hsehKRZV0ZA+7aAz7s3IYo9uUdsVjEagYeMkd3SlzdkErjwkR/FqZKCel+VbAUHDObjxUBYXMvYaOr484JAinE7DVIiImr42hMEUw1rHDNdsZpkt99JWr3PXj+greTwTN1JgT7ZWZoXkjUBf0lHxdO6q8czTEBL9PUgsZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XANTbUkt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XANTbUkt"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e347638adso8046479a91.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784746490; x=1785351290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=979Piyb1AK7sVzfdlmcBmpZIlN7tZrXX3BOsLsFclTk=;
        b=XANTbUktEI4CgMk93t0B24XiXFiYf25FljzpL6yLIuhXnyROxzshuOmnHOmB5cIzY/
         t1jlORnqEPMsC+JqNqW66RWVa24dAWYYoP9Zf2UdxWLapchELHsvhh3GHh1H7d4LMAfI
         G7Xku/afoS2/1JN5fV3Lp5851/hJtf+7gnvAAp3TQpqnlM2H4JLFETIZL/k5yWkzegin
         OGZZzqIiwwsQijTCfWSyblnCm1yhvsf2tUBaLLZ4EVd2ViXKcIPCzNdheZEZhG6/XkpJ
         dhWLHaEVuyj+aGqsJK9exZSYL4POO36tDiC1bNm8uXsEeeEUctYluA/njffpepBnJb4w
         auNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746490; x=1785351290;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=979Piyb1AK7sVzfdlmcBmpZIlN7tZrXX3BOsLsFclTk=;
        b=EuwVPmOt2dJZpQ+GfGLC2Lrnm6tGoMeH+AhWlDjeIBLnt28Y1lqU8uo0sVJ0guGnBy
         bDs8XQB/sQSJKaYacFVeR51t71+u3KbdFuOfu1CdAc94B+7420Q6PbHdf/K8Go6aUMEx
         dWsEYNRWnHrseBcBFn8iTo4KZW/HVBnikiN4Bhpt4QdgPRoz1iWB9LU0iTU5L9gu99y1
         f46cyfW3bipc6J3c9SXAXhRH9QNUuUIo2gnRaLvrJlwl46gZ/AOkwB2kt/okLIQfIS8y
         ikAGP5UWa4mSww3B4cfQfO8jq/cekSty+tsF3y4KoN5eYSPMZmjqgRNP8dLFEvZYQxEt
         9TBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUsBqqwRCy+HuU/SFGQOlzXiYYeDb2D81+FvNmRpf27dLwIChiAUfF0np8pKN49BDkrGrmOH+7oLQoYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjIHqFGbjZ/bOJcVvoVBy18nQr2nHxt4PAeIKAGplRxLwfFGz
	t9+UJxT9Lyl2uLp+OQwHTyqCC/i6+hGF4qCqeHU85F7B3KbNOMnyX8Yr
X-Gm-Gg: AR+sD11kZmPqM7rnlDFj9mKjFZHX0Zm0OBfh5DXFEwEPVo8D/OVCetEnNRA4Mzvy6sU
	ZmWdcUFiV/PSH9d1ATwfDtPhmBzobY7fI/dt34eS458tpiipGXow3raXlNLIjEK5g4SmB63gtfq
	RXcZcwLTyLnp4LOV0g4EzlbWG0QLrwqAWOWCwqoMmG/s2Dsh+WlTBTwkLn1Cfyrbk7hNi1Ml7P2
	ajtCgdWgQQbz8fGYSqpE++hmtSjwONfWr/apZYGHnHf1ELphF3hT9ibcjslqP7Fr1pIsyoH8+zE
	ENWfaSoJiUgh9SXgd+Y3nvZE0H6gLWJ+QJLdyhwqNPkVIfHXu23s95D7jXubKt6vBL2L2OCfvG2
	4p/mOIWudR0li+wncH3ukd6YG17CtnLnH7diYFNk0GtTYn9yBd07/IiQhSxP/pftw3kZwhjUu87
	uR7ZSxZhm++LnaK38MoZQDkAatvMN5uoiUzVnBu+d7ibU=
X-Received: by 2002:a17:90b:4c42:b0:38e:a555:8fc7 with SMTP id 98e67ed59e1d1-38ea5559070mr4172247a91.38.1784746490313;
        Wed, 22 Jul 2026 11:54:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e13f:e272:947f:d8ac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a87e9sm7978056c88.11.2026.07.22.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:54:49 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:54:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>, 
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>, Richard Pospesel <pospeselr@gmail.com>, 
	Chris Diamand <chris@diamand.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: byd - synchronize timer deletion before
 freeing private data
Message-ID: <amER82tgDcz2wcs_@google.com>
References: <20260720033030.1580891-1-lilinmao@kylinos.cn>
 <20260720061259.1601281-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720061259.1601281-1-lilinmao@kylinos.cn>

On Mon, Jul 20, 2026 at 02:12:59PM +0800, Linmao Li wrote:
> byd_disconnect() uses timer_delete() before freeing the driver's private
> data.  This does not wait for a running byd_clear_touch() callback, which
> dereferences the private data and its psmouse pointer.  A callback racing
> with disconnect can therefore access the private data after it has been
> freed.  The timer can also still be re-armed by byd_process_byte() while
> the disconnect is in progress.
> 
> Use timer_shutdown_sync() before freeing the private data: it waits for
> a running callback and turns any later re-arm attempt into a no-op.
> 
> Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Applied, thank you.

-- 
Dmitry
