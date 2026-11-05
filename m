Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882999;
	b=mfwyQCwZlgjvVb1+LI8gg/xMZrCo2R9xkhG3YFlzC76WCSqquILhm1pn42XMfapuwb6d
	 n1zkxR0dFDxUcQqg5EqG7ZxK40OZLDUxU7dohc/jtMzDyeVkUuhaoa1w6KAt02Hf9ygBI
	 VLgp4wWhhnct7WQx175BMpn3bGfPB/WjrAA9br/vc/lx+TZBK3U5penFXlAre2Nw7HLrQ
	 UKSt0y5TmboGYJ8AlN5gJUzI3dtgbqfeEwJUTel1qEhgqsSZ+IxW/iB7uq00f9FQJsTrI
	 i/KV+ZY6gXosVtdYR5VXE3UfDgnW6V9gJqEkBJL6yoSfYM84kc4+5voZ/QeG8ER8sCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882999;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kIDzP0IDOJsWChOEyUPHD/R2zakQJaIiem1/u8B6t1E=;
	b=UKluWfdQtbRJawuMbVQeWFE1HlYwXfyKgCh75EWMJOCHDA4mgQvNxTT2z0vvnwZfgue1
	 Io1oWyCVDOHq48flmhCNklWKRtFQsqQNsy9tjfs1AiYN2b4rwOUUq6/DCqc5z7QmMnDPN
	 CDqVX1yvQPJRiYclsFrrWqMDaHXpmgO5EvllTtKOnBfzUiMxmVFdnzE3SJe0ODryeajFB
	 57wq9jPOBXAaTZCVIEu+ocnL6P3PYapCiJu52sZ3SyyiUCCcBE99x4rNbH33Kni+EcwCY
	 snVA1br1tNdNH7iwOtG/KBVtX45VzbzaLYu3mAKDtgU38ATktHc6jIZ3nq3QFeYSaXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OLHEmmrL;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747D606A328;
	Thu,  5 Nov 2026 12:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C747D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OLHEmmrL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793882997;
	bh=RlhWYfICEXqxRLXR7YbWZGm+6cKZIs9StBuE8vu18kA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OLHEmmrL4SUw4QQUdUdJ6R1Yv7p69HUyEhKoJZG2LhtOVjTOcs+RqsZhB3zrZHs8z
	 3t/LUM6FYcDtt8OgGNvv4Pcp3XTWf/s2My28ZvVNk30Z6Dd45zgyrBupACbAJ3wHY8
	 8bfCjwq6jVxOwqJiGH5hwt1F+9KAo6jWj2UvKB5SQK94oBne/cvS1uRXCOT1KUCHbW
	 SmL+Efs+XBU4ysdYX6YxArtl4Gn8XCSL0N1ghvl1N/p+9vxFHo/h1s3FYuYD4RmX+y
	 VL97c9U44XyWu+iJe6BQcQpS+nknp1PgvHmvYk4s3yGNo2Ry0nGQj0vbQFsTCTxs9z
	 I50jvT9V7VZoQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97FE217E0163;
	Thu, 05 Nov 2026 13:49:56 +0100 (CET)
Message-ID: <8cf203c8-69a6-43e1-a12d-25bed35b79fe@collabora.com>
Date: Thu, 5 Nov 2026 13:49:56 +0100
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
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6595
To: rva333@protonmail.com, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 12:29, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add a compatible string for the mt6595 keypad, that is compatible with
> mt6779.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

