Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AC3EDE55
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608667; cv=none; b=IlV5pqB5j7/9cpkuJt2L6jcP3FkzqfvXQpebmeQNHvjX9iFBKotyiIN6DvzqphHOfSEMBqdKQrzCtmSBFj5wi3Onp5slpWODByICkv9RAkV2RTRKn+hxPC0Aph71/648NZuOi44qIP2YjdsoOVagQptIus77tXqxmpehwt6sxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608667; c=relaxed/simple;
	bh=DbC0giau3tkuoc9dJAE1gGKTry0Z6rr8t2gh69mnvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAPVekgt7WmQrbzpJ+uqnYGTNjPGYrdMpVwvbVGPzxS6OEgYkClCXtGlGLh428lzZYt/6wvfYYPLdfHXNyOYfx82RBSEdA1JA6A/xCQWhTMkohFhw9xXWl+pivypYuJbr6z1ETXrdhtTkhyoZtaLpav7A5A+RxqIALgdd9UkwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ivjFLt; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ivjFLt"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-132d1b2519eso4114534c88.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608666; x=1779213466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAT7x8PLis38MYgBl49P0EwUw9EMtbiaXZUfAfDowGo=;
        b=e+ivjFLtq5sJ8wRVzdzV5yw2kQA1Ss8iHkg++dzeRGiIpHo14E7Q27vVyCgtW0gDQY
         iwI0fus2QiD1PJHwld4YBpbVMm7y3fNIlSFgQEq/FsfuzZpMvxvY0RdnInyUG5CQDr0S
         cnCalAcFoDc66HKG8Xx92eF0DpTEZapWOYfxMUNhWlKdS4RehlphIedt+aa7tE5vDeIM
         XBZnSeCOpaSDxJ9GPe4NwT0fJhr9bqk8g9EwzlW+HaqSE8nBXKgpq2FjbuKPyk2CNkaB
         l9+3xOoMGk9QPa5QjcV7OEOXQmjrxIyfcC/Mqpd2G0UvSF4vdDy1+I4ZC1agdMJWNhJb
         wCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608666; x=1779213466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAT7x8PLis38MYgBl49P0EwUw9EMtbiaXZUfAfDowGo=;
        b=b7uFDKl8hW5JFyMMCzuDA9hRUSB7P99w6NpZ7B0p1hkDnSZaQPp0E9On9Kk/sTV/ik
         exxBswksQUxqgZC/wARPD4Tca6hjMFp5apsDSOgEzl3ZLAZ5ijeGspS8ksVgPYZEZP46
         W1XI+wstWJcaWSjx8dc0NYi8d9eDoLqg+QXfnIqQC/MoJIxhFk4AvlPKtvQ1IKwcZ/n6
         ycXzQ1ABkv/jPC2QbyjY68tVxZNmYKsKg/V7Rf4GIkYpxzZkLMQwXpprfOURdfXlR5Nz
         JP+eiZ49be9rVjroEDwRiCXkYuLVeMxHFf7xTxOdPwXujWGjdP6L3n9oWKOox3BZtyKq
         7eYw==
X-Gm-Message-State: AOJu0YzzKgHkPqS0lrTiE7FffqIB3XMzecb0aaBnnCh9R7TqD07sWQox
	Qh/N/P3N1AKJLB5gg4rKuHzwR30BofNQ92C9bfe4F1jQcmNu84pL9WMq
X-Gm-Gg: Acq92OGoIUvOqufmpG94BxOu9NIA4RtZ5wo5cCszwCoRGAsChnYhFqD4iG5M/P0IBn1
	RufmxpTHoyEhP1DLAdBnA0IM9y4cxbUMhQOR0+60QFfoaKYNN8KS7TNPR9MuP3YvN1nBRrPyOKA
	JfCicS2sDb+ruKxYQgu+fSynZz3NbUcEAxuNqu49AUVJk6fbHhrt4z64iElZuwn6Ocbl9JZmO/v
	OP72w1qkRs1SuTtZgrv3rAkQ+jD5sVjlyY859zN91L1QCl7bmiUxUhTQhVq62mXy3w7zZNhbutU
	5GD3cdDxYb3rTCh/F6YjyV4dJvci5Q7RaRhnQaHdTspKQteGvtMdPD4dqSfIlCHiVbJD4iXfqB4
	TRSlq+n5HztPu+qg/P2VdIvvadhqmdPv+cnW5XzlWf+c8VfudgEQJGCikAfIjMSycfkq+ZByxiy
	aedR0XxLZA2X02R7TeC3gO6UwrPk79/87WG5QzzhgL7Pn5jRjMP0ZwyhgVW0ySyGE9
X-Received: by 2002:a05:7022:221d:b0:130:9f2d:ff99 with SMTP id a92af1059eb24-1319cd26692mr16497110c88.20.1778608665652;
        Tue, 12 May 2026 10:57:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:84ac:d22c:b037:1a93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm24271153c88.1.2026.05.12.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:57:45 -0700 (PDT)
Date: Tue, 12 May 2026 10:57:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] Input: atlas - Check ACPI_COMPANION() against NULL
Message-ID: <agNqEisfkJds-8yy@google.com>
References: <8696590.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8696590.T7Z3S40VBb@rafael.j.wysocki>

On Tue, May 12, 2026 at 06:26:54PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> atlas_btns driver.
> 
> Fixes: b8303880b641 ("Input: atlas - convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied, thank you.

-- 
Dmitry
