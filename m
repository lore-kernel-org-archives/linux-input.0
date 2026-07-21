Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDD36895D
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600443; cv=pass; b=UpADcYVrMscP0SLHT8N02lDKGYfD8jYutHdx/rOtLrw648XjA+eQ1VeZcOvNR44Mz1PMEbeBF8bNQLL4vKLaRBYixxppIn9eJh747OdYqgxxG4H+Axs6rBQ1zsFDv9YLM84y7GcRRxcle1/SSyK0Z/pU7QnZGjWLj7YYzC5iUaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600443; c=relaxed/simple;
	bh=lackgBspxz8Vu9bWKgm6jGL9mX4vXEgYYRCcDIkcuTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQE28bfpRbQNfNyUEB9g6NDevLc9B412EM4fLd7ozedgwktjvbjBMW39I7JgfzuOvbQQRSY751CW48V5gemLs4ji4uOwZQQPzqfscrWW1AoayjgSB3Yn6LvJKDuE/lWRi2/nh4dIj2XhG5pL4o7B6XF7gRZS1qCyKK7rycf64b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZiK4y9z; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZiK4y9z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so4738241a91.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 19:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784600441; cv=none;
        d=google.com; s=arc-20260327;
        b=Kf2XSZUzD7bp2QCS7eA2cKEGXVQYm1nsIhTeCo0+Tkzi1a2gMnuVDUc1MwHRimwJMm
         r9CyARl/GRB0vBpNpKCVcRyNCoImnciDk4Sh5b9qyibDm60E3KPsWUs+HmLxWIB5ozsF
         rID7cULx7OJIkQDHtUfe0Ow5QthAcdEM5m+/2HEZ2v26fctOKhzMkPdGaoTumDMYbHvN
         Wl9rwzbiBP3xiQNJkZongmZ1e3SY38sFcHENEWfW/1gnValNn87ge6NbhzPUxwxylw4d
         JA/VIP3tUjeI6hoPuEe8ZhCucV3RDBi91w5AHMXR1/hVjdwwD5jrvc8OkaENg37+6kHs
         cEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lackgBspxz8Vu9bWKgm6jGL9mX4vXEgYYRCcDIkcuTk=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=niMC8uNwNmXTAtSfKYqYJzqmZzhEOeEzi/SMH6Oi5CaMb3wjH798f3OL8tsBwbDUmO
         EK8hHBlf6xly11JL4TDFlKLo6KIDpjk/m0mLRNfqcRWV8OELOZF1D+s8us9RLA9Ta2Wb
         Rzxsf8WHFRuMETRPTH0Z44fqzYNDft4IvyWlOEKUnuROnT5N55ATjomvq5EZvrNP5I6s
         lKzFQYVBX/akGDOfeAFAFssvJqhxHimwcEhZLpT8XEjiEcYStujxjc6wuLCmr08ZUSno
         Z/bKLj+j0MfN3zAd+QMEniYfXaPelvA5gAcr3RuHyyz1ppI6alzNmQymg6hWkGngo7cX
         cliw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784600441; x=1785205241; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lackgBspxz8Vu9bWKgm6jGL9mX4vXEgYYRCcDIkcuTk=;
        b=ZZiK4y9zKnTkflJMRvo335u/x0QEcN+eVts7u6ZUuYvIpH4EH9LExsKALvY3KT8YrS
         9oKa4eF2elMPmUi3odnimEZT0pI1SMZ8xAGk25fWs4WnHH+DRKTs8LXb7WMjaXc42MM2
         NR9bHoePglK/6SnI+VbakPyfgOtcpUx0wA24sAlQwuTPLHrB3gFkdv1ZvNeVkGvgjw0y
         yHWHRlijZLMroP+0HTjMTciCf5ju7owMfK6/aF4cAibnH2FCcpRtZQHt7o9MCeDT+GOz
         SG6F1AuLjXnieq7WyZlHx/UanVAKFoJpVmy40nsEgCpnutbHHSiMfbbfZ/UbjwB4s01s
         T5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784600441; x=1785205241;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lackgBspxz8Vu9bWKgm6jGL9mX4vXEgYYRCcDIkcuTk=;
        b=jo8Rg9BGk9tQJMtJV/3qd+zpEY8bU6gr53PINhBerkvdSFfBWDCTQZiryJyzGWK1Qk
         QydpfGFPQ35NWVyC3jCY3EsHjrvfupX+IVU+VOmseIKfPnYKGgRUIBMBtkBhMDKM7Kau
         XpDBu1VtbPBgWqG6X7mUQ0btIRMIMXZSMM8afJcNzOjsED/noq3LczZwY6aGKDOkJq6J
         sSadZ5IhUIhF+EnxL16oHSj2hizcMqZ1BxaXHdCt2zH0mZ6cyBcLCvAV3NbarCYeTWuE
         3exFfew2/NxCd2B7qwHQl10wTGs9YqJs+L5f8dZcYsCv45cnCNBXvIXHIEZWsOuDv3mK
         30qA==
X-Gm-Message-State: AOJu0YwHrsyJIPXyJBt9GDCDUEnuml4XeuDbIKLzElJ6FtSY19XECUYc
	ENvJ210FzzujNcKhwSBquGHGcd/oIrze3L5KLp6/eHvLZtOIDJ0U+TouHPmyy7ggHaAQhNFUx/m
	65q5f3jwv9Yn8XbBJflTM+yaxqXy9XiEF1Mjg
X-Gm-Gg: AR+sD12aTS3pDlkIwiLG/m4U8EUxMUZ/OZFmROgmamXgHn7qnzzuaSS81TJS5Z1Y12N
	gH0PcADTcFNTDcpZM1xrMd3LKIAHSJjrlQIEb+tOE2a0Wx3VeMwP2Dnd6H7SOD5Rb3jvUIeBjAT
	dRtXgLRyKciI3llCqfLz50zsTdEx+NOfRjYiOycTYY2tBfYBUdE4bjJa7hq06okTD6Gv8H/Q1lu
	P2msYLChAzNLtyTqkGWtd8smWnNLd5E5FRo9XOGidMRmSO3LgnUycwtb5XiRRcLkXVTexQTM1LV
	GdAlO3jUEAAsnlR+lHFUiBnrXsk=
X-Received: by 2002:a17:90b:5344:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-38e4b423596mr16741679a91.14.1784600441151; Mon, 20 Jul 2026
 19:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com> <al5V0Ym6zCGqPqJI@google.com>
In-Reply-To: <al5V0Ym6zCGqPqJI@google.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 21 Jul 2026 09:20:30 +0700
X-Gm-Features: AUfX_mxlrl4-zsk-kKT2oYN9C2MNUx2XHZ9_Ux0MNG55QqvsV5gkq09vHmSNBq4
Message-ID: <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thank you for your feedback.

> > Use dev_err_probe() for devm_clk_get() so deferred probe errors are
> > handled correctly.
>
> Same here: in what way the does existing code handle deferred probe
> incorrectly?
>
This is the same case as the previous patch. The current code uses dev_err(),
which logs an error message even when devm_clk_get() returns -EPROBE_DEFER.
Since the probe will be retried later, this leads to unnecessary log spam.
Link to previous discussion for reference:
https://lore.kernel.org/all/CAABR9nHHe1AzWmqhV0d5p87qfSsBk2O7bYj-Weowyr=99wtNNA@mail.gmail.com/

Would you like me to send a v3 updating the commit message to be clearer,
such as: "Use dev_err_probe() for devm_clk_get() to prevent log spam
when probe returns -EPROBE_DEFER.""
or keep the current patch as is?

Best regards,
Phuc
