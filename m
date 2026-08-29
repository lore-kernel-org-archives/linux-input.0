Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DB18DB35
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788008710; cv=none; b=ReW39q6q0LLkLZVdFji7JJKjOWGHBkIFz+yU7hYbrHadEjT26xKRy0mzHF52oAnGx9S7OlZaXZIo5ww1Ggkj1XCq1UAVNG5aXxzI+oxSFfoi3Mgj9t6KKkrrzmMwVnCJ7MEjbOpIyv7w/agyaqoqVzoYRLTjNbUiuBbCMNezHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788008710; c=relaxed/simple;
	bh=blL1EP/g8mK6CPayMFRENKyzIlwBWcD1SWMYI7+Z/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiPb9w3Jzoj7k3IAltCmx0M/Q4MKpP1D73Np/KTu53P70hOAxXNSWL6vRc88JZQobx11maYVVygxhlM+adVTZeei48CeWbVb0ycr/gYtscmUCHo8pMZ1HOsupDJl/bSy83bhsrMtWxOhxZ7DpGs0PKvyrMtZzFe/zt2Hsn7wJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPbpewGB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPbpewGB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3c37877so327375a91.0
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788008707; x=1788613507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wWzq27nIKuCjDvG5d26Jt7oNUlF/uxzezevKAoy24eQ=;
        b=MPbpewGB8mxMVnTUqMNu5NdfHNvJg24z+q6DMUOJBil/k52t/7mSOgl8S4EwNHUvQZ
         GJweXv9fJtlQPtIjpLNWE3hdudXC8CNesAvq9OCO71fH6GqOa/cQ7twp6BaGsclIP63A
         HqxSwNXBcVdORYPTzGPIG6VYs66YJjIgsLsg6XWZff4eRJYDnVAE6EW1d5OcD23e0fhU
         JAm1o2SgJq/MHVfYiAVTgQIOZ1k2lyiTBIZmCHj9ukOTB1T1eV8RE+8HDxhZaDGZOhZh
         PqAiEx7JAp9YTIEpkgaDQlEUHdSHFaT//cR+grrbJ3sbH4C0w3eCc10POcYg9qQyZiPQ
         W8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788008707; x=1788613507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWzq27nIKuCjDvG5d26Jt7oNUlF/uxzezevKAoy24eQ=;
        b=TtVSZleW6ExxGHtgBEryu+TnOUQpCwIpLTv54cAyWf2OdbYysi8ZVlmC4JUuRQvzXO
         KNpBfGP6zhH2HMHqZmhJYxNqNOEluWFUnX5R02E3vOi1j/2tYxjhRiLBW6+GHRorIKRU
         htrKfVUGVkD7L71ymLBguIDpqACDojUwwJ+EZxmLlNbqAt7PKwtWR4GMUKBxFoYYwRgf
         eC5ea8uSFQu8SZoaFrr/7sfx6gvtUwtiraFCIfp29s2OJl5Ox9uU0qwWWsFibQQ+DY7R
         Q9JhUYDcfjeL9+uRKWOUcvqK2UJLtabChJWcMKTn44YFqmIE6ad2xNIS/hexAb/YE6xd
         2ygQ==
X-Gm-Message-State: AFuF++mX48r9uJcnbpoo92mp9oSB6RMQBNN0Oib+QtkQUwt5GCds407J
	W0ZOaX7l67v8IuitgHJAtSP8tFv1nxoREvNTJ2Iq/NtiGDZkpbUqU7SR
X-Gm-Gg: AYBFou1rTuNG9JysivvhM044hksVKgkpJuK/pzDzUGzDyzffyI/HDQWzIDYOTacSHQO
	MucijquVFmQa9HSlAeOsFGXXWclg/RC8CZef8cA5V3Q0hcpiGnUmv6IOQYk6GQ+XnvZFa/c0xPG
	PKukl6f4tUvj7D1fQS8s9K39tkrmgNbRw2bU7P90aFadpEgaByChwMght0zTvNBbirBS4jvVNSq
	cpwpRDR/qx+GwvXHngf6vrqS2XZsnC4hMPYPGsJ9+Gs+TrptRIGRq7OX/9Snqbh9Bk6itg8YHAd
	Uz6F/NdlCGr0dBMBrjqaozQ1cwyUoNj4XvdtyNPqsJFHBshHQsoY8XRavGH2yl8MvqG06CRSNCI
	WMzwV0MJZIk0bt73zNvAM4xuxO8uEslKtGsGt1P47sTzzvf7SF2RNDfAiUAziN8wFq3u8RJKOEz
	+LYTlKqWF5p+Wd5SuBN6wByM+dIam9rGLA5lJsqe6PayjdIY5g/D+nM4BVpKRGKPUMufS7L+UV/
	9H8NpYf/QLOLNrbW7Vm+Yon4UrQ+g==
X-Received: by 2002:a17:90b:2b4b:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-3989beb635dmr9461333a91.19.1788008707122;
        Sat, 29 Aug 2026 06:05:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm21300993c88.12.2026.08.29.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 06:05:05 -0700 (PDT)
Date: Sat, 29 Aug 2026 06:05:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: st-keyscan - disable interrupt while clock is
 gated
Message-ID: <apLYTMtNqMQPWC8g@google.com>
References: <apK-PZ5c97mCxBSC@google.com>
 <20260829112721.3F46C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829112721.3F46C1F000E9@smtp.kernel.org>

On Sat, Aug 29, 2026 at 11:27:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Removing the hardware stop sequence in probe() fails to clear the hardware state left by the bootloader. If the bootloader left the keypad active and asserting an interrupt, this state persists, leading to immediate spurious wakeups that permanently prevent system sleep when the device is configured as a wakeup source.

We should expect the bootloader behave reasonably. The default stat upon
reset is disabled.

Thanks.

-- 
Dmitry
