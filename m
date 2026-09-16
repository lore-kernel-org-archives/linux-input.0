Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEE37EFF1;
	Wed, 16 Sep 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563774; cv=none; b=YDDzfVDdgTH3/Vx/WISwjlzk+TlzWQWfiP659VPQlYLIgyooBX4BI5Tozea7uvvI1TwLJtni4F5bzeNpEsV+gC4jp+H1hlhfSSA6EApksAwMNPpUWFkZ2r4274voXbzqcseurd3J1Mlq/1vvoEj/Ubx4xFe+wiZInk/QyWkQA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563774; c=relaxed/simple;
	bh=2kjukwKHhvxex4UWdS38ePUoswpvqsSXD+LWBFfMADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN9UVETmGfJwi0VzM2v5FJfjS9cj1VxV3NGaWpJlZZVIJ9e8ujcImt7Va8eSlB7D+6gvbMjvr/ynYOmJJzYKgOU/+zLYNpTCx45LhWnS2nW8PNbiDvPHS3ZCFdA4iGQiX988d1Ze/44PApqBKIWLzIGmRigxpR+daX+CguamdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iVO/NUWz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iVO/NUWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789563771;
	bh=2kjukwKHhvxex4UWdS38ePUoswpvqsSXD+LWBFfMADE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iVO/NUWz7XlEkldHQ8fJFgw516V1fuZCTBhCW4JfIuOvywCJ0tRW1Nm0ssUrJhb/j
	 c0yx5Tgb6JMAxWh+oxhKXzx8xCWmxKuV33u9LJEgd+Az/BDYjdPTZ4kCOe+UoszWLs
	 5wOz8P6cd4/reWtT0xj2yidbGolDL7+yMCO0Ov+KkVMBymhxalcZnU8OJEBYq/xdC8
	 PAR7rQUa5gfh8hVpmFzw5zYIjP5M/z+6aTwAYk3MAYOcZ1kFq8ICPFxtIhE8OQ7y+E
	 MKTV1gOlQ41eRm0jDEViBii0lnuXRIt3F64Njhg6Kau4svjJ3Uyw9xuTKcTNfKvjZd
	 iz5wqiM4mPUFg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF03817E03B6;
	Wed, 16 Sep 2026 15:02:50 +0200 (CEST)
Message-ID: <bd18c1fc-6ff5-4724-8b20-dbbb716e299e@collabora.com>
Date: Wed, 16 Sep 2026 15:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add the
 MT8173 keypad
To: Ryan Brue <ryanbrue.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 05:47, Ryan Brue wrote:
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

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
>   Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> index 914dd3283df3..b45dbf805ac8 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> @@ -27,6 +27,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt6873-keypad
> +              - mediatek,mt8173-keypad
>                 - mediatek,mt8183-keypad
>                 - mediatek,mt8365-keypad
>                 - mediatek,mt8516-keypad
> 
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260914-rbrue-suez-upstreaming-mt8173-keypad-fddc316ae098
> 
> Best regards,
> --
> Ryan Brue <ryanbrue.dev@gmail.com>

