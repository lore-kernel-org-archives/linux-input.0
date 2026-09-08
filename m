Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B738DC58;
	Tue,  8 Sep 2026 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851211; cv=none; b=jSYlIGn5dwwbBXn9o53NSa1jKGONWWkqd0nyHTvzcCblKLv33UUPAGNL7x8481T8DcAbe0NQpQa1AucapzQlR3t51QODNPFKxAyeUVtp8USKku9/2GFEf+F1HnW0XABdqlN50iBQnD6VyMS6eeIUAnB93E6ijJ8W1oEt/PYRYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851211; c=relaxed/simple;
	bh=5Jf+deF/Lqx2VHME5QZe491Y2Wh3liyfJzOwhqfDZSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNl8Qg5B6wDRpyr9EiPg3mled59hFuUFw+DQahICSG7QHgz74+ZNHBE6X/AZ3mOGNerpbBbAkMp6L6ECbQwYLn0YUDISq6ixsycO/j6qZ7gLacoDEz47SYr0KjMbA0MjEidmBkLYfZGrXv1iN/fb/tEpqxWvnMG4tGAeaaGIeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YaF2+V0F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YaF2+V0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788851207;
	bh=5Jf+deF/Lqx2VHME5QZe491Y2Wh3liyfJzOwhqfDZSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YaF2+V0FjKJF8BjDjtN+258NuKmYLJSI4Yys6/ZGhFe7vrADnSaY6gNe30ffml8dQ
	 HbvFBALsE6cpmwy8TKR/QLeBUtuSeAMx6vTWJBSonjrJg4Gz4hjgy1Fen5CMB3BOQZ
	 MOHen78lIX4BEAXgMdvBJGXrrd/MDowrSLz1fY8Kah3yptF7WMwMqX3BTaFqoxYuWs
	 UR+1CNt8stA/vy1J8uMA0wQWK8WiFH56BpLPgfEjHEq2I8C/YTrMQczavNgVuSo6Bi
	 aqADMc4zKaetrAu+KyG7mC/qzyE1U6uHUSzB1gfc0xHuLXCKYn9hQOK4uFnLQS/D5z
	 dtddeLdwIWung==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5479E17E04D7;
	Tue, 08 Sep 2026 09:06:46 +0200 (CEST)
Message-ID: <14238208-7422-4542-b678-35fc322ff579@collabora.com>
Date: Tue, 8 Sep 2026 09:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linusw@kernel.org>,
 Julien Massot <julien.massot@collabora.com>, Val Packett <val@packett.cool>,
 Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa
 <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-2-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260902193351.185771-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 21:25, Luca Leonardo Scorcia wrote:
> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Previous version of this patch had the PMIC device declared with a
> fallback compatible to "mediatek,mt6323". Sashiko pointed out in [1]
> that it would have been wrong as the fallback device is not really
> compatible with the new PMIC.
> 
> Since the change is significant I have not included the Reviewed-by tag
> that Krzysztof Kozlowski kindly provided in v9 of this patch, I hope
> this is the right thing. I really want to get the bindings right as they
> are harder to fix in later commits if the need arises.
> 
> [1] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org
> 
>   .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
