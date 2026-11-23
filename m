Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447957;
	b=umDnOlTF1yGQMNBYX52e/DhdYRsvZmSjh5DdnfSe/uxgXq3DhuQZjNFX5BrIiIoZal4y
	 wgfSghQm3zLcfE40z4FLO5+zteGZmpuQX9AZBC9OArvOMi3RK+D4B3Q3MyHS8ynFEEvRm
	 RMlZt2f86iCnP2lDHdZSNUT4JsTFLtGffxaXME0UosOwM8hs9w6sjcD7LO9o6aKOdyhS6
	 Guy4aLiE8mdtBrk7h7UsJuz0IgK0hNIuNy+R1FIdV9FVDCzigL8JqMs2l5dKn7wYtYof0
	 ktQI3CincvmzciFF689F/Ooi8DU2vaMPgd/UxVXDgVlCz+hgDOLtizeVKUIcqPnunHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447957;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=TUoXyOddWAz9fDDOvSA9MQNAlA1i/4mOf8DBtcxzgh8=;
	b=aiPA9x0Zk1468KqpoT65yuUjVXe8ABZRVBXofYXzt7q0RdPqm8HpmzVVLRQA1ojttzcm
	 roEJkjg1TPE+AwE4T9j+vKOMfZp/QDSqbO87rwbaeleEogr6XJ9H/XNSDWtQdDmW3jswR
	 uhdQPOUqXNGy/AppFr3xH9PAAy11mcXjF2P39OSY8ZjRMQEF7i7ZrGEoC6evA4gVt+FwD
	 uFIXaXn5Mmpidr+cNhuPAWL9lJ1werwpO97+PY1Etp3pWxdjFFLINvCNpb3/TNoaCO2yH
	 LpYpVfNgEE/ym5VNNTwgHSZOWXdEnWDbVFeH6eTdi9JxVm5AqJ4DQHFAgHOOpeFl3mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oxpUA6gT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89810606A31A;
	Mon, 23 Nov 2026 15:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89810606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oxpUA6gT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795447955;
	bh=Xnfpy4WZddREfPMFIPPX8OEnArv8MmFD/FqHyNhM8A4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxpUA6gTTlQ1KCGpEDK20y7rEzaVPpHuOF9j38OC1nadLKfNvr6/E0GsI+E4D9XWa
	 pWpbQl77q8I2HMLzwpeyX1gN4yJVZrBTy1pImc0YfrRIE+ftdOplZBCCjmSNbBCyio
	 YjrkTPxcrab8wN2YD68HFmOZsNw5881nZAlKZvJAqzeEiWHmd0GK2wN3TUsKZ58EUb
	 c5/YGgpB6ClcDmH2zfNBRRcJM8zCBOjcTcxGwkSR8DzpfyUwEscAZXyDCZXJwMPZRb
	 JGYF5QkiRbUK2b5CZVa53+1LnzNlhqZJIt5l5mOl5KtxxaopvCowxOdaqWW4XI7Vcu
	 WS4z6Fg5M/4ug==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3640F17E031C;
	Mon, 23 Nov 2026 16:32:34 +0100 (CET)
Message-ID: <cc4675f9-0923-4918-9867-05db05b5ceb2@collabora.com>
Date: Mon, 23 Nov 2026 16:32:33 +0100
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
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
To: Alexander Letuchiy <asalde.le1@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 phone-devel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-2-95c46597e63d@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261123-initial-mt6895-v3-2-95c46597e63d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 12:18, Alexander Letuchiy wrote:
> Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. It works with the existing driver through the
> mediatek,mt6577-uart fallback.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

