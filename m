Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA663BB67F;
	Thu, 24 Sep 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286559; cv=none; b=Z6ZSr3LeLWQZgW5kJ83eJbrcJPsIUiKB1sf31PgTNr595g15saV+JjKhfRn3gx3NhA8f6O8E8y6Nljj3ehvByKAq2R/ls3iCWzFwpJ11KdwsS0CYIKkTy/JiRwuVhndfKEbD5nDo4HSXRQi2wueO1/MCV/K0LCU+RgJ/WeZTZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286559; c=relaxed/simple;
	bh=xJkkf2Ck9rd7aO43dEkbBSvpNDIqEhMKGiPAxG448bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUK1sfcpv4IbHzJRFislucqI4lqyE7Eo5P+iuN2yauIHnvvKxkAd7+qDLlvWR1ukzRkH30rjU/dZd0d6+7zgK+eNMuHWLZWhGtuhXrv4udMidpMEPkGjns2g9fPzGI7SgFuKo8lPFyYFBnqFXgrJXAG3wZfH2/9qz94EDZn81Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz3PUv1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz3PUv1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0646C1F000FF;
	Thu, 24 Sep 2026 21:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790286558;
	bh=DL7Nsv04kDdnpWUYu7d8rzd7D0xGzhZqRoffIzHh1Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iz3PUv1nz8/kq3IXn8UG6VWi81dJRXt0JEB/5XeWDE6v/n4NtUOEoFQhBBWF6Qpgf
	 osoKuOVg+1WmuUh9vncVqrDmUffoX0/tl6ow7lAVAN4dU9Er73ZDrRZl8NkbA72Mym
	 pMsLfZClmz8unc1E78R+R8lSrDCYmmIUIzhM7XeOytuRV314H/nFmMnx3dDM+cW6zQ
	 O9qFYzEKiSuJYur2KIIsjNS9qw41b879WFYmiFMuNgvvlLY5MopDYxJBmmr/RdUIk3
	 Zib64xvPhl8ZtGO10lJB9aH4DkNcLVQRf7vqaxdWm4y9iDWdhWTQ5GbXAKtTyi+PVg
	 iCVsOOudSyOmQ==
Date: Thu, 24 Sep 2026 16:49:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add the
 MT8173 keypad
Message-ID: <179028655599.1874918.3532753045457471424.robh@kernel.org>
References: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>


On Tue, 15 Sep 2026 22:47:50 -0500, Ryan Brue wrote:
> MT8173's keypad controller is the same block this driver already handles.
> Its register map agrees offset for offset with the MT6779 one -- STA 0x00,
> MEM1..MEM5 0x04..0x14, DEBOUNCE 0x18, SEL 0x20, EN 0x24 -- and
> mt6779-keypad drives it with no code change, so the node only needs the
> fallback compatible in second position. Add the mt8173 string to the
> existing enum, which is what mt6873, mt8183, mt8365 and mt8516 already do.
> 
> Verified on an MT8173 board (Amazon Fire HD 10 2017): the volume rocker
> reports through mt6779-keypad with no driver modification.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> This is the binding half only. The board device tree that uses it, an Amazon
> Fire HD 10 (2017), is not upstream yet and comes with the rest of that
> board's nodes later; adding the compatible first keeps that submission from
> carrying a forward reference.
> 
> No driver change goes with it. mt6779-keypad matches on the fallback, which
> is how mt8183, mt8365 and mt8516 bind today -- only mt6779 and mt6873 are in
> the driver's own match table.
> ---
>  Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

