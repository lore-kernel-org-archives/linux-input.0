Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A82D238F
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972113; cv=none; b=FxzWupxS1jogCrqnVd9ngCjtEaf1y2UF4RN4ffsTKqcFCV8lfgNGG2QJGHkO+lRE4yYzgNyD3bWVJBL92nWqBo//nL6u1WdMcqLMzWNfaFdifZee4Je/ESHPFeEDZZGiQ9u0Ixrormb9BN//xjZEOJKU4h6nrnkEKZ0YDwWZEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972113; c=relaxed/simple;
	bh=kma/sGshPQ4GC/uZHT6F4UhQuiuZFZsIEBUBBjdstMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZO39pnAHwLYoBw7Kb4PCqu8TBykHzq3bgyFjwwuGN62d8ay81mvVCEaTh/XZMhTcyHRd8GwfoHXL7kSLwEm6EUbYNcXh5ewLFFUTzjiclBVKkeVjWxx2HznCIjvOAWGetytEaqrL+eHi3M+8bDEMu4cKu7vF4Nl1baBd7F4Kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JKrgQQj5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKrgQQj5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so4516680a12.3
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777972110; x=1778576910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVObhnI3d5P+GOd8LYV4dRecKq3x9z2S+zHFCnUm1gg=;
        b=JKrgQQj5pBXnY7Q3BdL5lytps64yE/s7Dwta4Kogh1VYpjCnGQe3QeCwJeh0ZGXzci
         9IPjC941OF13ctuZkjBoUOnz4X7w354zzncvPoKufKAtR8S1Qm1GTMw7Iolz+BSwEa3C
         vj9lk+JQMU6u1wEUhJTPhfozTNPaSigeAUB4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972110; x=1778576910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVObhnI3d5P+GOd8LYV4dRecKq3x9z2S+zHFCnUm1gg=;
        b=bn177GFjNu/UOknbbvCA/oSFyeWf4Rm/J7eBlSTik5CmsrNy+kE/naFJ4dvNLsLVsZ
         n+kCHNCfu9VryifUySpk+eiw7t1/GmGEtAbQY8F7AbyTbsutuBsmyLFQkVnrNLw6O7LF
         DHaFFQHbE529l1DqZlaxStWd5uNT+Q4lyueGCfNRXejU5xDLkCzXqVnK0JtJ3+yyGFEp
         jLXhQSLQ/md6rml4cuF2/bQLR1O3Xo6vfT7CEzzZsuwQuPBzXhfgzO6JxOU0YW5HQJ6n
         BYPTUXvlrpWaXw3Kv3GHSoPVwj7c/C6krCgaQWwxF9y/dMfjKEJ68jBFHem9Saehv40D
         LkJA==
X-Forwarded-Encrypted: i=1; AFNElJ+olGVPPwHGEWA37c2F364Xetei9qzRp7YhfgSWDoWjiWEX930bnZQUAtdw8UcOGY2O73hmPpN2/GndCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGM9Kygn4cR87V/s/VzqHNoI9vsnF+bOJwGlvOvHhzDUj99Qlx
	Us2HIgWlT5N7jCdyEUZU99kdCaVJZZN2XKnUdjtOIHxwubBJHCK30w47gx+GyBdGyfI3YR3qcnf
	XyPjf/A==
X-Gm-Gg: AeBDievotUiHUCnNy70P4+ovHSh7AFJK8i6iaE9scZ+x9beKZmRIYaFZ49fq69B0u/x
	bYTfo2qKZIGrg2sWJr7hc9MOC2mCxJOvghes7ovj4iPi81Wg9ye7mLZx7mN6+o5MeOJaTrMF6q7
	Fdz/LBXz8X2Ceyvv7c8CXZH0SCiFUmj7pYStZM4velwLogXXkx2osFm7UsF21hm8d7swdL6Lzv/
	cSSBMAwtECZ4NrI9DgWWOHPYtrHGvaJNLwZet8Nb+A7tVDAswJb2XEy5adYKp+9avzZiOwn6edH
	+4lIlFki4KYdAaaFch4jthz1cXyJoESowgk0SfEuj/Ya3DvrMjJROiBv4PB6XjlWXkbZ5j9NiQE
	YRsK+1ia2vfCEjGwoypqUQwV7rlsjdBGoIiE8jDuPTCVdKa3M+bXpeM1R1Z3GQUL97u7kQRnTIc
	SMcRiMxQGae3m+EJKyBxxehUYwPoKrKrDsBKgFCFjenllTpE6D0tWAk2nw+3OvVFvU2CWtres=
X-Received: by 2002:a05:6402:4401:b0:672:c1b0:1f3d with SMTP id 4fb4d7f45d1cf-67ccab1d9f8mr1061466a12.8.1777972110209;
        Tue, 05 May 2026 02:08:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90efd68sm227160a12.9.2026.05.05.02.08.29
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:08:29 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so4516607a12.3
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 02:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5kwJBLKfDqTrS2H0nj3BmfVLqFG/9h1rluPhWs2pf0dKqQpFORIjZsIAQRDJV+1HdpXzXTq0nD5Gpxg==@vger.kernel.org
X-Received: by 2002:a17:906:5189:10b0:bc4:b9c2:ae8d with SMTP id
 a640c23a62f3a-bc4b9c2b84fmr9906566b.38.1777972108095; Tue, 05 May 2026
 02:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 May 2026 11:08:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ift3Zu08iVItBFfRjTkel5VOtDKFJZArxG2zIKfA_4FKrlMSGIzZ5bxOY
Message-ID: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

HI Dmitry

FWIW this patch looks correct to me...

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

But there are a couple of things that look weird.

1) The patch line (1503) does not seem to match your tree
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/atmel_mxt_ts.c#n1503

2) The sscanf just before this check has two conversions (val and
offset), but you only check for ret != 1. Should't it be ret !=2? or I
am missing something?

On Mon, 4 May 2026 at 20:54, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> When a configuration file provides an object size that is larger than the
> driver's known mxt_obj_size(object), the driver intends to discard the
> extra bytes.
>
> The loop iterates using for (i = 0; i < size; i++). Inside the loop, the
> condition to skip processing extra bytes is:
>
>     if (i > mxt_obj_size(object))
>         continue;
>
> Since i is a 0-based index, the valid indices for the object are 0 through
> mxt_obj_size(object) - 1.
>
> When i == mxt_obj_size(object), the condition evaluates to false, and the
> code processes the byte instead of discarding it.
>
> This causes the code to calculate byte_offset = reg + i - cfg->start_ofs
> and writes the byte there, overwriting exactly one byte of the adjacent
> instance or object.
>
> Update the boundary check to skip extra bytes correctly by using >=.
>
> Fixes: 50a77c658b80 ("Input: atmel_mxt_ts - download device config using firmware loader")
> Cc: stable@vger.kernel.org
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d62bf2c95578..28b2bd889c70 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1503,7 +1503,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
>                         }
>                         cfg->raw_pos += offset;
>
> -                       if (i > mxt_obj_size(object))
> +                       if (i >= mxt_obj_size(object))
>                                 continue;
>
>                         byte_offset = reg + i - cfg->start_ofs;
> --
> 2.54.0.545.g6539524ca2-goog
>


-- 
Ricardo Ribalda
