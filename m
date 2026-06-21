Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6C26CE39
	for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782028537; cv=pass; b=LG0SOEnNwICo4xtvjCcoZK6dCwS4N0DbdMdN7AdKg2bk1gpZIqIkVDJHRLH5O7GIFsdTMoDUabbtYsXoJXl28NvHsXHPB6EBcvksYKpqPvMGgGLewrL4xaK4cDC0hartdMbG4oySbEDHQnyuE3M5Jg/SXaMkwEq3DR29mZqdWo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782028537; c=relaxed/simple;
	bh=bT+kSAr+cktWWhCVIYao26NUUMqDDZx8mDGFg9kSW1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcUsJqKno3h3E1dbAqCulr4+j3Zf2l7GHKAUZAlKneyDe9xm3QTHq/fluo2yosP4UlCX83S6FyaZOFc9nR7vJgbaUpnuIL934f+rf6J8izH5gUHnZ8jrtNUjI2XsVD2WJV+6MxkCCKb9CC56QR46eg3m/aPVqMvQSypwU5uxm84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWEeaYI4; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWEeaYI4"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso154485066b.0
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 00:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782028535; cv=none;
        d=google.com; s=arc-20240605;
        b=PUefksELrjenSD1IKtsYHyb67fz62i+Vkpe/OwO+GZ3lN+coF3QY8jo3ePtJjoOtCr
         GRu2XwMRaoqfoIqbY/dNrWbSn5+iWr8I4F2h27a421OOIMM+xS7RL8t7v8VvFX6L1ewk
         uLxPwJS5FOhkfHlCiS2Qb4SpGbJT8iJaY4kqIYItzdT+xNf4T1vq7a9Yv4lrml3Rm17I
         3RceffZfxSufCBQjC81fcrFQFlc9J0C+4aZXovOWEu+pZa8z3wNd7vw8e+c3iNwkPUvB
         Ad843sC2m3odoBlp0ImdEzJ1Szhu8+M2Zdw0J9dqAEsk3Y4t/vRSK0fno7D3Zg1BqP68
         //Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        fh=+jtkrdqRfwcWJdcDFez52lnabtYrU07utyDcg0dEAOQ=;
        b=JsydeZWkYDUt2YROTJEKrsiqAYXJC+sc3LLILsDmrNqTAjb21Dnh6ChZbLfyI+B1MM
         X/caAugcy3gYyFghmhBwLmlh1DSBWar0IAyShZiuCvt+tVRHLYOiLz3dunVdskUUzVQi
         nqjIcGoCtknjiqmWfVP6f24SxsfItfSHykJ/daxMUSqsNY3RxJ+XuyGeUhpFHU6F3DqL
         sAOBd5SLMs++R/XS2dySgcxAvfeBhsOkx+9P4+x+wn/HPyjODE8vgzp2EkoZd/mo6zeP
         THGBH49wzIj0EYcuXaBFzYgriLzS7OjZez18fok/O4Coql69Q6i+uRFPYau4zARTytyQ
         KpHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782028535; x=1782633335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        b=GWEeaYI4Aj8KgcCRXTTzwq52W1u6Pqo7eXhek1TWd9OFtwcLeoVDQayNGJqN1PTZ5o
         LmbGGOnxQFPOyKSL0A2kQWfrYRbx65JLmx0GZVLkPR3NLR9t4XmNcLXA2OeiU987zTlq
         L6Uwgxp/Q6g+Ob/bTBC6w+efIZok3c8gFKvzCFCbHeRX66C9Sz0CVDuDSi8lHDyHf1rt
         xS9z08vI8/ga+FEruWmiR0byDj3mrKFyTJU+SeHGI8/snB3x+Exsvcbh1HIsraw+a+5W
         OhGpQoCTIwCq/Jcfx0vVQwRerIdMdapgWPId1O2cmI6ffshz/etILyYmZcbUGobNkvfW
         6ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782028535; x=1782633335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMvYItPyzRe1gzBuo0wIhzY+wWucW3fQKtqTXdUcD40=;
        b=PILQCYbraG4t9n3gg+TBNAwfSzR1tMX3sH2DBFrjsIBY0BwudJDaP6GV2O+8xfcMBd
         90HuF1L2IxA0DrsZwJHZfjIUIf18uaEtuLWjdqpjTAmpMIuobTXYXFrOL49OKCkfG+SD
         CKCA8si+3idCmvV7JQPfC2UHKpkGxgtpYteuww/2hVw/1xt2fNQsK4zg7OMuMJ9KoHCg
         66Ia80hvoQl2D6eAk26Om4akUPh2bFAXjBT85MNhTaGNxBDPZmaxIbSbos5PDBJbxT7/
         RUcs/nHMJXpv2wD4bf5UdXBLQxwv1yozSkvYa3ci/aJ607qhuXHDvEpC6aJCp/eBhFx6
         tJNw==
X-Forwarded-Encrypted: i=1; AFNElJ9Nw14lIUsRhK0H+vGPzt26YT3k4n7aGPlC0UO/jmMwBdhQsxp8ubrJiPw4OVhOaFGY8h9bgatyppwDFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Q+SohmENoFgomfXi0bpOKHr8EHK3OSYl0PbNoeveyPbGSZEN
	9cQfj/ef9uZNR9SYmZvFD2JOTMadmcpPEdPa1Iv6x9bYg2K3zaj4Osw9Jx0UqajTIaB2QAJZsUW
	hlUiE1AbFAgGXwKY18nb2vXXClZZlzB4=
X-Gm-Gg: AfdE7cnuNc7L3xF96dW4nzh3BTkDfBh3zeHfCYgFuavM6Q87jOEAywmb5qCtXoz6nOB
	F8+3oPE3JEAcm/DBKmYKWpogLNfNKzcjse+rBqQevB6Ekc3pO3ISWLzCJw/EoKLnUqX7L2XnrDS
	pTBk6ffuwZw0/Jryrwoo+TAQy/kCsN7mIAIvKBEmFh4UPQVU7XapIboaj0e3LUzrc/NM2Iq/emT
	7+qQEQXw3Az6HWkBQ5YP+xuhO4Zv++NvbOvK4UQo350xec7aXCQ2yjPS+9ofvJ+0jqut2PuRjmb
	5dXSiRyot4wDGA+Ia8Ytj9VtotRm
X-Received: by 2002:a17:907:6d27:b0:bdf:8e2a:1092 with SMTP id
 a640c23a62f3a-c097adb13f9mr573581866b.3.1782028534767; Sun, 21 Jun 2026
 00:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620200032.334192-1-l.scorcia@gmail.com>
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Sun, 21 Jun 2026 09:55:23 +0200
X-Gm-Features: AVVi8CfSZq6Enj-XJKx5vjhFc4xd-jMn2ZAzgLd4cUoBxN01IhUJaqR7lto47H4
Message-ID: <CAORyz2KB3jaRc5EFhDSuPox794UUeDgT5kRFe=jFg_rXuR9eSQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Add support for MT6392 PMIC
To: linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Val Packett <val@packett.cool>, Julien Massot <julien.massot@collabora.com>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko review of v8 pointed out some easy-to-fix but real issues.
Please ignore this series as I have fixed them and I will send out v9.
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
