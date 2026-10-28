Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185718;
	b=NlgAq9hf/HA2UGha0H79rChR75VwLKD8qh0qfSY1qCEz50cSLT84uziHyh0t8zdoiu+d
	 PXzYkl6/Qtycjq4lPZyVwayh20tEdjwQMmkY9P3pN4Prgi0PLfgZTuA08qhMgpDjnOBrL
	 Bw9hvtZ4f+m8nBKvgCZbsQi3PspbxuQY7qXYSgw1CbmvclzG7fEi3rSdpVVKlq/94NaLh
	 ibpnVEGizEu4oK3igR/Mm53avMrMdLZU89DDEKmh6x+RvdOCBKg7wBBu98G9sKIYdvv4Q
	 zfKy2MZRKhYYkW/HtkDQzvTrsHKxnwLOOR6Sa6ETflBYcvwilbItJwohITGHWvCFNsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BPvFudkVHX8n8Xz0tY/evgQIfyTSEMNdwfTdWs5pWeY=;
	b=2EFohgwbd9qOzBHYX1QXPzK8m6olM64gGCKZw9JnV3kuS2+UsbDycVPFVYyJoaHjxWkA
	 nTKwMqqn/5Xd1uaJ5xIzNaFTnJVdjiIrIn++DGgWSa1xh4oNHHZow6GB14q1qMrnv6xh8
	 pZBu2Gjb76L8OCefRF3zSJgzLAnwWPT0ORcrOXCthogD6n3G9iIx5rWsllYubmO1b8+Qp
	 Lj3eryOmM0Dnz3qakKhXMwHaO0bjzj+dBIrwO1FC7spJr/YMUVsXCAZMrsPV3rm7QBrfI
	 32RQUgYYnl8Z8uBkaSMzPBV75TpEjszzM6Nimk1MXbQx7KwqWqy9eHKrdOiXcKh+oXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtTiG6by;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E3606A31C;
	Wed, 28 Oct 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtTiG6by
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D641F01825;
	Wed, 28 Oct 2026 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793185717;
	bh=BPvFudkVHX8n8Xz0tY/evgQIfyTSEMNdwfTdWs5pWeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZtTiG6byUrcmhfvzzZDpCrtyDNs0wNwEkgWPN/MP1yz1eTVX3iH8p0r3iMeSB8RS9
	 RReBMTb1NI/fnkYvc5qFCugmY0Ig+ps7a19GDbm6dK+jzD0CaG7Dvbbxg0yw/Gs9cP
	 Mr2qVchIewxuVR2pQTqcEbRESlbDJKu6wQ3QpzuLnreDmfrjiOmXVErZBpfcMpJcM6
	 +UeN8a0UGfre9DZQFpsUp9NdyR+AVIgNQ2YrqqDhRnFCrDOCOmIb4ZcjGjaDxx94U1
	 YVy3ybCc9UsNHolL528RgRdqeEDSAXfQ1P2+vEVwfnPjIKJl61lSo/xt6QeNvW6Ay/
	 +ByUfVU1QN5JQ==
Date: Wed, 28 Oct 2026 12:08:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, Enrico Cic <enrico@privacyrequired.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add
 vibrator support
Message-ID: <20261028-thick-gainful-pegasus-e1b430@quoll>
References: <cover.1793135056.git.soyer@irl.hu>
 <8717c3739be282747cbef611d242acfc5a40656b.1793135056.git.soyer@irl.hu>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8717c3739be282747cbef611d242acfc5a40656b.1793135056.git.soyer@irl.hu>

On Tue, Oct 27, 2026 at 11:01:25PM +0100, Gergo Koteles wrote:
> Add the required node for haptic playback (Awinic AW86224).
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> index ef91986a1fb9..434846be51d9 100644
> --- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> @@ -924,6 +924,17 @@ &i2c4 {
>  
>  	status = "okay";
>  
> +	vibrator@58 {
> +		compatible = "awinic,aw86224";
> +		reg = <0x58>;
> +
> +		interrupts-extended = <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&aw86224_int_default>;
> +		pinctrl-names = "default";
> +	};
> +
>  	wl2864c@29 {

There is no such code.

Please work on mainline, not some fork.

Best regards,
Krzysztof

