Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2EE34E75E
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538751; cv=none; b=UVt+8KXDMtVCDv1ko0CIRc2u7v8V3s2uqEXqamL9S1WLd4zlG9lSC3BIumk/S1tZn2c0KKzdp7h8jUbN/N+qAuSNVpks3lXQKifHxw3Weu2DnWCGGnoubVT1hArYK3RS8MeNvx7bsFY5Q5JxcA8teRJO0drGzEzaMaGJ4Qb8oJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538751; c=relaxed/simple;
	bh=3yhpx7HD5OMFHH7Yvf2pE9Z/a3eaoD+f0oluE21YBqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlxkebKROstZPxtALphQjxk5guaBmtpTkMxuOhU5IUslYcTBZ04Mn2X9RuJJPZ9P3Y3I8cfe6KNyzVIKrx/IJ1KQ9qUistOHgekEUABp3esyeLGe2IHasM/uCFw9Tc1E14G1V0O/u3ob/e1dGw+QyoUzwAqNfigpXfkQ6GiZKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1+XjndI; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1+XjndI"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128e4d0cc48so4826714c88.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775538749; x=1776143549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AT8awfUYL3Ueog4ZWDVYyrhcHmBHrI80IMobe7yuldU=;
        b=L1+XjndIaUTVUoKNglORtzNUBdI8of0G/r5/BYKSPLFdRzQCaPM6IuKBcc3Mr8f6OY
         zWfaLeVs5kjvofRSk8p1HRYWmzI20BTjHRUgsJbnpaxw7hLKQk7PjEnn56U+puXRlLSF
         nOsNA0s/RCzCO9jeZVljisEJyZlISYbKBoiqQG/5KAo25W3FvXwG+BJ+3Z6Lx7N0waOM
         TxzxuhV7SoV/R5wvnsB5u7wWNWNpXnF9hCZiLKWWy5JYKjRWEHf4UPykuHk+cvb/hu8g
         Tf2AaR1Qq7ssmV/Y6OZ1V5ZWsbHz7iLNWvTdjxmcHDBl/LdK4bk2s8oEb3uAo4Dm2n/k
         H8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775538749; x=1776143549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT8awfUYL3Ueog4ZWDVYyrhcHmBHrI80IMobe7yuldU=;
        b=Zh5EbqTFjT2sYU5eMUDBU9YmW1D+DMaG8sNlaVV2QfBqwM0EWe1Ayt7GHHMWX1VRum
         n53Ko+flgL+HU30RzEzb9bV99l5n4RmxtGDIkCP8b2tNM7AGYyB1XPNcxxZG1K0B2PKy
         t01eDR29BXrM5jZnJnlm8p71BQG44wSN0S3tfP9Nu1gxiyB2Ld0U9A9xR8TPA4UmqvpT
         4t4M47bkE1TQNZCnBHSuousEjzqU/mzNleF78eU4TRpkgKQ4fo3qaG93dfDUVr/ww5Cl
         vW3dDGzKT9sMJxRFPufQRE7qJbgyPOXAgZJgLEwkLnRrLwhRJCM4N6rKt2whhCJCjUtt
         irTw==
X-Forwarded-Encrypted: i=1; AJvYcCWnU0U3SJmkDKhe+J6nHjSj9eJbw2SiyAYJ0zvPJX96JAIxX09IEAaxIvOYGG6Pi7RLBr89ctABLHNdIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ivg0SaP0UEsUyricYcifi7cYOT9GPwTDZ8TD3DzdgddzsC6v
	SDXNSMq6WcTf9u/Yv7b7v1+oH/LAJRs+/XJZzb/RUZjHJRC1h666AQjl
X-Gm-Gg: AeBDiet1vCIme/D8s/GFmFZmXNn8pmYK3QTtS1aTQemW9BHROgrnK87kCzkRbtsfuMV
	wly5vnOf1ZzozDsWt48x50ZQIw614rdTFAryDiMh1zdmfr7/mi1/JprIoAJVKK7TwuslB8xagHf
	La0ZG43ZoyD+KqQMNf//nIgnNLe6qS7a0x7Qrtyp9SEKm2XjUS61Pba6Fh59oOrC3pIY7v0X+Uj
	vRaKHI6XHDLdT/M/l1yuR1l6b0t5B2Fq//bXG7hTq1G48XFQJe83WFlPseaTpuZ8RNljQGOt3UT
	b2k24AwL9A63e6YYxSAa5uPKgGDVY1hzzNMYmFfutMXxXg4ki2oK9JTuVvbNsY0b77rtZNQ0Ckw
	zbZgj+Dyu/cJY7Rvp+alvR7rey6rEo/Q7HZO0AXeQRE9cF3nh0z8aHBvgXfi+SlMk2zY5e2+ml2
	IVE2p6WKr3eZn98oob5jRF0bMGUXm9ToQP4WnQK62js7A+5C1V6C7TBzKskt3o8+Ii
X-Received: by 2002:a05:7022:b9d:b0:11b:99a2:9082 with SMTP id a92af1059eb24-12bfb707941mr6463592c88.15.1775538749505;
        Mon, 06 Apr 2026 22:12:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df5ec7sm14710514eec.3.2026.04.06.22.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:12:28 -0700 (PDT)
Date: Mon, 6 Apr 2026 22:12:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, kees@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: aiptek: validate raw macro indices before
 updating state
Message-ID: <adSSNxcpi2lvAiuS@google.com>
References: <20260323070311.42849-1-pengpeng@iscas.ac.cn>
 <20260329001711.88076-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329001711.88076-1-pengpeng@iscas.ac.cn>

On Sun, Mar 29, 2026 at 08:17:11AM +0800, Pengpeng Hou wrote:
> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
> the derived value in aiptek->lastMacro and later use that state to
> release the previous key.
> 
> Validate the raw macro index once before it enters that state machine, so
> lastMacro only ever stores an in-range macro key. Keep direct bounds
> checks for report type 6, which reads the macro number from the packet
> body and uses it immediately.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
