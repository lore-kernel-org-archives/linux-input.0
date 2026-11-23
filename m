Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427396;
	b=vSodkgpYFOan0p0IwdaoKu8HFB1MRfuk24vLetydgTAYYTOm6Px3W4Aw2YmA4fx3h10u
	 j+ssV1+jzoYHn7RqSQwAAF0so9K3+lmuF7rtqGkIDnhUqQ43K8AOSwJgdXAk1yeIf8x7R
	 yCgqQoQUKI3XxXyNE4/VJlR8Hns+61W4C4DqG6Q7kEoqynh7itPghiV53dv4sZr7NcIZq
	 6+Ia0lqPFroY1w6D57BAI2/Hv87AxADhtZv9/ZckxyTPKZStcjv77WNAklZ45bSsNs1nE
	 ViBO6NC0ZjJMdX6YSs0MZXiIKcLJjRweG7pyZp32W5SEk3j4wReubNqJiOZ9joctLMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427396;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=tMwSrV2ZjOeBiqelWNaRKRM/bJC/BjHhSGkPihEQE4o=;
	b=zDgN61OWNjg3wSZeH4C/xMEEuYrCmouu2NKb74JO0cSd23+CUvDXLBAWKz6BaeiObZWO
	 XsoBgcKxPz2TkqZATWmQxH8J3d/AQLF0iyhg9WM8opOQAmRUm6/bNWOdVjXxSaqRKIOXe
	 4eQLda+NNMM8WMhvO5TyPqTMLvgVKlDBrUUWKviWwzOdJlksdHAKumGb058VhtYjtmHIx
	 e0cxzQiBE71oqkS84gVjiZinQ/KIk/WDcl5LlIJ1nIHtshnorMcod8PNkyEqtPlyK8SZ2
	 dN8LKqgOvAcmtCTnzabza3elIV5GkwSO/FutteQavkMASKkqZfkYkoeu8wFosbxohHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XsEEV1cv;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010E606A337;
	Mon, 23 Nov 2026 09:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8010E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XsEEV1cv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427394;
	bh=dEpbWbiWtLxirOo3e2Y7hCJY0RRBzW/Rgxc+4UBphNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XsEEV1cv0fqWuh+8ZuPPCMrRGNWlKv+AaTbW/j1LNcnpOVToHvahyGCnwToD4wPxl
	 meEfKwqBhJTlnynQSvzh13ov3p4A/TaM9H2Pe2OFDDhrNduv/ZXahQVmzP2q9s1ZWB
	 SSZ6elK/gct7HR/vf5ywMBS1aYj9ByoSil15qI4Omb+YkpScc41uASC0btHGAj5iQm
	 Fbva/+qWSGoAjH7X2JtSc3s1T7tp5zjDiT9ykceUFm9XP5kUKE+cYm2CQWXz0r/ZCl
	 lRaHivzB+ioSSORdbbc4nEfr5ZwkmLLL1+/8WGMP9aczpmf5e80J7NY9EDjZdWu+nW
	 2tPYpjCJb/r8g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BCF2817E04F7;
	Mon, 23 Nov 2026 10:49:52 +0100 (CET)
Message-ID: <d4ae0697-2d1d-4c8e-b160-fc8389898121@collabora.com>
Date: Mon, 23 Nov 2026 10:49:52 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: mediatek: Add MT6895 SoC
To: Alexander Letuchiy <asalde.le1@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-8-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-8-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add initial support for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
> which has four Cortex-A55 and four Cortex-A78 cores sharing a DynamIQ
> cluster with 4 MiB of L3 cache.
> 
> Describe the CPUs with their caches, PSCI, the GICv3 interrupt
> controller, the CPU and DSU PMUs, the architected timer, the system
> timer, the pin controller, two UARTs, the watchdog and the keypad.
> There is no clock controller driver for this SoC yet, so the UARTs and
> the keypad use a fixed 26 MHz clock, and the system timer a fixed
> 13 MHz clock derived from it.
> 
> Only the CPU and cluster power down idle states are described. The
> deeper states that also power down the MCUSYS or the whole system need
> the SPM and the vendor low power driver, which aren't supported yet.
> The system timer serves as the broadcast timer while the CPUs are in
> these states.
> 
> The cache geometry was checked against the CCSIDR registers of each
> core.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

