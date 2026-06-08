Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616D3AFD05
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956236; cv=none; b=o6WGS98k4oF4tso9XsZHYAuFdqMPBk4EFUuH7lQvu0cAx/TyXhCcuDK59++Y4cynBrtsIHEHM40lv5uLy0vywWQC92WnGCG36uSYUhZx6/GcswG6D6/k1BZLbI7yz15/bRNE0V0KoFDlZA/HTDbotSJpxo+By/chvkjraKIyKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956236; c=relaxed/simple;
	bh=JlBnF56ZRWnzHd6GxrSk+oSNEixwMBnfd+3FNnXVXE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeLRRbmwtNHGtsGd1pEWBwb+SJinGIeKo2Ij9cLeKwZ3ZZ5S892fIGyrhC9woUq/Z+katIifSBvNtXxaOe2RYoJC6k1aRGlVHRHDdyFBnTQseqCkz8zNu4iS87CL2TRhFP44aQ1vAQKn/+NRLNnT4x37tt7K/iVT5ZW8nsb1SgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUpBx5EV; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUpBx5EV"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-486852c7b68so2981571b6e.2
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956234; x=1781561034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrvtrOj9d26ipp+5hv4zWK+nSNPtOXlbAt1AUwvEX2s=;
        b=gUpBx5EVFJN2cDP+Fpa8zl1A0xgI06Jad+XQ/5OSbyuw75UDBVxW937arNREWROTOF
         90Y708oZJNzvHbEWxpx9s4og88g48TQatRsK49EO7xNjJm2m3dyM1CmscWKH0JglP7O5
         FuRCeI1Suv63boMsYauA6gl+KuA14bMqmGdLorSkxon7WDysrvKIWDUox7CSOoLWZqhS
         X4obP46R3y9+8bbh2w5yUGaJG8jgEEpf+hGfC67pFXhl3QyPsIy7hKVKjzG9pCFS/DMJ
         j9/533ypyk+bMJuieqmus56s8QflFHnJHyqMWjx/M2wnfL80agyt7fRiJf1nGNBwlSbM
         gSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956234; x=1781561034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrvtrOj9d26ipp+5hv4zWK+nSNPtOXlbAt1AUwvEX2s=;
        b=hLAdX3FEMTJvdIeVLvGgobw7bzZDjY/+zZe5WTz/av9XBgCa1QS8zDKdN4cpqz1EXY
         MW0Qu445z9BsDYdNtt6SjytWP78KtmSRbFOgevody45O6Fus56mD9Dfiq6bWggbO/+QV
         5D3VaqQa/609ExsBDu1L3s//zHXnkH4DEl2tNqUkYK/kQslefBCoqsTTQS7FEC3BCrKq
         JNM6MyWwK/JC7YA2HWsITrden77BxmM7HQs4q7BiYaKYgcXRBr5lUbHOwDUUG4hNhhMY
         fp3rlpsXraDbfKoq+DHPycArSJwERitSoFNkkf+DHYQoAaHXzR3zFVOH5tMc916MJKwW
         vb6g==
X-Forwarded-Encrypted: i=1; AFNElJ+Ucies+nuZWS3R/abacYVnA8P105sgiZXWmQ47mmwZysRzlkbXVODrCg6cU9cXtVHjEvCXpP01O+QeYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwGPLW8GuUbI/d5FUX1IjNvgveTgq1+yDzb+cv7nkorpYwvu2
	4B5Wkph0X3rPx756d8jLNFkSpcVfZoh3RTVUZFDsS8KpB8H2CKwI4MLh
X-Gm-Gg: Acq92OEs9dNnk4rFG5NI4w61qCHM4ZB0QpgfJ1XJ1mHh0ZzxRsUBWGs97ikQ8mSWHln
	srTrT9Ft3VohYFVA6wG2wY5iLuUBXkg37r1vD3VWGnbntLsjURU7d9jumb7t3uNr/ZKvZyydwUA
	Q96Wfp3GJ34JINTpJjd9EL48Tu4tQ7fZpeh3gFZlVqHhxGbmN5hmFdywt2WtkZgjNEXsEcami4+
	Ym3MDB3EPvCFqiyGEf5TDb8ePCMRg0S7Updw89GKweX/J9QoBb6fzWsekYPHHKwLyQPO/pq+kSU
	Wq576A62kqGpxkmUFbZ+B6or3M8W3MW5W+NmFEbx8EI9coI0qf8+00ILs9XAm5MtmZW3TEka4D8
	vsVb8NOQ+r74FM1tghtB+SIRRO10Btk+hL+AuFReYffX/HJ/5PBfuit/GrVOZPvpsnP+ALiOG9Q
	fFCe09UF2o/hkUsPgicPpMv067bsCPsj63ISZFjNfvbNF0iqjjvmjFPXOM6y/0hfJReRNeXUMgl
	Q==
X-Received: by 2002:a05:6808:221d:b0:485:4441:721a with SMTP id 5614622812f47-4868df0305emr10961379b6e.36.1780956234026;
        Mon, 08 Jun 2026 15:03:54 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91a9d2sm14484863b6e.12.2026.06.08.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:03:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:03:51 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: iio: basic clean up for usage_id
Message-ID: <20260608170351.6f0fa693@linuxescape>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 17:47:41 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> Hi all,
> 
> This series updates all HID IIO drivers to use 'u32' instead of
> bare 'unsigned' for the usage_id parameter.
> 
> This improves type clarity and ensures consistency with kernel
> coding style, as HID usage IDs are defined as 32-bit values.
> 
> No functional changes are introduced.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series
> 
> ---
> Sanjay Chitroda (7):
>       iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
>       iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
>       iio: light: hid-sensor-als: use u32 instead of unsigned
>       iio: light: hid-sensor-prox: use u32 instead of unsigned
>       iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
>       iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
>       iio: pressure: hid-sensor-press: use u32 instead of unsigned
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
>  drivers/iio/light/hid-sensor-als.c            | 6 +++---
>  drivers/iio/light/hid-sensor-prox.c           | 4 ++--
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
>  drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
>  drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
>  7 files changed, 20 insertions(+), 20 deletions(-)
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
> 
> Best regards,
> --  
> Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> 

This series:

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

-- 
best regards,
max
