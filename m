Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378A3D669A;
	Wed,  8 Apr 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670638; cv=pass; b=GVtDFpOU9XXwFI+QDmB3EKNIlUZRFLHV9u7csjlTT8EWOYTTQ473RnrLIwgX41/t+zdzHPPQzAN65H4zzElsLY3JJhrBytJnVDswZVAbW5IUhoBrwEZLqBpYKsRtNAVRBM9UYdPzuQtW1IgjV7zybLo8b5pHEzkkO122wqI6N+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670638; c=relaxed/simple;
	bh=/nQiDWZWHUCr9JBVikoU/pdq20N8ZPS328YR4lrL/Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loadV/ZEjnNHiA71TprIo7idIpOtRPCAkeBmpJBvoHaawzsRThjTTY4ohC9unQKvG65q2RGZdHGnsAUH8SIyAAFqX4c78foWdgsCxMQIJIxytCloBP1mHzXqZUho+WGuQycVly/wkaqsbKOIxlxhC0ixlYpAWL5aoar8PzI+E/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=lMZpj1ZW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="lMZpj1ZW"
ARC-Seal: i=1; a=rsa-sha256; t=1775670618; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I4u7FW/tPFG/CjB3SVm9X11ID8dowsVwLk0U0XFJSktZfhxVxfvs0egS0DOr+EX4OnoeGTsG9e2tpJnwnnuhn0JLh6RwiHNPf6Wrvu91iEXbYzAduzZr2xkh+BuM36cS/Eu0gKzMMMy4lS5bI9+I8KfpaxXCVj4kVbqyhUbeeOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775670618; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I7h9KF6DUxHVCjojEM2b2Af8cE4DbNkN2i/zma/X7Ow=; 
	b=PWYdccTH0fTMhS8GnUFkVIC58LJW4LVpFfewPfog1+ChdTuVMML+UqSt8TjdrD8JUyDU2ItiUjqRmR5QCYT6NEX+rurSRhkYWk+66sF0VyvANCGvk6/0FEu40Tp1v3KCkAJJPr8AXoqHp5dCFap3jpV0m23dYsgcIqT2zaLAwmU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775670618;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=I7h9KF6DUxHVCjojEM2b2Af8cE4DbNkN2i/zma/X7Ow=;
	b=lMZpj1ZW+MX0hZ9CgXdA71UCvB5cuthaTJKBL771nBkz1A214PCJUozqdEKMx/s0
	blEHdcUhbm08487WO1RemLqcEovi9I44DBqB9TzNhbIxNhub328hJdjkhVBveyPHEOO
	FPRM4mhZkg7nTT/De8DKSnl5M0ucMYOyzyb3fuQ8=
Received: by mx.zohomail.com with SMTPS id 1775670617761642.4208513616555;
	Wed, 8 Apr 2026 10:50:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Apr 2026 19:49:42 +0200
Subject: [PATCH v3 4/4] arm64: dts: rockchip: add analog audio to ROCK 4D
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rock4d-audio-v3-4-49e43c3c2a68@collabora.com>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
In-Reply-To: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.15.1

The RADXA ROCK 4D, like many other Rockchip-based boards, uses an ES8388
analog audio codec. On the production version of the board, the codec's
LOUT1 and ROUT1 pins are tied to the headphone jack, whereas pins LOUT2
and ROUT2 lead to a non-populated speaker amplifier that itself leads to
a non-populated speaker jack. The schematic is still haunted by the
ghosts of those symbols, but it clearly marks them as "NC".

The 3.5mm TRRS jack has its microphone ring (and ground ring) wired to
the codec's LINPUT1 and RINPUT1 pins for differential signalling.

Furthermore, it uses the SoCs ADC to detect whether the inserted cable
is of headphones (i.e., no microphone), or a headset (i.e., with
microphone). The way this is done is that the ADC input taps the output
of a 100K/100K resistor divider that divides the microphone ring pin
that's pulled up to 3.3V.

There is no ADC level difference between a completely empty jack and one
with a set of headphones (i.e., ones that don't have a microphone)
connected. Consequently headphone insertion detection isn't something
that can be done.

Add the necessary codec and audio card nodes. The non-populated parts,
i.e. LOUT2 and ROUT2, are not modeled at all, as they are not present on
the hardware.

Also, add an adc-keys node for the headset detection, which uses an
input type of EV_SW with the SW_MICROPHONE_INSERT keycode. Below the
220mV pressed voltage level of our SW_MICROPHONE_INSERT switch, we also
define a button that emits a KEY_RESERVED code, which is there to model
this part of the voltage range as not just being extra legroom for the
button above it, but actually a state that is encountered in the real
world, and should be recognised as a valid state for the ADC range to be
in so that no "closer" ADC button is chosen.

Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 90 +++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 899a84b1fbf9..c848c706196e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/pwm/pwm.h>
@@ -37,6 +38,31 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	es8388_sound: es8388-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "On-board Analog ES8388";
+		simple-audio-card,widgets = "Microphone", "Headphone Mic",
+					    "Headphone", "Headphone";
+		simple-audio-card,routing = "Headphone", "LOUT1",
+					    "Headphone", "ROUT1",
+					    "Left PGA Mux", "Differential Mux",
+					    "Differential Mux", "LINPUT1",
+					    "Differential Mux", "RINPUT1",
+					    "LINPUT1", "Headphone Mic",
+					    "RINPUT1", "Headphone Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
 	rfkill {
 		compatible = "rfkill-gpio";
 		pinctrl-names = "default";
@@ -65,6 +91,37 @@ user-led {
 		};
 	};
 
+	saradc_keys: adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 3>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <3000000>;
+		poll-interval = <100>;
+
+		/*
+		 * During insertion and removal of a regular set of headphones,
+		 * i.e. one without a microphone, the voltage level briefly
+		 * dips below the 220mV of the headset connection switch.
+		 * By having a button definition with a KEY_RESERVED signal
+		 * between 0 to 220, we ensure no driver implementation thinks
+		 * that the closest thing to 0V is 220mV so clearly there must
+		 * be a headset connected.
+		 */
+
+		button-headset-disconnected {
+			label = "Headset Microphone Disconnected";
+			linux,code = <KEY_RESERVED>;
+			press-threshold-microvolt = <0>;
+		};
+
+		button-headset-connected {
+			label = "Headset Microphone Connected";
+			linux,code = <SW_MICROPHONE_INSERT>;
+			linux,input-type = <EV_SW>;
+			press-threshold-microvolt = <220000>;
+		};
+	};
+
 	vcc_5v0_dcin: regulator-vcc-5v0-dcin {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -696,6 +753,25 @@ eeprom@50 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+
+	es8388: audio-codec@10 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x10>;
+		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcc_3v3_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcc_3v3_s0>;
+		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
+		assigned-clock-rates = <12288000>;
+		#sound-dai-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sai1m0_mclk>;
+	};
+};
+
 &mdio0 {
 	rgmii_phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-id001c.c916";
@@ -770,10 +846,24 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sai1m0_lrck
+		     &sai1m0_sclk
+		     &sai1m0_sdi0
+		     &sai1m0_sdo0>;
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vcca1v8_pldo2_s0>;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;

-- 
2.53.0

