Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EE4657F3
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627836; cv=none; b=ivAukFS7fZN6p5KFPyMj5tzRsnsyYDbnCkuFoQhfq8oM+VYW29SB425q7Td3LgAqGxRpA844qrNZEP6QN1bXwPCIJUPo4BwV3l7IhtMXXSIo+vDjv0BrIIjjQZZ2ldzcZKcZeK9mq9rHq5mEugq9klxtXdMeESCM1DLS78I6Ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627836; c=relaxed/simple;
	bh=DAG+2vBSTcHuP4hMVL10G0irlKKpP37pG9TiqOhcAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+k1oh+wZLi2lTFuEUJlJYIGXS9wP9DrZZAno4YoL0I5srb3iODHlNZls14d91DXmnxd274YlPAJu9xQfJWOMMKYIO5NmyLCSwJRPoOxYD0p4sj3tMgS+M+Gwkjok9+Rq7uUIKi5BRgWYN41ZAoUzktr2lR308nvdKMrcIbd+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZgJmFZH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZgJmFZH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f633e6058so3657915f8f.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627833; x=1785232633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GeNicgr3pagFjUcuydOvJgIbCBC8VLlhnAD9p9p8eTs=;
        b=SZgJmFZHIm2H3HHjVgg+6yZB+tAz27IYCKhA52vZYcOf5A5Rd50Ecjqd19wIEw/H8i
         QorD2L4z/USDpQneHTVoiuGUtjVX2rWHbhVesyj9FDhaHwuZ03GepE9yHVkt9Nd7PjE0
         fbXjHRZQlc+WpCCCMV0Bqkm5EEzEFL/wLfFoTuHkPnRPzALs77t9pZKN4kRO18LFFNXA
         3R0Fz3sWIe1dlBE2sZ7LbKRDdckt4850Ejg2MVT5QYxK/GifrW4sUxFdi/dBzfNBN2An
         gYrdZt/y/8oDZxMqNY+gNOTU5cuG9cBxAbNwD+POhWkzLpVofCavYd9GUDbMfLyyAlOX
         EzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627833; x=1785232633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GeNicgr3pagFjUcuydOvJgIbCBC8VLlhnAD9p9p8eTs=;
        b=ZoH1zF1KFzdqLevUHT/iIZipuIjN0DxNHhlGMxtvEfvnFyuUxlhWLYmWWkylz1uNKV
         QoLJBkPN6axVU1GBOitjV4pTwGYXDSsADAFT1c6vyDEmNPmykw1HJAObGyed62ski8ei
         3MBJr7XT//Tip3/nQ/0ucPe9/9nAFs10FVV0A7VpRu1spdUq/3gn7iLHEdBkNf1/fedy
         ZMY4mTUTOSRZKhQUmn05p0QTem1afvRseoeFJ8/3ng9wuATYLn/GS+sepMW7flBN5Buz
         qrQof+cvDpj6erk+0cfovFknZz4myZrJ18v3hsYKlMg6MOSwMOk2vspRwNUQBo5IAlii
         dK7Q==
X-Gm-Message-State: AOJu0Yzsus3OMS4ao1BcTDrOCyjyAWVeGfBlpuMzR6o8iuIoLn2F1eZf
	ClwZuoc/svL4lJSmF1UKvXlf+5P/aglXSF+KU/XkYzOK5MYFxRIP8LjV
X-Gm-Gg: AfdE7clxNSTwyigEXFEwTzX0ivNptVkdq6vR9xQFVfRolRBEo/SJqDIDDWPY9rM9tqk
	sE9Jtcdd1SIhu1gAcEG/ui7iWi4SbcrQwuRrUSYLX2s1BiIBQdXdKFLQLcW3atJy6J6H4ZTv7aK
	lSOH5Gp4SZ8JblQrFE5oKCuVDoBSwJAHnCIHglEerxxSF1jZu0cRSP1b82laeVNUyuum06Wcyc3
	WGnEUlFOEbn7c+BHMW288/WVew21l3AHdjaIhvOQPb+Ci14vY6fvTPHOO+08PbTfXYHvtDTGWD2
	cQKoYfXzqhc7AxE1odA2VqefyTpmP60vJjZ5qqhsd2pqnjPw39dqUrBGYDeoSWGHBZ8dtBS8v1U
	lcSqAYbiVrvFguX49kKitwdzij45fy1Vf5KtIZ2n69kKZTiMQQzH3XVVPrDk9gQFi3ZNgoVZejI
	OepBnxa3ZO7tbpkWxJuEU/720=
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr189886375e9.10.1784627832650;
        Tue, 21 Jul 2026 02:57:12 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm227476185e9.0.2026.07.21.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:57:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 3/6] dt-bindings: mfd: motorola-cpcap: convert to DT schema
Date: Tue, 21 Jul 2026 12:56:50 +0300
Message-ID: <20260721095654.429346-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/motorola,cpcap.yaml          | 403 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 2 files changed, 403 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
new file mode 100644
index 0000000000000..76705ea56805a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -0,0 +1,403 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC MFD
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: motorola,cpcap
+      - const: st,6556002
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  spi-max-frequency:
+    maximum: 9600000
+
+  spi-cs-high: true
+  spi-cpol: true
+  spi-cpha: true
+
+  adc:
+    $ref: /schemas/iio/adc/motorola,cpcap-adc.yaml#
+
+  audio-codec:
+    type: object
+    additionalProperties: false
+
+    properties:
+      interrupts:
+        items:
+          - description: headset detect interrupt
+          - description: microphone bias 2 detect interrupt
+
+      interrupt-names:
+        items:
+          - const: hs
+          - const: mb2
+
+      "#sound-dai-cells":
+        const: 1
+
+      VAUDIO-supply:
+        description:
+          Codec power supply, usually VAUDIO regulator of CPCAP.
+
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+
+        properties:
+          port@0:
+            $ref: /schemas/graph.yaml#/properties/port
+            description: port connected to the Stereo HiFi DAC
+
+          port@1:
+            $ref: /schemas/graph.yaml#/properties/port
+            description: port connected to the Voice DAC
+
+        required:
+          - port@0
+          - port@1
+
+    required:
+      - interrupts
+      - interrupt-names
+      - "#sound-dai-cells"
+
+  battery:
+    $ref: /schemas/power/supply/cpcap-battery.yaml#
+
+  charger:
+    $ref: /schemas/power/supply/cpcap-charger.yaml#
+
+  key-power:
+    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml#
+
+  phy:
+    $ref: /schemas/phy/motorola,cpcap-usb-phy.yaml#
+
+  regulator:
+    $ref: /schemas/regulator/motorola,cpcap-regulator.yaml#
+
+  rtc:
+    $ref: /schemas/rtc/motorola,cpcap-rtc.yaml#
+
+patternProperties:
+  "^led(-[a-z]+)?$":
+    $ref: /schemas/leds/motorola,cpcap-leds.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpcap: pmic@0 {
+            compatible = "motorola,cpcap", "st,6556002";
+            reg = <0>; /* cs0 */
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            spi-max-frequency = <3000000>;
+            spi-cs-high;
+
+            spi-cpol;
+            spi-cpha;
+
+            cpcap_adc: adc {
+                compatible = "motorola,cpcap-adc";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <8 IRQ_TYPE_NONE>;
+                interrupt-names = "adcdone";
+
+                #io-channel-cells = <1>;
+            };
+
+            cpcap_audio: audio-codec {
+                interrupt-parent = <&cpcap>;
+                interrupts = <9 IRQ_TYPE_NONE>, <10 IRQ_TYPE_NONE>;
+                interrupt-names = "hs", "mb2";
+
+                VAUDIO-supply = <&vdd_audio>;
+
+                #sound-dai-cells = <1>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    /* HiFi */
+                    port@0 {
+                        reg = <0>;
+
+                        cpcap_audio_codec0: endpoint {
+                        };
+                    };
+
+                    /* Voice */
+                    port@1 {
+                        reg = <1>;
+
+                        cpcap_audio_codec1: endpoint {
+                        };
+                    };
+                };
+            };
+
+            cpcap_battery: battery {
+                compatible = "motorola,cpcap-battery";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <6 IRQ_TYPE_NONE>, <5 IRQ_TYPE_NONE>,
+                             <3 IRQ_TYPE_NONE>, <20 IRQ_TYPE_NONE>,
+                             <54 IRQ_TYPE_NONE>, <57 IRQ_TYPE_NONE>;
+                interrupt-names = "eol", "lowbph", "lowbpl",
+                                  "chrgcurr1", "battdetb", "cccal";
+
+                io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                              <&cpcap_adc 5>, <&cpcap_adc 6>;
+                io-channel-names = "battdetb", "battp",
+                                   "chg_isense", "batti";
+                power-supplies = <&cpcap_charger>;
+            };
+
+            cpcap_charger: charger {
+                compatible = "motorola,mapphone-cpcap-charger";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <13 IRQ_TYPE_NONE>, <12 IRQ_TYPE_NONE>,
+                             <29 IRQ_TYPE_NONE>, <28 IRQ_TYPE_NONE>,
+                             <22 IRQ_TYPE_NONE>, <21 IRQ_TYPE_NONE>,
+                             <20 IRQ_TYPE_NONE>, <19 IRQ_TYPE_NONE>,
+                             <54 IRQ_TYPE_NONE>;
+                interrupt-names = "chrg_det", "rvrs_chrg", "chrg_se1b",
+                                  "se0conn", "rvrs_mode", "chrgcurr2",
+                                  "chrgcurr1", "vbusvld", "battdetb";
+
+                mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>,
+                             <&gpio3 23 GPIO_ACTIVE_LOW>;
+
+                io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                              <&cpcap_adc 2>, <&cpcap_adc 5>,
+                              <&cpcap_adc 6>;
+                io-channel-names = "battdetb", "battp",
+                                   "vbus", "chg_isense",
+                                   "batti";
+            };
+
+            key-power {
+                compatible = "motorola,cpcap-pwrbutton";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <23 IRQ_TYPE_NONE>;
+            };
+
+            led-red {
+                compatible = "motorola,cpcap-led-red";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::red";
+            };
+
+            led-green {
+                compatible = "motorola,cpcap-led-green";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::green";
+            };
+
+            led-blue {
+                compatible = "motorola,cpcap-led-blue";
+                vdd-supply = <&vdd_led>;
+                label = "status-led::blue";
+            };
+
+            cpcap_usb2_phy: phy {
+                compatible = "motorola,cpcap-usb-phy";
+
+                pinctrl-0 = <&usb_gpio_mux_sel1>, <&usb_gpio_mux_sel2>;
+                pinctrl-1 = <&usb_ulpi_pins>;
+                pinctrl-2 = <&usb_utmi_pins>;
+                pinctrl-3 = <&uart3_pins>;
+                pinctrl-names = "default", "ulpi", "utmi", "uart";
+                #phy-cells = <0>;
+
+                interrupts-extended =
+                    <&cpcap 15 IRQ_TYPE_NONE>, <&cpcap 14 IRQ_TYPE_NONE>,
+                    <&cpcap 28 IRQ_TYPE_NONE>, <&cpcap 19 IRQ_TYPE_NONE>,
+                    <&cpcap 18 IRQ_TYPE_NONE>, <&cpcap 17 IRQ_TYPE_NONE>,
+                    <&cpcap 16 IRQ_TYPE_NONE>, <&cpcap 49 IRQ_TYPE_NONE>,
+                    <&cpcap 48 IRQ_TYPE_NONE>;
+                interrupt-names = "id_ground", "id_float", "se0conn",
+                                  "vbusvld", "sessvld", "sessend",
+                                  "se1", "dm", "dp";
+
+                mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,
+                             <&gpio1 0 GPIO_ACTIVE_HIGH>;
+
+                io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
+                io-channel-names = "vbus", "id";
+
+                vusb-supply = <&avdd_usb>;
+            };
+
+            regulator {
+                compatible = "motorola,cpcap-regulator";
+
+                regulators {
+                    vdd_cpu: SW1 {
+                        regulator-name = "vdd_cpu";
+                        regulator-min-microvolt = <750000>;
+                        regulator-max-microvolt = <1125000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_core: SW2 {
+                        regulator-name = "vdd_core";
+                        regulator-min-microvolt = <950000>;
+                        regulator-max-microvolt = <1300000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_1v8_vio: SW3 {
+                        regulator-name = "vdd_1v8_vio";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <1800000>;
+                        regulator-enable-ramp-delay = <0>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_aon: SW4 {
+                        regulator-name = "vdd_aon";
+                        regulator-min-microvolt = <950000>;
+                        regulator-max-microvolt = <1300000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_led: SW5 {
+                        regulator-name = "vdd_led";
+                        regulator-min-microvolt = <5050000>;
+                        regulator-max-microvolt = <5050000>;
+                        regulator-enable-ramp-delay = <1500>;
+                        regulator-boot-on;
+                    };
+
+                    vdd_hvio: VHVIO {
+                        regulator-name = "vdd_hvio";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <2775000>;
+                        regulator-enable-ramp-delay = <1000>;
+                    };
+
+                    vcore_emmc: VSDIO {
+                        regulator-name = "vcore_emmc";
+                        regulator-min-microvolt = <1500000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    avdd_dsi_csi: VCSI {
+                        regulator-name = "avdd_dsi_csi";
+                        regulator-min-microvolt = <1200000>;
+                        regulator-max-microvolt = <1200000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    avdd_3v3_periph: VWLAN2 {
+                        regulator-name = "avdd_3v3_periph";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <3300000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    vddio_usd: VSIMCARD {
+                        regulator-name = "vddio_usd";
+                        regulator-min-microvolt = <1800000>;
+                        regulator-max-microvolt = <2900000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-boot-on;
+                    };
+
+                    vdd_haptic: VVIB {
+                        regulator-name = "vdd_haptic";
+                        regulator-min-microvolt = <1300000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-enable-ramp-delay = <1000>;
+                    };
+
+                    avdd_usb: VUSB {
+                        regulator-name = "avdd_usb";
+                        regulator-min-microvolt = <3300000>;
+                        regulator-max-microvolt = <3300000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    vdd_audio: VAUDIO {
+                        regulator-name = "vdd_audio";
+                        regulator-min-microvolt = <2775000>;
+                        regulator-max-microvolt = <2775000>;
+                        regulator-enable-ramp-delay = <1000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+                };
+            };
+
+            cpcap_rtc: rtc {
+                compatible = "motorola,cpcap-rtc";
+
+                interrupt-parent = <&cpcap>;
+                interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
deleted file mode 100644
index 18c3fc26ca932..0000000000000
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Motorola CPCAP PMIC device tree binding
-
-Required properties:
-- compatible		: One or both of "motorola,cpcap" or "ste,6556002"
-- reg			: SPI chip select
-- interrupts		: The interrupt line the device is connected to
-- interrupt-controller	: Marks the device node as an interrupt controller
-- #interrupt-cells	: The number of cells to describe an IRQ, should be 2
-- #address-cells	: Child device offset number of cells, should be 1
-- #size-cells		: Child device size number of cells, should be 0
-- spi-max-frequency	: Typically set to 3000000
-- spi-cs-high		: SPI chip select direction
-
-Optional subnodes:
-
-The sub-functions of CPCAP get their own node with their own compatible values,
-which are described in the following files:
-
-- Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
-- Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
-- Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
-- Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
-- Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
-- Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
-- Documentation/devicetree/bindings/leds/leds-cpcap.txt
-- Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
-
-The only exception is the audio codec. Instead of a compatible value its
-node must be named "audio-codec".
-
-Required properties for the audio-codec subnode:
-
-- #sound-dai-cells = <1>;
-- interrupts		: should contain jack detection interrupts, with headset
-			  detect interrupt matching "hs" and microphone bias 2
-			  detect interrupt matching "mb2" in interrupt-names.
-- interrupt-names	: Contains "hs", "mb2"
-
-The audio-codec provides two DAIs. The first one is connected to the
-Stereo HiFi DAC and the second one is connected to the Voice DAC.
-
-Example:
-
-&mcspi1 {
-	cpcap: pmic@0 {
-		compatible = "motorola,cpcap", "ste,6556002";
-		reg = <0>;	/* cs0 */
-		interrupt-parent = <&gpio1>;
-		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		spi-max-frequency = <3000000>;
-		spi-cs-high;
-
-		audio-codec {
-			#sound-dai-cells = <1>;
-			interrupts-extended = <&cpcap 9 0>, <&cpcap 10 0>;
-			interrupt-names = "hs", "mb2";
-
-			/* HiFi */
-			port@0 {
-				endpoint {
-					remote-endpoint = <&cpu_dai1>;
-				};
-			};
-
-			/* Voice */
-			port@1 {
-				endpoint {
-					remote-endpoint = <&cpu_dai2>;
-				};
-			};
-		};
-	};
-};
-
-- 
2.53.0

