Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831260;
	b=po/RXB2EbcoackT+YwmB9E4L8CJbld+m4CZSVtKwLQ0NtaAEFzRVxeCfHzd4hjg+cKZk
	 iNx6yH9PzgUmhfJ1NDFdi5GGjlRzZesOLP2i15S4H4ubUQZtv4JnaRhVjSnbJq8JpnIDf
	 F2KWekC7slFciOSnjFYZa+ylrFCYMBuRfMMI8K0l/68/9DMy1kkFyfCMXib60hhaS2JWY
	 w9My+G6XGGYD7yhyyYvUOktfyVrUzCWeo8V7eALHzo/6+66UmEH9bKiBmgbWqXJFHZvW2
	 CHJy1YTeLqXpeiTDWG1qpctIO5LYFigqXEcPZzHyae9/YeK5bJ1sqA2R3fpTfHMwJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831260;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MbbNnl/jR3I2yk7n0pnhFk5B2IOyBxzkEUr5ZXc5j/I=;
	b=YA1V7nSc3UWY78A+GlR+VFzwr+n8nhvOWhzSxKOW4Sss26+KTI2o8KBBVxMewNfpUTOO
	 jQY+TdwTy9nO3lEAyPGD+hvABvEQWwMMXh6LB7xsutrDhN0rgncNVkcP1MFDQiHgHHmrc
	 00iYprWwaIaeIQr2Rei77+LTrEFgpglczWrieD/PJZMpaNRnxah+RK7P7hTEXgMv3G9ud
	 y6Sfn+tWMlvZMZssbdq58UfKUHnSKw6ErHUwzxe0MFg1gPx3YJSpXwX990dGwqmhxHS1e
	 JrAQjMO+mYWZUyhDqRo7hilVgy0URuPo9Ptjn8Bo2VJM+ifvTdDSKMMK9AJN9wnToSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8G00Yrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9F606A32A;
	Mon, 16 Nov 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8G00Yrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B25D1F000C5;
	Mon, 16 Nov 2026 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831259;
	bh=MbbNnl/jR3I2yk7n0pnhFk5B2IOyBxzkEUr5ZXc5j/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8G00YrpMZOFOLqZjGfm3ltH/GlUUkVKqMZNf93IProiIv/J7xu2U8EjH0ShqbYoc
	 AZTrr8aN+PE0KX8sGiQ0y0J/Af511zBRVAkPbsNdA5vE5tATFeEZRJbHeMVOodUZrv
	 OH1aN31qJVt1rpseTxC3rHTlTYnuyrNYpUlGw5A5PbRDYoSzFc3F6b2XBju34Zudl+
	 RcugStbk3rSR74W9Rt2YP7q0bzjHJ+Ult/PEzZ1vAAU3fBqcYeBuLE94ldhW7znMf7
	 xu60wi38paiT0gTQauw4tOmTwpYX+2FK+rymiMhTGpfJvg6me3WtKQr0zB/0LOfVks
	 cdnhwm6iYT9PA==
Date: Mon, 16 Nov 2026 13:14:10 +0100
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
Subject: Re: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add
 compatible for MT6895
Message-ID: <20261116-shiny-encouraging-mushroom-dc03de@quoll>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
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
In-Reply-To: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>

On Fri, Nov 13, 2026 at 10:05:01PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the system timer (SYST) of the MediaTek
> MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
> through the mediatek,mt6765-timer fallback.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

