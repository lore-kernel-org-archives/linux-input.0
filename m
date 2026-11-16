Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831247;
	b=1Dza+Ll80cC/DoFHTXdn4Z2jHra5/zoyfxvid93WmqBEwu4j/NKsNpSAbaeF15NNU4JT
	 BB1zItgMr/O1kDHOyX5iAHjNYYK/3gG6MNYz8fvjbeTxEuDurQgld2b1IKySZuiugGzNE
	 lCVqpitMEq30aexaTd74+P6WihrIlI7RjggTnqC+BFuI4GKyRCdL3GqGx4MDvgIAlMvak
	 3OL9MHC/6zNxKCuzgtksXG/Im3Q2QM2tDpDec8Ce5cXHksLR0HPq5ZibMICC0Fa3FyZI2
	 34ZgOlg5Zd0GoCNwQoLK77lIejde1xIFhPIM9X2n4M+kfVFScW9sgh0aznmhH291Csw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831247;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5TQnXyxPKsVYp7Swu6UCLm+jMK/P+KGC0Ry72Fb+tw4=;
	b=ntnMNVpSztwv3asS7c/vq0zEISxF+7EGvIXPavMo05+PRxGoAtJ64dgfeGG22bGRFC4u
	 R5S85BKRxgdmGMgsjwMP7jRIj7zSFYXyHIokSQ4/oD5zYyhQ3KBIBPPynQnMfnnhzP83Z
	 nNvxqdq2A2MVFndDmfvv/llMOB7F3zS5G1shgDWDamJyg/ZksMlYie8+Z09znlg+cy9N7
	 aI0a9Oe8vU0H5whfeAomZSNLslCIqwXLE3b5zFPdS3BPOgcDElvpgsQRlRe9xa9BN6KUh
	 ITv+FCZoxP7vQi1S+9o/lKddLp+cZvldU00BwEKzqVef8y6hPq+7gR3JhZWpJ4jn8Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALvci8CB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FA606A31C;
	Mon, 16 Nov 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALvci8CB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1DC1F000C4;
	Mon, 16 Nov 2026 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831247;
	bh=5TQnXyxPKsVYp7Swu6UCLm+jMK/P+KGC0Ry72Fb+tw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ALvci8CBxbM/eosyVK1BjxHfGbw2+ug0PaGwZSi7rRYyfOsz6ojgOENO9i/smX4GU
	 CU652soiiZ+0qC+m8SIQtGmaF1OTlqs0aFapVfUyAvUfYC8C+Q4ygS5kYmxY6ejkmm
	 QFZ5fQuQLs4aw5BGeONWggy5rgWpX++X29+SCoaZatkOOwJ10/ir7TeBL2gaEon58h
	 3i58H4i6SzvddpjLTMxueNlzoT1EnPnKcTp2of3PP5br9hM9DFlvqspWpz7WnZHH3b
	 auUF9oDP9H3VuM03LAcAJeVYjprTB+6O71Kx/THxRYhxt3kN8bzfxnJ+YMtICJHoKp
	 HjsGzaww3G46Q==
Date: Mon, 16 Nov 2026 13:13:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
Message-ID: <20261116-imposing-chicken-of-strength-108fe5@quoll>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>

On Fri, Nov 13, 2026 at 10:04:59PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the watchdog of the MediaTek MT6895
> (Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
> which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
> known yet.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

