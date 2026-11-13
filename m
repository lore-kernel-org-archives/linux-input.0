Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596887;
	b=qnRsFdxCHKx4SuMHWfQwTTtcdLESc5tPN5Nfk9j7gJhPIQFT0o4AWehALUmpinpBg9xh
	 xMydzUmvaLKTO/xuBzinH/B6aDLRWRXf7+J+VCqILbGB7j2G95iYLWIpdlTe1LFH5D6+x
	 U+aIpMAyegkkblvovLrtV04DfVJYxeFNcQwsYDlwhwLU4ldroI9XWKHWaiTmb2vh3V0O0
	 PjcVoaibOsYFgRkdM/zWw1IT/+tlU8iKWe9YeJtrwDeQAYoi7pNH5C9yMVBjrLgUxH3Ra
	 qLDCI4jlc0T6zAKuF4FPbhZseA2Qv5l4hb0ANBcQae2RrqKuuSSp//xIeYqHUBsrtEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zPNWLhjKegNqxQaf4Psjx+dd7yQ7TNbRuDShVLVRx98=;
	b=0NAJ62F3V9zzG1GzzPdRZ+yW0Getjduc4vuCrRnfqWNiGjq9blWZwWFkKvvkld102deq
	 X+n30LBXdPhAL3u9WSHEfD5aFseNy5SDzFdtmnWluoIHayq2zefu4Lsh0tjXXQPs28yB6
	 Z43jvp4HJ4wasMDpNHL6bOHdCZtehjD7SR1KLg1hDifXtv3zZAYi8CktJU2Cyd8zTjIFv
	 JRCMW07dFDXPgDrGtRxp/F+octSqmXxWGixt6b3R7Eko42Zv37QMSNv1xfvy7NyQdMNth
	 J5JxWrXBNxekMOiDXpePnnalypZkXyEK/EoYFVvChcqIKi63dqe1gj4ndeBJzRLGWYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjs5W4vV;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28F606A332
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB28F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjs5W4vV
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d58c50743so237624366b.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596885; x=1795201685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPNWLhjKegNqxQaf4Psjx+dd7yQ7TNbRuDShVLVRx98=;
        b=jjs5W4vV9yxNmU+QE2tCUze2kH/7ZfdMeuyFa1MHgStzct9g02+R8sfqEjCim9cyuM
         AC1yKwVc1G1mCD/4pv7GKu5AoOw0E8VIupjIxFFy3j690HEx3689Rj60wjUHi1vR2aRi
         NqEfcCAn3jCEV6PYRYcOL0sam+vbWQsvN5d1X4gmwXEUgF/yw6onDGM/67HhcapyWWqM
         NfESJe47JpLtQovD0JOf/QPLp+oqxxONt8TRV2J2/Hen4Kwhi0SHKlE8mo2oFczp3cpc
         UaiSRwK3PgE3CKHMUFC9MWHSUmRcqd1CtoBdIYPeI/2c93vQ07yJxKN7NQIauzpcJUr3
         5AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596885; x=1795201685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPNWLhjKegNqxQaf4Psjx+dd7yQ7TNbRuDShVLVRx98=;
        b=02nrEvc9nsOQUY/0dfLY/UCq2mR2apLr6URO85r6Xj7/CgjV8SrM7I6BSYkeT+gZTG
         8CoCNBGGBIGuQm9oBNCmTirW49UhCjLzTPh9t1J8XI/lInI786zqJAg7oQsWXsUa2x+m
         dc9Y96WuaDghmqsTF7BJo0uyghjvUSFZpD+QDQ7oF3+wSkwEe09x0myd+4H1WRzCh218
         5dl9K2r4J7NX0AU8qP0CAXDmcx+tseJGh/+64mBnzgi/suxzoTT1kGnaW581dbtQbUE0
         9CJQxv/lNjkD9tIKwO7b2J1X5GMDT3qVqc5uCyhWiiAg2odtIo9nH8AiGUEhX3YB0DlA
         cOZw==
X-Forwarded-Encrypted: i=1; AL+hErHoVvr4DJzBu4FNdPVpbnEilnedpFqMnsxsMkzyWzELZze5xagv99Q6+5YVv2Cs+0z92VhN5NWjnVwjJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZLhiwFkZFkesk1Dk+Z29hNz3edWWgnb4lIzc8xmBJNhI0wf69
	TunsRLrx4NgBTrkO65a5s5YIp/GHRyeHMpiH4YcE6eeaZfL/ZXTriAmG
X-Gm-Gg: AYBFou0V8oOmmQ6rCrZ0/8YXCANOFAfx7MhaO4TtG3XWx00oG3LnocyXsuyvt208Kla
	llRHEWA051GKBTpJgxELGnsJlbW43SORuEI80fyA9ACD4nZ+SkI7akEfD2XnGttamFxVHXUT+/U
	1BSsYphg9pgbdJw/NNYGvtB/UA3u/AnPo6Md2wZdExSNIJIRb0mjWPLkcjeiyJhnXWSUvpU7nIM
	d1BPyMOBxnLJ1okY1PpqpRDPkEkFStGZtw4aq0n55lhpgIR++2SLWq1VDknzpg9w3s7SZtucQ1+
	u2r/4YFpeVrjRaCqM24YCb4+aFq5Zbm/QrX883Z43tAky7BvEQSWxxwNp9zKHk/k6vL6gPl6RYP
	EfA0CF+n8RBELgtBWa/thCfpZ0T5hKYTzf71FHhECFeVecy4QrSU9dIu5pHt/60f0lN48R+d1q5
	YYPMLYjdo+67AzXjG2s2+yWjB4w5/cZ6PtaBuFVI9UtxJuJVunbjgIV1ks3cUy5V7QEDOGI+QOt
	GGF+KCZ14RHOr3FBBIPQVtie5H7eEcEkTAWr+b1t0QIYfyOIPrHF6eeAhBxkVBpr0j1eYwEY7UB
	BS5L1jvUj3A7RWdcX6ezWQZ/udVl7aan0evU3Y9OyjtLibEV2dp7jGzYHYCYvqRUjA==
X-Received: by 2002:a17:907:608f:b0:c41:30be:4f84 with SMTP id a640c23a62f3a-c50963dc8a9mr305587366b.9.1794596885147;
        Fri, 13 Nov 2026 11:08:05 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:08:04 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:04 +0300
Subject: [PATCH v2 8/9] arm64: dts: mediatek: Add MT6895 SoC
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
Message-Id: <20261113-initial-mt6895-v2-8-4ab0aa9fa391@gmail.com>
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

Add initial support for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
which has four Cortex-A55 and four Cortex-A78 cores sharing a DynamIQ
cluster with 4 MiB of L3 cache.

Describe the CPUs with their caches, PSCI, the GICv3 interrupt
controller, the CPU and DSU PMUs, the architected timer, the system
timer, the pin controller, two UARTs, the watchdog and the keypad.
There is no clock controller driver for this SoC yet, so the UARTs and
the keypad use a fixed 26 MHz clock, and the system timer a fixed
13 MHz clock derived from it.

Only the CPU and cluster power down idle states are described. The
deeper states that also power down the MCUSYS or the whole system need
the SPM and the vendor low power driver, which aren't supported yet.
The system timer serves as the broadcast timer while the CPUs are in
these states.

The cache geometry was checked against the CCSIDR registers of each
core.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6895.dtsi | 461 +++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6895.dtsi b/arch/arm64/boot/dts/mediatek/mt6895.dtsi
new file mode 100644
index 000000000000..62584cec0f4f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6895.dtsi
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Alexander Letuchiy <asalde.le1@gmail.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "mt6895-pinfunc.h"
+
+/ {
+	compatible = "mediatek,mt6895";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clk13m: clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: clock-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+
+				core5 {
+					cpu = <&cpu5>;
+				};
+
+				core6 {
+					cpu = <&cpu6>;
+				};
+
+				core7 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <380>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <380>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <380>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <380>;
+			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_3>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_4>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_5>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_6>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_7>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cluster_off_b: cluster-off-b {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <250>;
+				min-residency-us = <1900>;
+				arm,psci-suspend-param = <0x01010102>;
+			};
+
+			cluster_off_l: cluster-off-l {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <250>;
+				min-residency-us = <2100>;
+				arm,psci-suspend-param = <0x01010101>;
+			};
+
+			cpu_off_b: cpu-off-b {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <50>;
+				exit-latency-us = <100>;
+				min-residency-us = <1400>;
+				arm,psci-suspend-param = <0x00010002>;
+			};
+
+			cpu_off_l: cpu-off-l {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <50>;
+				exit-latency-us = <100>;
+				min-residency-us = <1600>;
+				arm,psci-suspend-param = <0x00010001>;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_4: l2-cache4 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_5: l2-cache5 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_6: l2-cache6 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_7: l2-cache7 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <4194304>;
+			cache-line-size = <64>;
+			cache-sets = <4096>;
+			cache-unified;
+		};
+	};
+
+	dsu-pmu {
+		compatible = "arm,dsu-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
+		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x0c000000 0 0x40000>,
+			      <0 0x0c040000 0 0x200000>;
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt6895-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11c20000 0 0x1000>,
+			      <0 0x11c30000 0 0x1000>,
+			      <0 0x11c40000 0 0x1000>,
+			      <0 0x11d10000 0 0x1000>,
+			      <0 0x11d30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11d50000 0 0x1000>,
+			      <0 0x11d60000 0 0x1000>,
+			      <0 0x11e10000 0 0x1000>,
+			      <0 0x11ea0000 0 0x1000>,
+			      <0 0x11eb0000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x11f30000 0 0x1000>,
+			      <0 0x11e50000 0 0x1000>,
+			      <0 0x11ce0000 0 0x1000>,
+			      <0 0x11de0000 0 0x1000>,
+			      <0 0x11fe0000 0 0x1000>,
+			      <0 0x1c01e000 0 0x1000>;
+			reg-names = "base", "rm", "rt", "rmm", "bl", "bm", "br",
+				    "brr", "lb", "lm", "rtt", "tr", "tl", "lt",
+				    "eint-w", "eint-e", "eint-s", "eint-n", "eint-c";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 227>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt6895-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		uart1: serial@11002000 {
+			compatible = "mediatek,mt6895-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		watchdog: watchdog@1c007000 {
+			compatible = "mediatek,mt6895-wdt";
+			reg = <0 0x1c007000 0 0x100>;
+		};
+
+		keypad: keypad@1c00e000 {
+			compatible = "mediatek,mt6895-keypad",
+				     "mediatek,mt6779-keypad";
+			reg = <0 0x1c00e000 0 0x1000>;
+			wakeup-source;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING 0>;
+			clocks = <&clk26m>;
+			clock-names = "kpd";
+
+			status = "disabled";
+		};
+
+		systimer: timer@1c011000 {
+			compatible = "mediatek,mt6895-timer",
+				     "mediatek,mt6765-timer";
+			reg = <0 0x1c011000 0 0x1000>;
+			interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk13m>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+};

-- 
2.56.0

