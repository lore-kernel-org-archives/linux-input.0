Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678193E3172
	for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946174; cv=pass; b=ZFfvIWPiW6wCr+5dPqt0KxWf8xOS5LtWvkgrysWnowtw646ZNRBtGPXzQax1Egr0WiPHo2GlvPmS4c2SshWnw0hpTNuc9/A2oPMUUBkfd+AmeXIZcSzigQdhWVHtEmyhthmcXjZ++FSl7niXjwXCVlM0vYmbBZ8BXdiELebBrOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946174; c=relaxed/simple;
	bh=XVn2QcmjcQjFkVK1YggfjpxaDDncirg+Y3RdNmPE/+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPDroQLztybXvjNpEG1pK24a2JJ82ntNHXxnOsclMWLjWZWUtTruHhujvrNjNJU+pAa5d56UmabS9koM8v1IFc9vmbCfEwhqz9iwDvr1QURXqc9EbgXP9JoAF2YPM9zkhV/tJ9TcX87qSpd5a6HAt7kbgwb7qZtiqFsvMn7S2KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+mjZTkM; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+mjZTkM"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so649959966b.2
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 01:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946172; cv=none;
        d=google.com; s=arc-20240605;
        b=AewGlrpp7rXB10wA1pIN9iLVWx2Yam9NUKUA6q31GT/Lbgct1geoU0+B6rkq1eRE+J
         tuMhyO9QzyH6DAWdCG2/900eN0Yftm88gRlqSdTrKW3tCL3DvKb7VeLKbo/JK/7J0X4r
         wixatmhJSj7Ymz1oFcD4pl4Rbd2LCI4QPfrLhYMIJle/HjsEP84MRPUt0n/3jdt2wG6A
         8HmXbQIhg6wuhJy1SL8yAN2fT9j+aKD+bMj+WlEpMJQM/4gvBfcPHtnPJ78yJrP+Yrxw
         lPzBfCk/HAxYHJ7rLFAoMpqaZ6Dmal/VM6XkUMCrnzAgUjapjjPz4Ehu5vsXnnKurdN3
         D/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        fh=/DYy44e4whkPu81/u3lYEfl9usgD3UL62cTLu0w38Xs=;
        b=YQLszNPxH3sF2BUnfyplN5yxKBbxVxxdbclPRWxEfw6Cvj5rU601C+BVjUoKObnoUm
         QR+pBDf9kumR+fz5v7C600+Kmb2Ik7q1tBptdF5myzeM7c9litBf0NgqJmRpi2X6Oe3/
         FDrEiE3q0ttFlUax8HoBJaoEgkl6RNPPq36vxa0gKFc9Cw7kXaWiD7mBRDzFoJ8CzWSv
         8iqRH3SII8ukcHqTIGXIrhd81rXTPUvfBBC2aZxKQ1HXfJzDk42JtX7KdxIJwV0aRp57
         7BVIq4Iz2QL9khMfln4KU4puogvZIVCuPtC6fbG/QEfO3fpLC80/sshU551SUazbPLXE
         Fghg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946172; x=1775550972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        b=L+mjZTkMhikoveXVS1doON1iA1D3e19kfJZdouvzvYjjCPs/Ox04vxuqTbHSBKdSmV
         ijzCACmhOB8z87E+xJGzEsmDKjEmXyZpcjBDQu20B+9pmLPVkF3yGnXCMv2iT4yM0+rl
         UisC10rV3oTOuBJjPJkEKe8C2wrlXqN5ZWuoeaeag8EleBfREB/CfMh9tbMsQEQzV9Oq
         2Zmm3ciexDl+gwr6RCPdgTmPgLplOkSvhRb1pYOpi7ylQOEmqHPU9cpxeutJkskX3aVw
         we7CjQ6vN46t+XJp/YOMcWWwMk5ZCF6RUK7UUq8UhLrCQ7yk+AFwH/kQCnElpUKajMdW
         JLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946172; x=1775550972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3TSuB1FbI7lqYJC1uY7y+dtfsWxR+6ey/FSJ/giDGM=;
        b=XFfbhCgpWEc2ILJrqZFwn1xh/FXK0WRAIoNMpPqMr7mCly1I4XrYrhMP61PYP+rv8W
         jUeaRam8C/YpW3o0xFmW0AZ3weTDW7HV0xlwFFFLALtojvrHTpCaRWcs+VdySxPp21rV
         FivRWyUZEoMraJGW+QdtIGwK/JUS/i4MyDyHIFasvdV/oQdIx6pecaN+ob2tpqcwqVpC
         0z08ds7Q4X4+ndcPDIBj9DahP8OwKBY3jXIRqL3YJ/uS1uPD+jX6704S7Ug+ncEWZnQW
         Fr4on1LEzNWUsnj0ghTxtgIMWey+JgtaGU/7JLzJohbCXX1A5GEJAqumeVFZ+qK5eXGB
         EkCw==
X-Forwarded-Encrypted: i=1; AJvYcCXJKAwuchpUXte7mCwZEqMv+xdNHNyUWFPOApxsIzqG8/nTYiGQJ6KiwGLntBWuXXOBZoj6RZtiqVwziA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJi/xXrP5ORVGEPwlsb3+j9On+LQgI+/X1FO7OyPaUvnZW6mqd
	USJK+7J6u9HoNPsUT6t5BOqKFpL7XLMm15r9AkcoYEKHxLHthG1IFubtkGnl8IscDO0SWaOEi2G
	gEXOLGGrLzyM65MwPNrI3BYlwQ6Urkpg=
X-Gm-Gg: ATEYQzzfsikQabyT005kqdXyzoSoVwasfo+qgP/9xSTcyqxvTohvtasS/rhfFU4tCAl
	tW7w7MELW0ugJkvEYuYybZWY4wSykLfDiOZ0imHK9ZYKvp9MTneynYPSjhYV8AWQXBPFUc26tU7
	rPrMfCIb6fjgJApIEtxgx7GprJg7DHBCB4D85oVhz32qfqNSv+6sDr0OUn/9I6D5Qcqb+c6wht0
	DLIS5681TjfFlCaL2sbxi8pHR8Z7cQrUjGG0eFilwdbwe3qYYJnLceoj8tGZhSOysxr92vc9WW2
	iFCFiQ==
X-Received: by 2002:a17:907:da7:b0:b9b:fa57:d5b2 with SMTP id
 a640c23a62f3a-b9bfa57d98amr71812766b.42.1774946171488; Tue, 31 Mar 2026
 01:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330083429.359819-1-l.scorcia@gmail.com> <20260330083429.359819-2-l.scorcia@gmail.com>
 <20260331-flawless-bronze-lorikeet-59a6ff@quoll>
In-Reply-To: <20260331-flawless-bronze-lorikeet-59a6ff@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Tue, 31 Mar 2026 10:36:00 +0200
X-Gm-Features: AQROBzCHGHvki3QPtgYv0FgcoeVoJGVuIm0WEFEat61ZeqaJ2itNlZb_JB2hAws
Message-ID: <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -    required:
> > -      - compatible
>
> Not really, this affects existing ABI and might make the child schema
> being applied. Basically regulators node can be anything now.
>
> This is definitely not a binding we want. The syntax for parent schema
> when listing only compatibles is requiring this compatible. You cannot
> have here whatever empty node.

Hi, it felt quite strange to me too, but that's what I thought you
meant with your previous suggestion [1].
To keep the required attribute I would be happy to reintroduce the
compatible here, in the regulator schema and the pmic dtsi.

Before I do that and resubmit, could you please help me understand
what you meant before?

Thank you!

[1] https://lists.infradead.org/pipermail/linux-mediatek/2026-March/105060.html
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
