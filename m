Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596889;
	b=B8er7XzCkEq36CsNCa00mOGfEhazdDKLWB892Idirkht24Dws/tLC/FMzdIn0yCeJytg
	 HYr5zyoP7ON6yQViVjlsJsx1Ltye8Azi+S1dO6AwaHQsn+DyuDvsb117JM6QfksjopH3V
	 HF5ahjkSaZQUOqaKHQaq5fRD//dva8gQtGfBK4wqMTXGgb3r5COGJJlFU2Dqjagvzi5wg
	 VgMffv44FqcBkK7Myx5hF5HAGnZDa8/lQq//VNaAQCOZStnhmrypdvHiCtYG+ZMGtN5We
	 pckYkT9UJxWYfEJ3ClfIsROuiH/Po2XmTtfGecYV1Pbo9bca+fzDNfBK1uwc0QO8nQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
	b=vF6Bhxj98ozWfqeoF2xVq30RcnEbbOtbPil2KbRcYDCSS1tc/gCpgICqIQI6uT5WGR3L
	 9PS3vAsSsnGG41R2NOJs4Irf2TMZJNki+PZ/mWgsgs1ZszQvg/zgJ4VxOEeXUD9xU1mhc
	 imSEJWEtBoEYxG9cqXjxv+feDka8wjBOxq5CODp7ijH//AevVuRGsrrD6eJqEdXMhELD+
	 goYjlfElOSX/5oFyb2VGD7OrRqcxE0m6/C9rZmTBboaLIqeUsGiDeY3yado0ZqnePFrcO
	 D57LIa3Y2711IE5KieJoQnbfrjDUQX2UzPatRN4kflqbFa+ZZgTUzXTe6QsOWjspMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4tedKCr;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9360A5BC2
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B9360A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4tedKCr
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d581da0aaso214636366b.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596888; x=1795201688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
        b=G4tedKCr9dTUHeL0osYHCYyb5sGhRprlJVyaCfkJKrgkZ5BdLEMGrYCpKPoiw3xGZE
         x4wRFsryhr1u1jHmsxGRUOKaVgDvUO4AVRmCeUMx9wzbAg0704GjQ6NKSUpUYXOEo4Dr
         OrO/R/o+d0heYsjmowV2I/rmWTmSUNqQa5XX7lVolvGkT4RCo3jKYaYjkK/TAkYRX/2v
         877stSoQ+3S9I9peB61iNcUnGWiDacUURczzYPOiv1+pztlIgF1kc9mvqJrOIqRp52TM
         AMxZWGQvbSW4A+weNKZq7Kj5NR4tGAj0T5HlFjLqtx35nCTxzVYBk+6lbsZ+fYOO5gkA
         asyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596888; x=1795201688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
        b=b203UmL4eqgdEWJKyPcDkGFX8QCafwTrH7QhmXiyppUvEOF6rzEW8hd2V/wX81JgZO
         iOJHjpxeVJCxiLtfG5/dAHeMw+y0YIzOtEjkh1DN4njUcT3O0TBMysPq+yL+ySh3FFEL
         p3LtWk86Qh6B8UmSVrp/GeoAzsgxCYGibFFEPcI53L3xQH7KJRdKGIBhKUqZ8J+dsAXe
         pIB0i9sEKsZKeE0bj2ajlhqPIuZ+bHQqaQZfFqwTMcIQARwRehhJ3u/QfdyHQqhxxR89
         9JsS+zBuAHImYj4V2iGi31bdXzruufXxXTqNwGodlpwHXZ6fp2YAEChZ0wCIspyaOyCO
         OkJw==
X-Forwarded-Encrypted: i=1; AL+hErEe1tAuZWPzGiOlwmEaHqBnViDDAyRy3P9yjm8P6oSnj6a7SHU3rEsa2TI5FJRoI9aEjKu+noguHMYgEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/iEr/ZdgpBVtE90tUVSxaehkG9rVK5N25UEM9ciIKrIMeWm1b+
	x7rLpdvQiUkuNNnJtsm4CRCwHKKsXXUOSXdSO7T+ROSz16iRsfym8RO5
X-Gm-Gg: AYBFou1/6DVka3hIj4d7h49GNtmrRArBpiTjSxfxpF1MsL9inP0u0ZnAwbNjm3m/4e0
	DoX2gYef5k6oZWP7eYmOjqmyB0NXl6KjMufis0ZH7G8bfs//G/6xrkeu4YhhPsagUXKgN/rSfpz
	HUaTHXGEAvsufI/Yv8NogPyNKmbkryay8qEjyDCKFFAhY6tdp3b4gUOQtNK5woZiqZTpcKvN5RN
	W5kNpJGz0wI780/1ReTczaWYF9FHl7zoftvpRsP/6wBcSSDrUE/3uO5YNtWV/XioYmXnNQZoV0j
	5dDFA22B69rB7Q44XHVTeXyrnQ8FKHTCtdQoxo3UbERt1BkcjMbp9SUsEqETDGHIlD1Y5iOeZiP
	WDFmSswEjhKANQLi4z9YBv3lSnvvkjTlnzqs49rQPmH/tW1XmJs1hkolb4lJonjTNLbF2jniW71
	Fb7UDlEmU2RU2fAzNMaKlhutTc0xo0YjwN0rE+YnV454VeHb7r0dIb9P4Oyr1/Qgk0JQ8qRKNQS
	wz3sP0XScZwhwtIUKpZLnvvmqm7p7J7MJC7ib9PuytNKs6eE32l322Cem7KjuLyavT/dkxGXFdF
	M/ruftJ3IwplH7GhSme9enQt6TmZX2w3mbMUTrkBP9e51psAoayV3zPmSjhXWjI8
X-Received: by 2002:a17:907:8687:b0:c46:7645:86c with SMTP id a640c23a62f3a-c509641d1eamr287876866b.47.1794596887578;
        Fri, 13 Nov 2026 11:08:07 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:08:07 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:05 +0300
Subject: [PATCH v2 9/9] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
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
Message-Id: <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
console on UART0 and the volume down key on the SoC keypad. The power
and volume up keys are connected to the MT6363 PMIC, which isn't
supported yet.

The DT only describes the memory that Linux itself uses, which is the
ramoops region. The bootloader updates the /memory node and adds the
firmware carveouts to /reserved-memory, so their addresses are not
hardcoded here. This DT must not be booted with a bootloader that does
not do this, as Linux would then use memory owned by the firmware.

The ramoops zone sizes place the console zone at the offset where the
bootloader expects to find it.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts | 87 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a9..d73489149ab5 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6895-xiaomi-xaga.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
new file mode 100644
index 000000000000..8d529062eea1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Alexander Letuchiy <asalde.le1@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+
+#include "mt6895.dtsi"
+
+/ {
+	model = "Xiaomi Poco X4 GT";
+	compatible = "xiaomi,xaga", "mediatek,mt6895";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* The size is updated by the bootloader. */
+		reg = <0x0 0x40000000 0x2 0x0>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* The firmware carveouts are added by the bootloader. */
+
+		ramoops@48090000 {
+			compatible = "ramoops";
+			reg = <0 0x48090000 0 0xe0000>;
+			no-map;
+			record-size = <0x10000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x10000>;
+		};
+	};
+};
+
+&keypad {
+	pinctrl-0 = <&keypad_pins>;
+	pinctrl-names = "default";
+	debounce-delay-ms = <32>;
+	keypad,num-columns = <1>;
+	keypad,num-rows = <1>;
+	linux,keymap = <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;
+
+	status = "okay";
+};
+
+&pio {
+	keypad_pins: keypad-pins {
+		pins-col {
+			pinmux = <PINMUX_GPIO107__FUNC_KPCOL0>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			input-enable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO88__FUNC_URXD0>;
+			bias-pull-up;
+			input-enable;
+		};
+
+		pins-tx {
+			pinmux = <PINMUX_GPIO89__FUNC_UTXD0>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};

-- 
2.56.0

