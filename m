Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427400;
	b=hLLTOGE3hltM3cGG3SiC0pi6yNZBqN2sSqMe8mZQccknwFeByhsQMcqnYC7A3QEI2U3x
	 or9efS0dsoWBjl/qZG+wRdCxKwoPjMfG2Y0dg/MUWzVsK5UeWptMntBpzE0vZy80jabsx
	 7ppjDms6W13Svx6dH7WmB1AMnv/xhf/CaN4Pt7wH/8cQUlioDO+iMrJRXCuDcQ+izcqU1
	 yz9aV+YDZO+FoorGszx7UKivE8VC/KECbN9gsI4MU7s2ueNXzixoo17fFSoR2lFhqB7ou
	 vVk/KhfaeWEv/XBlJbAmVxF8YP0JR2scwV7f17dsI1ub2YbODvUOE5S9d/rEf7EFCVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427400;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8mm6ghS/5heaQ3seGTi4gkBOyGvV6wg8F6jmPQ4Tsr8=;
	b=BlWZm5p1p9EyZKCY7Xbz/WszGQWejfVjwEKpDCUVPxxjc/+sgt8AidgX0GfRKA87eB4c
	 s3YBvkEtanQoHyGeQqDo217Hk36mHIr9j94oeuOU1mwaHRJcKFRZu+B3Cjvu0X8UxCbPu
	 WnSWQykjC7qPLhjJCvzvM8Zp5crIi/Y05cGin9TO/qyDujnzgDwSFQJEKcYVgKWuS3rzZ
	 +Bo8IT+J83upSg3gjNfaBGtEB/0CtdvLAoyhylSO0Qju6VI0uy2PuY/eHALuz8RdeqzWK
	 X8BMFen2QbuD/ZgqeNFdMbJeRv+MaJ+fV8RszYDAhMbxKyzWTB81s5tnNpCux3WW1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PFnXvkWr;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBB606A31E;
	Mon, 23 Nov 2026 09:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26FBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PFnXvkWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427398;
	bh=aBXD7WRadjQY3kmCtOad9Br+DZb0kXU4DK8pHVdVc4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PFnXvkWrn9xqgolcrZ4YAiuDXdVVKWcNAlRPyE5ge/wpQgiQ0tMyGApsdLbbnvsiD
	 RlHrINKFeEev0uK+okjVDn8OqRacKiJSAcP5A/5OMJITEltIM1acDkjcoM9d/nodK8
	 FmUHHuHSxfZ79T05ZWh8NoN44J5tBY+9v/bbHBGpoH9fnLmpcSqAr/Nl3g9khIgeEA
	 pRo5N4OY48DLV68AmLKPkxBhIrfPLRD6RCJT63++hCPTFQav8UaPsAY43j48o3M6eq
	 og2hq58txOuZ2yj4TxCkKvpHXIW7j6nOLqUNlT/h7jJZkJ01kGyx6R1wc6nyX5ldeW
	 2JWWoWa3veZ1w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA2DB17E0DCD;
	Mon, 23 Nov 2026 10:49:57 +0100 (CET)
Message-ID: <1ee347bc-6db9-4a80-9f37-72ace1c1b6de@collabora.com>
Date: Mon, 23 Nov 2026 10:49:57 +0100
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
Subject: Re: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add compatible
 for MT6895
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
 <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add a compatible string for the system timer (SYST) of the MediaTek
> MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
> through the mediatek,mt6765-timer fallback.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

