Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370249;
	b=rfJeAFWFWgtXmpN6rR0JFRdBYtSuIYk/pH9LV01aJsBYCJSzkW6cCwZb5UrkAY9vhEQa
	 b1qB+LtQSpnuqYmqO/bW9kPJL+SHmfZdYE1gKBCeSGErNzy/LovapS2rKZWmOkXZhVRNp
	 5tlCchcUoTTsJrUdGZ0otfbfPdAtsECHs6BdKvTx3eKf4fUkUR2VaFFZAEIXE1NxQw7Wu
	 w/Hx9NBuIMIyP5jqv/F83ZYNolW6eXpaEiI15KflrEwJLCACd22enbB787DJob4hIIQIY
	 sj0uVnU+g/a3BMFRSZB6o1hnjuS9dlJqwE4t3SZjAKD78ovXOv5Lh0gLVvRJHF2MbmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Subject:From:X-Mailer:References:In-Reply-To;
	bh=viicW6dYYgqYz/0PCrk8AqSDsgJ/CNYIh9VKy9gaRjU=;
	b=OgxQMvYLwrB1v6FxkZ4HHCTa0+9FIh7cyDNuX0oNpX9+m1F1kM4xXaa6NRIzjlKgQQ+f
	 xc1a2fXHM8Wu1fWdgsIyfixzhGixJIMdvhpKxUxhonOQJGMuKyi5aDgFNvY8acpFIdix0
	 GYcmg11NU2Xn6YUk8tUUNWb8Z2ejTt/5vVtvJzxAtuXED/dMwh3dliEsWXqtbSSnSXQXB
	 ix6J8zlXgqr74fMAaBamfBm+bh9o3E8xaOdstoPfKLxouV1TKqScTI+0QjH4UusLYjRp9
	 ZyZ6J5L2e2eezTC/MXyW5tTHya9uNyzIsNO9jagMjlwr+1jTlthfA4/ZeCOJsDKMVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dr/Qrd94";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0394606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0394606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr/Qrd94
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c516a160f91so90746666b.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370247; x=1795975047; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viicW6dYYgqYz/0PCrk8AqSDsgJ/CNYIh9VKy9gaRjU=;
        b=dr/Qrd94gpydZk0dZQZ2CXJb6YoGCswSFWhMwiIIj47twDTJ3HdOaFBEegD4UDi5Ci
         C5Rm/ulgGPq5iQyanl5JTJ8n9cmsydNeQs1FMh3EWDV5LRRzR/+ybKLlUDAEPuGeHMgJ
         p4x+z/Qr+gT9ztzpL76qiEgH6lOxq+faWCKM+UC7u4FkUFdP3ufnNdKWmQ3gXQkcVO7V
         sQK0t50daRMF8Mv8DPGjGOwrK5JbCEfHW7dYRe0CliEuOjtiwMOfwNb9pXr/ClcbvPQy
         xh4RZscekd4aR3P+gAP3MVJCZpfkTPmDTseCiU4bTBB/DwwGDRQZo+ofQwQimKH+mbXo
         nW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370247; x=1795975047;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=viicW6dYYgqYz/0PCrk8AqSDsgJ/CNYIh9VKy9gaRjU=;
        b=AFrs3wwpabvir/1MszIDluGGaCIshzTZc5BhBSee53/vuWlIQQO3nBP24SH4skuSiS
         ChLdYQkWUiDe0jZzVBVwX8z3/NuoEII9uE5McH+x/jS/UdVQLfe9ck97cMS97Vq3fN55
         XyU5UCA5dSc8KK8l+yZ3wmOO9ZbmQaHN9L8FuMIK0h+BIxTAFLmYw+djcLvpQ2LlDmBo
         SxcLPGevZsK02OGk9MCCwob3gOz3bQbZwdmDwQAvq3DZWMlo7eMB0iTzyMLUk4kphT5g
         kqmN16UZWXMzbN/aWTysLurV+xa0WEcTW5ntCXlhhWTiLHuuN42rwboMPnmCK09dlSIc
         VCxg==
X-Forwarded-Encrypted: i=1; AL+hErGz1R5rmPJuS8KK5tAgBdi8mZQscgq4tIurOmQxZw6Pc/gnVchYBlyt2QK9PFc2KYwGguOx0ls6Z4wSkA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+0DwHPMYjsWUea8IWRThhCTD/0CqBLhwkt5FN9NN8tveVmxrVa
	HAAXoAgswv/cxH+7NmQq1reZiVT37oX00qG/Q3vW/k/bXOmpuvFgQCWs
X-Gm-Gg: AZFdTZc6fSR3gMA5dVYCuESiv4N+nix4ixS2UxKVbg5cjR+ZgSjOGiaIc95oe6gMtjD
	/8qkwGfubwcPbr1F0Mu1UeoLCR9X6ZIyKuFrCFIssoC0ugj5LJTJk6ClPkWAjNZY07M4xwERLcZ
	euohqqhEAb1Ub+U+bhqkLULcsNELoStPBRKoftiAhiKUmqJk6tDvWwYLmtb9PzDwsDnj1nPvoQI
	VfU9zEilND6sLHkgNDOCzuv3F42iDkZhHurMbKXWdRw9IStvaOcyTMokASnmGgMEL+zm02XO1Xf
	BuifyoU4fF8k/l2ot8P38g2Xa1jtaKzSGCXX+UFvXw6R77FdPkmQpRPWTkL3IHwliTcdA84rK0Q
	03UlpzqY5bGWeSL9cF5fFd8nSk8dPA2nqVA+usEEf+r70EGpZx0Qmfp54ZVF7Rqol30/nAjmvhs
	zfsZL8bcEZqnpq1rHpaAYcXP35aALI3pOC5ZXOVUHixCbC17oVH/OkCAyfL42nHBhKhC1/ISfFr
	RBXhdvrM3h4/eGEB9T/KIzFnvhYGugggIso9fNd8d8ahtY1g6QfabwyRUnIQJscwJrazz5myNu6
	WLxXT+MGYM836/7wwMZxWoyVJ9Wz
X-Received: by 2002:a17:906:a099:b0:c2e:350b:7220 with SMTP id a640c23a62f3a-c513a99a637mr622258566b.9.1795370246930;
        Sun, 22 Nov 2026 09:57:26 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42bbsm331129566b.61.2026.11.22.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 09:57:26 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 18:57:24 +0100
Message-Id: <DN1XMWA7362O.3IV0CG8EKY4KI@gmail.com>
To: "Daniel Golle" <daniel@makrotopia.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] Input: hynitron-cst816x: set INPUT_PROP_DIRECT
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1791233147.git.daniel@makrotopia.org>
 <ff91fc6f203d4442d555597cdb455b476af9da50.1791233147.git.daniel@makrotopia.org>
In-Reply-To: <ff91fc6f203d4442d555597cdb455b476af9da50.1791233147.git.daniel@makrotopia.org>

Looks good to me. Thank you!

Acked-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
