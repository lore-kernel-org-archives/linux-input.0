Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884333BFAE7
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831447; cv=none; b=PuaJb6ZobRpEl1EYXQFsXW3LVPhbaM/t0UcuBHeg0O2wMPlnr0esQ4AlS1aSYtQtuhWXX5FUQcbJeaUOik3NkchD35rT++ElwMKFjMgCz0CGiFTUfoDWpSTNFiULjSfkChQ79wOYtyK10iS2POReNsD45+kE8/PvlelFmCfn6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831447; c=relaxed/simple;
	bh=F8CkSS6IWx1ghWlHdt+L/gsrsDwzuUfdc+7urWYp4M8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=GDorlJEfnkPovQijMMbVVj8qo6LMv+BszTayJ5sc9nyHEsiw4q4Xa+xNky7V3TCNIQpQ+9WocdbPGxKYhkiVp3IgRzkKfqyy6BqaNeLxiaHSi2VBOC9BhNbRT4f1vaG8jKkn/iNhyFT00w8ubouGiN0gd8gtcMzIlEKg0dYLr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKhGXCnn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKhGXCnn"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso313986966b.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791831443; x=1792436243; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aq6FGDCLIMEaFm+sGEB7AUNjwxZkgWT2FW+F+6Aa/HU=;
        b=nKhGXCnnR+SCxJkn/6FnRpU+hNmHiP43PDV5GC5JPClqmpM791+o9Orvl/JfZfDogN
         wh7pZAcfuSwFDhZljDQjlzGOEHCpAs6B/xU6zBpLBcBSV9XxMY4Ern+aiDHmhRjCQpG3
         /MWP8peJmq985Vyg96H+mTiistDfgyF4sZ6YClbTlt08OaGyJblOa7fYpfqcOBwtVFkN
         jFhW8Z3m/zP30o5jztUI9qm6Y8Ix9BW55yHloffa0BY8CABAmdbPXXc5xmLYkw8oCsT6
         PPRqKXibTqZOQDeAaN++VZK+P7qU194wyg+2WbBxm4eLJhZMVwIul5JHQaGHemNpASVc
         P6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831443; x=1792436243;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aq6FGDCLIMEaFm+sGEB7AUNjwxZkgWT2FW+F+6Aa/HU=;
        b=a+CFAG3T4K+9ndmcYhjGfMnynVpBGYFR+IJMnDX28PnDJw2xqzn6b6X474ZirCk+9C
         num5IgUl88QQ50TxKBBzzVOaoY+9P1Ddixo+en+pxlWSkxLs5ZWqwAsJpgtXhaGWSnoh
         LYud8cXl9zp3PtBvzkk09DPS9Tf0iOXSA+85oBjjQ7tEMGlXG3iwOylb65YBcxepMSRt
         9PwsA/Hu9g4hFmo1Bs0BDAslC75vKySK4TuXq9vyXqKjyFuxtFwOeX58b/gNsvI605QR
         qmgAhExVifQ/bB3jkDSh0H68dpEEIYS/F7aAoTySYVB+rK6LSJTtE1EkurQTSD4PIYlk
         Zb8g==
X-Forwarded-Encrypted: i=1; AKwUvBwEIlVJF7rRqXVq6F43/E0+VaXsE2ZXyUwiJ0/4MGh07X2xjE6Imwm4yd0txuzDQkGrqQNE0OiFo+9zLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKvnexK7A04NLSjM2at5T+K3yKqb6/nhbv1gZsPUhT6jx6b2Si
	b0uD0qOe0z3pYoIA4Ak8jfBSVUq65KAISb/GU5JQfSMb4hc9DWH9057Z
X-Gm-Gg: AYBFou2AMnFNl5Lfa+QURWcUqDdPdz5Mh37yoHAqQj/QCuy+1VqBRzD7KMbdcTrcH7M
	9YhayRwVMvvzIDUtoEOji4BI1CfYDWqHi/RjIKxfV3Bwtg52FF0mOoV51FaMW0X6IhrDJkZcUSf
	iO+nDMT6d5wmUiRjWAcYW0AGy4hirPHGjkRl67m/bsTqQPya+/20dZJJp3s8iM4Dk4tFZXZ0X1P
	9itP4VHNV+d/k+Ppb7R08ZGM4NYVBSLO+fhPAORFdqVFVMd0DXbU4Jpzp/Gyd85B9GIaMoe9EHx
	BqqjbhSRkC4neYQ9oSpOns3ecKfw2SnwvpYoyU9Rzw5guuCzdeib18eXcnxHsn6zkbvPtUaXy1V
	84gw9q0SIukH0V4xdFb1ljHwNKZK747yo/JgY2Nn97v/kqx9yHFY9IC0y2B0jthawKC4itWmPVy
	oQ43kIDCRu+oh6COo48zHOy0YSCLZoWIoSi++Ur179Xq65+h9KYfozrCzhFaWb04uX/Q==
X-Received: by 2002:a17:907:6095:b0:c34:c5e8:1dc5 with SMTP id a640c23a62f3a-c34c5e82123mr410354566b.20.1791831442493;
        Mon, 12 Oct 2026 11:57:22 -0700 (PDT)
Received: from localhost ([46.205.201.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9af103csm484502566b.87.2026.10.12.11.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 11:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 20:57:20 +0200
Message-Id: <DM338G5EE7D2.2WBOX8VFA3076@gmail.com>
To: "Daniel Golle" <daniel@makrotopia.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] Input: hynitron-cst816x: release gesture keys
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1791233147.git.daniel@makrotopia.org>
 <5312d67200e3251b2be08aef0a726d50d94fadde.1791233147.git.daniel@makrotopia.org>
In-Reply-To: <5312d67200e3251b2be08aef0a726d50d94fadde.1791233147.git.daniel@makrotopia.org>

On Mon Oct 5, 2026 at 11:11 PM CEST, Daniel Golle wrote:
> The gesture key is reported with the value of the touch flag, so it
> stays pressed once the controller stops reporting the gesture code
> while the finger is still down. Report the press on its own and
> release the keys the input core still holds down on the first report
> that carries no gesture code. Report a key only for the gesture codes
> the binding names: the controller also sends codes such as single
> click, and the index fallback aliased those onto the long-press
> keycode. Keycodes above KEY_MAX are rejected, as that release looks
> the key state up in the input core's key bitmap.
>
> Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4:
> - map only the documented gesture codes to keys, as single click
>   aliased onto the long-press keycode (Oleh Kuzhylnyi)
> - read each keycode once in the release loop, so the key it tests is
>   the key it releases (Sashiko AI review)
> v2:
> - reject keycodes above KEY_MAX and publish keycodemax only once the
>   whole array validates (Sashiko AI review)
>
>  drivers/input/touchscreen/hynitron-cst816x.c | 87 +++++++++++++-------
>  1 file changed, 55 insertions(+), 32 deletions(-)
>

Tested on Raspberry Pi 4B with CST816S panel.
Reported coordinates and gestures are valid.

Thank you!

Tested-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
