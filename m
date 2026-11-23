Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427401;
	b=SanY4L/4JzmPedYFAbOTfkJHR4IsXodmapRG79FcsnujPYt9csmO2QhvoVaNxy1j1rGB
	 pmnOjErIE8fsUMstnSeeliQEKUJewq7fhhkg5zI1zyS3Y1YHFH+1R4JrsgQiKFKrLHjuV
	 aFjwjZoJhIWMy8vEkXdSziOfZ+uRKB3rcN3V41DmpFf0BUtplllR0t0uaNoMQyqlALygT
	 UW22AJ/F9pusC4QlFaTrAUFfjaZ6Sap3UDj4YBfa8RSIAC9d3acb4KOWlZlqLhgiuqKUX
	 /aGjevnC/rNdUMT0+TvLqfl+7MMVbgPyElVMiBFKOl1Cj83LCN/LFfZiQawFrPn2dPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427401;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eiF/jOGcMBS3RJrUa5NmDvvMwz7m35WAnkbAKQDIzuM=;
	b=f6XOB/MfGA4XbdTI+7yENByTRbndxe4aOHAMVxhG399AK8wb1ZMy+mT9yuZa+COgYQt/
	 i4TFaNhplmqsEr3xRgSx/a094ghuGL6fIjlFz7Lm/B5XJQNbHq0dVDP8ats5zn2X6w1x7
	 wNyy6yljWCcf1J4w7dDqoH8rH3QXDVLWZfyWgXvmWtfbB+Tx3n53SSqTxnlbmMrYxquwU
	 uciIuhmK4eCz8ifcaxQhJSEMJk06ksFCXdgSxbhcm5LrCYkCq4L95CnuADjFGIDfjc57L
	 YEDmTtB6tovqGOZ5qOCN7wmbjkEVKzZ8Ndm2PoDvfJCDewBIbiTB4G1lBEkfElHszIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dgdGEb57;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A6606A330;
	Mon, 23 Nov 2026 09:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6A6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dgdGEb57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795427400;
	bh=3gj4la20Ij/aoTkrjPe4zjbBNz3w57jb6pogEbON12I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dgdGEb575kHihZtWdp5CYVQe4oQAWhbcPM8QECisA1bwX4qys8KzAcTLJCr3CD4xQ
	 C9/G/Y+5wuHck2q8RUwpSSOFQQX1euA20THs71u61cALH4TE3mKLpGHO4LmjhwH0UH
	 b4sjwqtLbo5mwtPKKNKPDcgDDG2QjJe+kbkbPUz9+D/1020eZAaSBbQt+xeo5SCNCB
	 Mbe5GvovL18CmH9K+T2w3lh2D/uuCCx94cbHuHg9j7DefiiF1oI0XIe0NSEGt8lLTN
	 z1T1esF+jJqEKSFFCq+5HhzsH5PwP47e6VkCkRpcMnmyrUE6ebSa/SB0UNKvjyP0nT
	 kkCPMSaKx/CfQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D65F17E0DE8;
	Mon, 23 Nov 2026 10:49:59 +0100 (CET)
Message-ID: <91bdc31f-a3bd-4838-9e2a-4e06adbbea1f@collabora.com>
Date: Mon, 23 Nov 2026 10:49:58 +0100
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
Subject: Re: [PATCH v2 9/9] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
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
 <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 20:05, Alexander Letuchiy wrote:
> Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
> Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
> console on UART0 and the volume down key on the SoC keypad. The power
> and volume up keys are connected to the MT6363 PMIC, which isn't
> supported yet.
> 
> The DT only describes the memory that Linux itself uses, which is the
> ramoops region. The bootloader updates the /memory node and adds the
> firmware carveouts to /reserved-memory, so their addresses are not
> hardcoded here. This DT must not be booted with a bootloader that does
> not do this, as Linux would then use memory owned by the firmware.
> 
> The ramoops zone sizes place the console zone at the offset where the
> bootloader expects to find it.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile              |  1 +
>   .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts | 87 ++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index a86fb313b1a9..d73489149ab5 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6895-xiaomi-xaga.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
> new file mode 100644
> index 000000000000..8d529062eea1
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
> +	model = "Xiaomi Poco X4 GT";
> +	compatible = "xiaomi,xaga", "mediatek,mt6895";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/* The size is updated by the bootloader. */
> +		reg = <0x0 0x40000000 0x2 0x0>;
> +	};
> +
> +	reserved-memory {

                 #address-cells = <2>;
                 #size-cells = <2>;
                 ranges;


> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		/* The firmware carveouts are added by the bootloader. */
> +
> +		ramoops@48090000 {
> +			compatible = "ramoops";
> +			reg = <0 0x48090000 0 0xe0000>;
> +			no-map;

For those ones...

> +			record-size = <0x10000>;
> +			console-size = <0x40000>;
> +			ftrace-size = <0x10000>;
> +			pmsg-size = <0x10000>;

...please, alphabetical order.

console
ftrace
pmsg
record


> +		};
> +	};
> +};
> +
> +&keypad {
> +	pinctrl-0 = <&keypad_pins>;
> +	pinctrl-names = "default";
> +	debounce-delay-ms = <32>;
> +	keypad,num-columns = <1>;
> +	keypad,num-rows = <1>;
> +	linux,keymap = <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;

debounce
keypad,xxxx
linux,xxxx
pinctrl-0
pinctrl-names

status

> +
> +	status = "okay";
> +};
> +
After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
