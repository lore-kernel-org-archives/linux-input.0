Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA303C3437
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273359; cv=none; b=sYUyMpynyyvWtT4b035Z7ta6ePM1KR6NZgEU45Z1nNc/JORfd60rG9t6DbFCcyWrAJIUaZ+/2T3nyB7SpmCGRoY0tm+eU/CZ8iaHMbnKMHHODBrdLy5kcbakwioziKI20jVFYtzj2Pf2ivNLOqjxbA2bLA5GQIEw1cCPab38jzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273359; c=relaxed/simple;
	bh=6OpzcuW/vXrBd8EEvVAzR0F/OfZ6uSTpUvNzXmgWi9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaMuQ5VxFYXvYiVvtoPZHdakt3ghyNOu+SEjm+NXpoloAFNb34mWH97k3VW1Y9dK2OmksynqE+JY+o4zCRXrR1XEJOalKCUsx5awpuwXlMZJmlcGv566Lwp8oMIwhhonoO34qyihYbCFJu+/rZzZpDIX7AyKYtnL0rWVjeReYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYBxCXtY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gpFnaHDW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYBxCXtY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gpFnaHDW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cSZU851577
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=; b=fYBxCXtYZkeNo41o
	uyRZpBnHJ5TxP2jE/HAnBX9qM1DId9iHDawfJvmwAgOE4fog+2uXQaQLYTjU4e/R
	LOauO3m9jfmsO3LgRcgew3DWHKKM9vU8mciy9EtuWWNkj+JkXQmZ4/yfcvHGGvuk
	vgZ7kEq9+IOQ+fntuzl7Tk+l7PKB4Mqd/nyQY0NQHwRvohLC3tSkQRAwQGQ3uAOl
	w/a9ODbuH3zRfUl57NfKgLNd5iM3BoWHw/z3Q1x2SP/X7GkgUDTIvNVdjUnjMEDQ
	/P3wq1NPGctotM+9qbfhJ0BQZAfLZebKkbO4S7vRcdJPBPHbgC0Kw35qXHdRqn38
	ezh8Zw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p86ta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso102572875ad.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784273345; x=1784878145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=;
        b=gpFnaHDW0fludPs3VD5Dq13X1KzIY+xLfdG6k42tJyVYryqCn9C8wx2NL9mipWcVeH
         Zath6vdi2pBLq9C/Fz6gACKKWI/3ReQV2lyDNScn7KxZgLZiV4ATGBbXCVYRIwEeeaY5
         8t4SeG4ih8NlG/ytw1KGQ2LHDrtq3kReCi5DqHb+wl79l/gVADJhJ+pd+PxZGaaNwtBS
         pQvVkyLI1MA3W7NCBDxQgdEQ+kr4M4HFwn1XwxJuwNwCmtBePrmWiM22m9jiNLzYPusI
         Xe3j8ySwh6NebdcozLfDf9gjiNWGMyd55EEYI8SQNt6qpdaaAjLBin90svjarHKw468h
         Ym+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273345; x=1784878145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=;
        b=AATBtw0yU8LRDicaTXw6I7FmLX1ejxNq3GqePPEXLvT6RC7SiIih9rxkIhB5bU/lkR
         HTPbr6vT6QcU34ApKaf5NmQP/Nfa5WlqW+vnA9noAGbOVGGn+6FkgcSC9AdEs3xkZPf2
         YmY2VdJmZV+EkpPvVr26p5wfnzZHU3ZBNU6SbaQzmu9f6a2lO1IZbI1sYSPHKm7ZT8Nm
         qpmSaQWlZpKcNSolwlrC6ibGnR3jv57K9DLO1smstldmlg9WLzEyn+gi9N72dlMe6s9D
         djCZvbKIssC1KEoahTgqcIyh6qBJ50wDHO7vElz5svnDqYoi1/jCzaXGslzojI435fnJ
         k5Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9KTPJAp3i5sburtk+ilqmY3jsiosVLiAdAx413+EDI7nLqFRdpBjwKRBmfNHTaeOOuV7k6azWuEczaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIddFAQ08pK9LpkC1zC7iacxNZd6paB9dGYlYQ4u98H6inbVWh
	UQRWrlJccZIYOw0Y5zqv3DIeiB9wqKBnz2D6jA9xyTwxaKRtxPx/dEKNbO8EAwtXhOQdQ83szqq
	uEKsICk6Ez1mMtrQWNcXDDSm24IQcXoeN8QqhTe6Jw7TWVus3bLwxsReCM6HGLxW2YA==
X-Gm-Gg: AfdE7ckSIY2aT3wba/KZRd8xwjhKq7NCYld2nJnCwyaVf0GvFZMxkXnbA8TjbNjsqjz
	egsykX6MbWNORX2+difhinYaWe9wLslD8zEbmezAlFImrgROaBKc1m2wZf457anSYcvuVvM/QR6
	+Jt1mzCdEaFNplTA4hjCUHlrbnwkg59hZbygOaSAGJvjQy2NeIMPYtRgRHNb6e2bAwIgAEXoFG1
	8pQnoit1yayRShdWExfMTXr3PGrLawv+yYboGxfIMa6R2i8UHjYuRrjJGKqM/Aw2c6yjnvgQ1ga
	GsR60JRMg3PX0hJj+s+F+rAtm6TQoRbm5G6QfTgSIbAObhy5Y+g3A5J/52h2xiNvgcoVf5YvebZ
	KCOA1gG1I2FhLpO7MZx04EbNhGM6ISR5S6Cw3ROuEJo5StFnkFzNN
X-Received: by 2002:a17:903:40cc:b0:2ca:e5c:7fba with SMTP id d9443c01a7336-2cf349f210fmr16115795ad.39.1784273345376;
        Fri, 17 Jul 2026 00:29:05 -0700 (PDT)
X-Received: by 2002:a17:903:40cc:b0:2ca:e5c:7fba with SMTP id d9443c01a7336-2cf349f210fmr16115575ad.39.1784273344902;
        Fri, 17 Jul 2026 00:29:04 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da071sm5724065ad.47.2026.07.17.00.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:29:04 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 00:28:59 -0700
Subject: [PATCH v4 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-qcom-spmi-haptics-v4-1-b0fe0ed30849@oss.qualcomm.com>
References: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
In-Reply-To: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784273341; l=6327;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=6OpzcuW/vXrBd8EEvVAzR0F/OfZ6uSTpUvNzXmgWi9w=;
 b=IJOaTBrSz2TSiz/oZ08xrnlS4x34XLA3wVRdhBIROx29351X1ibEmuT4KXyiABnMl8kxVS4Ls
 FNUTqP4X90EDl4gEdD7BlQrKcCv0ZxqbACv2yYCN+0S1yPCsKaHzPzr
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: A0HUSxzMKdLMaZDg83otvIO2SBdt_d6F
X-Proofpoint-ORIG-GUID: A0HUSxzMKdLMaZDg83otvIO2SBdt_d6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3MyBTYWx0ZWRfXxqc8JJhJbNfw
 pfPzD2B1H7yccGQ35WI390MIBH+mZvLR8cQuAGIOpdn+qUMpZYQCs8B48G5irlBgtqKZb9NjzJJ
 wsmRQGsFFjww6dn275Jc9hSJ4HCPH3PXfcuJMKl/MKKGuxdamLEazKAoBHMrUxq/r375TLQrd/5
 htAvzvq5vlP7Sev+YeaR38o4kRz7nsUnGBoffYEWnywvrCkTMVy0jfpz0NB+LVHNR/DfAo0SSOQ
 XdV7CRyTIH/RIRb1hjkvKVHDBc/pM9RC56d3LNnZN4m1QI1N1DETrih81mIQPPsRRDSYRap9+7v
 wzyesP78syXEAeKNT8a74YXDAJ6/JURgKeqInsueBesD23RQ5ORAPoMINcTCeYoDsjr/46j18Vm
 Q4MCBmOH8hvK32OKQa0O51b/lC0FFvKQLXLvQSiuI8Xt/xDoyXyMhf5famwoYV6ZQfr/kwoZGn2
 AWc3fT5B5pNa3i+RTbA==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a59d9c2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=bI6yuv9Qsz7HNVLwNVgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3MyBTYWx0ZWRfX6Fw9G4f/2CwQ
 I2agUH+tRn6v/KeS+GzGygmLMpGQsM+8wcS30CqkeDX+p/Gowfv21QaHpISkrMH+M6OywtpsNQH
 CuqLsJ9X/55WNsiTWrt7MJr1Oh+W/To=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170073

Add binding document for the haptics module inside Qualcomm PMIC
PMIH0108.

Assisted-by: Claude:claude-4-8-opus
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 .../bindings/input/qcom,spmi-haptics.yaml          | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
new file mode 100644
index 000000000000..b1a69e9886ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,spmi-haptics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Haptics device inside Qualcomm Technologies, Inc. PMIC
+
+maintainers:
+  - Fenglin Wu <fenglin.wu@oss.qualcomm.com>
+
+description: |
+  Certain Qualcomm PMICs integrate a haptics module, such as the HAP530_HV haptics
+  module in the PMIH0108 PMIC, which drives an LRA (Linear Resonant Actuator) with
+  an output voltage up to 10 V. Several play modes are supported in HAP530_HV:
+
+    DIRECT_PLAY: The hardware outputs sinusoidal waveforms whose period is
+      defined by qcom,lra-period-us and whose peak voltage is defined by
+      qcom,vmax-microvolt. The driving amplitude can be scaled in the range
+      [0, 255] via a single register byte.  Hardware-based LRA auto-resonance
+      tracking is enabled by default in this mode, allowing the haptics engine
+      to follow the actual resonant frequency of the LRA and update the driving
+      period accordingly to achieve stronger vibration magnitude.
+
+    FIFO: The hardware can play an arbitrary waveform composed of a sequence
+      of 8-bit samples at a configurable play rate.  Samples are pre-filled
+      into the internal FIFO memory of the haptics module and continuously
+      replenished via the FIFO-empty IRQ until all samples have been played.
+      An 8K-byte FIFO memory bank is available in the HAP530_HV haptics module,
+      shared between the FIFO and PAT_MEM play modes. The memory partition
+      between the two modes is configurable via registers, and FIFO mode always
+      uses the 1st partition starting from offset 0.
+
+    PAT_MEM: This mode is very similar to FIFO streaming mode but without the
+      data refilling capability. It is designed mainly for short, latency-critical
+      vibrations. The memory space for PAT_MEM mode must be reserved for dedicated
+      usage, and the waveform data should be preloaded and remain unchanged
+      thereafter. The haptics module can play the waveform data from the memory
+      region specified by the PAT_MEM play start address and length registers.
+
+    In either FIFO mode or PAT_MEM mode, the following play rates are supported:
+      -- 0(T_LRA): each FIFO byte drives one full sinusoidal cycle with the
+        period defined in qcom,lra-period-us.
+      -- 1/2/3(T_LRA_DIV_2/4/8): each FIFO byte drives a half/quarter/eighth
+        sinusoidal cycle with the period defined in qcom,lra-period-us.
+      -- 4/5/6(T_LRA_X_2/4/8): each FIFO byte drives 2/4/8 sinusoidal cycles
+        with the period defined in qcom,lra-period-us.
+      -- 8/9/10/11/12/13(8KHz/16KHz/24KHz/32KHz/44.1KHz/48KHz): the FIFO
+        data is treated as PCM samples and drives the output with an
+        arbitrarily shaped waveform.  This mode is typically used to define
+        custom driving waveforms for specific vibration effects such as fast
+        attack, crisp brake, etc.
+
+    The drive voltage in FIFO or PAT_MEM mode can exceed the value defined in
+    qcom,vmax-microvolt to achieve a special vibration effect, but the waveform
+    must be short enough to prevent the LRA from being damaged by operating at
+    an overvoltage.
+
+    Also, hardware-based LRA auto-resonance tracking is normally disabled in
+    FIFO or PAT_MEM mode, as these modes are intended to drive arbitrary
+    waveforms that may not follow the resonant frequency; autonomous hardware
+    resonance correction would interfere with the intended output.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,pmih0108-haptics
+      - const: qcom,spmi-haptics
+
+  reg:
+    items:
+      - description: HAP_CFG module base address
+      - description: HAP_PTN module base address
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: ptn
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: fifo-empty
+
+  qcom,vmax-microvolt:
+    description:
+      Maximum allowed output driving voltage in microvolts, must be a multiple
+      of 50,000 uV. This is the peak driving voltage in DIRECT_PLAY mode,
+      which outputs sinusoidal waveforms. The value should be equal to the
+      square root of 2 times the Vrms voltage of the LRA.
+    minimum: 50000
+    maximum: 10000000
+    multipleOf: 50000
+
+  qcom,lra-period-us:
+    description:
+      LRA actuator initial resonance period in microseconds
+      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
+      rates and the auto-resonance zero-crossing window. It could be also used
+      as the initial period if the LRA wants to be driven off resonance.
+    minimum: 5
+    maximum: 20475
+    multipleOf: 5
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - qcom,vmax-microvolt
+  - qcom,lra-period-us
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        haptics@f000 {
+            compatible = "qcom,pmih0108-haptics", "qcom,spmi-haptics";
+            reg = <0xf000>, <0xf100>;
+            reg-names = "cfg", "ptn";
+            interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "fifo-empty";
+
+            qcom,vmax-microvolt = <1300000>;
+            qcom,lra-period-us = <5880>;
+        };
+    };

-- 
2.43.0

