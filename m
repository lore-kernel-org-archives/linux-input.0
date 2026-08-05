Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8133D6FC
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905306; cv=none; b=kKJUE7YxIV0kC5u3Jy5OKB2EFZ+yemg1PZZWoB7UW1DVmvmI7DJk8jgL+gz1eFHmvtb/lTZKCuKnoJnZ/hr3Y3Jignw/bFTHwsmPOjDb+mumdrazfNAXfDedodw4vPohPUdnvl/bAyZkuWbS0+RsJkakaKPN41qKkALbT6DjZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905306; c=relaxed/simple;
	bh=6Dja9uktIHlytGxQ4Mfy9LyhfBwiNIxQgC7eDqSetaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3cPwvmCVVGlkMWuU8Buvy4iFT6Ox1RU7Ab+/F6yjbNlmC22NTzigybIFl+YFGaWpwLYl9p4theI9ZSEQJIez3XK32ntZv3Yr1Mc0RCMEsSFvhQbw3l1hEdm8gMo68ziewjUI08ou8GUadK3o32UVrPEFbgaObwTYJbK3HiKslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGbZOdPD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGbZOdPD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548e01d02so2630255e9.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785905303; x=1786510103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Dja9uktIHlytGxQ4Mfy9LyhfBwiNIxQgC7eDqSetaI=;
        b=nGbZOdPDfjaqLBPa2edV/rnBGVIfVJJj3RK+G98GwlXBfhhDSI65UmKAEADoKLspen
         49IL2eRmfmU37CO8obw21IeIXfVtDzAdAw8qfy02626Rd90e4BXklFxuHSlm4xwJuP2C
         wwIHNiIjQ+7c793hIGFEYJOClQ7k2tGgiaJzI9AZnVyMMxpktA269OQDlwQNw+erwvRo
         77st0Yl6Rep2ujE0/XzjTdwWgJpNBF2pM0lLM4p9wxJ8A+h+Noa8BKtrrlAGQpaW5wvo
         92BtretSXkW2sSVe9i2uP7Tf0lermBG1bXyL2YEhZsVmLKT9ZY9V8jKksgGEUTkxc+Za
         +f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905303; x=1786510103;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Dja9uktIHlytGxQ4Mfy9LyhfBwiNIxQgC7eDqSetaI=;
        b=VeC0H2f3CaJSAxLFSkXFd2rQMem2CTirKwRTZqfoWPl5HfxhG+u70TtW7LW4rZ5ajB
         5z9x2Er/Vd7cppynMzD985230o88FZPlFMS8yMzKiDEUGMdtrcKCeITZvJmtVFVwCLzC
         3EPGG61FZqiTgs+EqRIviYAl6IwXQvdllEUhta6wJZ/pBnB1JPb+r0OKVAmbwzVUVGEi
         ls8LaQbkKtpz/rvF2o4hNUwnlQg8dEvtyOk/IB3Nh148F+tuVij67kGsjKyK4+Pfcste
         qVVXEJgoyeBT0PLBu/hhM/Grj5jPknUnoEJqOdT/wkjou5fdNUv6mKVH7FU+iUSiEi1Y
         ATVw==
X-Forwarded-Encrypted: i=1; AHgh+RqztxPZ6XFpltul2FT25baDDIDxdO9eLMCROsuvj8Y4WhCrdZA6b813S1Gba3JdcwWFwIkGvZBjId9rQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJSHi8hijrGtksg52YNptPTBmJvGDzV2VuXEKGJfgx20uWKHG
	a5qBOJ59ARW82VViKyBvJ0qbQF7dtlHiNHEiPOhe41LdpyQFyTSiYIlz
X-Gm-Gg: AR+sD10fIz9dEYLe1Ol6wHZTwdbQDwTLMXh2H15FGSjnbQtzpe9zPlm6M2FeXQhzzAG
	V+k0X5AMphCOiPRqoeaos30B+EKGhafmiidhrfwUGEPTiplHGre4lcE1Ph1ycog114JzgZj7wSA
	/VeO5qtIwCYjHFSTxYGILRK4MpS7KljKeONjm5lxW0wDE/1pueAGsWl0EhXgwSEwkihqCqIoAhA
	QhFCTggY26kO2/Yc7Nb6PNMqSspOnr6W1/9DDkWRatPgRVJvLSaJl/ZkAqSBqzntVQtHiF27Aaa
	T4Q3sFJADGzguBSjo7HgR7v/CdsFrBvFiOQiLabdbdWdNViuOP8HF4GfJxP9AoBdciSp1rtGHu4
	9snChhhbZMoUkm6TG7LSmSm4VLrEYvlOkKxD1zvtLa97hihuSAaYY90xc3Z9OdOQCHxn0bwhD3k
	JBqBX/+1PQnyxcZxDlZFgEwgIyfWeFO/e5OWmnH+M/FbkLOmbXwTaZSquvfdy+MZ4GyuXS6mi8
X-Received: by 2002:a05:600c:5251:b0:499:4dd6:3cc6 with SMTP id 5b1f17b1804b1-4994e73207amr32358695e9.5.1785905302689;
        Tue, 04 Aug 2026 21:48:22 -0700 (PDT)
Received: from foxbook (bgt135.neoplus.adsl.tpnet.pl. [83.28.83.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994f124135sm10989415e9.2.2026.08.04.21.48.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Aug 2026 21:48:22 -0700 (PDT)
Date: Wed, 5 Aug 2026 06:48:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jamie Stephens <jamie.stephens@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev,
 gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
Message-ID: <20260805064818.542210d6.michal.pecio@gmail.com>
In-Reply-To: <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
	<CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 15:28:02 -0400, Jamie Stephens wrote:
> Hi,
>=20
> Per the recommendation on Proxmox Bugzilla #7850, I=E2=80=99m reporting w=
hat
> appears to be a Linux USB/HID regression affecting a CyberPower
> LE1000DG UPS.
>
> Proxmox Bugzilla #7850: https://bugzilla.proxmox.com/show_bug.cgi?id=3D78=
50

So apparently you are running some Ubuntu-based distribution and
"The UPS works correctly with kernel 7.0.2-6-pve, but fails with kernels
7.0.14-5-pve and 7.0.14-6-pve". Also with "Ubuntu mainline 7.1.5".

If your distribution supplies such kernel packages, I would suggest
starting with narrowing it down to a single exact release, e.g.
"7.0.8-3-pve is the first broken one".

This will make bisecting faster, or maybe there will be few enough USB
and HID changes in this release that something will become obvious.

Regards,
Michal
