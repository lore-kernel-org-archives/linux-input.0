Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945936920E;
	Wed, 18 Mar 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819454; cv=none; b=SKNUp3cluYoMmnCgfi8ODy+RWy8tRUY0beBrWVGYtPy8/I5NA/bA49VGIlI8zpoirQMz205ZKiEmJXIkGAtDP2W25W2XNrAKtp6OBIO1glfBc+3mfCNLjv3fyLJ2AyfOVuDI1OjpxCxrCjoumZCHGYHegqJCcAQ3N9WsX2ECyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819454; c=relaxed/simple;
	bh=M/ax/mRFFdqluuuB9V9vnJDmziqeSHzHaAaRfTp2XXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtVONS+j0B7A0y+Gqg5+ScpncWXDMNZXZsN7heM6oGPFrMEHWG7L+rdefbCa1KnTnxdEH0F1ISqEbPzUZ7V+x2AN//scs3yW/DgMHnfsIZiqLP8PexkOCuh5b2HTzSH3dVY55ZUDQHs77RDUPlcinJ59aTZQYWCOBIFqXv3vsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1ha0wVP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1ha0wVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89147C19421;
	Wed, 18 Mar 2026 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773819454;
	bh=M/ax/mRFFdqluuuB9V9vnJDmziqeSHzHaAaRfTp2XXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1ha0wVP40dk/s/pC5SIP+ELHAbdpt8isWlkxwmQuY/4Iq9H6La50kbuaqwtkE1rb
	 SucfJdeh7N+N92Xm0s4B9btRhxZPV/3fk4YU0LMoeEqKu9D1O4GnxEmCiG5rbHwS7Z
	 tuf9+s8l9aKfXL9jbCqj9dSfmFvP4SPYQZq7azh9yb/RFo/8vhuzyPB2KQseVk5lob
	 X5AyCZI3tcPJGS5TeTxzfMQTgzS353u3wCl1qjimrO/9TpmVbJ4eZgSzslMkTHr8+t
	 PayG+mKLNtSkfyOsHKu66sKT/jXPdPNtaxE2xS8Z424qu8c5B08HmoVTbfK189k4ae
	 cwX05FkOnJ4gQ==
Date: Wed, 18 Mar 2026 08:37:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20260318-heavy-bear-of-art-4bc2a8@quoll>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317184507.523060-2-l.scorcia@gmail.com>

On Tue, Mar 17, 2026 at 06:43:04PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

If there is going to be new version, then please fix all the subjects:
A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

