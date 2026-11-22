Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370086;
	b=vRy3kpTdOeMJAfAij9e4euiCqn/l8PTcXudJe5318x5/yL/X1L8KigpxhytyU8VK2o8v
	 G8EHihaP0Vmm63b3EpXP/fa9X0nRXehjIABNMHch6Axc9X5Ar7HkW7PYr2+WRt8/atXw/
	 42OzCEpDjMxDcwgTLH/Gb6+nWV7GeSghsjF8YXCUcK4/u3FnDFFMRvaRX3y3CvQce3Nwc
	 FXGHMT5i9fOUoV+F/EnkQx3WsDx7qXhh2zdNraZxbBvkS64V1fsMB/GAa5b2EzDHcxas2
	 GYZV2fM6WGRmr1QPckwzU2XWfJSYN8/14w0NfCnpd2pB6nqxstFMmZT6G3dJtoqzdJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
	b=3Izzu0m2EzzHRZQvdDnjWr3oUakhIC6kmnnPx/SHTdFh7i//ysCdPYK9yunp2JOC30YD
	 +h9lOqzrVX0Uis06M8eJnoufZJsBoJ1gk/xMUmJKLgVm1+PbSZflDvYOfAhiDEq2Z/iE0
	 A1YAK92LlI6TDZp9LIWkR+SqHB+sZxl5Gc1j/2/kg0Ulpl6ov5Dkpz8XEL/5v+jSVE4+z
	 HX0lLan8A6R9VsbruhHcLPoIcSkbr3PIA+SkVabb46aieYiltxtwOXCy7mCBr7c5JqKs+
	 jDAJ7aReRdsDmZE1KK5LfqPg3GX5piWvAfy6td1Gps8mXa0ELEb+gzep4LknWiV4Wdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuoSorem;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A96606A333
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A96606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuoSorem
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c516a160f91so90484666b.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370084; x=1795974884; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=RuoSoremNHQJkMwt4D9dlvXzHbdF7ZHj+l3ej0fCcfOvXWfKMGiZH2eQWHfuCe5Ump
         eslZWh2GdQbIq/mp24WuRZzpysLTaawGYLAAgeCncvtc+SGJcAJptpb/7PvxC6B8wLIX
         6xofLLQFcYECW49evFPNMYl5tX3SLCqeTkGCSDQ+651Iw41VcFjhdiFGJljJlg41O3rN
         5AwO/IL3X8gclKNzNKRRi58zfyrkfLFpUMboMbnfaKGlsnm4wqtwhhxLccoPwXyML0BG
         UqJ1gKO75yBFRBy18KZEl5EvoCSUFR6OvCaK74AmRqAJnWsxKRyHz4znDnCsdbBUmlVu
         JQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370084; x=1795974884;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=abYjiKDqk/rMCakK0XvrJrPapA4LViQXV7dOawv8FXEZsTvRohuYRGwupzBcIS0kSQ
         amYMaFNST5lnj/lAZ84B552IAIfZpRtaR83Jo0cVyfUqBjT7X/zPLc+fadG9rhhrecU5
         FcYZGSC9z+vlpL2NYIy5tzgc94l5ebOV2nH4R0WFvFlsBoT7h7F7DkyZCHP6BUzf4+gd
         ++xseXb1SDp+qb66Zo8LLJ6E1cuIP+td34LN0LlBeb1ngUi9wqEO3AhO3Y/+zsQxGDOn
         p0rsEVUqfZGvZ1VlRR7reT8sIqVuSBLTtXQexobNdBgQoZF4vUIjbc0zovujLAeBHPNF
         PrOA==
X-Forwarded-Encrypted: i=1; AL+hErEQDabhJuy0dimxGAC8wJCITZzaLgnvE3rM72Cj3HDp1iIdfojFzuzUaGAllZcaNbZqSoOyYo5S0wL9Sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z82emc9twhw+eBRkwsE2lly7xxDMm17iHGRGWzRPbZZlq/OOgpK
	Nkfxh5Y5Paz9twkSB9zvLEoM1HNLXsMRE/vrzvVZiZtuUon9cpA2LcH4
X-Gm-Gg: AZFdTZdpc7cxyms/xY430Lu7bpAAYSU8CyIS+PULq20O0yPFSmaZEvIm5PyPd5nBZ90
	rQ3svmGhhDHDfu26owQOPQB4rKKgrrWeNN1k4J3NvZ2qYzDACZPhw6jtl4Rvss0gzjS9nf3hOwV
	qVh951wIbLcxnM+zU4KPkSci71zx6GixvEkwX3Lq0QtXnpTLUft/5XkWNYELpAwnpYUzzVhlfq5
	kKlW841oRUArFI2L/3a0a3HsHYxzKqOAMe595X5yY6I8hLc0P44M38I+03zCzcjaB9+V31Th0AM
	kWmS+RHLLD4PpwkYiDC9uIBDY0KnvZCfQ6Hj4o1kKUZnxsGfx1kOwdtdPFBzlz0KMa08/j8Vt0l
	KCqbjbIUXi0MQp1fnVULxi704c7Vfq9myfN9YJBtCPbROwZMWvTQjGnByeIjqCj34ZGTIKFj8sY
	J7TtuS4DC9Tdgz8Q/haHBp9NKgbHbkqdWw+nGzqSCeTk4SOLI8+FQ+SyXdbHKIg5zKHz/ta8T78
	5XIbKjmhswZFeeogRUnsi1KsC79gH7xq4UkldS3typOgD99tO3u28ql6Td2FWAp1/IqjVIACpP2
	sKz9XgvPkIjtp8DjLsiF1RibT2BEDlrPzvv6vjlzgTfomFPWOQ==
X-Received: by 2002:a17:907:9692:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c513aac2909mr735269366b.21.1795370084301;
        Sun, 22 Nov 2026 09:54:44 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm327992466b.0.2026.11.22.09.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 09:54:43 -0800 (PST)
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
Date: Sun, 22 Nov 2026 18:54:42 +0100
Message-Id: <DN1XKTU0C9E7.3GV5042SF8QV1@gmail.com>
Subject: Re: [PATCH v4 3/5] Input: hynitron-cst816x: release gesture keys
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>, "Daniel Golle"
 <daniel@makrotopia.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1791233147.git.daniel@makrotopia.org>
 <5312d67200e3251b2be08aef0a726d50d94fadde.1791233147.git.daniel@makrotopia.org> <DM338G5EE7D2.2WBOX8VFA3076@gmail.com>
In-Reply-To: <DM338G5EE7D2.2WBOX8VFA3076@gmail.com>

Looks good to me.

Reviewed-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
