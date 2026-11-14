Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794617040;
	b=2KHJ8CpwQ9vFBLeah5fm5jAJsW5ZEakBhLimR7O3X9GAYF58Ga5wI9KyRc7IcME78xFN
	 JsKb+T3MyDR9J9jk7CDcgSQAeyJmZymyNb0DN5qAMS4PBFwlFr1oqRcfiBRgxTgdQeONQ
	 XI42bSVAV4zX0AHK5teHkFfWLbzkuEy93RmUed+yIoHiKeAXRiXBqa1Yqex/XDQ+IEE7S
	 t54F6M++RwTDUm6kZJ8MoCJX9cxFTBFq3LjxoZFVypYXRssUvu+Y3MNdI9f4JBqkTkaHm
	 7dkFAEM6vLRZ+yHUGRUa45foWqW4fSnESkxhVn04+Mv5njVwQwHDrVXfbCua9MqHuAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/SKaeZs9UUdBSjEG4Yxl5VUOK2mO4Vo9Wp0bSATsDS4=;
	b=BYPzjaANDlFzKLf39Rw7UMGOlHhcsHxlsR5IF5wFjPnzRBtyIrZsQbTZ4piXLLUSEyhr
	 zcxIx5yvATijD9i5UbrsxqdRQxpphIOhzDXlda6Q3t3cHBtpnIvy0ZxlWUQn0Kwo7kZNW
	 HDeBDrjXXdWvvqOgSpnCO48LE9JcJqGAI6b1qZe3XW+KWFZGC44S4kxoeI+R+H5nmMpPb
	 pdiGP44H65USR96suf3fS46cjfwjaWgOIWBeTRxfVv6lfdrINbFlyf+87EwpHWkBiDHIb
	 OwvKDyxkor6YGCOpemcB19OPq+vrlZTF6wZww+PGzu2Fm9k2HYv3YzZOSc8/XY+EtJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIiPboA7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A6606A334
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174A6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIiPboA7
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0d126f631so16367947b3.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794617039; cv=none;
        d=google.com; s=arc-20260327;
        b=d0BgGRSSaZsCOZRrYj04G/mRXGcRtMNtbvxbsRXhT8niHD4TiEUewMd4u9TFGlRrFB
         vT6lCM9NIqJvXTAUgXU/KauMp4KZoyYnJggY82aDhuswYs3of3qRY5MQtJXAmzzTzGW/
         RgmFXDBm7k1tPSBpbhgvrI8Qo/KB6GCWFUYoymO5HpN2GLFo85blkMfnG+8oFvnaHBNW
         2HKZHXRKMKuGszrU0FVqayIdx2zCQy7e2b/EnmFEI1BouwaFmvNn7Yu6f5z+XkrneoHW
         wMDiNYevWKLpDJkvG4HYAo+35x19OB6O0TfR5jLx2jNfP+Ix3T/l4QelesjAbw4E8Veq
         3pLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SKaeZs9UUdBSjEG4Yxl5VUOK2mO4Vo9Wp0bSATsDS4=;
        fh=/vkIH6GF4KU5qW1716h/mXKzt7NGVMYpv25r7U+WTlU=;
        b=a7L+gcyNcbxvaB3nyDZwRJAWi+nPN9v3z5/RTQIzT+cGxM8IuIxhaORpWE+3twY9Ul
         0ea7QVaYnO9t7Jg+1XongJ0qYsM5eQqLp9dUijqj/7PWmK1q+VZZcC18rnTbjxUOHYGV
         zvnHaZkLauyWDff2BOO5ag8mgWM3L0FSOEygSkGbwZbzMOe1bGOA60pdlnlK3ZPzBQx6
         7RfjQBzYkJc6oFKJN5p9Y+WICgytv75QiaZ2+39yHMqRJbnA8xpV50KeJFnKfOS9V4Rx
         ciFQ69WnQ7HSTqhWIUgcwdb1ao288MYRxBqAnq4GEv/Vzy2L0/pSKFHeDkc8BNeAB6oV
         gIOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617039; x=1795221839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SKaeZs9UUdBSjEG4Yxl5VUOK2mO4Vo9Wp0bSATsDS4=;
        b=uIiPboA78aaT02qyAK9e0HV66ew/kw/OpyXLc3uqKLYOPk1Lgs21MBaZ7q4hblGQRw
         ccjGyokUt3cE2wr0PzhUl31atqOVXAzUNPzCityIwJhNcrCEUIbZLiPLG67zk1WieQgJ
         zLaSXOHfRmzHNdJlIzGCrziyAFI8AXZTTvW5JT1NOihgGQpLIADFNNCcpLAWK+hHmP30
         PPnRHHqyC0P3MsH3nOYJRjhcA0Gb3pGvrLyhF13yraB6cu077aQdwfhSmWIGsBmvjmbe
         6MDL8rfeJJ5/E/vDYMFeN8Og9VYBk79NzyWvyHIKiVMgoBPqarpqxotNrziuZhR73dLX
         xvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617039; x=1795221839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SKaeZs9UUdBSjEG4Yxl5VUOK2mO4Vo9Wp0bSATsDS4=;
        b=0oTvhM1ONQUHv+cAzhONP7xwNA7jmW/wsnGietXliWlNVvcmQFnQ8lzrxmzP4l2JEC
         37GZTifx9De2n0ThlqtTXIYkFsj9LhYTe3rHoGBle8DVarM5EJ3+M3akHudueuYGM+0F
         ZuJ++UoUyHypUzVz2xM1lL6IzYlT6iqT4MAdz2ep2PC8V2p62+VFsUxt9YtxxSvYW97i
         +hj3MdKGGf9VeIKNIseT7T9qPoZ/WnLXpf2jk/kLyOcwSgvldkyioFn7zetkB9jwOb6a
         Ah/EGbC3q6Jzt6l2zbSzzsNIIAKE7twNbioNvz88VTzk7/SB0gDpyv478zAALeO4k5CA
         OLcw==
X-Forwarded-Encrypted: i=1; AL+hErFrFrnTX+8Ei5Uzky7saqOFmj0bh18YAVjbJiVSdHguNKcimv7wyBA1ll4ailuzYIDwMFSu6jgtrvBbTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/O7OmDHEtmfjpa34FalG1z7yuBgySwdCyjQ8/ZBE//DJnFLxQz
	fd/MDylmnooEEeHgz4YXHQfcN8oQN/rHo+0dSKKj0oO3dS8rldnDijxaOHz7RHJzxBPe07huG7v
	PGbXs8xUETgVNgJlzIehMmklCEOOtFFg=
X-Gm-Gg: AYBFou2MOmy0LbH2OyW77n6mAY+qCCe06z8WQ9UFyxVG9GfHKDFkkE83gPZrdsgjSM0
	FNlfVbNiPRS7Mi+lQCWX1Zy900N/srSj0Xi44O1VQcE338dil+0uzZj6YiDD2Ml+kl3A3hw6HTx
	SSY8vgxHTGdpB+aub3O+8b9G6/bP4hu/ePm/pjusNAo7yJ6tcXd2RJrQMcyvTPriLaZw8wNI750
	40hqwce+ukINuox6bo/16b8CbUzIU/mWxT1q0II35D1sLNZweP7DheIIlYQFEb/KMtAX6rx6GZj
	FQrEWPLzUiPghnyyNswtqhwi/tX+9LWva0HtQsrkJunUUoMsWzHEh7pRpjkARBrnwOhNVD69JCD
	3BCzWQuGaB3ibY1f9d1NQjba8zd64HD0z+1fUWYmCj+V5aYX+YN9fmS7X/qMW7U3B8QVXccIrMh
	K164NMvG1uqg1AQtezz2U3JmLgywje6w7Syq1e1dI6SmFyhf6m1t0Je4YiBYkr2XoAuBVga7smk
	wmG105Y4GV96AG6GZR+oMndrouPyQvo51Amm366Vp2xtThSOhAoJaZAAVE89g==
X-Received: by 2002:a05:690c:8d16:b0:8b3:2b25:36bc with SMTP id
 00721157ae682-8b4aa2f2afdmr26285117b3.14.1794617039086; Fri, 13 Nov 2026
 16:43:59 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Nov 2026 02:43:23 +0200
X-Gm-Features: Aa3M54ojF2yrHM1uxVyVfHXLX5WfMRHRX0zeARiKfpiOLu5uw4jzzevx3BI1kbU
Message-ID: <CAHp75VfyTSD1zeKjZSoqz8VSBMrwoNmf9pPh+f25tiH1yC7mWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Input: tsc2007 - drop unnecessary cast in tsc2007_calculate_resistance()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 2:02=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The resistance value is already bounds-checked against U32_MAX before
> returning from a function returning u32, so the explicit cast is
> unnecessary. Drop it.

Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko
