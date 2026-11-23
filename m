Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427396;
	b=IaNxNIioP4Y5LPQUz8wvHkYcBFM8nqTUNxPH9Lpf6e691pUmEZ6XSvRttPLSRx5KchIE
	 qHknzNR4EtWCQ6Ct3NbBJdtcmGJH0nA+JLft/uER34nLHeQBM5bt22AY77AJMsrc8xAnV
	 NvMlbZ/irWbcHqrbkdsKgC4MJi18+wpE9UlhkWotFtf3x5r2JF5NFBYQLvkzUfUuwZwIk
	 q006tpmHcTvsqTgMqDDu9sPQ5TUOd6Yag/iZNyMHh7T11pVTxFRHf/G5cm3r4kmrRl7k+
	 OIDWWRHHxuEXzTqHfLCQNUBFNSmRZDgvKGZItqqVFUTEakVhk/fCxVKy0Ik+fkfvTvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427396;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+9PCTbh71L1HM3bKlGiIOaVmykcBeQmvpI3vljck9JA=;
	b=q9cEratgpxXRkbkRmBgowVTCUMOEvsH9gcVQeYCps4M7L8hcaUM/toS379NSmj7QNJri
	 hApWcYxOt5fJZ3g7KH3i5Rfoqf6dAwgn1GoOjJ6RFSZco4k1yvjozcRwsAOExMso/bAR3
	 hwAyjXysREsXGochQxp7AHpWWmGlBZAfIkxT4bB/7fVpdUJsediuO33CbaVHnWmbKhFC8
	 n7TqtRnBolxuhHNTi53PobHnyDGZ69g1FUzWN/0mpub/D8QPql2w2guoTmwbAzzx7JEqc
	 qsqHvs5jcE4siMLs81rbPsdn8Zqpq5jHyFMn+Kb9LaxeOEjVMM62WX6mwT0tdYmKnOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bFm2De2+;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A04606A686;
	Mon, 23 Nov 2026 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A04606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bFm2De2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427395;
	bh=qDlQ72Vc7Hc/VU08uITBDl9vO+AOoQTLBFQhPb/BZh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bFm2De2+DX6rpDbSTnze1A9rSRSqcnUXretTh32/Cn7I2RwdAEgrER/L4mivzh9xL
	 hRdrV2rdAkTMcCIe4Eo9oyWwOoNQMJX8aG188briw+qLRAVDGfxaqO5ESMYsvncL45
	 xXLiDVaNc0XBiNKBv7R2ruM3/NdVD7h5FTYRVBV+iAmdAAS4y86KMKzTD5LqmJYItx
	 umsbfw6IFNS8mNWp/5iufwz98gKEmde2YZnXUM4cgJg7298j7Qb1vbyljEE0k75wTZ
	 tYd36wNlizoEd6o5rq/jQ3r0MBJjyxl9U7qf9hkmNvkCvzjoBrZ9uaK5HIuAatTDOx
	 781Ab+hMHvKxg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 249EF17E0CD7;
	Mon, 23 Nov 2026 10:49:54 +0100 (CET)
Message-ID: <d367dd8e-d712-49c5-a2ae-30a9b3a41d35@collabora.com>
Date: Mon, 23 Nov 2026 10:49:53 +0100
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
Subject: Re: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
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
 <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its watchdog registers are the same as on the other
> supported SoCs.
> 
> The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
> match data and no reset controller is registered.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

