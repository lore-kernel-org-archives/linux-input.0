Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8B348C54;
	Tue, 18 Aug 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041882; cv=none; b=Ax+TBRaEhLmZsLeKhNNXzDbNqPljiAJh7XW3Y4sWsI/KUI4uoC5RJfxONsuPecpZlNm3hWah0z5CMIH/2+JifMF7nkGxfOWzFD/dixP5hpBi3/1UK+hjl0V5Dn/FZynNz+3naHr/yo2w7YzkOriR8DycxvLkAkYCYT/gqIZPYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041882; c=relaxed/simple;
	bh=XM7fE3mKtzVB9JAKS78sIDcc1liv81ME2oLPJMF72kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgjhOnT7m8QvHMNZiDwqu+bL1iUOcQU1kRxZHexsgIvICYYv2PaWjxyF/jM41hOyXkjd85TuxuDgJhJ3uZk9vxJYYyqTc663eQZZUITJAIRYLuj6SCbtI5u8i9W5MQweeWgp/XuoxwjFxmyms8bRJibrZPN4evKHrsRMnEfkS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C026E1F000E9;
	Tue, 18 Aug 2026 08:31:19 +0000 (UTC)
Date: Tue, 18 Aug 2026 10:31:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6572
Message-ID: <20260818-shrewd-falcon-of-focus-f4c2da@quoll>
References: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>

On Fri, Aug 14, 2026 at 04:13:52PM +0300, Roman Vivchar wrote:
> Add a compatible string for the mt6572 keypad, that is compatible with
> mt6779.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

