Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822676;
	b=2twxzMosc4LPS7eRJhfWsRkzNaXq4LEi9TWcR13L7/sjQa8qmDLI4zWgV0qmeSK7FGQd
	 wRjJbHMCeGXFSB7XZ9Z17VKkzBYsF9hAE+EFo0dF1eujdK3M/gJCL4wHf3G8xXVOOEZFK
	 MqXi9Dl/DyD5dgT9BipzTiifakEZ1Fz5/wx1UoTmSQabt5G83gqN8oYHTq9uFmFDztnhC
	 GuvjDRIriwS4s2L07EVgrvnoM2gwGnSS0pMEsV4CWQmcF0pHQXWakzhxD11ms1xFbU/5+
	 RIB2UQhFP0tJSWgCVFL9fo1vMNG5F1dDMMQKUbF8fhY1a3ynIrO7cNAuHJ/5uxKHNKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=JgdiOWBAP1/nIji7HgxFrYPJWlr5o/OvklSC1x3arJE=;
	b=HVOVkyEKsYvgjtdp2EnhxrNaradohOaQYre9sUuSZmA0BBg0G0XcO3OAcDV1SrQPHCVE
	 awXSWfoYk32kCdygtF7uWltVfP+oRFIS1FjSA7as3sgjHPI9hMRNLuQ90SfcFmeLd3ejS
	 pA5YXxOSYc8pzu4aHRgUnPQut4fDv1CP2wYpZauD5KAWYb8S3Lf5B7crJhBWkXvR1u4oE
	 JtuFqMR+NgpD6CjgZepuSpwr1BuY5yuu0omEeiP/DSd61T0mJd3BxlLZJJRsrUKFelqRa
	 TEkZAaV6RFwDT2MV/+QpMpkHHYct/E9MZJiUE1gATPB4GWXq6VC/bJIj8Do48HRjGpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gigmzPiC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F279606A893;
	Mon, 16 Nov 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gigmzPiC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02031F000CE;
	Mon, 16 Nov 2026 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822676;
	bh=JgdiOWBAP1/nIji7HgxFrYPJWlr5o/OvklSC1x3arJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gigmzPiCqtr8URfsrCJl4vkcs05v6/AEdg68SwNTNsranfvU8IZZ1wnH2l+aeT2DI
	 HcvXlTmZWCH+hz1LVM2Ip4jt4PMn/jbhJ814nW4dkLZ37nhpGxl9he+CGi9JY/hwo6
	 RO38BOaqOrBhqMy7+2bftUddnIs25FlmPdCLrqm8GOsUf871VpOmtxR/ep2Gsrlm6X
	 flhYE5VNkgYVhKFlntkiEc6DQzlYd4OhNLUeCRGfXtCC/WPf54L6GUXyZzY0/pYBH5
	 WH9SUgmvLC0NLSiKzqm37MEAW3eMkcMfhmziktJHaMSBOa0DXm3fclQblG4WTBS3N7
	 4zGS+Zfw9sZsw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Alexander Letuchiy <asalde.le1@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean
 Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wim Van
 Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, Alexander
 Letuchiy <asalde.le1@gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
In-Reply-To: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
Date: Mon, 16 Nov 2026 10:51:14 +0100
Message-ID: <xhkdbo6bpqf3h.fsf@mkorpers-koolstof.csb>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Alexander,

Thank you for the patch.

On Fri, Nov 13, 2026 at 22:05, Alexander Letuchiy <asalde.le1@gmail.com> wrote:

> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

