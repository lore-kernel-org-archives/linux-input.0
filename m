Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794869477;
	b=E9UqAPKz/Q1J+FNLPaOcf15CWiVZXyyx9x2EMXrk2iY2M4e9Mu9aunyH+cpKuh0dUdFq
	 wSHIkVRKnvZN9N5XC4NXdjmz5SEONxdZxIf8FA2GPcDhFNV4jezHDQq9lK1MEP5qJe+Fo
	 5XTCsJ13/ddemtZhlbXoMmM315t7PUN+JFEW1ainoXeJBgPWVSQjLtUL5awGg3EStUTcq
	 vt6kbdvEd+IBQlRgSVpx0UiAkf0dy0QrjzkZrzLXgHdfKfP9VHjtvpy4LYuKY2T4IdIxt
	 JF3R9OBqkwNjDWfShHcKLFKR8+z1tI5waXzLiSqEyA6hWWAlFfL84KAS2UbtlU/D17g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
	b=bGB3UjxUEsVMa/Lbepcj/e8a9qRc3kzvb6o/SX1Sm6+F0ko/a8a7/S5j4jEVzRlkYUTt
	 iseVkj+tjjwY/uH75FATayzgrdlh3esIz7qAbZoNWyHzmqy50+Gp1Ww2dkdLEpoVARU8N
	 oEg/wRrGWcdK0UoHM1WXTD3B5bWPVnyPJcdmk56laypf5Lkhr0gS3+LZUeIyxIjwFfNG/
	 B+F9GtKb4tfSWu4UFKL69dtk4eFT2LvmmENfD7Wsfl6tEwLb6NEtokQgB9u5VgZs0kPuW
	 L3jDNj9y3g2I4LsdehXVeOSBTrwAmONNRailBocyPs7MmqgvvHyEt/uRfJdlwLhHmTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kk/p/EUZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA30606A323
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 22:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA30606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kk/p/EUZ
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso3260367e87.2
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794869475; cv=none;
        d=google.com; s=arc-20260327;
        b=CTy6Ju/+wb8ZhpKE8cq+c1euHlJuhQtyAYrtYPvPKNP4Xs76dM98y3OdpuXHSp9CNJ
         3RMlXhRKctPm9NnixRSvnstuLuedyNSY/MkOfQfWXBOkOj4CaH23M6kwLTc5PNeA7ybs
         mGITj5LfaGXHvGyOnSOQL0ftlmKLvd/d9BukRd3uU0IpqHYT9zH3Sd0VByUXkCRNKli9
         hVAJesSKBRGKMptK15dk96BnA2T/tflxvNFdgs6u/IG8O6+QBPvqovIvOxesScV34bT6
         yjqIcYTnscsGYakMJAoB3uf1lQ9orc8YlDCMaWUkp+hmVQrOsMDREXuvvRc1JnYqg6j0
         vDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        fh=zsaHLuFna2TZEOnneKApxN8+5Eyi6HMZmVHKBEmUHio=;
        b=ctpFdIG98UH/6lHStZA3yNm4jjtzOq5j/MYa0Okwo0Y29GDAQ1I8yx6NO9o9cpZFxl
         Ci58adD9Vok7Ct+p1MDgpxNYSt4ixI9OtzwkvJDQm1jawfAsB5zXHWyBmWyuswwVPOCM
         CcJU3m0PVaXzTkamHwefZFWcq8y/KtQnz/352ZT9Igi6LUYHDB5FalFeqFHmHtnvnrKY
         AQOqqTUYtchZAmsL1XUwALEXSPdcg8bQc65a9ukQqfVBNG8z+EeETZYJaTFkih1m3mfU
         xOIiwFqaDHqh6WiqP76uzB8YnLQtssUKkc4T+AR+TA++W/OH1MIQ3EuUMslKpsEdVjIY
         D+eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869475; x=1795474275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=kk/p/EUZ42VJ5YgKv1Wn3i+cPwj2SErCTRW7L793OJ0KFsNhCm9BuTgxw25M436hxE
         V+gWlsQN7/eDt/WsiMaip+OKOnsd8INibpn5VjqY0nM8LEycYyq8fhFtSzsxtVa09VYI
         mX1qReotK4FksPWQDUjL98HvDzHNaBfLnKgBYWSR17ox+RhuSN+LMYvEsxJvXJH2IUHW
         BHmkCG2FVqHRuiswoAB0HnlpuNtJsPDeRalmZzkIGnNMdhEtE/lVhJyBu2SepnE9Dqzb
         wC2kJSVYH3Y1/rbV6xzEoYbWB7cHhGoewD2w7T2axTp0Mv+VXe4PGlgaLvzVgchabuwg
         wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869475; x=1795474275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4R6GMf+N1WSGNe7ynv/fMp2cLGWJ15ixMnxyfrCx9Yw=;
        b=tn8kjRe3Gu1z9g336ZpeGLFSQ8ZwWxEH6D6Ag7cahwJdT6yqpMXtqFRMNSi7fjtyaY
         TzYndLaAVqLJjmc3svUbAy5YhxMC6ceQ0mmKZVjB2dRMvKLwriW5/ixfKvf78p3CKp7/
         ts8h65ET2E8k11Ldd2i8Yg4Dyw+w7fpPPlu/OkJCjFlq0k41hyFvaNaTrBqH7TTSx7e2
         +6UKSsb1wgTJChz0WAO8Orv3icOca1sG6f/Hy51iqhKAiNmBNCLhi15+LwM+uO3zX78E
         yto/8rHop1DCI8eiG68OOviX5Fzqi0VcxdsNabLkXHC8mTWkgDRvM9KOkBypgs/i/WEO
         fWgA==
X-Forwarded-Encrypted: i=1; AL+hErE4aLWh7l98kPH/9HyCy9da7hr1Whh7iWmh9VieoRaxk7TZ5t22Jo/83NiuO10zz2x5KDyA0Ar5cbnWtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8LyunSqGGrW3rY+mfrsrxwP5Qv3MpRZul549AmBUGj07Z0aVDZ
	eldCq3Ujy0UfsPKmpAx5kDcinuVM8grl0QiOm9la+K043bj5A4N6K8NlXRqZOvUX1NVMyKg++jf
	SDITvV3CMyWS3UEKI2ZVAJxIvkD2QRJc=
X-Gm-Gg: AYBFou0/9GXoR9KPDONZd1SCzX4RaG3xk+rbxl4e8SRA8R2SQo7fUWRNd3eDRk+ccFO
	ZxYY+o6gak2siYwFH7YVMsszbg2/bY9axOQci8sF4iQ/h59NRfEv3AiauD7Sx6IlwYhVsQhPtf6
	wZ9s0NlykBubyuQIpmklzaXc3rQHO/d6ssuAH6aMd5Koh41/WXfRmOlEkD/29dOMWzok6nS99HE
	KjI045M9JsO6ATPJBEZErwyq67VK8RFjqRMncncJyIs7dMDuItZPqIQnjum9mMhLKU5UWrb5+30
	ofbGbq5TusZnsU3pxhiP8QQ2j+kh5W5MXHpjOS4CAG+LNQlBbz+Lj/glRxFjLeHF3knQRRAF41B
	52RlUJ0JuPN3+x4W6TkSOx0gyuzCMWFeOL6Rdcl9vg3vfhmGdiXIzP5c6Qs5pMtbN88DOh5p8th
	57qx8BQoXEH7+E8tFELYah4M5Qlg==
X-Received: by 2002:a05:6512:31c3:b0:5c1:4f6f:564c with SMTP id
 2adb3069b0e04-5c1709c5b64mr4475988e87.39.1794869474886; Mon, 16 Nov 2026
 14:51:14 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116224803.61154-1-festevam@gmail.com> <20261116224803.61154-3-festevam@gmail.com>
In-Reply-To: <20261116224803.61154-3-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Nov 2026 19:51:01 -0300
X-Gm-Features: Aa3M54oXe-IAn7x15degHvby6uCIkABaEwDsnl3MJEDi4r1Iu6Ak5t9VY_ssJ7s
Message-ID: <CAOMZO5CPym+AYFLv7D-mAH+OQXL_83yForV3GaSk4ReT_x1HrQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
To: lee@kernel.org
Cc: maz@kernel.org, andy@kernel.org, jic23@kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, 
	linux-iio@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 7:48=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:


> Changes since v4:
> - Map the LRADC MMIO range once in the parent.
> - Share lradc->base with both children.
> - Remove duplicate child memory resources, preventing the unbind use-afte=
r-free,
> as reported by Sashiko:
> https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?=
part=3D2

Sorry, the correct URL is:

https://sashiko.dev/#/patchset/20261113013212.470981-1-festevam@gmail.com?p=
art=3D2
