Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA7219E8
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243035; cv=pass; b=m0/nNiKuheCfjZG0hBWEezpL6obmoIdHlGIiCZhOLWoiIE1y6/t3SKPK9x+DAQD+DZ/KEusyDynk7gjXM6gc2zwz5UEiMxmfaCcDO0YzpqR0uZ5AxqWoE96qeM+METfmhImCGJRmYt6n7CkkklMjfVaMrYfA3ez3yfF58rEKBQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243035; c=relaxed/simple;
	bh=UdXKq1Z08MfDjVf3UvM0lSQZNqNJk0Y2QOCyuFIplP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV91YktRdwJUJxLM+3K2vgNnCF3z/gHuc+y/Lv++rwL2Sy7QA9lz7OCScgEFw4i5uJDp5nacd3m0mLCsJiTMhzi74Uh18gPrYDLEC5HmmxM27HZkST7h+76gVmSFMqDRkgutXik+nAPG5qkVxPCjW9eP7XI+OsEOeruyw/Z73CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFOpFNac; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFOpFNac"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d1872504cbso3518621a34.0
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 22:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774243033; cv=none;
        d=google.com; s=arc-20240605;
        b=EhltPG5h1O4jH0z1tpAy+LmdI8FrIE7zeuUFhvGAm2P7TzgtbyJJ8wCMfQcwiw7vpU
         UeyWkvz5C62JVCZkxD6tvcJaQDurMR1sVTSFJMO8nhZB7WtYXS3sPS8izI5uSzjst6BK
         csRKpTCUl1nc3RhDBUGGfkrQLJenqNIU+iOww/dk8hH81/XE+h/qnAKGowLVpF1KjJPs
         o5Rb8qBXrFroclwQWoqw1+w7M1q+eY0NjIeVXS+JmdgwwCYNbtV5R76OYC+ZzRQFHzZF
         Gc/eeN0u0Q/XxoTb5smdFnguh/5UNx+fOQ+ls2KYbOoKAMdPE4ldCyuPzecMoeaPj178
         yCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdXKq1Z08MfDjVf3UvM0lSQZNqNJk0Y2QOCyuFIplP0=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=AA2DA2quMZQLts/uBTQwXfola52zQA2hjZ0mDAus95JCca+LIaWDX67kTWtuBDxYad
         g8f34yNHY+foC7y1PbHHupi+T32zJ/XqJgFV4IZhSnn8cMXDn8AUS16B7JVMixoAF+UA
         Rsne+6JwARkx+2LeJ3oeM2T1DzdHxJGwbCq82UOLwbjqpJR6ZZ/Kdb8hbpnPZj2Ydp5t
         18nmz8I0roL8Huo9uRpq8YkIqM1J37p7+wISZSiNIOuVWbUGeHpblQ4Yl+0dRJmAB9Q7
         e33ruK+ugM/BroaTQA3bzXUHkiYHHVBrKAqgCW7MTKazOCjoUVxr9ivO04avXHra2Nxh
         rQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774243033; x=1774847833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdXKq1Z08MfDjVf3UvM0lSQZNqNJk0Y2QOCyuFIplP0=;
        b=RFOpFNacaZC8FTfsLZo/QFwBc3e3eP10g+XOFRHTCm1OfPUL4oUjzGwCwRoYZEkUf9
         L7BvEjdQE8UIWWPDUeB85011ys2e6NQdjHOl4sLXwFJgTokDS5VFfOipCJi9DA2DNtrN
         xnKlWKMnkkp2BgQAG7x5vpUYLLTYvvcFcOGXjQFRvnMws7R0cuIyks05Lkun6niInAVD
         W6PlLgENtTJmD1pvi05ewzEU3a6KlW4m4RH58XlDc+BFvqTSM0wsYHFG7+AoKXa4cGDz
         CsMFMeCsxUSschrC60KX8RjeMFBxJxOvnhAc+vgH7l2FmCQHnT32PtCAaYdeA4+nn7XW
         mWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774243033; x=1774847833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdXKq1Z08MfDjVf3UvM0lSQZNqNJk0Y2QOCyuFIplP0=;
        b=rtcxRcQrFCyQkdHrYO/wRnWIxbSZ+EFqzg9VuHlCJnH+fvl2/+WgWHXkENNoFt6478
         WEgOPFn0uXDnSB85GIwfWd4u/EygPupjQAVDwHTu0TyDM9pSS79tvyBefJ3kkc1C1foq
         yKwBiqhROSzyE8IxCcz6ISWaAlfhLdoBcwyU+MIy1gqf8F5bRG0QKftRIm2cJJGPSoV4
         qBxa4D67xnjZacZzMtwOl4lPpmFqQYb4CimNtgSAFrssy246vPywSRSyZLWUosvAOlyr
         GSpfFZPOgh/59ra4LasMmifng6xyCXcpvqol1p0gQrcdGI1ByDwRXQvo94guPhcWAUv2
         WDmQ==
X-Gm-Message-State: AOJu0YxIruHfy4RTll4U5cPWoQ3AdTIC0I2nku2RRThNhGd1QmfK3fiW
	8IgWE1pWHjirGMgq6vz8qNTBEfm2zGNyHxuPdnM31fcktOtIMvysCIPVYqu73j7G9KThook48o7
	Sybq8qc96C7W4y0BWLQQfvK3H7E7vcg5/Bj4y3Cex3MvE
X-Gm-Gg: ATEYQzwCG5o02v6bIdmLb5FpJxQW/ZtRMrHnbo/6jNTgkkCehoYzq9c5086qaeNIIQU
	2b5Nhp6BunyTKXPo5j92rxAWnuTAcHFNKuLdUJKWN9wxQZTFuMztFMiTVayA7S1Ish8OF4tQ6qc
	4Is9xHizxtsmxgr7EfEnIDraicPH/RlHbsGe9epWuwLxuMnYqYC5BeJQc7eJaKTRM/7LuUz6JC1
	36THWd1h4LlW5qeKb02oVs+1wrO4GQ7L/zgQXftLnonV0zSrhre+2octI/DIJFcrxXsvZmtoj85
	DwCTkxpHlQ==
X-Received: by 2002:a05:6830:3148:b0:7d7:cc47:9623 with SMTP id
 46e09a7af769-7d7eaad0866mr7928378a34.10.1774243033457; Sun, 22 Mar 2026
 22:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com> <acCpW6McaPOE0Jq5@google.com>
In-Reply-To: <acCpW6McaPOE0Jq5@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 23 Mar 2026 10:17:01 +0500
X-Gm-Features: AaiRm53nOUp6SCUYn9hkkKQdCYAOA8tYJeFzsWWyfvFPlEv9FDr1aPczIYfzwqA
Message-ID: <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with ff-core
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:47=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Thank you for the patch, it looks solid, however I wonder if creating a
> separate "state_lock" spinlock would not be better than reusing
> requests_lock?

Hi Dmitry,

Thank you for the review.

A separate spinlock would certainly be cleaner from a naming
perspective. One thing I'd like to note though: the current
approach of reusing requests_lock has the benefit of atomically
checking state and queueing the event in uinput_request_send(),
and atomically changing state and flushing requests in
uinput_destroy_device(). With a separate state_lock these become
two independent locks, so the ordering between them would need to
be defined.

That said, if you prefer the cleaner separation I'm happy to make
the change. Please let me know.

--=20
Best Regards,
Mike Gavrilov.
