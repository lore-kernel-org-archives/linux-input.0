Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792714937;
	b=Oetdk6LvwtmYl6OwNf+YYihe1xbl0lg2taAfvG5kf7ooEFOMWzSifW3jiix6HKeB4Abv
	 fxUqtogD62VvYSfUo52fZTo8jHHoBIChZbtGREfSpuvVVWBmeUod1BIRaCEZUwXeWQIO+
	 YaRK82HVkGmR8ivs474vdrd65w7FKuNwSGcIxgvmEaBoARsKAxTgWYXXz3ly3/e3y1mFV
	 P/XUdMgyPWhWLWqr29RNcvMqk4AH7dEDDtqXz4sDqS0qQzI8v5OC3qrWCSi7Fy59GkY5/
	 Sy8Qzb38H4M6Diw5DM04vGopicwNtt+BwjRriaEGlPntmI4ZiqY3tvGMl+zg512FZDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VkjwhNqrhec49sZYnWQitZbiXMreHiWthFexlaEi7O8=;
	b=lZtWklcldIBXi1lxcuRis8MJ/lwYKzinMpUEed/A1r7XOVvqi14SjHGncrXMIzkwb0AY
	 6YC/4L2mITCYnnCMyvuZO9tqhgYZH1Rv/EVwZFZQ89BCpZpta26NUTK/3tSrxM1LqCJPs
	 0b4PVMd7dv3htTw74ZKH5w96PJ5kpeZKoil7VF7oIO8ckFqruG6QAd6bzoimnLsyLN2TE
	 bGy9J1uEDJiOYHvYqAPUfM+YiwJhugIJncpbXuigt8zY7rWIPQzImC1oE9AybnQZU2Pyw
	 +0/qMPq/XQpvCrWhqF/Riqlx0PdPTExwpxkCemlcsp30xom9sPey+cDQdxKmJkEQT4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="a2Q/QNEP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE60606A31D
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 00:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE60606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a2Q/QNEP
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67989a98f8bso372289d50.2
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 17:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792714936; cv=none;
        d=google.com; s=arc-20260327;
        b=sukEf1CpnlxIdXHqtWIXEQnFUt5WlVM2o7LjhyL1DnpCnBViZcMvVHwYgflyKyP6z5
         5zv7aB5WKJix7xswUVMwfmJptSRiEeAcf+V/c9qiBxLHu9ifGT8MkoxANEQxaM8CA9hj
         a0hD/hI9DUZDon+SrMgm9lmYMiq5/6uL4yMe/DYE0flq+TyMDVJV2Mxq8d1JyAmUTjrz
         bRVpXLeMpCUbf6+QUHZvPrCJwSPHXflKMQWSfSdn/uuJTogJZbk1smwzCDZmj8t1au7D
         iwTGhHOO0BaZ8KxIWUH2AAps+NpwVDp2Mb/h89GjQnubN8STeAu7oNAYtvjORrnNM0mX
         XBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VkjwhNqrhec49sZYnWQitZbiXMreHiWthFexlaEi7O8=;
        fh=xp+OcrSLeU+KBG1rCT/eMcWqFUiFGYw1sb2qL7eFWEI=;
        b=fMP5wuQ8eaQD4eK2j+dSeudB9ukl3zLoFLFWkEYpgWhZf+hMdLX/+JAKisPazYEzye
         ALKq0b1MqvFqofMENXZl95yivy5VX4GDaRM0oziD7b0t6bm2pa5AHBWA+CT/biPTzOmC
         YovL8NGzDYljQSf388HUs8UgGnD/IKSaHLZzlDbGijafhFuKLpVhvkpiCf6Aa8b7Y979
         2o2XRL3nqbo+PvMOmRVYPMKuremSHzLSGkPufChM+IvEZm+eljKzrEhpEAkk+XZrzppV
         xfto2CulKGSqq/qeuMq4RpNF3Urrwej/KUf3jm5o7DyXpi1W5OqI6QA+qfGgpDKFdl8o
         xAZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792714936; x=1793319736; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkjwhNqrhec49sZYnWQitZbiXMreHiWthFexlaEi7O8=;
        b=a2Q/QNEPVSrvDNMXrTz8Ym23NxEk5ci1YdoOZqJzDzRlxCCmeMlhVNZT4k+TgGJjE4
         drbaoS7zagqDU8UariXTlHj0GwZm+Ix7NJoHVb5bC54biwZ8vrn5PjKaQNROo+tN5Fno
         c9D4fuyN7aB1HaRqWCNnUIdt6GMTfMS/0rK4BtEKy2oD56Dmk7yMYmjUrGTn4tGidIWx
         Jyj+39h1jXivxlrMnrAUmTUshE6yr9am6JQgZIWIUdXYwuTJRr21mGTv9ftcV7z1DKxL
         g6RZh85aj9lldhFoYVzEMZzUfNSMhSNHehbLqTSV/CDpZZRExRtfjju1hgSb6RML+lEv
         tgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714936; x=1793319736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VkjwhNqrhec49sZYnWQitZbiXMreHiWthFexlaEi7O8=;
        b=d0E1q6hh1krUfprLb8uBV0zjMPdZKPe9xYHSIXsSx+l7mIcT0fqsLV7YsWzjKpSpPc
         Xlb/yhVTI69uINoVI05RQfA9u1BU/5RYMGYbEeDJjuIlVJlAt9i1iVEgUGP77OKF7bWk
         1hGFJJfeH8zxLvAwVLzHlViZTw2GSWzhuXjAZvzbpeZXO1rdkjwKZXZjj1N16We5a/Mb
         XHlPTQQNWtSsxQRTMBDpy5mF5N2+L1RdeQtBw8sYNuvgOViFqNEDThqzv5dCk2sFtGpb
         ITDahSUq79yQu2rba4iWJ9pSNT1YTMXnzs+iVizTlFAns97GaBOd5oF3DnrRhbj86D11
         ndMg==
X-Forwarded-Encrypted: i=1; AKwUvBw5J6VSkC7siKAzDAM4OG6ADxmwobaWN3bYvR/97lvtWlP+b92U0NqQ4ObcQavzNTGQTGwmj8NC7509dQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwmleLzhX0lMQf397MEOmEHWLNazG+V1h7VbsESZOJjO0vQypH
	rhBVST6Ofu5xELyCQmFQudMlpa/u1NSaYpOadBTFurQI8vg4Cr/2bTv/zESE07KSq/tJHSMvRfr
	l9ZQCgfiYLAORMv/qvhui+CdM6Nm5O6s=
X-Gm-Gg: AYBFou2ha34GpjBGiyy1qnWW5B+G7N5iAO7mR1/5fUXcRVrOr8TzD8xvUt42WbqKdv5
	OwPHPxusyFGHcfGeAZXlWWRVohpaIm+taFiZ8wSm+Legj7hrwVF82GrufmuI3o963uQdlcycvJB
	ZXy4VCJbW9h/x7Ae1TGkwsbOeBuAPfgaPQpqnCI3mPKpERVXsjN1ovsY7YjQKTJuzjUXN01iBE0
	b06Ar3LlnFEP/EnHjGHkNe0BYRkt1Ze546B54teo1TFdK02aoLplTjxCkimS8hZvIYERQXBYYCH
	ZrGvaygSW18AdWjMQVySCTEC3efdfiTogpzERVINlomrQh5tZYcYhe0O/urQ7hv6HalSGe9CPDC
	egQXFmPXZ0zYUs1MDnjdse1fSXWpEj/xTgL4pJFG68xFXyuuWvy9+bqnKMOXyYXIzoAPK3EBjh1
	oLG4KNH4ZOKVBA7i3k5L69ISf0Ub86RSm46wLfif68pdiATAoWZxiD5ozKFH6kux4MdqddUvB17
	jVuBLQpaxuSuuefxZ4v/tWAW97EUy/ambL3AOHRN4BtN8naj8UKTa5TBR3m
X-Received: by 2002:a05:690e:1507:b0:679:97d1:4378 with SMTP id
 956f58d0204a3-67a35bfb62fmr416506d50.51.1792714936009; Thu, 22 Oct 2026
 17:22:16 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021000338.2160223-1-miro.kropacek@gmail.com>
 <20261021022336.2232886-1-miro.kropacek@gmail.com> <c77944ee-f170-ce57-9065-d7d49fcfed6e@gmail.com>
 <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com> <atqTLxkEusWSS-wf@google.com>
In-Reply-To: <atqTLxkEusWSS-wf@google.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Fri, 23 Oct 2026 10:21:59 +1000
X-Gm-Features: AclHuK-Y6Dnm1r5HCn5OEPDjtqeZI8Ly1qy0RvG-aD-4oneVDHT_0R61QzLB_0k
Message-ID: <CAN5rfbQWDTXZVyh8fDjxqRVO_HEKvWLC7Q_i-7aTtSxi9sWuSg@mail.gmail.com>
Subject: Re: [PATCH v5] m68k: Fix atari mouse movement
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, 
	linux-m68k@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

On Fri, 23 Oct 2026 at 08:51, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Could you please re-post v1? Can't seem to find it.

v1 went to linux-m68k only, without linux-input:
https://lore.kernel.org/linux-m68k/20260814031745.17140-2-schmitzmic@gmail.com/

It touched only atarimouse.c, keeping char * and casting the two
deltas to s8. v5 is the same two casts with u8 instead of char. The u8
can't stay in input alone though: a char * hook doesn't accept a u8 *
handler (-Werror=incompatible-pointer-types), so the arch side has to
follow.

-- 
http://mikro.atari.org
