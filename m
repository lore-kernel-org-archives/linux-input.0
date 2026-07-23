Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2D47D456
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828601; cv=none; b=D140Cqx2y04nQTl55OyU7XcahEPL28WolsXm3Q+lzFk//xzVo/zuLcFak40PHjcEUUMeO/9UuAzRxOFb0F7W3tODNakrp2ntHzzL1WlM46PDRuQot4rKXR8cVX9Th9wWaVmS4uRFwjDHe9WAxZ6BGPaj5qAQ2a3CT6o11PmJ9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828601; c=relaxed/simple;
	bh=onOMg4dyuXVGKUdKg0x4ObMl25KYAxMmlgWzU6oAaRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amq1kHYVX/3w++R6HwypkgdF2sSyTs2GNPWD4BlquPp312qIm3MgqlDvNHkVScjSDI3TEvXFTNWtj8ux8nWDQ74eNy7LstVKae+beUV+GqlLAbrXTCEAI/eE8jRQj8YMEEkndTRlZwuezeR8y5YRoj3+l98h18c9Z+US5lFGn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFugTMNb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFugTMNb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so729415a91.2
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828595; x=1785433395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mxD/hD3bol4E3CIoQfiq0xA0eyEDzWsDzxIIks2DNV0=;
        b=EFugTMNbtN+x3snlXPmzv8wXnfpT7N/Ru+wqKWCwNJMbobUmPu6IaNasOU6db1gN98
         TXQJ5pve4gKmuKXbo3YisRiJTnN6kkwWSmyAgtg+lFufb10f6L/sVDF2QmEL+lcSzHdX
         ZAqRTm0WJJokYGpZ6aP5OvVX7n4Nk/LgGolmKv1K/njZYbd0/3sJPaTgoIM/GNo5sP3y
         ii7vi7fEfmSL6LNJqvK1W26el1IwzSSVGyCA07XihOKhdHc4K7mRFM6QkfqzfsSwfgH9
         z0NUVvNJZluhwcA5qPgRtjeqCdPA3Fplp4HIjFZhoaU0QbLCMe1McE7T577uN2uvu64s
         DDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828595; x=1785433395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxD/hD3bol4E3CIoQfiq0xA0eyEDzWsDzxIIks2DNV0=;
        b=L8YLZQlUOY0GyPRvcaReqiaSILG2fcwvre23pqPtS4ojJ5uWpJBI7prCRaKqq3oqzX
         AiVcXXKJqKOtcR8bm2RlvBvRqFSQjMIO2hST3ZPcyxDuMfVXcwrUDdmmg//tEuCHUW2J
         BM9IXczrpaDTO1gLP+Dr1EbFoKzktiQ2pXU6YSwp0EdMtPtnOs42Da6c69U8PyNl2ftx
         /Sf87z0pxZOyS76FoxaqBi4f6EeoMB4Z6o1Lw/NF2B/nWxzFKuHkwiWXrYh7fQFnLOmm
         g5mY6VMI2I9n7jeeEMwPdy+fqCk6mwjD83mJ6pEuJag/E5NYT1ixPcuQQ2TzJLlgoPay
         OIsg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf3tliylx0yOYIE1exkNc3amw+W0Q7uh030FMquLYaysPm5C3n4hS4mMkvxK4c92OIIc8xq951yn8HrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LCieGfOvN6kg+qt+d4rCAc9dRQMgJKUQZOkyoXiynj4aRS/3
	OptL5uWuRnfdAlJ0IiX49a8lmS2tieZYVI5tM3jkquq+P/5g4+ZEOxBu
X-Gm-Gg: AR+sD116PDZHaBhoSPSdd/y2PsC76t5r0Tm/olA0V+TPfxutMvVMB+P4hkWcDhfc5oj
	F3WdjuhuNw++aW+J8ExjZrCLYoRuF7T/UAlYU0Qu6XASEjh/Dbu0cPHASFD+e0/Q5ZeSIaOrLzO
	nFdQObdhnG7ZwfeqWG53qHBOfjYchjQLknN6QfWbdeTactUX1R1gespVf1RlGwhSDGYbjC020bo
	zhjFaI4S8zM0T+w6rmxLvh3Dp7N5c56oIuM9DPP1uyPdoLAE3fOzeWoz+5FUfucqegoTW63sNfV
	8MterZWwQSlGG2awYvSPdXw5y1oCANBQjuek5DMi/onRSISp8eHbJJCbwpcTmgb/tfwzU+pYUun
	57r1wDVcPzk+l/YEkHgPh5o8Ci7bIioj21JL7YwJAJjkALXM28mLASM0q5SJuNL30g5R5lbPAiV
	OMafWBp1xn6wSuLmF1l0BIr5GS365mcvZbkZtv4ZwbFA==
X-Received: by 2002:a17:90b:1350:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-38ec64c1ab0mr4192747a91.19.1784828595262;
        Thu, 23 Jul 2026 10:43:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f5d:dfe5:9bb9:71ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm29470021c88.2.2026.07.23.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:43:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:43:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: azkali.limited@gmail.com
Cc: Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] Input: edt-ft5x06 - ignore contacts with an
 out-of-range slot id
Message-ID: <amJSpqqkqljPzHWt@google.com>
References: <20260723-b4-ft5426-v2-1-cd2bed168051@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-b4-ft5426-v2-1-cd2bed168051@gmail.com>

On Thu, Jul 23, 2026 at 08:24:09PM +0700, Alexandre Hamamdjian via B4 Relay wrote:
> From: Alexandre Hamamdjian <azkali.limited@gmail.com>
> 
> The per-contact slot id is taken from the top nibble of the third
> report byte, so it can be any value from 0 to 15. The driver only
> allocates max_support_points MT slots (2 to 10 depending on the
> variant), so a report that carries an id at or above that count - be it
> a genuinely higher-numbered contact or a corrupted byte - is outside the
> range the input core was told about.
> 
> input_mt_slot() silently ignores an ABS_MT_SLOT beyond num_slots and
> leaves the current slot unchanged, so the following
> input_mt_report_slot_state()/touchscreen_report_pos() pair is applied to
> whichever slot happened to be selected last, reporting the contact at the
> wrong position. Skip such entries instead.
> 
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>

Applied, thank you.

-- 
Dmitry
