Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185B1946DA
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149641; cv=pass; b=DS/I0xsyHLo0y+jCcD4jZMvSm+mUd+uzlNbz6xJsnr8sYExjwuoRnu9HkWrofvcxZgiCwWTAk0qH09mCHzse2Bxv9CCCB8zlhzHYjwAdl9GjeSvmjvhYaZ6McAW/21imjFYBdxizhLCytZ7svXB8eLf3u+NhCkKyFgtpmu+znhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149641; c=relaxed/simple;
	bh=D/jXk1pI5cXw11B7dE5qYnkpodxoajS0naREmh8Tang=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEki1nHgbqzk0VHRvdFLWszvFPotCTT50QSJSmw98O53EiZL1nRz6KqoN9qKd9gvAR+pWmxr0J7rYVHeAiy68N7w/jDrMkoCr+0gqIx3TD9HruU4Sm8k6o4+n3UfiT9W2JrTfZXuDVIK/6MwgSSJNsI5h+GaSIBSNbf9ixi7P3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy+SnTzT; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy+SnTzT"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a14be4733so41304986d6.2
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774149639; cv=none;
        d=google.com; s=arc-20240605;
        b=JPePM8gGuQprt6vjZQ6vh6Rl7d/eVsGzmCHi8D83o3KkO4m+94fCBBpchimDi58dva
         Q7az/uyEqQJWbGiL/3dBqyhcj/3FTSKfwZOiKW11y68lSAHDYaAOJZ3AOB+agano5Of1
         kAa4UrwpMGxpK/EIdCH7964aB5+mjqJ8yTzHQgsmC4IXOmHHEM0eltARBSLc8Y1PqK8L
         fZvPIYJ4OCl0lcehjlsmhBn6szPX0ks3jgdbwfa6qVEW3dqVZY14bXi7ySZ9WRl/sPEB
         m2PMZyKvzrS32+VmkjIH5/7Mny/i+P/VOHw8peR17gmS2DlBEUq2GRXr9wd5yulKO8km
         Hp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JuN3KmF+V3XuyVg+Ox3zokYqXtXUn8OU7JfRGLL9pOw=;
        fh=IwBJkzjnepWsP003R1FMa/XEuj6fTgHKCKJE14Y8Tss=;
        b=iFCqAk9RB8ycA93EHEqfeNfUVHY+rCSlvZkEDpTVD8Z+HbKLiqKpKlbZPhQUsXv9Lr
         z88UZjPw+asAAR5PqHotk6WfqkTgAmOKuryNZwU42SYxbOIl9Q2bQWJBITVoOkO8iG2x
         D0Zn4m3BH67uGhEKhowk1fpwa9kEKXLhrpceg0gXSpUhihFZIow1f+QdH2+RjLGLhdRN
         vBRjxMeYmRIkoU0/KwzJXWBqCEpkYKsSxnSFgI3SlOyT0ffAHKITtF0IIhGSWCP/VfOc
         T0HesLQxTP52ICUK6c7zspM/xPRIiYt4nH3nCd/F2Ebuzd8kzmFDAUPhL0Emv5EuUC4U
         ePTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774149639; x=1774754439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuN3KmF+V3XuyVg+Ox3zokYqXtXUn8OU7JfRGLL9pOw=;
        b=cy+SnTzT12rdFe52I1H6QnKGY58j2E2ZK5q1d1acOg3CJ29DSLcYpm5SRbSAa+mK3D
         SC9ie1gCLDIzH7PGWs5lJvl66fM55H8Pavl8RUTd8d/F/oz/IZoB2foEm5kbsQz1k5e2
         BE9ySdGSwy/j3K9na0ZR6yETuPJCE66hUEfBuxTAKjlR+Y5AMJGLZCeA3nc63AXOTpEs
         FG78RAAgs/SWKqpQ3QrSZtECv3UubABNKG5HXzM6kG/bmioyjDE9grwXi+8x21hjfFiq
         YPslOQ8a4Kl9g6WwxcxWUSmohQK9/fb2cfMmXFzAQ2CHLWr+X9dgfDPjO1hlGLuJwuKg
         c1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774149639; x=1774754439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuN3KmF+V3XuyVg+Ox3zokYqXtXUn8OU7JfRGLL9pOw=;
        b=l2q2mNcd9ov7m60Fj1AZseR7A8hRkMHguI0MrL2AL5kgO4IlKKQSAOsk/VHbeV9+OM
         t1bwru0ImoMtZNyXZAuboGzhHyzbmwB41Sba5iOjY4cl1X0gnl1sUIz5yRaPVyQIkZJD
         V65gk1UGLUpf4byzBIei3YDpNZXsh22L0QNzanqBKMo7UXBliSl+v9h66X2T60SWa59k
         fNscT3r0ogE+H3JN5M/R7OFBjN0QxOMzTvJ1RNBhkppb/V0f8cNKcMbFftApM6YgQJK6
         xyQxlMzBVgR1wntwHJysA8k4K54jS2m2UNNVdYad1jDIe2OPjhcRFXkwCQ536VV/KNvb
         N3tA==
X-Forwarded-Encrypted: i=1; AJvYcCXuxZs4UuvbQTHnmJTsrP0Dea6SAOjQvtI69EjBVTptbow1UsdtXmsalWDg5EE4Hsr5sReAG/kPdWbHDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrM1g72jGt7KKdKujy3b9wnE+S1wmjq0FGd1wDb9rhbFU9dFQ4
	2xyCcmnWd3fMtQV/86B9mpvBXpZYwlOviUraP+wC/JpmrstXkB0hx5/gMD6Gb7mP9wXD/VckucP
	gqZkr+Rp8HvQAJBh3BLsstWrKIv3kQxc=
X-Gm-Gg: ATEYQzyW35eCAMrX8LtiQjV0e+WAToHE9Gal5P0ovUmo619ffiwL2PZnf4bODvRygSt
	QAnLEc2rOLUd+V4jqhZuSBcwFUcRE9Y6/kbh9kaR0nWxrHTJlkroJhEMZHUDQDXNHH9Bm8bHlLb
	jyYRu5LH/m433184RWw0aqGwmqyHQ2jX1j9c+OFonEx2NVPKCnPCniHKsTXGkQqWQ47vjsq5MiC
	I9zodwhDT5NSI/2Iz7hupS7CQQ5WZvsGwbjuQmOJtpSTMWTvquLpy//9whPPRsKV96XVGGl/9Wq
	48vUp5Ob
X-Received: by 2002:a05:6214:1bce:b0:89a:10d8:f9ca with SMTP id
 6a1803df08f44-89c859e84d5mr132297946d6.26.1774149639178; Sat, 21 Mar 2026
 20:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
In-Reply-To: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 21 Mar 2026 20:20:28 -0700
X-Gm-Features: AaiRm51WFDkUJtKya_d2Hd7XzkBhvrWuYD4OyuVFWBTk5xib76q2ZKap24xbwmU
Message-ID: <CAFqHKTk54aN0c1SjjjEf33rbWuPWEfDpaKpDvmAPJ-2L1PNcwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add OneXPlayer Configuration HID Driver
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Lambert Fan <fanzhaoming@anopc.com>, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 8:16=E2=80=AFPM Derek J. Clark
<derekjohn.clark@gmail.com> wrote:
>
> Adds an HID driver for OneXPlayer HID configuration devices. There are
> currently 2 generations of OneXPlayer HID protocol. The first generation
> (OneXPlayer F1 series) only provides an RGB control interface over HID.
> The Second generation (X1 mini series, G1 series, AOKZOE A1X) also
> includes a hardware level button mapping interface, as well as a
> "takeover" mode that was added by the ODM for debugging the button map.
> This takeover mode can be useful for exposing the M1 and M2 accessory
> buttons as unique inputs with some userspace tools that can consume it.
>
> Signed-off-by: Derel J. Clark <derekjohn.clark@gmail.com>
>
> Derek J. Clark (4):
>   HID: hid-oxp: Add OneXPlayer configuration driver
>   HID: hid-oxp: Add Second Generation RGB Control
>   HID: hid-oxp: Add Second Generation Takeover Mode
>   HID: hid-oxp: Add Button Mapping Interface
>
>  MAINTAINERS           |    6 +
>  drivers/hid/Kconfig   |   12 +
>  drivers/hid/Makefile  |    1 +
>  drivers/hid/hid-ids.h |    6 +
>  drivers/hid/hid-oxp.c | 1340 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 1365 insertions(+)
>  create mode 100644 drivers/hid/hid-oxp.c
>
> --
> 2.53.0
>

Note to everyone: I forgot to rebase to a clean for-next branch before
sending this so build bots will likely fail. I'll be sure to update
the source branch to the appropriate branch for v2 after a few days to
allow time for comments on the patch substance. Sorry about the extra
churn here.

Thanks,
Derek
