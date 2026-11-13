Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562575;
	b=LfKlephQx1u0qOeeoUs0ay6A7YInZrdOy2jaclPS2HU3Pv+xmBl6Ti51nZWSY6YQjrZW
	 dAzo/807VjNdNdv5trobQJBU2KgwE0cem/TCybo9nVIx18BYE/kilJ+KDTwW9PbtBUWCI
	 vMHwzGMJzq/Ax1BfkyxbxyJPaxyUGxGiDmbKSzdoQ+y4xIsuXlqCr0l9ftXiXHIomvPcu
	 +pvi73t1KBM+3xk1sZR5KCyL4fOOb/koGej1Q8EAJmFDO5JLpYIyUxarNnErPCFAG3Lh5
	 qqXDSggdYSur594pliUcwigGgsIjBsmcVwq0Vfd0DH4LhfU26mFwDNybhqedDRnrGow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
	b=qMc9wFJeLLMLFtb5pxI3gL6xwWx2wP2AfJ378WqQf79VNOOIBoo0X6iwDSHbs3glAm5q
	 Wz0Fo4CieD2ivK1NZRBkZM46blxAf7UHsxEKblIVQiBmmtfg4tUT124W8507VMV6ylaSp
	 sJNPndLL6BC1eAvc05jRhggtP0g9fdvvKmVbbvXbxUIF6OMUHe2CORRBmWdzY5X0qikMf
	 qjhvo0ISrzQg0Cd2QeqvzC3SAJ1wsqa/rDwhPQJZiktNGTjH+9aGFlGtJsJ3nFZMDTDZT
	 n7fs2owQ48ZZnh9lyaZuVc5KnM6IvpN2lfgCh8dJx6icmLGwvmAFTto64kAJd5EAzbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpnUGyLj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F9606A330
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6F9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpnUGyLj
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b335ef6441so6317687b3.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562574; cv=none;
        d=google.com; s=arc-20260327;
        b=Tgjh7mVzWsQj5wN0UVwuZ/UG11Dj/OJGfG1riNUQXP6cLWeABojoKmDW4Ky4irGpyh
         8V21Smk+OrAGGCLZy+btV1pijUFPchcLciC9HW0E9B2NA5550UtWywS56TLYt+ohAEZJ
         1xsUEkrUUYrNzprVqmHWnz//hd9hQwZhYQuB2mqkg1C9+u/SY48okfMaGYkI8jB8oGfC
         gGp1CiJ1XMgU+m7uSVLFYjzcwVIBZtzR+SvNOAXFS8CivDgnt9rEsjU5lRA/ULjurNI0
         kiYfiCQDyBairCbuovhy9qla39dcj0SgRF8ruVTkanzG6aEUliWN8kW4KW6cUx/BWWMV
         xHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        fh=wnpYC/+1NLnRHNQETAfa85t4Q/iWWpSsMV1jBHh9MnM=;
        b=IGyrnFdzwRyRmZAFkixsj/pNQ9+81FZSH6vG7WWuWQx4e38rZnjt/EA4X0y6Y3zRTn
         OGroLp9dn16x0ldXypUy2XNAzbcJ+bAHe0ns0Knebb+Fv2frUlX+ov8JnwxoMk8zJDH9
         xoypUhatyN/tmFGfcFXf4BkKqYSItp3YxstWL+mnO7TCGcA4J6cDVolztstJDakjv5kx
         559t20YDX2/HPxNpq1FgR6I7sdu/NyKuqrGcXjhjr5dJtqxJF+C0dIsuiQQ9pMuPE6cH
         wkWdgGtmqV7YnA4QvNt32v0nRhOYbdlxzwYBIxIOTb8eoE/rUilEt5U3bd3TljB8Stb/
         cxgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562574; x=1795167374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        b=YpnUGyLjwTTMPc519eNPTuVbLmsWYvdED+cQpDTOEnZxKB07dA5nbVbtkstlarUB73
         RZnRl/1o+zNgmL+pkoBsibRXQJ71EGX9qusasyTyKNUeIBw78b4sX4evsWbZpwT4+UzM
         4hEm8ZGZ3mRoPT0rbBalEcvgZvIx5b50uTU/oaP+kaV7CRLz7ifv9diaRVNC1qHzKDfZ
         RyYj1B8nTbpTnVwkAQEj4TK/BSokn227r1X44UaZivMmuxPDhLPnt2hddwnfpgcIX3TW
         K03eFfJvb11MekZAL783ZRSu2xueeP/fuxr2G4FlS/BM0dyCO/sY6ANNlp46dhFmvvrY
         a6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562574; x=1795167374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        b=Y8IXUu8AB9OU9FWN6U+AJh3XU8o1fvqPHkW+0pg1tMw4a6iBiKA9uTAVTgMZayWQvq
         HSTyvIGZnh6ar/oh4r4Os9GXxwAWgFqpWYoN1Hjt2piZU/K4GkijEkfbYPmAffiKMl8b
         VcK14o+B1Z97VUpX72+w8w1EHcu7X+O49ejNHB4BpDeBLOcn9V22BeUcC9YaktwOqvcf
         nDuvC56U4BRaS+0ZLUWuEwhVrSFVWYOfZ55IRw3jBki2twMinbkvwGYjZwC1R+XZ/T6I
         zTi87LD02ehxIxQiaGLP9HLOXOy9ykts9FR1iKQxJGJvbWgAf0ktFFSQ+fIXv4k65BYc
         Xv2Q==
X-Forwarded-Encrypted: i=1; AL+hErE2gPwR61m9hz3AtFcyRfqKNNNsqys0a3FaFLFqg6MeWDBz5xu9ku3xcDYQUDtosO+iD/R0LWTFmEhKpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xH3bhhuX8Xsh/z13Ye26c0t2Dn39H693vB5SF0aNz1u6oAIV8
	VOg1nuY3UB1DxkZv7EBTTdl19QNMCnU1oHNJEz7ZoeBLd/z6RPbyYzt+daJzntvBZO+nTLKX85C
	CnR7jAuqDJ6jQQOCzFi22K6C/a1zqDCs=
X-Gm-Gg: AYBFou2w/vgit/5WjW+YXsLCzjlzY8TtbJ6N2V9qsVJLzTjzHZLhZxxVYuWjib4MgYE
	pWwradKfm9JS+gCR16kduJafb9zQwu0AEtQdhtHYQHdtOz6nDHAJjaMOFJyhIdqNjvCyFGBZbRY
	SfBabPzdCea3OkneePjxqSRnZiUN5+zX7bhGm3EgN9fBePyd3vYZk1hYsRUUNemnW5uphFw6FSA
	rZAkBB++BJhDHPew9Nkt6FFJmddyiEnAwxlXYI64Tv8wqa+Q0nCVOD2op6h6vXjKdPMctsQiJe6
	pNaq5rMAfnpVJr22efoP8Ue7QpBMns0ZjCclV9LHCPzOjNumHe2XcHAU/3rwEyf94qfvwoyRBHM
	ccPJmIA0iUWNEDNdxYDb7z/veP5W/HZOhMNAnzw+eey3jrnX1Yh/RvpTkwyJTppClgGjydOrFdP
	YGYTeJ2TMzDxH3DmSr8OwCTaVxoziHbzmjIExbkw7Rbq70HipBplKdMkeedY7eWulcP/urbaTLh
	9AryKWmTQdsLT+9uxzxTkDzJZ+FXevQ70A6qXvrLYm0pwJAf/+aXFE0CkIFRb/0s4f0H5qSrUed
	l+HO+10=
X-Received: by 2002:a05:690c:82:b0:8ab:6374:5629 with SMTP id
 00721157ae682-8b4aa2efb9dmr11468797b3.30.1794562574285; Fri, 13 Nov 2026
 01:36:14 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:35:38 +0200
X-Gm-Features: AclHuK8mf3feDLq50Bt1BSFwCDhuFJWegSiz9V4F_TUQJsU5rvtBoffQnUrSgRI
Message-ID: <CAHp75VcY4O-kgYv9jN0vSiU3Y8FeFDWAojeYWhOuKJuzKUXFCw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Input: tsc2007 - fix minor coding style issues
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Fix minor checkpatch warnings and checks across the tsc2007 driver:
> document the mutex used to serialize I2C transfers between interrupt
> handling and IIO reads, remove an unnecessary blank line following a
> loop opening brace, and drop extraneous spacing after a cast.

...

>  u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *t=
c)

>         if (rt > U32_MAX)
>                 return U32_MAX;
> -       return (u32) rt;
> +       return (u32)rt;

Do we need explicit casting?

--=20
With Best Regards,
Andy Shevchenko
