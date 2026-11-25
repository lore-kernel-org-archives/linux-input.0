Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795590882;
	b=EvsOhYFKHtZb+y2KOXy7M+ILnZEeXOQ0H2uEWZHXuiqIlYCE9I8olRR4L+DdFYlyQVDR
	 KRR/6EZSzCKW69NsuwAk2NeehOLuED7OKo2Z9miUz3yB3uZY/RVO0t6ZtMSHU1Hz4cixn
	 SPVvZVZFtC3dWsw1slaZuU0ql19Vx1UVVGq1XHlgm6ErPp8OJEr4JQy/c+tQzWh9KwtXk
	 B+WtV7UiwS6hFYwBhoLyGC5Z7ULvaiOXEKZl+6+a7l0K//cnrtClIUAgKVkNc6dhmWF+y
	 /odWSJ8SCPAXolK2/dtemXJhGPIlM9npt6wP1ror4HDV7D1JyaE9qjH9+Qh1H3FvG/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590882;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=9O9vWon2AID/bXAvQdP8zYGG5/Ux/NpXmOMChYy6MoU=;
	b=bJv9jDa1eyWWAhDtBOTUjHop+D5Hhg3Sa8v73e6LhOxsFFfLpWcMJ57vryIpb0l6dI2i
	 n3ywyR8W7rMJKzQ9hTIA9Eyr/rOtLlBxMUI9Z86Gxn2mQlkupX7b9yMlfbvOLLeLRWKyC
	 6RvY0MEeelxsNZoPZKXRCb/FwGN5ijcyOvb4IywFljZnotvIqF7B5mgFOos1BwWNoLtpP
	 QOYKliP3CT4bdXBD+DkLkKBMwOk06XzttcKUIdGWx7bi4LqVGqVTWsyB/7hoWkk00lYGh
	 SoKw4sXFoP/vR7dzJLRAZ6bYmtVxH9/iMkuJrGy9vAwzYjBKHAHI6CfrVg0oTPjrobQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvEXUrd4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B00606A33E;
	Wed, 25 Nov 2026 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvEXUrd4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F61F000C6;
	Wed, 25 Nov 2026 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795590881;
	bh=9O9vWon2AID/bXAvQdP8zYGG5/Ux/NpXmOMChYy6MoU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WvEXUrd48V04Um5yRGlR1O3i6XcYPHzzpMIBD9AacCfPfeZLoU+0DqeQX01NeK2CA
	 8+1da4KV9oXHQ7gD5JQEirTsNtgv3/u7B9vyfhIQgvHJlDqkZbln9EEYA1DMg1HWnC
	 PD2ogIFnYWV9A/zNDimkm2Qmh7gHRTh2D3Fqh8stSr9EvPe3827pEuLM9qR8F7uwxG
	 NABN5edtMh/SLXJTYjGAlFI1cyga1Wy5YsIT3LR98UfIHdV2OVtc6X9NiGXFd1lgH/
	 2FZOvRWkKfhcY3nwzafTZVcjoxmCFkVodBeBNU5xKf8eEjteI8fzrNEOevr3nzi2Kr
	 7mTQrNGMK2xdQ==
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/6] dt-bindings: input: add Jadard JD9365TX
 touchscreen binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
 conor@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
Date: Wed, 25 Nov 2026 08:14:38 +0100
Message-Id: <179559087806.9063.7183621842723367523.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-25 10:11 +0800, Hefei wrote:
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../input/touchscreen/jadard,jd9365tx.yaml    | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
>

Dropping all your patches from DT patchwork.

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
