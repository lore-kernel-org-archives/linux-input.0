Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343190;
	b=Rr2bil5VOQKhpEXY2P/ekaNp/YQV+5lvlqJRSJx2I/ToZ2mIJaGAYB5On0QbXLDwKo1w
	 ilbEUT2COzlkug0HIUd9QrvXvdye0fZUZSdv35ZrAp4RLAvw1OHm1swxm1uKMPEEQUiOo
	 fHEcF7k5YrYm1MK4YixOoV144OG2714L06S7kXoZE0d/h7zntrojbjYiiLxh9zDcuMWUn
	 w7sZHheKlSJjIzAG67Sk3t/ncPwm7T2Vr8L4/4uNqVSpUSvaK3DRbiVq+pIGEILx7GJc9
	 U3BPDmfkHw138Yb3Lb3k1OjsNpwg7iQvf7fiFzQGp7RHY7R1ZNWvx78dFT6qTbMKtgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=J38IOBfpsPbN5SosP8YUKlgzemikThjgLknjw6gg0qc=;
	b=R3zmiFjnotoxiUOE6x9OoCE1TrIS8l6+KIfQIVKlVC5xfq3ZRuK9oRNDCIJksaj4JmWo
	 8UJKNevyQ9CQAF9lg53roBw80Jk+1GydyN4Mxd51PjOEe+v34kC3/SFUrqyosc66ktDqI
	 Yb+cOxGZHIq4BLqj3f4b6TDGm6vUAeRr4luctBL9AeHlKu0aZxrp65KGhBbw38YcTF2l2
	 yT+Nt/MU6p5jeaz2wKFnHOzSjhW6awUmvDJEOxWKt6ixlHTdcDgpIES0HLKD2hJ2V070p
	 nZJmnjTmZkjSsgfXAaZzadJdptKMpbpFoap/5O98ilGBpEPEP/AVU0fAXNDL7+khE4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lH7jYkYk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BC606A331
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lH7jYkYk
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so3833736c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 12:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343190; cv=none;
        d=google.com; s=arc-20260327;
        b=j7b2Jgot5UolBpmwt0P5n7oLiUfMCB4qKpj8xVSnK4h4PFjgq1Jr6eARm7xRcnLhcl
         s6FVBKQDWZkj4MuCBeBEg6BY+8lTqt3tmzg3erurD7VBH9AWv/sa3BzSQoHsPOoM710n
         FJDcP8QWXOo5JkL0j3RV5HtopHYF+Eb6n+VP8sTEnfkNPwfsw/872p5u9vve8VOw/V+T
         iwp6uSrYpS5yHpRgEyrKugt64ob3knMZ3PvdhucN5jg0H1+7PzJaC3pBFjflwf+roaHa
         KFeh0hlMV7ufQ62lDhXnBntcAXW2iL//CTFWLJS4sVdE834ZUiisWCwCJzoCBZhgbncH
         w6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J38IOBfpsPbN5SosP8YUKlgzemikThjgLknjw6gg0qc=;
        fh=NbabKBWdeg9MVIYxRW1hYqvHOgazwqZD3y26uNRg8C8=;
        b=XAvH2L53aUCo3yPtB+GUPWWT8hm3mGyzThC9PDdk4rvvTHMD+1RLACHR/c/iSS4/+j
         Z9LT0PyB4V8SHx8ktM17bRx3pixfQeZ8ZsumIKFHVTc2MRwv8dotyaEsepgnV+KR6scF
         bPbCne0Y2Ye376p/T1Ri1m7lnGsZDSr+pg0pDpfz/AYK5yuisp8eQZO2BFRyfP18jQ35
         xcjTC3vnIM6dLE0vjKtbIOcZT552OssztdtXrg+b89wuUYjJSpeI9T/NDvk069/VR4WN
         CjXs4gAqPNYgDT7C4kYm8qcKezcZs2yc2dKbf/pZmYRe6xlTjAd8Nbhmpp5kYKR/5uTc
         EjPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343190; x=1794947990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J38IOBfpsPbN5SosP8YUKlgzemikThjgLknjw6gg0qc=;
        b=lH7jYkYkBit029x0XRy3Vqjq+pQpxwph/zmx39p4QB5e2gxZsAaIBOWYNIulvCLWHu
         1gy77MPNTdsVkefpb13cZ0OjlxXJEF9djKNdAO4XHcE1bSAjSQG7UZdHP/WTcadu6BS2
         0WoEbeoVxlmmwu+eloGm1uN1NAgCEuT4BkvCrCzshIUpPSlXTsTT2DxbabT8Wc4O1Q8n
         pTtgL8PRLolm+oA1UCnMyGACegbuFDI0JzY7mPKzebj651L3VAQTPJBIX2UvYIynC9il
         9hmHgqZQ4TQd6xWxtBl/SwrRyrJ//J1nBerAwlnt55xQo1LSmRHOBE4txl7pK9WwdSxu
         7Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343190; x=1794947990;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J38IOBfpsPbN5SosP8YUKlgzemikThjgLknjw6gg0qc=;
        b=u4o6GAvyWzROAVUKvYeVDx04ShGyUEBp2sRZI3qzz009dGX35OLqOUafZy4xyCWnM1
         TXPXUsHQReXdhPUymGGfa29ctSqHduCo9tPfGflkmpnxqkZT8px8QDMrBQJReOz8yyDj
         Ngu3gybcSKungI12dO4Mp4U0AEzfl/JHPm1qrRm9Xp/UHXg86714WhqhQ7S2J3wzYHTT
         WXg+auhnsnsOMxWe5wx63w3ynepPDxEvr98a7wzAj/8EVhkEYD/1H+Zmn4WcKICFDCnO
         WM1NxtgAUG7QzwAnrxTcK8Ltj5DXuP46fDhARs7m4MpgDcVQjXFoa1sl/zlmULovDxQM
         fq1Q==
X-Forwarded-Encrypted: i=1; AL+hErEjyrwnWS7fGcMx/V/xhh1m60H6EfO4rlbrrgbceM9AFn+iHrW0KnZfWPtJbKHRltw+0TJorIsiGXNpbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DTlrDXesSJSp0ZW0DoJU7iBZ52ZeZ8oEUEBM9PUebic16EIxY
	v0gqiCb0NvvOi1x+9n3ZPSxEJiGiF1r6cBhDFgdR/poY6Jr2RU/OlwV66AQRDmQDdzQDutbMG0c
	0i/gP2K9tWNbzkw3x3S4WWaLAzAi5lsM=
X-Gm-Gg: AYBFou1/RFhiQ5shYqa7HjIZePQikOsMLqYmjuj4YF2EhVpfJDzRnz28F5JKKxFLvSh
	ayE++4mBZzLOrR3dOWSOsqTsPXEu8Zy9tA7HK+9OyDT0r85+eUHwfmn6Yub7NwEkcroyX0rUh5H
	5haRJvnqNUYAE5fx1w4YYSjc4PxHESvztxMPjclbcKBc1t0jQA/Ey9fmFirn+K61r/fnZ4U6egV
	d85v7T7Ocm3BQMoWpwvZ2jyJ1bejPMJdHtVVHPMzQg9Q049zOwuvBgsNWevA71R8qJg/50xKXwF
	hXvWpw13pwy2q3n0rh0UzFtJthklOxcwAopqMkmmOCP+o5sHBLB9u9U5uG2eFAgvzaqA1x9JZzo
	J1VgzL0/j0THqSCE1urOXfZl1ucLHYaEPoCgm
X-Received: by 2002:a05:7022:1404:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b3c033beaamr5801c88.32.1794343189620; Tue, 10 Nov 2026
 12:39:49 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com> <20261110-legion-lighting-rfc-v2-1-845726afb71c@gmail.com>
In-Reply-To: <20261110-legion-lighting-rfc-v2-1-845726afb71c@gmail.com>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Tue, 10 Nov 2026 17:39:37 -0300
X-Gm-Features: AclHuK8ISHGBV8pjvWEvjIm6puJtyLzBsHrXTVOLHguQpEvun7kCzwgFU4q8l9I
Message-ID: <CAPKD0Hfao7drmVg1UFVn6BymFync8dP4LK6DpVgtw5SuSA6-3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: ideapad-laptop: Ignore keyboard
 backlight hotkeys
To: ciro.pedrini@gmail.com
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Rong acked this patch in v1, I missed carrying it over:
https://lore.kernel.org/r/4d0153a209a7c54ff513eabd3fd87445269279f0.camel@rong.moe

Acked-by: Rong Zhang <i@rong.moe>

Thanks,
Ciro
