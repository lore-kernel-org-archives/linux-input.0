Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792564544;
	b=Ftc2YkZo3LGSnK01MdCvRjYBM4rR2Y67uxzL/i8spcjIng2lG8IueVwnPDhwaWQfrhUu
	 uEj7ix3lw9UK+onXdqxF9QlnymJJaDkDAp12JXf95BCYRZJuxyJns+d8KHdJnIwZL8+nP
	 s3YdeXoeDIFnBYSWSK9iDmYsVlSv5ZtfX1Azu3vBTNRrUWd7rBUrS/BS7sq7VnRZi5VTT
	 d1xJd/9H2b1K7eYPvnlcI0LjdR0FY6QWNLaWhQcMf3r9xqLbu4azuADLq3GwLoXGd5qMe
	 9IZ/YvojuACpE9h7a6pgTeil0CjfjPC78RYTJ300/c1rJkbFetVDQ/T9BVcqlrUoq3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
	b=DJXXQDvNZs3L/9+6XTJqqf8DZxdQOPLvHzz4qoh2hdyeI1jFudFlv2gt8kIxC52g+J6O
	 s+CCYMxddZqmYQc1op2xS+1WUxKsE5gZMWTq6VwrhMQENHjGWvHS/q+o3fRiHFj0dOhKX
	 3x3PjjjP8k/wNR8fQqXCacN5lmknBLRr1YkRT3/tcmRAsmTbR320VtQamFpJJdTedQyfW
	 pV6+QA9y8ejn4FfvvPhVPkbiZDDkKBd4tlM1leb149R0bxlZQtByP7RmjF/XDR5DTWcFM
	 1Q22ggp6TtpZLTp5sc3RqYaaBB4hKNAb5HzmJHLUcWwGlR3Br/DbtfytKm2GGC4Knlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SQsO8Joy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C43606A31C
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 06:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C43606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SQsO8Joy
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so307171a12.2
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 23:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792564542; cv=none;
        d=google.com; s=arc-20260327;
        b=WwHUMGeludaROGJz0Tu8nkix/jolRhCT1cQh1GPC+TrKJ+O1d1wLA4AkhWedlnfyeW
         cx4IB3oAn06xUQYdX/ZD1qi2lwD9ylvDIqloF2jpCouPD8AJSo2V+6K6apF0UfQmJGto
         B2EATtfToXy1xaaM8b1S3skFBu4pjC4mDpp/fOuCLVJdtl7ck5f8G0sXgvD04iXC1duU
         bd11XqWQ+l6KYmvQLDVwJMpfzE9fem2ktQPM37ckwB+cKHnt0ho7NkwCr889ZDMdOU2B
         VhQFBXwC/yVjbS4AW+LLYol2nLKbNQtlPz5Z3os3BJIjaSevCQDPeut49UdjTrLacA7n
         JlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        fh=WeHfBbhb/MbcerlMqYz0++OHREV/duPku9gcob8dW4I=;
        b=MhuR1Ebv7HkWOMIGg/KrzOHnBI0ZHCquJ4Boek3Opd2AbYKloKStJAzmA5EueRGWNd
         Nfjfx58MStDNrDuCgpHH2hbMEZrAV8UzyWfK1iePfyT3WJPTP8TpJUwJYVoOMU5sRKhP
         HFM5i+jPYxAuhicRD48VNffaw0o9wZDSRK8ZleAVzYWkXl6PbMDgU2nS4whk/EcRiH5x
         PsetZBdHCNx07H4gro8zErTNZNgP5FtA2keOfR7r/DaqvsEX8h/vU3nmpDX+dpASPHGq
         X6Ayd9AcwsKckEIewDyDOgVo33NSWRn0VjymdWNFllkfV/4RAOH+rg1ZxCRlNqNFl0ze
         +mWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564542; x=1793169342; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        b=SQsO8Joyz7VS+7gfUvSNluNI65EhcKIFQMPJULqGN5UfjLP9MzbUUAM2GeJ3hqkllf
         uQTdBDyQbPPjRYGai0WfdeDnW3WO4+t42Z2mxWWGm4pmVnVlCQHe6qlpBR9vaZ+vllGx
         h2xGVBgEQCFKH11r+9q5QdY65sS295/+Tq2DS5ZXmmh/j1ULBCd9h7KS+U9B5Cl0c3Fo
         X3iBdo5tlBejOn37rvZjodYCVcBnhpW++UlRUA6F09Pri2F5ZzW1B1p7sy6bKVbEkrHz
         Wb8LUZX233PjNaT0LiBwXYPf0Yyg5Q1S+TRvn1by6+Fz8GSTOQ4X1R586y6DHikxclnf
         NB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564542; x=1793169342;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CPNgQTs1GPMvKVhw0mIO+CE00wYs1bBtR++qtcMf+Bg=;
        b=wKNI1NtgHxZ7tLHdTcl+0fKm/dU2qi49woUArpyAgZDo915DM202OzWx1LjypttaEB
         DrCzHbv1KYKbTpHK9W77CNRTm1RBkYNggzJcS809yCPfhAF5/dbXeJevY+vSuh9M/ge1
         akMo12Obsu3VdrldpLAunM4Jl1ml7Lkzu+2yTLfOKRIGph8e+vLFnkcpuSIDCT9tF4A4
         dUuolQsRk5ReOaI8tU8XdBo0xb3p24YB3kkcxMJf5tzI6Lv8+rzBk874BAFFbanpm3qJ
         zAEWpyr1fauYiky0qmtYzgmzW3ByZ/WJkEkZLKQo4Hef2w8CQiaxHHOrHAq6mqwncbrW
         C/zw==
X-Forwarded-Encrypted: i=1; AKwUvBy2R/LUlYnNLIdzZc12Z3oAeovnE/lkW9wta1GFusYgHOoAIVHCsLHm5H6Lhy8bVg5kKG/+ydve75vAIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIR7SU2NllEFEHp6jNclXNpqie6QpY3PQreYs//WfBBcy569Z2h
	P9xJidFHi9a6nxMUNeXZ1U+SWfz6STUL4WVByRH0VQPRchjN+i0xcNz5NE88wcpNFENYlPPv8OU
	xOR+7IrOEcFQfYpaw0/oJdvXqv8lpuldYKjwz
X-Gm-Gg: AYBFou233nxZ3Z2BcZC48J02WkvbF76YzH1fz02R/8wT8skxJ0HX3yValZxKnZV7CV7
	EYENC73bnNXQJejXhlduzYcwjADOO+Orpn5a8Q0N243aKEupUOXCaYAVT4qVfi6fjL1QUp20kMQ
	YIg6kz2KV7JaEMzXafQbKYwZyuj6AT+mVrk9M/Xd6FnacEWAlX8F690PKtnafQytLGt8qMPZz0K
	dR/CMkJH9xSe4dZ64kbkgrgS4s+9C9X8dNi0OE6RDlWIvRfc/hFZAdX2q2M6kZuKu4kiMf9GJFn
	2oxTPNW+0O86XHb1WmHlX6UTVVIqEJK7GdoUKRiB1ExU01SEwRfDRLY1yzhZQCRwSoaSmO+uahh
	T5IT/lZxcH5uinnOgt8gdvXBJrMgCwnfXp3Y9FFf1kypMBa6nK97DdJuQ
X-Received: by 2002:a05:6402:2105:b0:6ac:5de8:ab5c with SMTP id
 4fb4d7f45d1cf-6b408ea04f0mr627314a12.10.1792564542175; Tue, 20 Oct 2026
 23:35:42 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020173556.632798-1-l.scorcia@gmail.com> <20261020173556.632798-2-l.scorcia@gmail.com>
 <20261021023245.GA3650393-robh@kernel.org>
In-Reply-To: <20261021023245.GA3650393-robh@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 08:35:30 +0200
X-Gm-Features: AclHuK-lIJk49lXRNa98GE7gi3l_Bk4TgNu432VwdO696lfchFDIYtZnsg1U3Dw
Message-ID: <CAORyz2JS1vf7P2cQkzYse_WheB4xYMmywWi6v2pNbeFSkCO9ZA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Or drop the example. Is this one really different enough from the
> existing example(s)?

I am so sorry, there actually was a previous email by Krzystof
Kozlowski where he already asked me to do that and I thought I had
done it!
I'll send out v11 without the example.
