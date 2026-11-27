Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766648;
	b=oQvIVpHNDuzKGtII7FZtKqaNnmY2EIZCUR8ZCptOIHBLfShVvbMt4mK6FaGlsnWUw9fk
	 j+mb5soDXRfcdq12535VWnnzt1uYxh8XSNptegIGkS6okkVHmOhUHizEZ1BkGogkqa7HF
	 vTO3NOQP5qkm98xHYCSppgCJocP7+XCSIITRM5+DKgXQQQr7zaB9LdUKm8My3VdvA3ysZ
	 yOguLrGHcchBxFGjpVcJ5yxIXWm9PSngfsTtzmzReTTGh6igfTqTD/TGodaJ4qyT8afpb
	 Ecof4tnyAbWGaEMYxOvkNN5KZDG1t/rBU01ta/EI24OhmFHaimY5WZZZ4aNKXdGQABw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766648;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=0Uk3DM1hXGgSbrinOlWbLYwmZse9Fx0OnZPuwT8c5hU=;
	b=5gjVr1sNmmWCRyHXNXvJqCKd9iANnc4HZgSNRIO8J6lHLOgMc5PKZQdKSiMPnEwKr9/J
	 8LqFg6nwjGEV6ehiVm1exKJ4vo9p+pTG187q/9F0YYl8zp4U23QSdax5+2JtQcHNxuTB/
	 w57BJOviee10hC01VnFCErpgDVLe+Ui0pMLsTQ3vN0494EHa82jPcsDK3qZ+RZwZb+LCA
	 cZqNWwIsYpPLEXC7dEEt+2XrYmIAHwyepJS/ZMxj5b2uE0kX72dGqJ2YcsrQdS7wah2m0
	 dEwEpiBZG9rZLIx+9lNjritIvqFs78q5zPNdp0nRy/8XitA9ab3odqJmUWw0eRcbA5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJqHBrz7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A9606A31C;
	Fri, 27 Nov 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJqHBrz7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81201F00893;
	Fri, 27 Nov 2026 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795766648;
	bh=0Uk3DM1hXGgSbrinOlWbLYwmZse9Fx0OnZPuwT8c5hU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BJqHBrz7xUFzaqVDmL3SijzD55Zcd5YsaMstEcRThSbMMIKevkXW4C6PHOA9DzoxL
	 7fm4EGUBUcaKf1cAJ2oJMl3vLLeF3M5se59x1elshj5v+Zl+AhpZz6w9stOFxcCHnX
	 fOCinu5JfsJN06iwIN3NIIPbRnrm0cNLfDojp2m+LLrE8ddaJnX8tSv3tAo4osJlqW
	 e72WA+NRKLzjI8pNagJe+r5MRazbvq/dD4L5AU14FbTpdiBwclOqAjDpN6IDvw/5sc
	 ncdTo4NKsqd8lh4qVOO8Oka+pvIS3OVgL+2hCzHPBHkTi++/FUpNcnPyXZs6d4bmxM
	 WkzFvRShL6TOQ==
Date: Fri, 27 Nov 2026 09:04:05 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Tawheed Makhdoomi <_@tawheed.cc>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Jingyuan Liang <jingyliang@chromium.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: input: hid-over-spi: add the Surface
 Pro X touch digitizer
In-Reply-To: <20261112172641.407-2-_@tawheed.cc>
Message-ID: <2r51n495-9r07-po31-r450-20320713697n@xreary.bet>
References: <20261112172641.407-1-_@tawheed.cc> <20261112172641.407-2-_@tawheed.cc>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Nov 2026, Tawheed Makhdoomi wrote:

> The touch and pen digitizer of the Microsoft Surface Pro X (vendor 0x045e,
> product 0x0996) is a HID over SPI device, but its firmware implements a
> pre-release revision of the protocol (input header version 2, device
> descriptor bcdVersion 0x0100) rather than HID over SPI 1.0, so the driver
> cannot treat it as a "microsoft,g6-touch-digitizer".
> 
> Microsoft does not publish a part number or generation for this
> digitizer, so name it after the product it ships in, like the
> "microsoft,surface-sam" embedded controller.
> 
> Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
> ---
>  Documentation/devicetree/bindings/input/hid-over-spi.yaml | 1 +

Which tree is this patch based on, please? I don't have this file in my 
tree.

-- 
Jiri Kosina
SUSE Labs

