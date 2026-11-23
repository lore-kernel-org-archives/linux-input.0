Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436020;
	b=b1ly89OAQ19h1Lb6jRVLbNsr+tgPcOkuGAiX+jvL1XM9YvacoP+X6B+6HT5qyF0HefXE
	 30T2cOUtWOcDOiGEgS0tlaPTUb6K2FOo9RW6us/k3zfXkec0ooqEfqv608blyOicjrcnO
	 6MN90opLE/p94kFEQeqqdGxgURMbgYcHJUJkpRH7HuBkmbX31ZTa1FY3ppgZBQWuswTvL
	 Lo+UDRywCQy4DlXLQBz+Z+CvuLVuKrWaegEpUd1DM3OFiDxyRkzmW56RIFeRtarxGBMtj
	 2c5ZoESLYBQ2fO2xb9CWhAxwxWVcl49ZdQ+YKnRWlD5e81a6CSXKiGj4FTMR1DWxfgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vsGgiE2lye4hbouBWbMldcxgaC/s2n/Qfy8fpJXTtCc=;
	b=5PquJAct4Uucwwf3zcAB3RXYTj1LpLoNVD79sL3f4DDYh4GNgH1tbsu0p7lUWBcWulj4
	 34E6ywmqQgVloHeAutkEBxheXJmCubcz+1NeiXskkPu9TCSyJ+onVVyNgIvSTFL3PGGjj
	 qtwt/5YNuWM5nOCHYq5HweL3q0zE8ogdpM6sWfFgXrvyps8RxYwTnpVztxqmb4Wt0q3EG
	 FFWKBpCSP/IzEidvwQXCUYuEEQ0vrYocOxVEJ4qqp1Nz4iOe04NNNz2aTa9Aa36v8MFKf
	 +ph3JNHqMHi6eby4TVhVzF9UWxSS5fmA0WrKw+9FfCyetYU77SLBJCOc7Q3jfhD1zkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bHGR44PV;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C22606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C22606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bHGR44PV
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so4661851a12.2
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436018; x=1796040818; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vsGgiE2lye4hbouBWbMldcxgaC/s2n/Qfy8fpJXTtCc=;
        b=bHGR44PVxLG3t2B14cgDrCo2Ck5i4EHcesQaHIz5JBjtcP4OZc8U6jPhFWjT255fPF
         M/vxlBLGjHpAPsUYF3SFhZRN+CCcCiihtxgsQRCSUy8X0aV0Ar9JuF1BOLXQ/71JGRYA
         F4oagLvjNqr0ieuo8CzMea/RE9OIf2BjLN36ltLUGVOkjasfGSd5CMlWaje3MSbBQpXu
         iqAXurSOGSmmFrQqgsOohgmvEGEHrD5MDSVfvDCIbe3+kHp65puY8xMEyoN9wuSWN0+p
         BdYKvquP78cHpuW7MK47qI1IlVOPkVP/7YgnnglfHQLmjU4jcikc1utMqT8zJaHLVTro
         DB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436018; x=1796040818;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsGgiE2lye4hbouBWbMldcxgaC/s2n/Qfy8fpJXTtCc=;
        b=tEXt4JKoOBY1aGV4+kyrt1DfpG42QCAZdk3LlqfCTUR6LgQHYqlLgWE9F8U/JYUwSR
         evuYbdJk6aCAIqVIcLMS/hESPpo6K7HmgotFHVpij5lZj6E4EnM44rXbBNn0mRtZbf3V
         m+LM35FtR0iVAE3KiEVNuYZxCkrbaOkXhgZJXFRqX/K2vDuE3izj+zv/w4d4PIlJkVUA
         tXZSIRz+WbJQ3PmOWbnUIm9fSBUoe+Nwm72bNZjRWmaHvcghwc8l3SdkCMMnkzoY9Kkt
         /fShaJYY90gZZ01sJqEdIDSPDI6zTMy38b214gMj9n5bgOyf5kmSGgcfVVYwTunUZ1i6
         3QaA==
X-Forwarded-Encrypted: i=1; AL+hErE9f0OKvhaoqZ3r+gc8CAzHdKynqmImvnJ5UJvB/ABIdupBWKB3nLMd0McFEhSmyljm2uuzDQZndbH5CA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wHPXM7UKTW7K2londPcTgpPgI83TD3nCdM3Dx1ZhJCdfy7jZ0
	czX0p31C0cxtYScn62LRFVniGD2hwJRHaMpF0lfJTAh2NSCkyAfRCsXD
X-Gm-Gg: AZFdTZcHYfZu8tEZsMu3urq1kETyWivZGtJ8jXNgO1pOgWe8ZJvbxiuEXu0LbItxJli
	hBtuJvqc8M4sJyUwaqfF5Jpr/6AQ/6UwHf7mSl75XMY8razD8+ic+h0kT3014Dd5CwVNTgv+PIG
	8Qs49V/VZzd3Hza739KvRoXw6ZivIMhnqpcd9THp+OEAlOhfsZW2f7cLjRib1q/1WLe+pN41/JN
	/2qoW2Bd/qgo/FHnYWCUjrTQw+e4ER5eh8wM8eFrAt8vETkgRSn646CFTO4YF669GX2xdqtVHPz
	Dt/a2DA6IFDBhoVn1VVNB/nhDWm3IlPJQ6d7XaTjZpsiAsr4kPaaNRSJGhKxKzC0QVrBr1OdkCU
	XaaD2Rggri8eEDkhfh/SlQwPe/HLx7157Z+vN721lr8aoA+DjxJqwMS6dKvIZGLH+vWJuuuqx+Y
	uEn5b/MM/k1EEEJ8DEfq6/BemCHV6GB136jOzfMVutigde5LCwQ+AMzn3FW+JTw5BKpunaa5A9q
	O7ZPeM1aEmjruzVjJm6pR44fdJNvTWXwxZxcBAxlcFDLUFs82UMDvPEuMIqmqCl8Fw9qnJ7KYoO
	UraJG80kKJEY8FN8d6KF14P4CdSt2evPLDPPE6EsjwpCniDBRt6AGv0e
X-Received: by 2002:a05:6402:3207:b0:6ba:9cea:5bdf with SMTP id 4fb4d7f45d1cf-6ba9cea5dbfmr2715988a12.8.1795436017691;
        Mon, 23 Nov 2026 04:13:37 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fe162sm5443990a12.26.2026.11.23.04.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:13:36 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 15:13:32 +0300
Message-Id: <DN2KY5MGERWB.3DN1SFL7JZDLO@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sean Wang"
 <sean.wang@mediatek.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Kees Cook" <kees@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <phone-devel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: "Roman Vivchar" <rva333@protonmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-7-95c46597e63d@gmail.com>
 <cYX8v2leizSJfWjS_2dbkU2i6ApgjEKmgar6xjZopFQipSXW6YZNgjexWomHucqKghaTzW7oO5GN_jeNBM1MBy0u7aEDR2ygQ1s7x_L2jpA=@protonmail.com>
In-Reply-To: <cYX8v2leizSJfWjS_2dbkU2i6ApgjEKmgar6xjZopFQipSXW6YZNgjexWomHucqKghaTzW7oO5GN_jeNBM1MBy0u7aEDR2ygQ1s7x_L2jpA=@protonmail.com>

On Mon Nov 23, 2026 at 3:00 PM MSK, Roman Vivchar wrote:
> On Monday, November 23rd, 2026 at 1:20 PM, Alexander Letuchiy <asalde.le1=
@gmail.com> wrote:
>
>> Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
>> Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
>> console on UART0 and the volume down key on the SoC keypad. The power
>> and volume up keys are connected to the MT6363 PMIC, which isn't
>> supported yet.
>>=20
>> The DT only describes the memory that Linux itself uses, which is the
>> ramoops region. The bootloader updates the /memory node and adds the
>> firmware carveouts to /reserved-memory, so their addresses are not
>> hardcoded here. This DT must not be booted with a bootloader that does
>> not do this, as Linux would then use memory owned by the firmware.
>>=20
>> The ramoops zone sizes place the console zone at the offset where the
>> bootloader expects to find it.
>>=20
>> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/Makefile              |  1 +
>>  .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts | 87 +++++++++++++++=
+++++++
>>  2 files changed, 88 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts=
/mediatek/Makefile
>> index a86fb313b1a9..d73489149ab5 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-sony-xperia-m5.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6895-xiaomi-xaga.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7981b-cudy-wr3000-v1.dtb
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts b/arch/=
arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
>> new file mode 100644
>> index 000000000000..7bfe0d438803
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2026 Alexander Letuchiy <asalde.le1@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +
>> +#include "mt6895.dtsi"
>> +
>> +/ {
>> +	model =3D "Xiaomi Poco X4 GT";
>> +	compatible =3D "xiaomi,xaga", "mediatek,mt6895";
>> +	chassis-type =3D "handset";
>> +
>> +	aliases {
>> +		serial0 =3D &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path =3D "serial0:921600n8";
>> +	};
>> +
>> +	memory@40000000 {
>> +		device_type =3D "memory";
>> +		/* The size will be filled in by the bootloader */
>> +		reg =3D <0x0 0x40000000 0 0>;
>> +	};
>> +
>> +	reserved-memory {
>> +		ranges;
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <2>;
>> +
>> +		/* The firmware carveouts are added by the bootloader. */
>> +
>> +		ramoops@48090000 {
>> +			compatible =3D "ramoops";
>> +			reg =3D <0 0x48090000 0 0xe0000>;
>> +			no-map;
>> +			console-size =3D <0x40000>;
>> +			ftrace-size =3D <0x10000>;
>> +			pmsg-size =3D <0x10000>;
>> +			record-size =3D <0x10000>;
>> +		};
>> +	};
>> +};
>> +
>> +&keypad {
>> +	debounce-delay-ms =3D <32>;
>> +	keypad,num-columns =3D <1>;
>> +	keypad,num-rows =3D <1>;
>> +	linux,keymap =3D <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;
>> +	pinctrl-0 =3D <&keypad_pins>;
>> +	pinctrl-names =3D "default";
>> +
>> +	status =3D "okay";
>> +};
>
> Nit: vendor,property should go after pinctrl.
>
> debounce-delay-ms
> pinctrl-0
> pinctrl-names
> keypad,*
> linux,keymap
>
> status
>
> P.S. scripts/dtc/dt-check-style --mode stricter can be handy.
>
> Best regards,
> Roman

Thanks, I followed the ordering Angelo suggested in v2, so I missed
this.

Best regards,
Alexander
