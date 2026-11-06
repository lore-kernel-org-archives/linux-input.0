Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793952002;
	b=Jr1qCEtIHI1SFxbCBcfuJivWlzkt/9l3XZDlPwweXWmteCHE5TfeK73gWv6yI6ijejQ0
	 ZbLoZUDTnzuR86auFwPKSvRtBqVd5XUtUZ2reQmr1WKGNi2vF5Ghk2jPkzjjfBMRDwiWq
	 XpyW2pKg74/lfTV86RjeSOxLzKNyO2frSHlR26gCWzu9RPUw/7ejunO0Nm1IUJlcruJm1
	 7Bcg8e0nChJ3GYPjV7R/KUPX5xnxnMW80gIjRQhAlU/xv+GLZsWXs6J6LhGsgL1SlVKSE
	 SNhNNvRw/yJi0yDIfTmycNxzi6O2AhxBrMx/XgASi5WjKUhnpb3c1oSrYVzJxYpe+Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
	b=CHRgpZYwayBCwGFOcV2v1+qzDvFp9dTy2nsuSFyh2u/emKdRpQ07YhlmZ7SdGbPYhm5c
	 rfFUdIOaHnv/L5TKF+CGAXFG+I11RGxFZajLchswhR3vcPqgqOxROIcraWrvbJZLLH1GB
	 U3aaduYQomDOJnRBIUKvdmmp6acBkjdKGoTyXlCTy6TcBSjQHV/WlxQt+JHEjrCWNm5AO
	 7Aq4EMx2XZWTryTDRrURQJXIkG1haeh6RA3iCwWuPY2LVauR7oOWKTDEjIpkVQUT0dJsI
	 vmer8fb6U3Nhi6gYHZXbTalYCydLBOx3G4VhAtzFO/j6mlDbPsPqTEsF+w1DBg3mUjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZn45ghf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B76083622
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 08:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9B76083622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZn45ghf
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so84666a12.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 00:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793952000; cv=none;
        d=google.com; s=arc-20260327;
        b=nJW7TkJgeDHp3IiokS1LnS1rncaDc7rsT7O+1PpS6faY3IcgyhCnbCfkt3tNvxRF0n
         /yaaTUQG+u72JznlaLf0p27xDBbihP9KVEhyXKLaZokopYAleCnq1sdJJwPWv0cGqeYh
         FUaPZAFVRLpu/OePpUhQGpzQ6x6NIxkrPTJMbnVsiNh3dPfUXCVPOC+JhLqlGP64hnxT
         17x0Iix0ijyCMxi3wCtKVU8VsZg89MCL09M7P/8/NA9froWPp9jD2y/bQ1JtF1aGXQll
         uN4+FiRL+sysGIO0Ao9MhSh5ZIBEsh+QcFBzc4qLF6yFX4p9i1yw6jJort6u+g1D+Ub/
         S5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        fh=B4VIZvnJfw439S0NhuHVIQcWolq4UPJbW14HcWlrSnI=;
        b=NHqndnV8+1CEIgcbxJtLyimgJwP1KwK+grYRD0cIUEKYrvDAHHibDLAKqxthuHwBCH
         FlT6lIyHDGsiDkBeqed6Uevvb0e/OvXtSNCz+/iLLvQQpIxuZ1CIChtPy2OxQh3Mf0sN
         7vX07CqZJks5y/2LUlZr1NnsD9ywx/GTpIiAzZyHS1z6UEe7/EobTxScLOCcr5Cbe2Jt
         qpRAlctAE5I0Xf1yb8qmxS4/Hjw2VxYnEMNiUG7GLfQhppPOqZe9zpTw//2o30UOvw9n
         6T4/vGcWcEw7Ln2zEu2miEsSEWUv2yYvnsDCYMK3Y7IIrnnf7pIzZWkpY8FoACsRd9IN
         HVZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793952000; x=1794556800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        b=NZn45ghfBG0ZvdDOyynp1nFEfObT1pcptC1zoQJVefkfah5Cvf4KhBdfAtP45zAtAQ
         UULmHj0hEPtCZn15bvzalYNRj9fhdp3uyVdEClRuRLkVnpOfV9ppeglAAdfxPS28qNaw
         O+q0E4sjEMKTMoFNcQUz67xVF3I/KdEzY8yg+Tpd2afhiQuFsmYUaFLtm5Ti/Cv1nQCD
         bntrz8dBI8l+pN19cS/mEKfoLl4E98jrhkuxDF+X3o30Z7L31Q/ieTJQlTrfBLk9dFV/
         5CptV3jFVboDZT6yTQgUn6wxAwHGSAsVVrnPYMvRpyNWRmRF2c+DpLESNG1RwdqVq9wY
         I3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952000; x=1794556800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JL/ejsWQpZh4uIBI1fUZsT9Ty7diuDK7PLmVq35sQrc=;
        b=yvqjZvU0Oo60U2G/IMiBzuV5cWUCd/pMQRHUw1IAwgEdDBpMCmrW+KJ9r8WDLo5yJu
         xyaHFVkPqAEvIm+ib+NrtmKXKTi+e4+imeRw8FJN6fxtqaJhQxIKGhulGtvg1fWkk1+l
         DTH3hK0ZPOEQamTp0IEH84oPZfGA/AycESROFVUsFXj49+NGoTpykWG5q5gAIKVfRLPh
         hGatm3iWm0TK67VJeerb05Uqlh+9s+i3Y+5GQX8sUjQXqbGiT4EQqqIBigOFbj1qo+/b
         JMilUOsWsBbj004ejIgh3barYWokd0zvAwBsg0bt7qEhzKsdwDd3Ky7l4ISIW3YGZMPr
         fV4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxgfu81CNwb+SreWeJythia/et1ZwHoHtevqyGbIIYye6RMg+VrhcDOjM75e4++dAoHOOvM3jrmnDYdzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9EzN+fjttWQBaykceLFYbGazAcjL0vI8zY14JMdrByXU+xwLu4
	EsX7x5xsuHX9X9ISeV4PluKEbhqz7YTGt2yj2305a/OH40iIuWlXcmia8WDzwoLJ8kobKB1WQYC
	Wa4DnPbaGKaRhe9rv9Voi95SQOrCpeJk=
X-Gm-Gg: AYBFou37GS/BdB+kjKhWBxIPilzrAsNPiswXNid5VVJuycn5Y7zS9Vx6vyjdCgJiOjg
	8kYKDYusu3CU6AKxw5nvtJJd0QsIQHWbWFxl/JOKBlC5oFoXiH0kowNxL1nQfcLfvxP2TxtQmRn
	7xbsAlwNEMik4yuZmwHn68bP9qTq4oYHzp6YeHNP3LjU0G6Dni6Lr+QdOylVJ34CDqsMbxQ2woa
	9B03jezarzM15XBq89zJ/JeNzQ/OHR17iVkHhgt9j0BNAkUZcMNUMrKxj7CI6wDBWmv6Rvq4kWf
	RH/8JzekXlWjNw+rC79qOXTeDs94rOuzgVER8LkFDJ+3c6BTUmJPfbM1XIIoDzwatoOtN7bOV0J
	P9t5R8is+efCFXbWW2AeHYXaNsbcsSYMZBQeWndF4FZGZvutnRtkAUvqk
X-Received: by 2002:a05:6402:440b:b0:6b5:9849:e335 with SMTP id
 4fb4d7f45d1cf-6b5985927b4mr1117288a12.1.1793952000065; Fri, 06 Nov 2026
 00:00:00 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021105109.199886-1-l.scorcia@gmail.com> <20261103150936.GB792264@google.com>
In-Reply-To: <20261103150936.GB792264@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Fri, 6 Nov 2026 08:59:48 +0100
X-Gm-Features: AclHuK_yxwIK0Nk7bFmyEO_n6HuxXT4AJJgazikzKXrXwadabrKuwJfTV_QGR20
Message-ID: <CAORyz2J_J0dYtg2BMKq9cuzo7U0j-cMQoFXn+2pOTztHz8dS-g@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How many more Acks do you need now?

Still missing acks for the regulator and pinctrl device. Yesterday I
sent v12 of the series [1], rebased on v7.1-rc4.
Thank you

[1] https://lore.kernel.org/linux-mediatek/20261105194426.1113050-1-l.scorcia@gmail.com/
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
