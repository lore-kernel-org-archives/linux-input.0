Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AB3D75A9;
	Wed, 18 Mar 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837551; cv=none; b=BcdIXncCe3rQb62RyGdttU+tgOllpKgbVn0tc6l+oeu9h19gae0xmBh6Qe0DJCoKunSlASX4oMO7EYrCPjs4rAMjXfxnRBscoaDwHUvoVGV4wNlnrtzYxveZqejM+oELDlhxxWfJ/Xm7fyBFWoylqM+OelzfZZXwIv23SVDIdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837551; c=relaxed/simple;
	bh=WL9VO4CT3Q+H6qxrfU7yZL1mVg3nI3AzqGEwGt8v8m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6Rt5RhKQHCYoyo4WtR9fcZwB1G3BhBIfZi4rDtZuy4Ks6qpD02wq4leYhI94z2pY42yvUEjdcU5Vm2vCybjIufLXObS4F+mYwpTNw8evMgn038M+utQ4W5qUuqVpblZBxTyo1HNT51ndEAT29B+pqfyp2vECcaubwxpfX2yH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FqkC1wI5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FqkC1wI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773837546;
	bh=WL9VO4CT3Q+H6qxrfU7yZL1mVg3nI3AzqGEwGt8v8m8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FqkC1wI5I9QxfNm++xlyuXaXAN+JCCU/0G3JEKg3rho0b5llDVOZ63gGh/QOEhdhN
	 4hVO77C1rO9jEIf/Xqn9QO4QxeMXmi7cLkOrQZ8LUZAqVbOl8R9rZRwsbIUWpGlZO8
	 R3jXdFmVbJltnxsXc97xq+Y8TCuVx4ptyk7BEC4qBafAsIUor5+bJ5AVGVZPjlReDA
	 Xoei0AnRSteZDoo2C18ypZi/qrEz48o86o8g0LvAqistF+0mVIAMBXpGUEvvsfh+2X
	 YcNdgzmFi8uTQwupupC7BbTss4M76q23oE8pli8ex+LnmECxnFkoLILeU11NLmoSl5
	 MAgKNbzURaUjw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CB9B817E1537;
	Wed, 18 Mar 2026 13:39:05 +0100 (CET)
Message-ID: <c649b147-e078-4327-b660-f0e05826f1c0@collabora.com>
Date: Wed, 18 Mar 2026 13:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: input: mtk-pmic-keys: add MT6392
 binding definition
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Gary Bisson <bisson.gary@gmail.com>,
 Julien Massot <julien.massot@collabora.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-3-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260317184507.523060-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


