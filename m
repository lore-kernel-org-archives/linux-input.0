Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613745;
	b=PRSE30nsFJp1qcPYAVFngqytaUdA9UCqs+zrKaZHuonqZl75WCLvf6bICN0npXVJCH1M
	 4Sxh2uf73QXIbzrBO7FldKtssn6II1EPX/04SJyHOAmgrRF6fRzSBAOBRLOy19NDsmsvh
	 HNAzUxcwbtsvQ7D5hdWq665Itd1wUB/h5WekdQgYWA3ARASpAxPm7wN0E4Bz/vtRs9vwL
	 ObmjIPlknMprP9BfWaaJMWAVTIR8+Gm1q3ot8+k9a2QyWn/K0wBxC0p9x5uRKoEc7E3aJ
	 O20A5kIyHWRoX+Z3V4Vhlx5KWCLbYTEfOrUoMaw2bTbcvRh+6hDx5y7fLxlFOknD4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613745;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=PsqVLknAUTo7NBjCEmIKFZJ9LLhWm4zNDbCBptxY/NM=;
	b=3IdWsRG3YHnmpMbR31mFXldoNWxvJvLDWXb0T+A1CHcatKvw5FFgVCzig7wLd5ESsk9F
	 JYTncUpG8aSoxjhSz/RUNZs9smJlNhmzBDBEx+12H3A1R5oHa0v3NnoJZvwBB5OEuLZTn
	 y01kbx/5CW064Q0exQ2b/tBF1MLBCPIIXxGC0SR6x+HzTVBwKUSwsA5St+E9a9h8XKArh
	 g2fT5j4qD9ZRlK2hGymNhhK3zLhkLgC/8YORCwH3XLjX7z6s7sdf/mFJFi8s3T2L9Gt3p
	 i6VqFv3ukVhPGhRSS2h++W3D5NiJwYiJ1whVouUDRIHHfle+0f4M3TPPAX7A9ZJDT/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8G2OiY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55337606A331;
	Wed, 25 Nov 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8G2OiY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6903A1F000C6;
	Wed, 25 Nov 2026 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613745;
	bh=PsqVLknAUTo7NBjCEmIKFZJ9LLhWm4zNDbCBptxY/NM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=B8G2OiY3H0jVMx7MMO2efx1O3ji75YeG6AxuhcsVYVzgbjROo6xbVkY3AbSwYxpAi
	 kNj1qj3jKXs4koolWipNNHKUaWmlQBSgqSIX5h9K28FD+gnpZMrsGjZIMtwYqsI74s
	 UqL++ZWjJtnVZSwtCJVVTXSYu3NMXxge5n6JfZsy0ENZcNrkeVMXMjyrnScMfaxFjx
	 OW4CjnNIMTE3bPJq+YExqFVCSfDVsneRlhr/SWbchiG18saSiNjf9UgqbK0rPeCjsm
	 5C/RqLmhoRJWJMBuQ2+vPNUGOXTiat4h8x4aIPHP8jJR+40U3zneajuely0ecuJTZG
	 v+na1MspOi3Kg==
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
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: hynitron,cst816x:
 Reference touchscreen.yaml
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oleh Kuzhylnyi <kuzhylol@gmail.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261122093405.70406-2-gerard@teslabs.com>
References: <20261122093405.70406-1-gerard@teslabs.com>
 <20261122093405.70406-2-gerard@teslabs.com>
Date: Wed, 25 Nov 2026 14:35:41 +0100
Message-Id: <179561374192.84329.4761080114492904783.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 10:34 +0100, Gerard Marull-Paretas wrote:
> The controller reports positions in the coordinate range of the panel
> it is fitted to, and how the panel is mounted varies from one board to
> another. Reference the common touchscreen schema, so that boards can
> describe them with the common properties (touchscreen-size-x/y,
> touchscreen-inverted-x/y, touchscreen-swapped-x-y, ...), as other
> touchscreen controller bindings do.
> 
> Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> ---
> 
> Notes:
>     Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.
> 
>  .../bindings/input/touchscreen/hynitron,cst816x.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
