Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831270;
	b=ZpxfmODPc1yNdImqqwFkDXUlSZWHycPfA9JYZHWflxVwHZra7oNRSILbrl9gYtCW/WXV
	 X7Bu5m2eZUC95FI8A2He87zKYPx8k7MOH19meAjPuQnqJmkkikPe2rff4vVPNWNLmE3Ax
	 oLOEXxAXFepsmmZb093jqeOciI8U1b2g+kbQWNckIrEPs8wg931cnERV0zg2QZvtGD8oe
	 MtNO6R5l+JlhrYhUkGUb2MATxw3b2ACS9VgvLaJHIin0fKIne+f1PUNUdGz+xgtyLe5GI
	 8REzzI2uLY8ZbMpaJt05OTE8mzfrOpm6zxgRXckEZov4DAwRVzPrE76ZM75eCbljIBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Xn1i3YnRkDlooHuSD1NNSSzodVAxCfUHp6XrUWpozOA=;
	b=IyoJsCJCvtocEJuWuPNS6Z+vNWzmAxySmSUi8wRa2PCMQDUVmdV6/QfOM/CaL+xIxLPp
	 Pe3JLThwEB4K/CU5DZ+algDiTH+cHB/cHoRMrahl7y8LEkZIcFwJJOhTyySIU3+AJAUfu
	 zxSsbCiSRgDIcOO6dFypuKdh4FBUA1OH3ulKy6HiAffP2t/43Ar2tcPWTwJnHWL2Q2N2f
	 Ttj1/Taun0JIT0r2rCLLOaVEtv+i1SHh8FDqDohLdWJ9pW8Amk0Y2e0k7AIwU9uJx+3uD
	 y9Ouo/Dx8/4fj1avNijnWpg3H5U3iHknLBW5IKA4CkMYm4VGw2HNVpUYE3PwwALc4QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KIm50iQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328A606A31C;
	Mon, 16 Nov 2026 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIm50iQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73991F000C6;
	Mon, 16 Nov 2026 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831270;
	bh=Xn1i3YnRkDlooHuSD1NNSSzodVAxCfUHp6XrUWpozOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KIm50iQ/adAvkjf6peIijG/2vh984qmxf9dwhTBLew3nTx0Om6CadhLy96Bx+X5IE
	 wlrS90PvzDhaVba5SucbE2OYb36jax4bZ47GK/qvZz2cssjpevzK+XnVdBg2fPTsHI
	 iumPd2qooRm0CIzMrmGz/GAFYV7sRe7zeIT13kvKz77iOkgz+H1l/cJOFpLZLJ4oS3
	 jvMngguK3FD4r8fP0tIngANPJ60GSldBwSg5AOH1BlhBo1b5/E2Guafwmj0tVsxNEJ
	 HGclFUizCNNxhHJGYzfj8v4yDk0NXvkATJGkl3expuv7buN9kbDnRcuSGEPPipZMkY
	 1bMT8JxIrGJ1A==
Date: Mon, 16 Nov 2026 13:14:20 +0100
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
Subject: Re: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
Message-ID: <20261116-real-ginger-raptor-0e6eea@quoll>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
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
In-Reply-To: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>

On Fri, Nov 13, 2026 at 10:05:02PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

