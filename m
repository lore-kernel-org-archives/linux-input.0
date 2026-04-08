Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE732ED3A
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668055; cv=none; b=qtuX7ocEpMIKnrUslq2PHOVxaU7BaW+ig2Lyka40J0Z4XYwV2U0OufceI3Xy+JhBnidHlOXv22MqFE8PkqGz63m31YC5P1PKwgWukly/EJIHUaBFH6b3KLGCMhgCD2lFRC9dvqq2JWNwDzYE1XRpBeGaZFtvuUrzK9SH/YuGCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668055; c=relaxed/simple;
	bh=tqPW+MOYa7hJQJQyeHO8xkjWRQelbq+mS24+WSXsvJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtlYOQSaDmzygWzoQHafWC3aNzEUPd6AtqJWHXIJ4UZhBxIp8+9ZLDHSRKPNEv9sqW90rdJjath42trU711czH624stnf4lHn4IJc474d/VQrVjz0q7FRRx08Ds3YLwo1bfocnG9vK4FYLKTW0YlxK6Ly/kFrVyau0YkpVIXN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I353Hcek; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I353Hcek"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so76849a12.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668053; x=1776272853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=feYaYqqY7fSZ1GrhAkbNG0WGZDjQPFK/z2VTC0H0n1Q=;
        b=I353HcekfIUdCtnlhdFy0z7bTowSgno9wY3UFrGKC5X1u2qa3vgap0ZvUtvWdLbNUp
         279f7sUv1TvSHiG/5VOVItGptRBs++BBzMmrWrEMZUw+j68lyWemzwZIifeyYeDOTSSh
         nmWwMD7swX60SaAwwuJA5C3jgf120KK0cjPV0ZyuwuF+g1NR9cGkHu+of9chtXhzr+15
         x4UKDXNE9G8E5OWGhdz3cB/vA6AdtTQiHQeJcSFmHmoda0vtR1KHqDjHNBv7PWJzExLo
         CPRvXsoi+XRLPVBIYMfNACn2n2cSE9ve5nV6j1bU8fwZHEikOzuDHk9fGI7iy87bcn0L
         YrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668053; x=1776272853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feYaYqqY7fSZ1GrhAkbNG0WGZDjQPFK/z2VTC0H0n1Q=;
        b=npNakQYbIbbsAtiLYZBylkda7x4O9bE4hMHSaBwCIlOVSLdpfwFdKe/xV8+zIxRP1c
         cHqhbR/1rFSSiuXDAFFzVS0ZoTobAw14j996MscQyMrRZDEN82oCeAfoPgX5/j4VLymp
         7i2XdFx00ASNtimbe/2xLZF6qRAja99rApakEL0CLYsJyEp9ceniAw9Uoc32zfHG2ImR
         70TrexIMazb/TY4S22MJFMhNIIn5GyiNbf0LehaGB75MtBu7c8NFv/CL4fAtCMadkETv
         flHwXCVlKhfauIT9c5S7N1CXhwOGgUhFaCV6yHOcnGt0KeQHXDPVs0pszKjdSNQBYSfX
         ovAw==
X-Forwarded-Encrypted: i=1; AJvYcCUvOdXNBU8ZNoae2XAurXuGu9ms6dMeL751PKD/mVejdTSDJQUEbDEgpwA/JLsfe9DsiibEfXLLKKYqzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoS1XKfmtOtF3PoOAVYj6AopVGF18pi/8/2x3GD1cxeREwwvU
	oGpazxysY0pDKIT3YkikYfYL/z9ANsgMVJnzTPZRuBp1om6V6V0UFybD
X-Gm-Gg: AeBDieu6g8J0ORcINJ1xgaoeMIHfdiwdBj6yb4ktTQSQ+19D3e01ayb5E9PmMKPgUTe
	4cScbzUNV3SatL18p6s8XJUF0uFmUp7c3orT+NZkhEZr/ZUdiSg0NVTzZ+eCpOYjifa7pGncz46
	1tTb9khKMOoVXV4mnDzzYlAVG08Xukbz/7z0oCrYOe7ZrTKCtm/itslISR0+tg/PmWNJ24aE/eR
	t3sKFCcJ0rfYC+TcatPBkfZcQMN0A5lC+nvqJIHl5kKNwiZn2TzHIccJIljl2iFALSaAwpa5zES
	clh3C7eLq7sMaoi53+q9xyV4gyX3oHA7w+h+hV7eV2kozT0RRxIEMSHMOJzpsG1GVpNJnr/ADjD
	Z77wysLlXav0lygZPYOr1lHh7VBrnZ+6GtfXxKwZGsQSmBbqeJccNSfUJn3PRbFt/HtHhJswmqY
	Cq+VZyGP1YV8E/cUGMVzHw4QZ0MhowrHArCdVLbQP0VdOgB52PY4xSDpNA8b1vd7k2fthV73808
	bY=
X-Received: by 2002:a05:701b:291c:b0:128:d967:466c with SMTP id a92af1059eb24-12bfccace78mr7127876c88.24.1775668053068;
        Wed, 08 Apr 2026 10:07:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e4e3sm18622614c88.1.2026.04.08.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:07:32 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:07:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: kees@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serio - fix O(n^2) complexity in
 serio_unregister_driver()
Message-ID: <adaJ1MJ-Rg9qeeyr@google.com>
References: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>

Hi Mohamad,

On Wed, Apr 08, 2026 at 09:58:47PM +0530, Mohamad Raizudeen wrote:
> The current implementation restarts the scan from the beginning after
> each disconnection(goto start_over) because serio_disconnect_port() may
> delete the current list entry. This results in O(n^2) worst case
> behaviour.

The "big O" notation only makes sense when numbers are big. Here we are
dealing with 6 serio ports max (1 KBC, 4xMUX, 1 Synaptics pass-through)
unless you have a serial port expander and hooked up a few ports there.
But still, the number if very limited.

> 
> Replace with a two-phase approach:
> 
> 	1.Collect only top-level ports bound to the driver(skip those whose parent is also bound to the same driver) into a
> 	  temporary list.

We do not have such setups at the moment, but what about parent's
parent's parent?

> 
> 	2.Process each collected port once, moving it back to serio_list first to maintain invariants expected by serio_destroy_port().
> 
> This eliminates the restart loop, reduces complexity from O(n^2) to O(n)
> and avoids use-after-free by never collecting child ports separately.

Could you explain more about the use-after-free scenario?

Thanks.

-- 
Dmitry
