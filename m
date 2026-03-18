Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1E3D667B;
	Wed, 18 Mar 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837545; cv=none; b=uVbIoPzOOGT8hf6gRLF8hAicbkN/oBkugazxBWFpbxWPhF/InHtQIBsZRxshnK2RGc2NpANnLJRdH0uLK5Obh0SmoZKWMi6ksMAwtroIUfK9CUzqrWJvs0O82/UMy6+ZXUHK6uheDl1OOgCAk7dVsVeool0YLH22nsiznw6uY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837545; c=relaxed/simple;
	bh=9U/iI1CXl529Xk+OEnXPc2Xt3E+s6tig40NUgGlPaVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOs3ffPo7kUeZhXdEU5fGAw2X+yCH8oQE3ZDRz5GL8d2yxRqJU8Kg518YwPpp22XWo+tC7xC7Uw8+YG37b5lJn0NoK84UK+i3ZckPyosc+aTPoebRHQU1PS3OqAm4OkhYc97z9DewjcUDC7AGqwLWqC2wadU6/2n7fHnK1Uj0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0+02u9T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0+02u9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773837541;
	bh=9U/iI1CXl529Xk+OEnXPc2Xt3E+s6tig40NUgGlPaVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R0+02u9TojARPQ+E5Kf3P1hkkLKNy565zJXac5uxMtSFgN0YKGU0/Ctm1RYa/Ipph
	 +V6OS9FtrZldm++HTHrUHnmZXdg/uKE42eDGla2UsgjP5jhIarReqOCkl2Ut4b9ud3
	 EmonEj9hO3isxcoUvX7bEsqiXgWIWTcdT6GMykc1Bp8wvvvwC4WqF+AVC2dPax2EUH
	 jPIzhp9qy0AfzzHIxNHjeTYfV3JKvo/f0wlIGYz/xhd2DOZBh1JcPbIbkqsJOAZLYf
	 znPjnqBRLYzsSo1u1o6g1OAYoxn/eTAEP2vynI0sMhy9ptI6M9KXH2X/OGdjtM7TZa
	 VTbCi9Ze06KTw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1AA8217E0FFA;
	Wed, 18 Mar 2026 13:39:00 +0100 (CET)
Message-ID: <3ddf39e3-3d41-4393-b410-a1335be625ba@collabora.com>
Date: Wed, 18 Mar 2026 13:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] pinctrl: mediatek: mt6397: Add support for MT6392
 variant
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Gary Bisson <bisson.gary@gmail.com>,
 Julien Massot <julien.massot@collabora.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-9-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260317184507.523060-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> Add support for the MT6392 pinctrl device, which is very similar to
> MT6397 with a handful of different property values and its own pins
> definition.
> 
> Update the MT6397 driver to retrieve device data from the match table and
> use it for driver init.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

