Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CB281358
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955451; cv=pass; b=jkbVQAPZ972Dt7p+b2MevIpnjn/UiOoQzAwNyh0HuzjGkL41NFazIuQgYGqSN+cEbuOUaX33bynFZ5QLX2ORpx0aUTy5X/KmQnv+0vnnMMyLj1kx5npIjqHYnZQGQFf05KggB3+vP7thJRxbiqyBOzdTf8hvpxykXHEh7QG1XrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955451; c=relaxed/simple;
	bh=ox9rn+Fein4vN11Cw6S/+4g1ZOCYi+K1UH6STeUGkEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnbg919MNOTxSYFM56gABE45m92OqLSKZjfoE1vABRNrtdg9ofHKVnkIiU4ey23//ePHHAhFROZeoEKEsagWtQMkcnrcsjdaC2Fln99Luu1anYlgi7bKcYVjoBowjec/5yMZ/ljNejaD3liUkaS/AkDNFKa9mXjzSUvFf6bYpKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6WMzuO; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6WMzuO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so32770535e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 16:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955448; cv=none;
        d=google.com; s=arc-20240605;
        b=IQJ1brjgj5sFjgOFeijfbvLWLqjvN07egnVNWlsqKh28gaOc2A0L8aO7egJCP7Odi8
         vlEuYB6EKbtAsVR9xB3RsS/sMyQZvw2+9G+iM81MXERHuJGIAbahd2INsXRZEHbWgSLB
         pYgO6nBeh8eSWGwvFTqd8VwcEUbQVdkIO0CCmbQCFWCUEELM7vE+1K4cEOpBssvEkVnf
         Xd4SrixsTz0zVQBhn1XpW6DB03zBkn+Hkih8ybf65Ll0qceU5b71k3CWpXZ3IdN5+64K
         worEdTCTpWrMWveiAi1hXZwd42SLXUteQ1U/oHdgTFZjl8uKf36+2mRQDMnIElfpHsGU
         rGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        fh=XUt83oXgCxL/rrtNLKQbosV0nIxn7Nkx8toIP/K1UOw=;
        b=ESuEQBKydNZ4miyoJW2oEoAvxZbBbE7UXsERmdOmfqTXO629oFTs5hslfpPmeImjmK
         WPK6MxpndisbGnSavSDO2M9xW1ZX9EmsJSrGWKRUDbcPPPiB+FigwJvPEtf5ZdyO2TPJ
         Nt0EhOYDV9I0q2e9fG74nZYcLCvWJmzdp6j0HqYwP/a43il9p7NSFnVNjXcd8FzXS350
         bvo8T7AxjSCn81NdmyaMiDHkiyJzRlgaFQqb7o4oqyTdqJoBhoqmhofSiStGuttSeEYC
         hTid52ajAEgD3ywNl/fVYi2qZrwEbLJzUl8/sF7P96LxkdsTTjg8k2HePRgtwpmAqgRT
         +xxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955448; x=1769560248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=d+6WMzuOVGM/bLQLxmw2aFAMjvWqlrBg6RUn5Qoa2J94ldIROf8HgZ/Z56oqfuMnag
         jyeo+Cq/QA539DAixUPDHVoaMBwiwrrIUVaCE0ZCg99wyZEWC9iGC9LQFo91lAAY25v3
         Orb0jC70NAcfxeE0BPCRoX5xEUotrknu3btTffJ94iIxq7V9MFaZmb9vf1Ros2G6EiMA
         4JPimRtFVjK5fXQqLFsQwRfKNXFBGeXIjl4cvHshUMX4etYqpg0K1ngaW2HAxLSRuTpj
         jAJDyKJBRN6RyDEgIEXWmmZ/um9qo2oG0nB3td3gBxffSelaGxf5102Y2O91XbB5Ob45
         SbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955448; x=1769560248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=tzXq4PdBcjDHH2M73bY1W+fxwW1scsjXJtFLGHeKXg+qUOg5zuaOzej2hCqPFCtVul
         ozpB8KKQpnSZKI54yvhCC3bcMCcBwAnnfa7ZHkjkHIEdftKJB0mAKKohXW6dDupHlAF0
         W12dQuc7GyG2hZNTwtr59bGX1RK9xZl62QuTAhUj/3yLZMKLJWyaVGDnCrqWNUbkwDv/
         8MJZez2PudBU4ZeYvkr5xCcarUajoXuUCeFydKsKB83XL77Csyn+cz4+ChKOnoEoYlcF
         AWK1jt8RL+V3ucV+0EakYPm8inTT02va+N+AndhBgPlci6k7u/S7y/tcHUUDLNnEKRWi
         T1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1x57e9uouwoF/wM7ZdCVew2vg74Vi/efVI69WG8imBoVURg23BQWKcAKz+dN86q8FX9F28PTJlMa1yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmKPqqbWfjm063uo1AOWz3GPLRrXwc1e7nNTwyPOLGqXScA0xW
	kg0TFxOACsOjDB9TIv41g4YPyNe+x9PSM3p8HYTsOnx1FzbXbSvGl+t0RWHE6wjL5DKvnwsX5i4
	wEi/4zUnjgdgBpYt6MOfzwRfP9kngLZw=
X-Gm-Gg: AZuq6aKp+4NfzGWUowoLZShEvLsOjEOt5zCXNDyh8hMMoKeFORIztueenVWK2hO3FhJ
	tMSWsb46iw03h2QZS/IotgQcQ3W8X0z8onAlGkxUi76vDgJw5nBPMAvhAbBvcrm9EF64UkwEm7S
	JccZhP7k8KvTyrQTDc3KthwWJwmzS8T3X7eXT4WxzFmx0NlFG/bRYnPokfj7F0vyswFmS4vN5rf
	WWkvwe+O5h2E6l+TRwTs+ZEufYJjafR0o3PLzcNG2VeaM/jcLSmlm9KaTNQBaI6tOwFQ3KaIPHm
	kDw2iG6D0viYS0zThTarvHZiNu9OesCnoEGn6O7CVucN/QtQXhpJpI64y0c78J1Q7pEKoN0mDg3
	ts/jqRFITTE/bmQ==
X-Received: by 2002:a05:6000:25c6:b0:42f:bb9b:9a82 with SMTP id
 ffacd0b85a97d-43569bd2f46mr20748477f8f.60.1768955447569; Tue, 20 Jan 2026
 16:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:30:36 -0800
X-Gm-Features: AZwV_QigpAt1OwMvxetFLr7YXAAGHgfEc4qQJaCqYbPeCOGL2VSp9FOGATNFtrM
Message-ID: <CAADnVQKtN9HS7sWE_fZex4hT=ZEGDQX+C7tS6jc2+8ixC+Jexw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
> tracking, because an explicit rX =3D 0 in place of the verifier-supplied
> argument is now absent if the arg is implicit (the BPF prog doesn't
> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
> all caller saved registers in check_kfunc_call() [1].
>
> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.=
camel@gmail.com/

...

> -       for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -               mark_reg_not_init(env, regs, caller_saved[i]);
> +       for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +               u32 regno =3D caller_saved[i];
> +
> +               mark_reg_not_init(env, regs, regno);
> +               regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +       }

I'm reading that no follow up is necessary anymore and
the new selftests cover this part automatically.
