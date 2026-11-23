Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427394;
	b=5rCe9s6DGRa2phro5dsjg2G8p8siyfiEy0QxHm7b4lL4QWFTEfiCdz1uu892ykqI71zK
	 HnQCJR7hdsGZ3Vn8MBoHUJVBGtyR4SGb8ctBJw1cZX3NBXnKqZ8Ie8O5uMjEQj6HJ5dFv
	 KiT8WiCbpGCuDagPgarKJPhX0cP9dZKe9x3Z5pyfAe1K7Q+P6K8QLjzoeXH1ey4cE2NdK
	 y+S8BaTt4c7Rloq2Rx0hgQ26t4lfFGWmkZrPVhxHwBTMWV9I2fhShpUwAzrkR7F+VTYTu
	 MYXdBnBl9RndQ3Rn4WSgy+PVPG0FZe03MtO7tthgUE9w4Vj+v88WhxxFC8I5UMCh3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427394;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=P2zIkU1n+ita+RQHERTvlRIt6fwGcjgFl4MCMyC3UWg=;
	b=2F3+2y0enTiVUR80o/S2Y1yWUNGep3lA1K5HQ6YLFCmh5XmMBhNlfoS/sBwMrH5Ecy5W
	 BFHZWnFD6Crb8AK1/AlDIYRxsIA1tgFJ/VLYqwcpAaeBe862V9XttKnpNq3al+SKqWGHJ
	 iVX3e+WJS2le6iIg81oiBMgVsanTXjb5knYCxjfOAipF31ovMoM/tZp9ZO7xQZuVceW/9
	 ZYH7XZ8Pqi0DqBZTEDx+XJVWIw8sCM6Hk7LXPB8QANbaBh+nsisNmsw+t77KvyRStLSp5
	 7KABpcQuRAn6l4txhUK6HiOmG+K6tw/79uYcTjwshe94G9ZMAqrpVnTAVZngc+mWr8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=g5N90EsV;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B6606A321;
	Mon, 23 Nov 2026 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=g5N90EsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427392;
	bh=WXScrJpd1VjqcBYjrIdUvV1HdNJY+7in8XAjuH3YRSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g5N90EsVCPTZzWR0NPIPT7fBHsvfVDWyhuTrZMo7RhSyElWQMOmtjdzhgd8lPn5rl
	 FeP1BcC1QSVA/V8VNaxwyRZCEenCYOFzcgHDckyyoyK0welKFuEOr/2Ik+ppy4DDYH
	 MGtc6kEjCIPbcy7igwxPTSFgj/io9GbElUS6Ok+shiKK6Qn/8dPUaxgIQaQcIYeuWg
	 zR5QpgBcfkTFcEdfWuA8mV0hEIpiRGMPtBzcFGRlgCdze/mqxCZRqCRY7y85NzLQh7
	 4oL+k4wYnkDjF1eCxV2SbUs6B0hZLxEYK6lW6AbQQCNVUdy3BZkmBMoZ/GjgV2kir+
	 QgIGDES/Sw7GQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4226B17E031C;
	Mon, 23 Nov 2026 10:49:51 +0100 (CET)
Message-ID: <32462cca-ea45-4af2-8c59-4e8a6d8ea0a5@collabora.com>
Date: Mon, 23 Nov 2026 10:49:50 +0100
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
Subject: Re: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
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
 <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

