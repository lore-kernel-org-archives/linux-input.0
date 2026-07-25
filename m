Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1B331EA3
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941387; cv=none; b=b3bq6q4u4Gj/Dp6rrsCbxhO6c979IVA/DQzZMyHFOHUdJYaVCg8in1W2X8qjNh4V9BgMmq/sNWBda5E/BkuotNSNVHYXbd5eqocSaDBRkz2uA+xeD1u8cDgBvk/WxuJA+5phlHBUfrR5af+t8Sv8uFp/8IlzNAV0QFYzNuNPEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941387; c=relaxed/simple;
	bh=TiLoywhZJG0EXwMCo9QLUPXjCy+ZCnB0vIt3vMPVpzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkRw8WbOqUYKoTUmPO9nfMFDeTvo6FiQ3VGSsbyy4Fa9TPOsiHt6+KHIjTzsEKx0FOJ88T9DAgOIdPpTDRc76fvHT6v0jstcjDUnvzq06/nOHLM7svqVv0iZOtSAasLQ4F9Pfb4pGIfSCBM8iGPukyrXtPgi59TIb4CCb6KF3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyUzuItr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyUzuItr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso957691a91.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784941383; x=1785546183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtzcZd0BHK8pah0ZqU0OyKfJs9YQfUCnaRspeibYxl8=;
        b=eyUzuItrPejBPfS1Aug0e6Q/UFrLTOsD1YeJnmw3QKf73qO348jA8gC8/jRAe39dv/
         XXqqaze7VcT98Dry2p4Sh0/wDdQo7f2UFpHac1zVFUlgC5yphKCq/+h6pwSbbXmDxU9L
         CrQZ2Te8XnIZ4iGOLZHnEkL6S8fKe1nB20YhDD92Ne7uuoqvb++GmLvBgJX53PTMRLEY
         xEAsDEcjrexSnhDoH/7R/HfTYgd5OnjRi/lWoe8678GPNtdejJ2m0btE6kbDxTkfEBn2
         ADdB7bGN/n1lknRE9gQV6g7Hq8uyb+WNq+NPAvT08HzerxXBZUKdcq5oiIgLiFyln3oz
         IqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784941383; x=1785546183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtzcZd0BHK8pah0ZqU0OyKfJs9YQfUCnaRspeibYxl8=;
        b=qwvc0RKhyEhZ3kV+RXn9IJiRWwEF8IdKMkyGa31x4Nw3bI2w9ml03C8TatHwOgYzVo
         KyWP6c9QNxLZv5IW58KEa8Lw/pdk0IvuzjGuXavXWnw1I1I9Z6N9HUkhrlMyP5/2ocfK
         gvjhl7JBwHaDLCN8il0GzdZCCM3ZBqHoTYUX2Huv9vEpdhRK1hAUuYfLZDniqpBmQGjf
         WGeqEPUtl+ZqGziQbqdk0jKz7KGCzalCH+CC1lrMBxqW0EqcUA5R+XD2k3/KCLT92XgC
         rZBdvytdRlDyLaKPG7+i//aqym3yYLubZgDm92boYtfMcVWvKWssKfpv+6BPqyJRCtXh
         B7/g==
X-Forwarded-Encrypted: i=1; AHgh+RozJNDm9hGM84Ow62psF4tubRIXYVSOwDpFq35W1fAQIOndHt24Exy5RwTxoJkgCfGrhuAr+Peh8KH14g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0spfkHtWnqb/n/h/oz5l4Xytqv+ZqhJAoWA37YD1OEWybvxtG
	vR4FMRbexRuNf3krNU9vHiPNCWgZRKGPl3/nGhCrFc4+bHVQ0ijmDkY1
X-Gm-Gg: AR+sD12ZMSt2cUXVUK+ASscrIBqVo6zge5JAYUQ4+H4Hm/2NKHiv+QNuIWl1PlBlbiE
	hB8maksP9ahG2KYeZBBtiYojDWVBtWaoxgj9s1OpnAUzPSIqGkKlMZYLhPORKbsWP/jxin3I1jQ
	F51Vyw98qfLYH92+jxoV25DwqFIftD6Rjp25vIzhZcxAQVcAXFkKqsE0XjPFQSPVlrkyk3qKb25
	iSazcSg3tLrrUd8oisLiMvbH8xkHk0PegG10dZLcjVaAjL4ou8ATXLIxnFrd2x8I0K1p+gkdz1n
	jX1hxyEkIgibYIC764j/hNbvyPsbGAcCUCa3ZkGKc4qNuugL13fxWZGklK8XSI7wDa9i/inZsAa
	reoMSyHEshovrPbR+KoJ5XZe4UmK9Ai8wrY4cPNjGEd4BM64BUaxhPh5jdGGf18QSIcS8xJ3i9v
	7gwqcVD022y0g7Cfz75hBaZFLRN024DSsvLK6rFtJaFYM=
X-Received: by 2002:a17:90a:d885:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-38f1efd68admr2511017a91.14.1784941383451;
        Fri, 24 Jul 2026 18:03:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm32542730c88.14.2026.07.24.18.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:03:02 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:02:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: kr494167@gmail.com
Cc: hvilleneuve@dimonoff.com, andriy.shevchenko@intel.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: charlieplex_keypad - check
 gpiod_direction_output() return value
Message-ID: <amQLPadZPLaAVXQV@google.com>
References: <20260723022943.9337-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723022943.9337-1-kr494167@gmail.com>

On Thu, Jul 23, 2026 at 07:59:43AM +0530, kr494167@gmail.com wrote:
> From: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> charlieplex_keypad_scan_line() currently ignores the return value of
> gpiod_direction_output() when setting the active output line for scanning.
> 
> If setting the GPIO direction fails (e.g. on I2C/SPI GPIO expanders or
> hardware errors), the function continues to sleep and read input values
> from an improperly configured GPIO line.
> 
> Fix this by capturing the return value of gpiod_direction_output() and
> returning the error code immediately if it fails.
> 
> Fixes: 2ca45e57ea02 ("Input: charlieplex_keypad - add GPIO charlieplex keypad")
> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>

Applied, thank you.

-- 
Dmitry
