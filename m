Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE63803C3
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530385; cv=none; b=G36URxnxEhJAQdOeMkNiPVp5Hu5eOIfpSmhnIyZv4YvyzJa7pN8Llv/+LbigaDNuEbzO1fyEB0P9VAnOrAA1ikE0hUFwGWxim03ZHxXX8mGU1BVByJen9Z8VoE22XvpzHw1lKgdg+n/vmQPDpbz4POOpjVnbkw27EGZSsfsek+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530385; c=relaxed/simple;
	bh=Jye6GvFlEjzThLUvmLkambJ/dmm3iU6zf37i3X16hC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIDrsZ0zy36p36+2f+GdhSVcU4efgi3REYRbzS74Xo/WsXTZrEnyh2JQIfvtusNJps5Baf6y/pDtSSVDsSO5SJA4TmA60kQaoDjWpsLhPTf15NJWR6pdrk1OuW+Arp6PqAk4BLSSfewSFF0P10250E5x5/m7icthQhfSzDnceqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5F/JnQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5F/JnQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF53AC2BCFB
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530384;
	bh=Jye6GvFlEjzThLUvmLkambJ/dmm3iU6zf37i3X16hC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f5F/JnQHSKYkh1ZDoeWc0yFbkA3ZlVxuZe1RZYlXXFqzidoA5HlbOcLTxiK3W7N6C
	 SBpq8Ql8L5DzkKbCGSTqXYwN8cjP5vHAiAXIJaLDObBnWKjXhUHL1Yeub6z2c9Tgis
	 gYLFbF/JWJP2ymiBrR+9eq5aiYO0n83rc5H7/pzeDmvC9vCSypoMZJW7J7/5aKguCx
	 pARHjI2mFhaxJbYy/hUzCjyYMB2ulCHjCDd131nTytK4p/ov3GJ3tQClaeGEgqMhhE
	 Xv1CYUsTHPdRPMzGpwuFW5d7ToUpMGLGnwpv+ch6F4r0t52PMdMs95TAZS0ys4WAq4
	 uIHvAQ1yaUUyw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-393c93a0166so49097231fa.2
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 13:13:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9YHOll1tdvbhJqG+QDWpUT30hwmPTYNbgGdblF5iNTeKvOr0C8KNgcMD1wOcaEOj/vBgf9MlIgqIOsBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZAYR8Wm/pdfsa2CJY+NPPWPczndFXjJxcdeeDKhtxluVZDJ8
	Xq+NlGKt47X0R0/XizWkEdn3GM/ybAK4zwQ9PEI7YvecBdukTb2Rt7hFF5EYNEyPVs4evKOaEcj
	OAF5FMbdagUDlFiBhc5FGfiQWCmgkALQ=
X-Received: by 2002:a05:6512:3a88:b0:5a8:9aae:3c99 with SMTP id
 2adb3069b0e04-5a8b6e8f606mr4490300e87.16.1778530383250; Mon, 11 May 2026
 13:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420213529.1645560-1-l.scorcia@gmail.com> <20260420213529.1645560-5-l.scorcia@gmail.com>
In-Reply-To: <20260420213529.1645560-5-l.scorcia@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 22:12:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLnypYKUmKjnPX811m5Gc0guUwYeN=cQuxpAT3_gS9JWWg@mail.gmail.com>
X-Gm-Features: AVHnY4LX3rah_STGf3_slNDMEwQfgJHe21tHW014S60VT0tshZIqHNAjHJXvWcE
Message-ID: <CAD++jLnypYKUmKjnPX811m5Gc0guUwYeN=cQuxpAT3_gS9JWWg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Val Packett <val@packett.cool>, Julien Massot <julien.massot@collabora.com>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 11:37=E2=80=AFPM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:

> Add a compatible for the pinctrl device of the MT6392 PMIC, a variant of
> the already supported MT6397.
>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

This patch 4/9 applied to the pinctrl tree.

Yours,
Linus Walleij
