Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED43BBFB1
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134603; cv=pass; b=UX/ZpYfkhuBaJMGAPuLdYVnDyfy3eAocJdkGigWOQXEpjHor6nWduar2ppQ0M4F4j/ueYgRhqMjy4r4z7Px6Bn19zWn2SFyK7WEJfhFeL+Vzmslylxq56U/jGOGjqLhVPMSfWJ8o8VTA9DfoN3G6SwlhdKye7JNpti+R103FGdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134603; c=relaxed/simple;
	bh=WPig91j547Zi//br7Yry8NnQ1QigUQvc29TfCEv4DIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQyLsI5BqPlU/bd60MA6pA1a6q+IEOi/E/luWFgHiL/P6tI0FWHNt9XqnzmuijJI+gY8Cj9ZycEAnWoSrHMdLCUS4QMpFpDseNEm+xnBgh0DcaD7ygqpM0Pbyxo+SvJ0LDOc47T8B1CHrnarwExzJodAELQkljgK39SRQ3fgAJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRApm4iX; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRApm4iX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1743059a91.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 23:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785134602; cv=none;
        d=google.com; s=arc-20260327;
        b=ftpqTMzmJHZ0NT5HJMApfrw1Xh91JXRC78YFQQbwEAOLDLB4vSGdgdyBDUShUk9rgM
         yTlKRB8Nsd0EBMhCuvYXV1VaEyO8QvdRRkh6/mau4RkeUYFdX+vgY4zd7lGMNnyOP7aI
         Eo8ZqQ7bLuLmD2XpQIqZeLsf8koZ4804qOJZ8ZaYjuVWvtX+5vv0/bOCmRJqz7JuNkbq
         POpA8zZieB0MSvfmXVg0yVlUxfOWRnDKDC/bWae8d8L4vawBscO46G2+v82vT3jdyJ4D
         wAF0O7PHcJaB2PPtycBrp0JUb5hX78ukcXy7w4+8P9rshFPQ++HnWY6uZnaU6eXHlHcc
         DXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WPig91j547Zi//br7Yry8NnQ1QigUQvc29TfCEv4DIE=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=ONcvcOOvCCqj2FslRy9Li1/faU4aumw3lJha+RFTufd6SIrQYi4/9I0YEE0jTmIXHC
         1j8/QzMcr2hdY7ADoo+HZfRYrOd54p3RCZ9QClz1NV64liVby6SNOT1G06dWeJXu7QtK
         h7psYiGFhXI0qm7IO3jgrrfFMH+zzZ2RsrhhurYDGDLPLlZlq6lZYC/ckO5K7U+acNy5
         fc6aSBdhFfpIjqrRSO7E744vRlhFMD8UEVQsPX3Wtv8Qh7Y6FV6Or03OEFGCHvNjpTKz
         mg+tDPpmu5xrUAFUYDMOsxzC1sz9CglVBuGKgzK7J1YwdY3e9JM7S2pgMjTPlgQ9rrRg
         HUtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785134602; x=1785739402; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPig91j547Zi//br7Yry8NnQ1QigUQvc29TfCEv4DIE=;
        b=ZRApm4iXid12gTeq7JHPmzI7pqHF8ZnT+XEfZKGq8mC1bK1CB4tnZb82U6NX6+VnAA
         hMTMAC9QaaScAFTYaQG6ZrNChV0hyABwmq4DekkJhDBk87SgJ1pH2e7tLVetNsSMes35
         MLBP5S+UiNPyRK9V6unuor8KjXKtTF8YpTkz4e+/v1GkBVklpAn6u1QVOL21IzFotE4y
         ZPLd6IjMGNxDYWZXcy4vlSUeC6YcX2tFVqnVTiFZTZfS5Kh4NYuzNtLJ2pMTLrrOjYnQ
         KGWd3X8eCDoYxV0PmO0KCm2YpkKNVwxfxys9gHtThtFahsSWeysR+CUjLRJ3tC5UFtq+
         Gl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785134602; x=1785739402;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WPig91j547Zi//br7Yry8NnQ1QigUQvc29TfCEv4DIE=;
        b=gfmktG4n4gnT8Tb8rux2seeCBIPxXYovAxG4Fx91PW6iFqrXNLiGTTweO6kW3A/7SU
         wXaZ8zTLwHdkqByD9S0x8zZG3q8HPqw9kq4yteNq98G9wowwwDYzybHmbz0JqpSHrFNW
         LroadsF7OJR6fIy13WWvvI9U6f1BK7i51z19gyzJKDCIFymnlySqVgC4pY2T954G9mS6
         Jvq2+AdNPVy0mD0F/liPQrZ7bICIKs3f9k7MCro4WqX22Z+8oO4uTaDE5TVCCjbPVqnR
         cSMwBqPuD7mn1H7ycugHMhbgng+FerQTB02do67KUJnIxWlH/9BDDjE3AX34sloV20hS
         TdKQ==
X-Gm-Message-State: AOJu0YwnnWWxGVXjSjDUFEzo8ZQ0uvgL0zIF7yUWMX+KvKy/BvgbFweB
	UZi+pE6Za+FgaiPBvomuIdaP+FSVO19L6qRBAkyMF0mcOZjLuScOetnetxuOBkWT9E5QqR6aj8w
	TjOVq/OByRvBsUNKeymEmSs38HNT2wTM=
X-Gm-Gg: AR+sD106wwSneXkslfDPINUrh+MmOwOO4faQd4HwjAto9tc34on3o1firUQ/fJVywhK
	pWrL76P6tlW1WuiRxHiHGpgo4TwC3F7J0Y1A/pm5OoUfyPajyus4IZRCAvJ/wk0cYJdd97JvIaG
	WETZn+27t9hVd7TqHd0Jz/QmfOUzii8PCW0EUqFhCqyO187FEipzwMrTdYXsMvrEiTbp28+HDN/
	vElCer333GNDy5cpga1JtjWiRQb2onWn2TBvlu6Xdm5apsaMuPPmee/O2mJfdZ0OdaYMsyojdKD
	i1ZSbuJbrMUxIukH4gqPi77XUGHcq2ppDlWIvvjpJHxfxbeFp+BDqVM+CKmhSoFxtPAiwGPTrZs
	PHotxvdpV
X-Received: by 2002:a05:6a20:7347:b0:3c4:3321:4ff4 with SMTP id
 adf61e73a8af0-3c67e00ca76mr6749469637.61.1785134601764; Sun, 26 Jul 2026
 23:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com> <al5V0Ym6zCGqPqJI@google.com>
 <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com> <amQVsmuy3cgm-i5M@google.com>
In-Reply-To: <amQVsmuy3cgm-i5M@google.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 27 Jul 2026 13:43:10 +0700
X-Gm-Features: AUfX_myl6Lfgn2pyMXMDVE93hId1fyutVzmK6y2cMlh-lWGq2Qze7VyNIcMBcYc
Message-ID: <CAABR9nFR3=4QcWwUApMDcjrBSJCRZGZgxE+G=bHOKfF8G1+3wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thank you for your feedback.

> >
> > Would you like me to send a v3 updating the commit message to be clearer,
> > such as: "Use dev_err_probe() for devm_clk_get() to prevent log spam
> > when probe returns -EPROBE_DEFER.""
> > or keep the current patch as is?
>
> Yes, please, since the handling of deferrals was not broken. We just had
> some harmless extra logging.
>

I'll send v3 with the updated commit message shortly.

Best regards,
Phuc
