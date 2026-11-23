Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435251;
	b=G/gXc+EEgNCJ2Pym0PMM/2TmbZZcgA7uoiGD+/2nujRHgfE5ggs4F7Yx0alKAizgsbIX
	 H/Fj75vjsn84VyVmPlTfujT/mMqIEy5N6bxX63alTHlXn0gcdOtP/bjFdIqZ5PvdFtZTu
	 Qxt5rDLijmwko0RkdIQBeIsS0a0JvvdzQUKxf1CDSrRz9FJCFSQKveUJm8jLXQDX2PnZo
	 WilmuCA7v2tjXj9QAoOCzeFQH/8D9/burNoPWEF8kLlie8Lm8rHHYUOCBx+91vIDrLTZk
	 eh98aesEvWMuLx6VTWpg3ZjE0BdSmOdTuzcUsOym/jLspVpKqA+HgPaJpaDnP/5dSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435251;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=z8qg3U6Qej1tpAsWPfwFQnfSv2z3+luuDln9nLU+vFA=;
	b=K2T/lfTr8AfTFCbmpxZ6qkV5ztEUTmeke6iEXrwC0mdro2ytJWTzBRn8Q9T8LkZerCpf
	 WCiOWcIfLzEG5R6nxWxwjjFfYVR0q2Eto7R2wtHF++XOtnjjryid/jqfhuAW39gHuBNNY
	 KBiL6m/I8nQry8MfJ7OB5W4XuMZH+dtm3IGyaqIGe8lhbYev1CqKGktrTnEOR4HKmQ2aX
	 yOX7tEDEB+sm3B00ui+AawdN+RgPcPeOEpN4GgyhvE7QdhO16wZiHOHv7Is/eUoPA1wsQ
	 ssn0ihHypDk4zDgMZbHasEDUFs0h6afiM8FiUgzSWCbYdaZ+agn0FZe9CTemqhRtMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="ghMx/3dg";
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100D606A31E;
	Mon, 23 Nov 2026 12:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9100D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ghMx/3dg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795435247; x=1795694447;
	bh=z8qg3U6Qej1tpAsWPfwFQnfSv2z3+luuDln9nLU+vFA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ghMx/3dg2zSJoKg0v4LkFmgAUSKTrtj4meQAd2seNAMRVfXTtmg1YxOln2MsOhJlr
	 pZGQa6rX0m2gnWgBQZr0GnHkW51Uh6dus3KW6oDJP1LHR5h+om9Rnq2NCkdIBWOE/8
	 VeloCQFtp7ed9geyWVbdZ9wDa7ruV5BigJpoA5oILwc4s2/bH/mjKPF2MQxfRiih+2
	 n9PswQ7IuYeiLNfRF/i8581MXOhqX3quSCwkCxG9hDeLDxcAcZ74+t/dX+fZ0Hc4Rv
	 RoKM1I4noQ3HNHsVbUzMsOek23H/M+TLbuaMJS46Ptt+q8hkAoAChVm7bXXc2eY1+k
	 kse3Sh7kLUc8g==
Date: Mon, 23 Nov 2026 12:00:40 +0000
To: Alexander Letuchiy <asalde.le1@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
Message-ID: <cYX8v2leizSJfWjS_2dbkU2i6ApgjEKmgar6xjZopFQipSXW6YZNgjexWomHucqKghaTzW7oO5GN_jeNBM1MBy0u7aEDR2ygQ1s7x_L2jpA=@protonmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-7-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com> <20261123-initial-mt6895-v3-7-95c46597e63d@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 9176670b887ca86ce9dd7243954764b2d1874340
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
Content-Transfer-Encoding: quoted-printable

On Monday, November 23rd, 2026 at 1:20 PM, Alexander Letuchiy <asalde.le1@g=
mail.com> wrote:

> Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
> Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
> console on UART0 and the volume down key on the SoC keypad. The power
> and volume up keys are connected to the MT6363 PMIC, which isn't
> supported yet.
>=20
> The DT only describes the memory that Linux itself uses, which is the
> ramoops region. The bootloader updates the /memory node and adds the
> firmware carveouts to /reserved-memory, so their addresses are not
> hardcoded here. This DT must not be booted with a bootloader that does
> not do this, as Linux would then use memory owned by the firmware.
>=20
> The ramoops zone sizes place the console zone at the offset where the
> bootloader expects to find it.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile              |  1 +
>  .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts | 87 ++++++++++++++++=
++++++
>  2 files changed, 88 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index a86fb313b1a9..d73489149ab5 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-sony-xperia-m5.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6895-xiaomi-xaga.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7981b-cudy-wr3000-v1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts b/arch/a=
rm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
> new file mode 100644
> index 000000000000..7bfe0d438803
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2026 Alexander Letuchiy <asalde.le1@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +
> +#include "mt6895.dtsi"
> +
> +/ {
> +=09model =3D "Xiaomi Poco X4 GT";
> +=09compatible =3D "xiaomi,xaga", "mediatek,mt6895";
> +=09chassis-type =3D "handset";
> +
> +=09aliases {
> +=09=09serial0 =3D &uart0;
> +=09};
> +
> +=09chosen {
> +=09=09stdout-path =3D "serial0:921600n8";
> +=09};
> +
> +=09memory@40000000 {
> +=09=09device_type =3D "memory";
> +=09=09/* The size will be filled in by the bootloader */
> +=09=09reg =3D <0x0 0x40000000 0 0>;
> +=09};
> +
> +=09reserved-memory {
> +=09=09ranges;
> +=09=09#address-cells =3D <2>;
> +=09=09#size-cells =3D <2>;
> +
> +=09=09/* The firmware carveouts are added by the bootloader. */
> +
> +=09=09ramoops@48090000 {
> +=09=09=09compatible =3D "ramoops";
> +=09=09=09reg =3D <0 0x48090000 0 0xe0000>;
> +=09=09=09no-map;
> +=09=09=09console-size =3D <0x40000>;
> +=09=09=09ftrace-size =3D <0x10000>;
> +=09=09=09pmsg-size =3D <0x10000>;
> +=09=09=09record-size =3D <0x10000>;
> +=09=09};
> +=09};
> +};
> +
> +&keypad {
> +=09debounce-delay-ms =3D <32>;
> +=09keypad,num-columns =3D <1>;
> +=09keypad,num-rows =3D <1>;
> +=09linux,keymap =3D <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;
> +=09pinctrl-0 =3D <&keypad_pins>;
> +=09pinctrl-names =3D "default";
> +
> +=09status =3D "okay";
> +};

Nit: vendor,property should go after pinctrl.

debounce-delay-ms
pinctrl-0
pinctrl-names
keypad,*
linux,keymap

status

P.S. scripts/dtc/dt-check-style --mode stricter can be handy.

Best regards,
Roman
