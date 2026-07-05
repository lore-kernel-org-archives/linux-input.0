Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6B433E74
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783250226; cv=pass; b=F5+0axYo2pSW/x5JCw87zJuW3fbyMPyD3dPB/q9basdo6c6PhB/UTRlrNb0epsueiQs24PoASdugimysu7tnkFl0KuxhXvPp47ZHlSYgVKdLqiM8+lzLHQi8Bo8oI/47nVgH4bPZtCbYm8aKV+PAYmCxWkdJZBWuwY3P7aQpMuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783250226; c=relaxed/simple;
	bh=URFNGBnVyLaCTy03NSUjDmt/gri6tPX81p2F/VoVBVU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2nyL0RSYAR7MoG+P2l3busownpMXcQP4jxF2buCR6HuU2kCbC1UB82qdLIuPYF0ey2xkbSXI+qXLxArIcpwDVSoHRVOEEJ+3rK8A8bzgr3uoVzZn4tgWRO80GGqBsJWCaDxgQrVkqCFR5hLSpJoYl1tPsStkcvW7fKVXvky6HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR1L6KkQ; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR1L6KkQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-472326ca506so1309480f8f.2
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 04:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783250224; cv=none;
        d=google.com; s=arc-20260327;
        b=Hw2K3Wut6jseO4WWk/fxdc9eoOPLxY31k3zivS7XaGUYBsl1VfpG/g3sVePeNfVqAi
         lfRF8mUguwuOt6aIRglz0vmouDF4zPiYgp58Iwyo+zODQOt8FDVIp4QKfXHJr3ks8fFQ
         JLpRhelKzqYPwSgcfFq6WO3Z+8QqNHGAQvfSERd0Lg5h9W6XSERoBMvJTYvNjny540u0
         zYoYNJsDsxPyqyC4vntoppCwfJt9UhGkjQJ2dka/GfwhFjL1tTpUItlYufpUi8hafAgY
         aw2suk7WD6S7MSSp6qlbLAdZZsWZyv7gWlgPH3k6t8qkfnvRSWedIkXv802+1CpCiPXp
         UQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=URFNGBnVyLaCTy03NSUjDmt/gri6tPX81p2F/VoVBVU=;
        fh=1zWC7zmSUponIFyMjue+5uZp8joF2aKtWEWoHd1z4pE=;
        b=MSGVEmENBZo+uU13iPCv1kCPjSfnd68DwFJ+/+848XKSMfYwYXmWmVtDd1lEYliJQ3
         W6Lr6n6Wp4HlOp8d5G4Z10JniW8Kgk4n9T9TASGUcF8/rrAnoDKtQJZq+8atRD5GYJdj
         /DRITsoepOMK6fK8wyLwlsW8MhoB8NH9p0MWOx3OKpN3xQm9n+nZ0Inr9c+KAtpWFnPE
         uBHHNt9z9ACilq9Fu4tDGs/jdiwZvVDVM+XpVZS2N1VKada4i/dx2v7oCL0TFM4jSDbE
         5bkHmlpBQpLAZszKStTFAiRHEQzY1a9kdKuWIWQVzOg8DXqyCTCtNCIaXvFmWZjH5Cav
         MGVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783250224; x=1783855024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=URFNGBnVyLaCTy03NSUjDmt/gri6tPX81p2F/VoVBVU=;
        b=lR1L6KkQBjhSfWvv8XJe3wp/q1otiZjeRPDruymQq5pBZLH5LVwlw7jTJ/sqRuuQxm
         Iiwo1mHRgWa+1zBZCh0OcAyZxlePwj5JIY5jAQozZoKNMMYV8GyXBI5l5GA8jTnLbf9p
         nMG3WdMMA7Jl4JZBU/LRoHpEKeoTGQDrWBYEYilFUkbDU9Qzq9sLUTCvC+w8SH+eSxyi
         R50HCJ/xpkSMAp3M/QHGNmbofxzLsTyA9Z4TffPZ7m2/2PxtclHEsWZ6TprYSVY0qOWy
         76YJJiLI0/IQL/SgP0fCcBCNar9/8yov8iks8CR7nLFu5mMyxAEYk+5eEzR/AsxjCOa0
         1t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783250224; x=1783855024;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URFNGBnVyLaCTy03NSUjDmt/gri6tPX81p2F/VoVBVU=;
        b=QWEc57Ozj1YwAjxdgeVVMKtciiLZ95nq40/9achOm7J0JfldGWybjA1bga8rIsqE2l
         oKngAfHjvUzOqqxn4s1QGtBp4qUOdsVA4Gh/ztzfynfPVxGgxngzbxhhWxjEj6XIJF30
         Uo3hxLoiOTQxjPB15RxfJ9gpKxkrOzqjJ8s5NRSEIlfXgd62v4IufFCIlEfFTaxLb9es
         jKMmVghKS4V25x69m9GgDTY7+z57+skK3MpD8oSQiGftSX/yBXM461qg3bcYgddsD93P
         bWf7uej2VpaFbbaS6/QMPoI3sEHQ+mV+6aEENPkzfzR5x8YOp4qfcpSEx6YNpoNJBQIf
         uOaw==
X-Forwarded-Encrypted: i=1; AHgh+Rodep6/3R6KR1MZMNQAjdVGntr2k72eRWbwmKwH0KlHrhmrukbUuEN5kWYHYbOJYWKY4g7/+8GDrJfAFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEiqF6qqg5ox7113RTaLDrrgKN8oISUytIjVU7Ke0N1B/qlTx
	hkOvk76Vj9DfARlMAIquh9LafEVyuiXQU5UxA5fogpQh/9dc6bTxl+ScX35AhMBuKKSOimmKiZT
	a4NgNEknIwf636EJF9lNI77cq6pTLQiY=
X-Gm-Gg: AfdE7cm9j4biRt2SBTlop0XPkIpWCw3yL6tpmviaa9GCUJoMNuhmHRk2ZO1JA3wSA64
	gYI9t6eQpNoAOdyZO4065/rbd8mJ8OMqLxKfZQtlJa0iA6L0uzetRz5YuUtEEeUB2zjmVLM9bEJ
	XcEcMWj4VP6aP0QNTuAlOwWAkuF+FMlzP6vmu+Be+wF4WvYb9odXXJRU2ZjejMfzuI5CaPDi8Vv
	v0qmjoVmVsXfHCp3kpEy2GFBFnxsaZAf2j93+njx3JuGjfVGN9+9QBzOomrzEDgtzYMXwo6
X-Received: by 2002:a5d:4743:0:b0:476:82f4:4dcc with SMTP id
 ffacd0b85a97d-47aae2c5ee3mr5597377f8f.33.1783250223529; Sun, 05 Jul 2026
 04:17:03 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Sun, 5 Jul 2026 11:17:03 +0000
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Sun, 5 Jul 2026 11:17:03 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ca5a59eeb522bfd949f31e2416639fd@trvn.ru>
References: <20260408051907.792-1-thanhnguyxn07@gmail.com> <CAD++jLknVJYLc0-StNFcN67pUDRQunUJvNn-Npz+HJ-j2WXB5g@mail.gmail.com>
 <8ca5a59eeb522bfd949f31e2416639fd@trvn.ru>
From: =?UTF-8?B?VGjDoG5oIE5ndXnhu4Vu?= <thanhnguyxn07@gmail.com>
Date: Sun, 5 Jul 2026 11:17:03 +0000
X-Gm-Features: AVVi8CdNMtcEc_5fOd5FxtYvOfHn21hWnd9AxM2bv5UAklGLCxMSthmASfUpCfc
Message-ID: <CAPWvNi7ATfEKCC6qn+DTHnSLJxXamYiiNWA+1JgQmw2RG+PH6g@mail.gmail.com>
Subject: Re: [PATCH] Input: zinitix: iterate contact slots by finger count
To: nikita@trvn.ru
Cc: linusw@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, timon37@lavabit.com
Content-Type: text/plain; charset="UTF-8"

Hi Nikita, Linus, and Dmitry,

Thank you all for the feedback and for confirming the fix on your end, Nikita.

Unfortunately, since it's been a while since I submitted the v2 patch,
I recently had to completely wipe my development machine and no longer
have the local environment or the original patch files to create a v3.

Since the logic in v2 is sound and the only change needed is a brief
comment explaining the dual mask/count nature of `finger_mask`, would
one of you be willing to add that comment and apply the patch on my
behalf? I'd really appreciate it.

Thanks again for your time and help with getting this merged!

Best regards,
Thanh Nguyen
