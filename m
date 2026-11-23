Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427404;
	b=ZlmUgSE0vHiqvsItbCyfd4esU84FIVc88Y5qyhdXp5t4bKw7D92pQwwv7ERBSmqYIraY
	 q+I9s8XEykOqzNngmNJYPJuO88nCEoObYQCWA0UdHY/CU7DxFza3reE9sOL+Svrw/rE6v
	 IpvQx53aZnrWFUc9pTN8KjwhZj33GgoGqBVQFNiL+XIearV0BLHESzXfc+arsmH8RuTyv
	 tnROH1SND7/bu1nPzgFsqe82ecanypc35yEWdJcFiCtPiPtl4CCbrR0qzpEo7jb/nX8Uq
	 QMQs2pR/oN1k24tqlHQ3fjUZszlwU13iWuDwPVLQOv4wq6xrRs9UFr3PFFdSiWeTrCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427404;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=N7yDg1jS2E8ZCXNtP72vSPpBD2Z2Qt0T19MdanjZIfs=;
	b=hGlNZB0kPZDgWVvBdznabAMO56eo7AlsA2R/RKtIQSnwsdDR8Oa+tEbDY59y33px7yGt
	 ze11X7SuRHf7Hfpl7k3XykV8wMlSDWfSDRNMPn6EIl/zL6+YXKe0n2Ec9rqu4LM0pWPwO
	 0zAAgnc0Tt2vBtQGGLdWteEUc6esxJEpd07h+YuHcH0IJfElS9kuRHp8k5n9AsMFzZClB
	 xDJfsAFybNyES4T9G4s3jMYg2HSf1ldAIrtsfil1nwP1f47IWL6L7CIv4xboHtqur0PDE
	 jDBMioEYDkPxTcUM/9Ye2BHEhIuij6InkkyJtRY2x+idqp66/vigc45GWvITtH9vJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jRITqFx8;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2678606A337;
	Mon, 23 Nov 2026 09:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2678606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jRITqFx8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427402;
	bh=CPgJojwzYBCxEhJmvECCQ+W9MCWeNgq7tm1d4lpevIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jRITqFx8dcuWF5L8ddFKB7RdkiTji2UrVdFR3yRyshOEO0LJyY6mB9jQaDW6HHRE0
	 PWwfXI44nIZiA6T+mpabpGmephLhwESHRQKdBjgEXn0tZYV+Qwl7wb3BjJg6/nuRcM
	 bZ0s4bM6K9oL7jWZfmjVCAbf/cL1/uVsGKUcWqMyXAikqlU1DFk++x114e87SLlU9N
	 6msKMyRuSLvwWducNH5dEDGDpXzWLxYg9oogAwGiq6VwqDzC2zCespXEnP+TX9gmbO
	 o0WGY8I9UuOUQeN/q9Z9JWXyCeQHhLU/MxMw6bQ25ZPRakpHDU0uqAOqEcLmR3Fnkf
	 OR4cH11C15A5A==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 870E417E0EB0;
	Mon, 23 Nov 2026 10:50:01 +0100 (CET)
Message-ID: <ec9462da-2e48-4140-8648-e566da305010@collabora.com>
Date: Mon, 23 Nov 2026 10:50:01 +0100
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
Subject: Re: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
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
 <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:04, Alexander Letuchiy wrote:
> Add a compatible string for the watchdog of the MediaTek MT6895
> (Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
> which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
> known yet.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

