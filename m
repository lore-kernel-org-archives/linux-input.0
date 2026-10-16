Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940394CF476
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177348; cv=none; b=XarYgk1OPiQJoqUsX1lbT08NrUO1VlUfaGfgpNk7E1Fts74fBvqsMDMx7/67jMo/ZDPEA3osOLeIHPiG1r9n9aHaaI/E8i0p37iQ7XCVf+tQTXZ125biCBi6ZzaOcmOxreVy5Td0HlgGyfB4pyaMgzSf6uLgbUGXrrRHAR9J0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177348; c=relaxed/simple;
	bh=T9nOMQ6oRt6v8GpIwxlFuraW2nRmfrhcLcC8gx1KQNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfmwdSqXu59nbBNpKHN1HufNv9qhPqvyqAz0NC1kqvO3tTICpRDBxq3YujUv6LMuF5EBc9rNdeO34tdNLTPbZQQ2NCCWSBoicH5pyvFlL0vQc8rf90TboeqH3YGqKLMCkBpforeZ88Lx05j1Z6J/q28HQCNCtHBrylVu7xhZvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er0ziaFH; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er0ziaFH"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f036b17easo557121eec.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177347; x=1792782147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qHNRJtbg7fetKiTmTn1xgl1DSJ1qaU0O+bzAPxfbYpI=;
        b=Er0ziaFH5QmrZO3oHypi1lruruU+5cJ//95P9mLPRuzWz8fU6Xf0pmPIjYfb3y3DlA
         5kIjTas6yOVr0J0g0AlLml084Auo6MnslHMNaP9aylc6CzuZkAv/LcxelIewu2VIwXRs
         njJP7X2wAu8iYcnnLwxjzpde9mwYFmPS1gz28MW0CULy1Yegf4figZi4t5hYoIg+nssK
         f6sqMy/+Q3NkXkfULBtd70WYIeYdgMH8Ub5t4uOXSOFCJ+AYZKBJ7KLOuEaLHDQLYrFk
         Or9JgzcIx6J8H0kaZCzF8psyY8GSdpLn3pCtbyIAyOcCB3lGPcsfYafs5zs0EcDziTzI
         gyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177347; x=1792782147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHNRJtbg7fetKiTmTn1xgl1DSJ1qaU0O+bzAPxfbYpI=;
        b=czP3iq0nZ88K7/uwkMlBB7gwsDoFLSqVXmbXYFn9IeuoGu8FR0iAd/AH69o8wVk+TL
         CifL7VqsEjSsi2A75/+8eo18WzoouAo4ui8qghSDqZdxshuTl4jC1Db84IbLiyjGm30b
         uSvVLkBvk673d1je4JNIVuZ+dT5c+w7rfet7S+SMAxw5ElWFXq4sjnTmhT8fIz/PgoSM
         ER/GF8AMCT1o6wu9I7/R1rz10DHvr/B4fmxsquCTgR7mS/s5ESk31FDxZx/AJEMD77SC
         JWTwUuXYKM74gykp4EWPsR8m0q3IeIOCKAm+7kqgj7VWP/ufkLAizMBUXmKbYvM2nhPW
         Ofmw==
X-Gm-Message-State: AFq9FYIFODmLbqme9ugsOYTqGsWq55NDx8/s1nyiwIfKA69wrNQCWCCU
	TgYcYRMZnqNahPGhB71RHItKzjDzfhxR9YufNeQGmGbc4XMLAYbCCqAO
X-Gm-Gg: AYBFou37lHeXkMurFwPAXW4fhN+MDj7SJLm6wfjTtfcgbO4TX29FBGhCAgA1gCiCvXP
	ArSTQ9aQeJG5W1hs1QMGNv23OP0j+76rB/0rt1mB+1s5NqpabiEjHLrEuqmqVGBed1SnYZjARnJ
	T0218Bq+fBZy/6cJxstNsJ7oqbZnJ2sZo+DrKVH5i/xZYrp+EX4fvLpkDeXdU0C07oAmPP35Td+
	+KD0x8tOEw1V5jvvI9sguG6HaJlyxOdD8VKRlb+5H2UyphCCBa3KAhTPmRPqNC/aiqSsqCBWJN8
	Xf17GNjR7hsmZPahEhDvXRTdGOKugK4eQ1CXJtUQ0lNha7NZ/noxYZetdyvpzb2GQCwWKcgEzpk
	fPKFKWl6/WqzzGmmhkNbAWdoeEk+6siVPN1igRrsIPc3HyzuayMfo14+bsMo6B18rIkChXkYJeZ
	WHa26e2ypIHyaaTavfknO2nRrdkj/1PUtQyOFY4P4iQNL/gm/7nJ70T8/U8YW2LkW0cX3vwoVFR
	xMfprpcO+y9q5w52WicUJ8868e9ltzO9MeUZIXGrftniRAO2wk=
X-Received: by 2002:a05:7301:6f0f:b0:35f:2349:a574 with SMTP id 5a478bee46e88-361a2e2e6a7mr822854eec.40.1792177346416;
        Fri, 16 Oct 2026 12:02:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm8212639eec.9.2026.10.16.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:02:24 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:02:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jame Jao <jaojame6@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [BUG] Input: atkbd: REDMI Book Pro 14 2026 (TM2426) needs
 dumbkbd workaround
Message-ID: <atJz_OR-rIVb-RDW@google.com>
References: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>

Hi Jame,

On Fri, Oct 16, 2026 at 01:41:19PM -0500, Jame Jao wrote:
> Hi Dmitry and linux-input,
> 
> I would like to report a built-in keyboard compatibility issue on the
> Xiaomi REDMI Book Pro 14 2026 (TM2426).
> 
> Original failure, observed on Arch Linux 7.2.8-zen1-2-zen:
> The internal keyboard could not be used after Linux booted; an external
> USB keyboard was needed. Adding i8042.dumbkbd=1 made it usable.
> 
> Current verification (2026-10-17):
> The machine still boots with i8042.dumbkbd=1. The built-in device is
> "AT Translated Set 2 keyboard", isa0060/serio0/input0, with EV=100013
> and no EV_LED capability. There is no input Caps Lock LED interface.
> I understand the missing LED interface is an expected consequence of
> dumbkbd, rather than a separate LED regression. A local userspace
> workaround writes SETLEDS through /dev/port; it is not an input driver fix.
> 
> Hardware:
>   sys_vendor: XIAOMI
>   product_name: REDMI Book Pro 14 2026
>   board_name: TM2426
>   BIOS: RMAPT4B0P0909, 05/21/2026
>   EC firmware: 1.9
>   CPU: Intel Core Ultra 5 338H
> 
> Current kernel:
>   Linux 7.2.9-zen1-1.1-zen, x86_64
>   Arch package linux-zen 7.2.9.zen1-1.1
> 
> This is a locally built zen kernel with a small bitland-mifs-wmi
> suspend/resume error-handling change only. No atkbd/i8042 or graphics
> change was made in that local patch. Kernel taint is 576 (U and W);
> unsafe xe options and an intel_bios_init warning are also present.
> 
> The current upstream atkbd.c DMI table, inspected on 2026-10-17, has
> atkbd_deactivate_fixup entries for Xiaomi Book Pro 14 (TM2424) and
> REDMI Book Pro 16 2026 (TM2425), but no matching product entry for this
> 14-inch REDMI model. This suggests the same quirk might be applicable,
> but that is only a hypothesis: I have NOT tested that change on TM2426.
> 
> Source inspected:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/heads/master/drivers/input/keyboard/atkbd.c
> 
> Limitations:
> I have not repeated a boot without dumbkbd during this reporting session,
> and have not reproduced the original failure on current mainline or
> drm-tip. The original no-workaround failure above is historical; the
> current device capability and DMI information were checked again today.
> Please do not treat this as a tested patch or a Tested-by statement.
> 
> Could you advise whether testing atkbd_deactivate_fixup for this DMI
> product is the appropriate next step, and what diagnostic data would
> be useful?

Yes, can you please try adding a quirk similar to TM2425 and let us know
if this solves the issue for you? Then we can include it in the kernel.

Thanks.

-- 
Dmitry
