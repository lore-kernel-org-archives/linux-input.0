Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CA3BADAA;
	Mon, 11 May 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491532; cv=none; b=j/+iXb17TH4PZrhwVArm6gl5bkClQGuS3maBqItzmyvi+ZEaJ7eLq/JRNCRObqv7LR4pjrBSRY15SzmkSw6GqOM9P3LPpWXUrpfKp5WMRSdSJKbsRcSd0Gpb222JOvues3gEvGnOCOZFvfOhcDnd40wdMiSPC8Z473IDEmdT13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491532; c=relaxed/simple;
	bh=8PIQl5kfuVwdt+Cq8giu426qIR0fILebOJgQCKdgTVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfDEupSVotcq95o3SfZ6KN/C1wH9VXM6ida1WVLAgm7XDQ8uSARrzU8SVAWREu5po5IXVwn9yJC23IpT/TLDWNPqS+dDorITUIK4VTEviY3H/N2D1aGyjMUTIExGAn7i0opGDa8uiRrGgo+W0VF0YRTtXvHNKAYccvf8rtWFXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iqv1Ihmq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iqv1Ihmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778491529;
	bh=8PIQl5kfuVwdt+Cq8giu426qIR0fILebOJgQCKdgTVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iqv1Ihmq5waow1+PsNta2unPX8dsTUvNCl4sbOSxHj1t0IJt2Mz1hIVxuSdJHqoGC
	 KM9DC1j9TqXzCJa8Z75IhkacpuA1x9kzXaoLvkS4Absp07V6naYUfJDeuz2tSECxsp
	 ha2lHQb9naIgbtuGvIwV7MyuvTpXkjg/yLt1NmFTOQ78iJ6QVMiT/7rg1IDRApRUsu
	 WGWpepR7HBy4zJswqhHyLxT3WH11Kz1xhDKhq8DOidR0MFh5srquI+U+u5/hxXXxrW
	 UV5VcFjRQ0K8g9879OMZsytWxfZX7yQgWL5j6TxD4+CMrBOMPBggiSfHC83Lfehgli
	 FIirnlbJVY+vA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A17D17E138B;
	Mon, 11 May 2026 11:25:28 +0200 (CEST)
Message-ID: <b3a07a46-ea7b-48f3-b7d3-0ec7f644a2df@collabora.com>
Date: Mon, 11 May 2026 11:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: mfd: mediatek: mt6397: Add MT6365 PMIC
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
 <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 11:44, Louis-Alexis Eyraud wrote:
> MT6365 PMIC is compatible with MT6359, so add the compatible strings
> for the main and sub devices (regulator, rtc, audio codec).
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

