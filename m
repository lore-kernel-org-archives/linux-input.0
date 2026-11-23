Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427398;
	b=cuGf32mnQcs6lf4wjb+kzL7IUFY78QQWZLVlOC1JLw05VpJX4CZhHh3x7aiHHf9CT3fq
	 WL4v0VeALFzHXEaF1NnyPLelUhtOK63PgpdbyOA0O8DzHZY1YtleHNt3jQ5HICY2CaUFa
	 RjlhQ+0slXZbsnH8VCIyaQj/QALG90LhyE9HwW0rOykMbNkIm/KVphlZRdAE6Hwzi7Wh7
	 EgheZ8DB1oA7i813cWonT/HeiUoG3x2blW/qogHhbRg7WIgI1fqfbghvZYMEFD8EkQVqq
	 S/LFikVYZk2v+oBu+fLzRYgQsM4T6OwleKlOTrr6fnh51+wkkKsMZ9XAotrQSdXHz5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427398;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vi9YIEkgcpNDo67MMyhT4GNsmJycA+jIPzIUFtZs4+8=;
	b=aG3eU0E3C3lSihf4/Nkz+dAxU7uKlOBrtZ3QH2vX2KeQzrsC1mQtSuEC2G9Lv2RAe5ku
	 O1eI1LIA3wK+0Rabg8qYeySHNbK2rkiDylnDtR7wWSEfLqGX4lsixQ9/lw57V5XU8ucFQ
	 f9ukv23RZYqRvVB7WzbUf97FcNQJCX4CApQ6l/sEXpLgJNKFItYRG6Lg7Bc21cqPpJ+A5
	 ADxtt0XAHc8kk9tOkSL9Ny1HJ4ztLUxPi+wF9GAf6+tYNTp1VBRCdXEUXzr9/DkeQibWE
	 12kWV41gz5qIVMIuMygYe6Bjedim/PtowdlTqbbdaF0sGAZPmk6tBhd6GXueo6wK2gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nZXPQ0pW;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829F606A338;
	Mon, 23 Nov 2026 09:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4829F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nZXPQ0pW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427396;
	bh=oklZcB2ZgODd1ccU587GZpgoAJhA7Noc6dkU+5Gv3MM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nZXPQ0pWy7EEBsRu6tuBGZHmF2oIfTurhP+6ee3Bl9Qqjfpoyiy0xPCf+q4QNLYio
	 mA37bJr0KWyITQFT8bEmRA1DGUv3+wDw1O78meVdldFoDhl9TEOmUHPOl/SJZs/1Nk
	 ctscHYRJSAk0agzND9uZ+vn72PaOS6lFNsgZJwg5mJsLx9nW/AnI4l6PToSletBKfO
	 K1kc/i5ukSZ7jg7ZyEa7LwIPK/Q9woZqVcXzk1Y4ogftHtILq0nbvNGZUFlaqrgQvY
	 lMiH/TVkYM8n0hSqMF/RICmMK9FbdxjR2wMKotT2QVolkkFCZdLycy8nAEp00YzAmf
	 7vEoPWs7drgUQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF2E617E0DB6;
	Mon, 23 Nov 2026 10:49:55 +0100 (CET)
Message-ID: <db39aa16-0a42-4588-9efc-06e894bb506e@collabora.com>
Date: Mon, 23 Nov 2026 10:49:55 +0100
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
Subject: Re: [PATCH v2 7/9] arm64: dts: mediatek: Add MT6895 pinmux macro
 header file
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
 <20261113-initial-mt6895-v2-7-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-7-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add the pinmux macro header for the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. It defines the PINMUX_GPIOx__FUNC_* macros used to
> select the function of each pin in the device trees.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

