Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188841E49F;
	Mon, 11 May 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491533; cv=none; b=j/fIjdLm0Q1T/RO5vczs9I2BRTARGPRAYYktnb34ZqsOYLewcHothDNPP8+NkBP5bvt8EWjBuP6tYGXVBjohP7NbOv9IQoizTEtIZV1twAcQNRleNayh/kF66hBskdPWkrsxVVhRiF04zU2F98YHCjCfyilk+3WZ55OBQ9vzZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491533; c=relaxed/simple;
	bh=aLvBg8yakBBMO6jq6pG8SoxUD30ySkKq3+Kw9lSTjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hExAhLdTEUz2PlIj7m7EzTFOblYLYOC4uBGcu94XRt+yptxhsuo2uwdO9RfJbt5wxtH3K5+47oEgjpLKbBNYz9nDQ1WvUlr6uS93KUGHRHZTiaLvc2dIIcP3/De51NFS5yBjrTRU5a5S2ZSU3jHLQ8EAUcTBxJKGGtZhYbSRQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nYYFs+JY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nYYFs+JY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778491530;
	bh=aLvBg8yakBBMO6jq6pG8SoxUD30ySkKq3+Kw9lSTjlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nYYFs+JYZ7yl0vgORaPPmITEPFJc9Ey/HOy94txswRMCib3V8Oa6QC//hS6w8/X4Z
	 RK0Rb4qKgLtjFsKjjcPbZu2xpGZj41eV2rSa6A56habCn7DBX01c+FVI8GiqsVf9PG
	 mfifi16uj9LZMrDCzE4mRwUyelZ0vB1gP7PCAMvhWhoKzQrPuA6tKEN96hY55tL0BR
	 QgMtjQ2ou717SLBBzXKwCXmCrPS2FdyONMDRmIJxUPo8TW99pcvVUdlWMxLDwxUMo+
	 e+Uzmxah+DjDET66i0R1L+mvSGLUOx/wdS3kzSvmkpqVNIJQLjS2e9TCHMwNnpRC07
	 yFAq9HieUtrPg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B79B17E139E;
	Mon, 11 May 2026 11:25:29 +0200 (CEST)
Message-ID: <37cbdf51-46c7-4cc2-a213-74dfdd604cb1@collabora.com>
Date: Mon, 11 May 2026 11:25:28 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: input: mediatek,pmic-keys: Add MT6365
 support
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
 <20260429-mediatek-genio-mt6365-cleanup-v1-3-6f43838be92f@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-3-6f43838be92f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 11:44, Louis-Alexis Eyraud wrote:
> Add compatible string for the pmic keys block found on the MT6365 PMIC,
> that is compatible with the one found in MT6359.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


