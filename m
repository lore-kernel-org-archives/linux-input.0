Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E733CB8E6
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338956; cv=none; b=pvQTB+emvWNsw6zDlCWWWDWerf5yvoUaBkasR7wj/BILFTno/gi5fW7fr5dhdgUh5KI/3JxFgUQX+JKRlL+Yo2DdtmyyXe6scfbbekY75iRWjIZKQ9ukZGMbFx3h5It3lvB29H9mdeGFw21c4dVrQo073UdJOE0YgMvhUbQh/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338956; c=relaxed/simple;
	bh=5BOSuS+iU7vFYlQwtmoDD7uZ06WyRq2X9XCUtj9GmXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCzLVxGzK1e7Gz+5bYJjCWd/FHOGOLroHICSnQEpNHUm4l2GWEEzaceXyuw1/7VuH7xK9caAHARjE1NtlHGtjTKkil10jxjUUCXAwlJ24nOpLYuur+EUW1pIJS8OU2VkeF71h2FcDp9hlx4sH1NNs/EsGXvL++0c+HuHs6Y1JxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVEYIj6U; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVEYIj6U"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef82204c6so1016907f8f.3
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781338951; x=1781943751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDCfgIsCd0Q4hB2aGkv+tHe8owWljtqt1jPIzUxxB/s=;
        b=GVEYIj6US3GAHbVfY4IWPlRtWf+6RQE4Mg4kXNNpyqCzK3yVm0eAln2zThaaOQ1o8Z
         j4FUz8m8/7rYWsA2ksMTualM1zRXt21xz3c+mo4raS0H6rDFXxalgRCT4EW8zjZmBase
         aKbEGJNT7P0u6Q6N/ik9FJ0770KNjMBAUTofO4IQnEs5tY453YoI6a7osK/UMFRGwLZ4
         EKGuvW/a3qI1Rt6JNH+2XKrujHRN8KVxmWaPPxJsTOhU2kulrSvke4Rw20WNN5gJDe75
         B83FESP3pkP508wE7wkOy+SwEjvj1dQGcaTYG5lL/X2LbW0tX2khC/+GLNTXfSkdZxux
         QRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781338951; x=1781943751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDCfgIsCd0Q4hB2aGkv+tHe8owWljtqt1jPIzUxxB/s=;
        b=U39K8EgYICnaJ+9Gri5QwkdvMw1zCn+uaNpM4b90YzduE633i+c71jVVGi13njQ6yc
         LC5FD8NOgmJEau8y+wCXm7T65zJltbJmdsM1zNksJJOHPte01lIM/mlJAaoOhMs/5kOF
         RihTQGnQPcei1n43Qc8vgNve2qyJp82utCEyvZPZzVHey2WABcFQrqV24mZLD+zYV8rZ
         r3V+riGouKZnwjd1Of2JXXzwR5WiLJ7Y+3QbiAOoE+AOFRUmP7FqsPEvEm3XXVoQixLw
         Vm5GPnIc5Dj6ml/3xJZHFjySf/d5f5SSymAVOQF6dFLDPjnWPI5TxjuTMxdtAFXoeNFu
         scTw==
X-Forwarded-Encrypted: i=1; AFNElJ/5GwWhkPwvItpo6bopwWFjj/9d/j6B1g3bhnJwqCbKfcODwGcTPa8Zwx7tnBpl9dI4PNxHMbLWlTK61Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxynoNjOe/WbpgY4ZeSEV4qbgHYQfC49EN7ZKNJsLxR6QfeFxA
	TPvm1Y1VIL/hpKo8e62ThZRcEBHSZEXnopNcUrUXKlZzokwbw+25RbMv
X-Gm-Gg: Acq92OHh615sY4O78OccfkQOdFeuPH0tVjUxjnYHNNR48RrrbqhVRuAbi9qb6u6K/q5
	fkcfK1J+UfRskgKQn4KnaPBoyazAxnjm52FRFwIFqwnfAVl2K67QnO4X74W3qegTYWU9bf5Djkw
	ur35wP9V1gXzgzB/VYq+GpyeNjvbnsCfPkhm1FEIXxywuYfULYHtysAmsP2wpKlza0bHpIWmDrF
	1HdY1zDOGPmXh+HMNVyDB1s8CqSLGAb3VvY8RrfmDsJqwcRFv90ZAM44oD6+AJvOrPLbbtVNRwv
	zjzvGG1Wt4dvBHRxiz9teoXL1uxMrqmZrAcsJ9ONVi13Ljhmq1LEtMTx+8IuFca7Ol8JblkV2VM
	pP8DxjvGnGywVpq6EbY7OmAoz/A6RB4n7sjxwY13B44yJuRoduRwk70culmaCZ3vR+SGDmHxKL+
	n5fwbJzV6oyYI74t00bOtpprQLUWGu2zAjbjupMjXxE19aH9U0gXYBte4=
X-Received: by 2002:a05:6000:608:b0:460:70ae:f196 with SMTP id ffacd0b85a97d-46070aef211mr8420172f8f.7.1781338951277;
        Sat, 13 Jun 2026 01:22:31 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm12723144f8f.13.2026.06.13.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:22:30 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Hans de Goede <hansg@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>,
 Lukas Schmid <lukas.schmid@netcube.li>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm64: dts: allwinner: a100: reserve RAM for ATF
Date: Sat, 13 Jun 2026 10:22:29 +0200
Message-ID: <_6NEZ78hR8a_3V2bhBAGoQ@gmail.com>
In-Reply-To: <20260605070923.3045073-7-alexander.sverdlin@gmail.com>
References:
 <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
 <20260605070923.3045073-7-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 5. junij 2026 ob 09:09:20 Srednjeevropski poletni =C4=8Das je Al=
exander Sverdlin napisal(a):
> Add reserved-memory node carving out Trusted Firmware-A region spanning
> fixed 256K from physical address 0x40000000. Even though Allwinner ATF
> itself passes the address range in the fdt to U-Boot, U-Boot currently
> only reserves this memory internally, but doesn't carve out the region
> in the fdt passed to Linux.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

NAK. It is job of boot procedure to properly inject TF-A reserved node.
Any issue should be fixed there.

Best regards,
Jernej Skrabec

> ---
> Changelog:
> v4:
> - new patch
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> index 7cb06b19b5a5..d8391663fd1d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -87,6 +87,22 @@ osc32k: osc32k-clk {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/*
> +		 * 256 KiB reserved for Trusted Firmware-A (BL31).
> +		 * This is added by BL31 itself, but some bootloaders fail
> +		 * to propagate this into the DTB handed to kernels.
> +		 */
> +		secmon@40000000 {
> +			reg =3D <0x0 0x40000000 0x0 0x40000>;
> +			no-map;
> +		};
> +	};
> +
>  	timer {
>  		compatible =3D "arm,armv8-timer";
>  		interrupts =3D <GIC_PPI 13
>=20




