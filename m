Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7339CCF8
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378052; cv=pass; b=klc8l+wbhjoLMF1pu8YtEMwQRh8GtmliL+Xoc0ON7q7Pj9lPFKcMuVQYYUkZLosvHxCxuZHnisC+JE+a7lIlnEWrGH/nQXl2lWfQ/77+wvfPqiM5Wjkhf7kK65NdfJNvWieJ/fIAgOmrTy625kyBdoPDsIrNwmmHTgW/K/qXDZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378052; c=relaxed/simple;
	bh=eLHTLx0sDJsJ3UdAPIBmpFXK0Itit+qS5fZpvv0jeas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVcPxM0hI3xYL39F2v1QKK/G0ja+71ARzCGDPQEAjRG5cHzv1n15mTvkXmH9HgIjGzZ20/p+ujb4v8QwEWWahSy4X4bEJKhXSfwRvesfNg4T4YBIl5moHWXSEExd7UbYpxi9FEplNm1gNP1ohYcIqXr0miGBPvRt/F3wjjRpZ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUWb/IbW; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUWb/IbW"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c255acff671so218772966b.0
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378028; cv=none;
        d=google.com; s=arc-20260327;
        b=HEpMMhlMGJaAIn5xzvyo0rLzQqh3CNVhq6Fb4I2fGqX2It3IovSM7Za1FT/HnQF+3T
         HrzCYCRI0YFrfFUTGn14C2JE7X9oTaTOEzAvZy07UvmSZJcEkBYp+CjcDOOv5GSjZ9yq
         5XQDo3iSlt/XYfw0DyNaDmVPHUuwdSGdDh3oJ0OtypS9iJtohb8vCCHQtzezPJW2xexI
         FwRxAxS3xfj/n1gExiEMZKG0/Kz4ZrdsjNC2cxx9okfJaP88Mxo6DUFFiIHqU2UOTfWF
         /CkDkY7gkzi6+qrDS2s2ABXhAsM5qm1NvuwgqIR94WAGIC0vkBuTGv4qdIOPYgWfVHqh
         quPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        fh=iHAldso5J3a4pGF6jHugTycndrLCPMyN2nRu37TiGEg=;
        b=NYxKVLEMtmncY5h664rYdgbhxgiAnlhGLuqpVEwghu8qCoW6yklAC43qz24nqQ+T7l
         38p56/KhZdEzgxq57L+wgTwAcwHLGF9lUSQJfUMK656S7QuubteqQY5nnsOvwYieBLdQ
         KZcPfZ/b4aAmkEWOM5XgMzXmwZo65utyUGruShVDSY1cTsVzztffFiLIFJSY8uTNGnBH
         ul6blq3jQTEwXOO5kfAofj3x2sIGuXhZbx64ABxD+ctpDDuWX+g+0tIOHOqDRqUgPudt
         OyoOKkjzvQ02RrpHoNFE1QA4wH2HIyuca1xN4oUcW8zjj6omC8AmIa5jr5PnzhmP/OL8
         k+iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378028; x=1788982828; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        b=RUWb/IbWnwRrHbpmkQ/geuHNzbmDZM3cbIFwkfhuVSlkzDe9K+TllRV9sa1zWSFFNs
         P3UEISuLLof4pQVZAJksf7DH0AF2dwvAhkVTxtsCHL69q9dGK1yGxrjV89XvNvcLbc8m
         BqOrHpBBJttj8/slVhrpqfoXgq3JnYrl9wRfF1IvH93PMsBNKVxTqg9Lw/MoDl4YjSST
         WpmBUs8pxfEhgA1UaWwT/3P7AXVuaTtrPumsRcCwNtWxsv1UH5u5Ez+omICA2H14FPdm
         aU8Ee3Gi7M3UfMH3RZa+aoQQrTL0LbBcJBfLlPI1DdLYXaw/ofFUs/TXgvK/a5X6VzOl
         QgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378028; x=1788982828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MqbOVEuyYxeSD2DntBhPNO5j8MUT5Vkh/1ohb7qF7PQ=;
        b=VaQS/xLXuBhFUesCMO1OpK19zrcvawuenJTqprHTwPyXDBa3roREBQkCQtBobrLeAE
         h0DV4kAA4nyBRFxMqpVybU+vsCscKmTXDQPKv5oAO8KJK0CJGtYWc2k4TDxeFrfn/k9h
         Rfp2Fx6yRoXUjcb9bqu3Ndu16YERD3rI09vFQLJ+mG26H74TJNMFLfXHJuKqs8tBJBhh
         VcSMkPZXKw2Q01Km10kPI/vBYiHa7AD0R8m2FogbJprDbT5PPbKH6xlhJX7FmSNyVSaB
         CIP47ZXxzuhTVDmY55jLrebpl51wazRHL62bT2qsHA+yFU+Y53TlYsViKdV/dX9kmPFU
         yrcg==
X-Forwarded-Encrypted: i=1; AKwUvBykBSB+Dk2QP6VSNxCWlUHbbVyAFch9Ybdf8Vj4EPKLPWMzMCPrsq7A4dePtN0vqUQKXzRMKAC0+I3Uww==@vger.kernel.org
X-Gm-Message-State: AFuF++nShY7Rj5CWj7RTKnfOn75H1ixP0ozwk/IEFMgrc0SY8YTtCfXF
	2eSZSiEbNuLVIsxvnNVJLxYJkS9USG9q4cLjb6iazp6/ibGzTY9ub3tWwAckuMNJ2R/GO+Vk0we
	R/uCaxQqoqGVIEJjAmGgHTnqQN4P4p2U=
X-Gm-Gg: AYBFou3z7i09tuoavIWDDMsJXW/tvXjwRnNmWMyA4cp91RhA9uXmz36mjM1dH9Tme8E
	Tt8rx/aZ6XKQwvXhbx3gYt7s4jMYLUVsbnbeduKDX//aWSQZymJX8Bm5E6YXvj0JTbXa3ZHVm0O
	qfhIBGNxeHbAPJBv9/DyxrImJ1t109Nmt5jrWbaC/yqvBN20FlgsdBOJKNTz79ip/H/HdaGqCJa
	V7yPjyt/ndWMj+rOY4D2NWh5gOVmxfjP0t92iZtieiIm65uQzBGgKGl25rWqjRkpEHPEbemK3Ez
	YcviJrPPsDUHqRBIO7Q4JjMwZjRhnHtGfx4DcQR/OYY=
X-Received: by 2002:a17:906:6a06:b0:c25:88e2:fe25 with SMTP id
 a640c23a62f3a-c25d53cd18bmr358830066b.7.1788378027879; Wed, 02 Sep 2026
 12:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820122242.120039-1-l.scorcia@gmail.com> <20260902154616.GA2133376@google.com>
In-Reply-To: <20260902154616.GA2133376@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 2 Sep 2026 21:40:16 +0200
X-Gm-Features: AcwNN1Ue5U8Nrt8IK2CbOEno4dpAA-gcYG8T0qYRXxkQ6nYlNe8G_uXeI7qiNIw
Message-ID: <CAORyz2Kt=rKSJW0Q9pFJiBsa6nPGhHdNrsTsHcE4Qxpq5RsSaA@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What Acks are you waiting on?

Hi, I did not get any Ack for the regulator driver and for the mt6392
dtsi yet (patch #8 and #9).
I just submitted a slightly revised v10 [1] with an improvement to the
main mfd binding, so I think it would be better to "renew" the Ack for
that too.

Thank you!

[1] https://lore.kernel.org/linux-mediatek/20260902193351.185771-1-l.scorcia@gmail.com/T/#t
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
