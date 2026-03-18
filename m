Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0833D669C;
	Wed, 18 Mar 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837547; cv=none; b=Sm2sWp20sB8VaPARcL4/ri4IzpSgCAbvmzvSUlwWNunactaoLfU5sSBfczj8tQUFn8oonfI7fu/96v2Pj5hVxLh7yfLHnqhiRh5EMyWj32Jn4F9Zff9uStIPg4oByCD6dpnabz/vHIPmHggjW4/bWnre9CdYqHw3FK+vH3H+Ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837547; c=relaxed/simple;
	bh=j0bQmAJySAA2tYvcnGopCcbfXX57DWvHbxqcn8CRYUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAPhz21Z5axmFDBUYzdGi79aV2+IFQhlJEfoiDhZZ2LAXVTBuEm0ftGb1ZrDyTDbM0jCLDE7O7e2ex9rqLDpmhA5/rlM3xzPdlSNib59/JSvtmxYPOXTcjggCaqqGsapX2w9mj8GJTm5+5O4Z+PoNuKkWUnR70Q+PijQvAHUDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qm7wKcvO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qm7wKcvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773837544;
	bh=j0bQmAJySAA2tYvcnGopCcbfXX57DWvHbxqcn8CRYUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qm7wKcvOVisgVxXY0wCZWC5VTeUsJvbLt7e3no8TLmJaXZBzVCi/yloiM3xj3uhNM
	 mwUyMWMjh3tBbTrSdpTygpWLvfLhJzXj1dAXgYF86wXviwZYVYVTWr6OiDBDMGYYwX
	 qQSSVCTjVWfQth6JXq7nD0Xgnqcg67EJv9ViVnZivFh1LQxKElMrhrCtxuy+ntECgX
	 YVCu7jBI4SaeULfLYwgf3Vq5+5C6rHihJjttO/oQFv3qXqSwxaKUMLJ5mogAmg+r4Y
	 Zwb6G1IxcwkkNqdRQSfbbIcGr2yCJHad4u56atmU3jIHFtl7JOwFOlRSRDxAFO5Po1
	 1JRjAIu7HP8mA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7FC017E1517;
	Wed, 18 Mar 2026 13:39:02 +0100 (CET)
Message-ID: <c121500f-a41e-40ae-94f1-b4504323e8df@collabora.com>
Date: Wed, 18 Mar 2026 13:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] mfd: mt6397: Add support for MT6392 pmic
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Julien Massot
 <julien.massot@collabora.com>, Gary Bisson <bisson.gary@gmail.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-6-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260317184507.523060-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Update the MT6397 MFD driver to support the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

