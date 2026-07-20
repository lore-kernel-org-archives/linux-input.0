Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8740D598
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556454; cv=pass; b=YwtsjlLqz5on4gdsRkgy6lKIhGOmjFX5kZV0KpB1ErnPMYNxrCHsQ5yKkqCMyY+nkneeQ/FdJ9FpoeWh2u54UfoiuvHddmpUgtClXVXxMXc2pxTvOCO2DfjGjyOM38cZ1Qm5Yc+yDPgaMUWDSFIOszWZFr6x21nY33Im/4Y6zJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556454; c=relaxed/simple;
	bh=r6n4V8oTIiF6Cc2yyAdGZUbNGGVL2QpLuXftiOlSQEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrhirQw42XWEmSxoO3wSK7Ip8xzjmwaJqM0LhlU1PG7laW4afs3aRh6afaMJAWt/UrKA1BxzZarMNTBkIHftAu84V1PBSN/83g2FteNgy2fU734JT2oYAcWkx4YooN4p0Z1zzPGbBQD2QT6ITXU+HzVXDWzT9PuD/ot60aCTRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2MgLzQt; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2MgLzQt"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1614804757so1076907666b.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 07:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556451; cv=none;
        d=google.com; s=arc-20260327;
        b=eqGJeVsZsKwpO7gGkSq1HkTFXqRGfwOXUdd/AHndUMXf6CvYNf1rAxdTvrGjm6npM9
         4Dw4kWDEAoqhBZy4hIhsQnAgPqnWdzmhFs5mVSELnUdVT7d6oOr4o3O17K7zhIIrTHg6
         EqkevKc0IV0mtWCid00oGwbe0SW4AmsZRK5XT6ja34KRq5XwvLe9H0uCUJYajsQY3ECh
         K3FIOPeQh70pxbZq2aoT/+w94Uujuju10kHiATkv8gL9UGb03ERRoHmreUuL2jEdYOyY
         XkrMNONpN80rTNSsAa8VAp9Eke3zg1Sg6yrkVA5O6jxbb+QoMCyQ9nzWJjvZj7Em7kZ1
         fw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        fh=wy8TWCzhi2qRbaHrygEUXqq/dTez3PE5om2LSVmEJDk=;
        b=GzUUY59eg/BNKPSFwY6oQ10PWuUR6Upn33kft1cehZwEkRauGdYKw6tSv/LwJXfr64
         KV+4R+Q9noc2DWqEJ2J/uaklAUhPfl+JXqF5u21XavmE1Z6d2AtqxK3ZF1s0NBgxo4d/
         zqFEkjEzxH2tGZNVroHyAn/1ygLMsRDb40mEN3XiZXKCff+rr3phuwQSWeutvTdoNtFh
         aowQHet4vpWdZ0lGFsz2pSNW7X1oBtc0FCf77XPRtdgLK3fYg0s9wbRb3HwkeQTcNnjl
         UExPDCv6v3yIIdm2ZysafjzKMzNa1BsqfdvTwAodv6n/cagtlwj5WjfQ0RYldjqbo2Zr
         koKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556451; x=1785161251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        b=a2MgLzQt3CGzGz5eMCYyv46AMhuVNalm1K4dR3Xeg9zOQXopfu28uSd3Dn1MyG+UDY
         LYpOHmPxBsoaN8546q6TXqs+nKWL18NMO3lr2Bupq5pBlbbYXDpur9PaRE1q9w9pPM6K
         AEW3veYlo92OAzIkA6CO/Gr94w4wDHO+jtBaD3tVY1cIG2MW62IEUP3MVFUI/xLQnpDr
         tSMJ1bDo2L7hwBKlwSJuasLfXQFZ5UZ7RdrND7BAzm4QXHB+LVZ/5QEAwP+mI8qnke1N
         /2OoDp7r6SV/+olx+3tY3o11kmS7Ndwsg3xoH8M3sT+Gu4eqZwkWQTwh8ZADyrwc4VAa
         gTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556451; x=1785161251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        b=Vg7rQMwXpyD0LRVFnA/mpl7ZPS4svKyVdR+YG/0CLHB6CNM6XTvQrls4az2pntrgIB
         lNKO1f0gtSk+Wn9sVDw3rfIfAYinFaL94DCbdGrmg9oEgcuEUNw923YJoevIBtHYvoz0
         fLUjAxAtfim5/IxzYVr1C6uKqztdPQ1EDx1I8iy3basEH5n9Vkt5dgBbaYz4sTWkf0jM
         NMU590oOkSvjcZKbKevp65xt66D2UxEZp1WFSfSsH6rdzv8UoF96Uf+pVnnHf5qwAHUF
         6tiixW/QpTv0uoWzj+G6j027CafcskV0CE62qIL4etQq8xg2z2j8vlTxLVUgF414USkr
         /psg==
X-Forwarded-Encrypted: i=1; AHgh+RqF+mmOSwFnqwC9/ML9ByFla0WbdC6xs8v0rfR1YxAEG5vCYWOOjNBzeKXJ1NlnNdCFbm0Ko/8cm8Tglg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9759HGGW9p1JtpvjJZ9oxOK6SXPU/oDwR7BkvO+kZg2C5WKAT
	aoF/m7G2ED5i4soJgcCXHmEJkkqwv5vY2T1u5noSsV10I9slf+HNEmbIuUWNSaYXtJn1xilJZno
	4Hqyzy+b9dc5bu8tb/MYFg/K6CUgdM6M=
X-Gm-Gg: AfdE7ckaiygN43tabIr8Q4yPx0R64GF6Qa4QLFv7GEYwMXdpn+VRboMolBE7vw5fsB3
	6Xav3RWkXvW9ieblf4YYa0Y0EEnYBfkB9XGpKo1OrkEK6U53dXJ6fFJgSWzeC6LvOQIF56HnqYl
	ZZCJ1ia7DVTRNsihUWyS5IjvGH0VjyJ3GvojoQ+VlqzZt5KSXb9hE64mu3J/rVQ75LNiIbg+vde
	tYxMhzSpS8qiBlhKijoJNUlY56lHck3+0LCMiSYaN8PFfdKpxv7pG6+QrwS+NaPKbAtuhzG+vl3
	u4fD7ekRf/uu2PnGzFeFQ7v40HksdZwWj71N2ZWDZvMs0aq0bKEK
X-Received: by 2002:a17:907:c012:b0:c15:c3bb:c90a with SMTP id
 a640c23a62f3a-c16b47c7292mr550030766b.35.1784556450739; Mon, 20 Jul 2026
 07:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718215632.3295049-1-egbostina@gmail.com> <20260718215632.3295049-4-egbostina@gmail.com>
 <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
In-Reply-To: <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
From: Eddie <egbostina@gmail.com>
Date: Mon, 20 Jul 2026 17:07:19 +0300
X-Gm-Features: AUfX_mweWNBqk7caXjK50S4Mh9MQkC1xza8VdHGojIe6ULgydOnDi9gkyNgr6GE
Message-ID: <CAEFOc61Tan85xQhz33BuGSnJHyACvjRc+6YMFYav85CzxMwiwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-omap@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
	m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 09:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Jul 18, 2026 at 09:56:32PM +0000, Eduard Bostina wrote:
>  +
> > +          regulator-compatible:
> > +            $ref: /schemas/types.yaml#/definitions/string
>
> You should not need this property, it is already in regulator.yaml.

I did not find it in regulator.yaml, or in any other schema, but I
found out that it has been deprecated in 2012 by commit 13511def87b9
("regulator: deprecate regulator-compatible DT property") and was
never carried over during the conversion.

I agree it should not be in a new binding, so I will drop it.

It needs a dts change too, tps65217.dtsi names the children
regulator@0..regulator@6, while the driver matches dcdc1, dcdc2,
dcdc3, ldo1=E2=80=A6ldo4. of_regulator_match() looks at regulator-compatibl=
e
first and falls back to the node name, so without the property nothing
matches and the regulators stop probing.

So I will rename the nodes to dcdc1..ldo4 and drop
regulator-compatible, reg and the address cells.
I will send that as a separate patch in v3 along with the other fixes.

Thanks,
Eduard
