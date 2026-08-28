Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C83F3297
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910596; cv=none; b=AU4zvuldxLC8zMhBIz1bJcwHwHVHxcJFhFdFtAL9xkYF09b8PsgataAnUw16cXaAksWwIX0xEZ0v0rQlnp4RtRaEs7i58AB8BuSIPtnqSC1J3Xjpq4W5Qsz/dv6fdmg0uvmk7oC6udBR3zDNj6Km9wxyJrgwortTI5nl0GEV7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910596; c=relaxed/simple;
	bh=YcJzWuwZ1RPM60Xmk1Fr6v59EnVXQyCH0dMpsNpXZwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQinrC/AYY5QzJ+NmuFcle2XC/l05aJrmD+4BblEfoiMbyXtnTTqu2Z+gY9k/HLRqwxMLIWOa9Kj/Lq/7tLeh/a/Tw1tvOHB1uc4PBnC13UYS0tQkqnW87KF5BRhFTiy0u7rgaLGVONZlv4QAVwNRdtnJX3biTPT199Esb3yzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AtIQ/bsW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ecc9mkSm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AtIQ/bsW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ecc9mkSm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66T6g2761900
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hYYmAr/X6jkEKVI/rUiLckvRRdWrzEQRkaCP6T8C01U=; b=AtIQ/bsWp4n3wEmX
	1y+L3yXaOGP/lQ+xPwRu/e1Zed2KvnRK249wWj0M1s9GmVJ5HeJcSCkkhMpB4/79
	owJVeRS9vwkWbKuCRtyG4VAmuGhodlL5A0iJ039bXbwutvb6K/bOgqPmBMPzj3gf
	dYAoK6C5I/agpX74vm/OQKdgip4lKVxrpMDXroQOB8HXL51h0P7oasl+yV7I8goY
	x2+q2u38jXdNr/iqAmTSgyMJ2cKXparjO6LeS0mObNeFkwnLKb1I+Gfu0ZfwTxRA
	aDbsmV/J22Lm+6C6zGITlhLcrF0meh4+R7l1S0coOrrd7/icBTyyhzTBF9PZZVFC
	UJfJ3Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p90me-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so976610a12.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787910577; x=1788515377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYYmAr/X6jkEKVI/rUiLckvRRdWrzEQRkaCP6T8C01U=;
        b=Ecc9mkSm5+pr0UC/mYybbmN5qm2sDKLivLbOQqktkAOeZTqe/F0y1acQrI/LjlOFCJ
         wEpMbxc7h2kl6lDQFzF26E7OklY3OAPGzwR1X3wrd//c7d8tPLiTdsP2uiMn2TsYt+ma
         F5BSC14SxFvPY9xQcknsgyHO5Dnd5jyQ7QkexliO+OJh6gFzgeCXrE8lLEkMo31mcLAv
         9oXzURH40LIltjcB2xLUQZQSzXyFrq6AGKwjjWwenWTIKy8MS9n42ftS/aFM6UVSFVEF
         Defzy1N3D5lNk51/YlCRe4yiRGksqESxe062e16kB9+djXg8n+Ca4r+cp9B7tn4Lp3NU
         FzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910577; x=1788515377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYYmAr/X6jkEKVI/rUiLckvRRdWrzEQRkaCP6T8C01U=;
        b=giTWkKua+MldQTGKbMed8yFCZVsyrjRzoVl0JgDUD1GpvqVfi71XGFovKiPK/Mfkgp
         EuhEDdeBpL+jckaLKdgDTQx5r+oSg2sslUhDDQr2aU1maXUaoGy9f6fbyf1zifksBYXH
         0uM8PaZvY/4A/uuy5mH0z6WtAmvTFI0z5JyN+p2/7+b7RJ9V8k4PfDPbnArQvK2VcfhA
         Vsx0f7TMGvmgfN2BAE6NjG1VUay7zYKIKXBfOjdkwv53F8HgBhkbkdmOehoKPZlcqfnL
         MqYhO0KwG65u5n2q8Esh/RoW6FXhpRnar4/+SiHwV2D7bmReAHkKdjL79ixbZIBnLeT8
         hYvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKdLUsv/fwcW417jcITx+pxfv+Q64e5NKG7JT1HAxovy97NS15LnR1ODwjMRDR3Hd+UezzGIPbLHjYcA==@vger.kernel.org
X-Gm-Message-State: AFuF++k7PK2Mi6fhT6NZ1bP/inxAEGiSu+eWWuvyZW+L8U31ujmP1ZMR
	q8gdDE/zCTq9o1jaIVQGJvzbF2g6liqk1CU2yJDEdYICNZfLZADGdUwERJW2RZdGfsT8LEzK/v6
	+gGC+xsagmrhKnWMVBCcjTHc/662/MU3jr8DONRWn3AEJu6r7hFUbvZJ7VnP0jiIgJA==
X-Gm-Gg: AR+sD10gpUEY5FPm0pbs9pxrV4nxoE2eU73Ueu7O+Tmi/OoXRK/EZ252gfjrN5EtP83
	Okx9Vgl9cBS6/0fkKSeSZH9lXj6M8AK5KuVo7LB1FeAOnQWyNcav+bqQUUjBu4xDSxFtjuLJyLv
	e0ib3w3TxQsxpkiDFpCLXWcZIoIYniQIVV96XOIb6V0OvrBhpfkeUmuekGJYwOrQRWnh5W8XKbp
	cBdXFZPXxDpd+cFvfk7ralSG/hB1dPTfOjPMcwYb/776czX44jV1FChfSstjkW4vYUtLXANkxUs
	MSb3VU6WvQO5td4jt7xH+jKRlReT6k91Fqhz0tExNibDlAFUSo5ktY3bEQcVnbYUEHq9xq48LiX
	1jGlKVib+x8gtqBPHcppRgH00Y9YpjdXSxzO1OISPt27B6Vs8kbc6
X-Received: by 2002:a05:6a20:db0a:b0:3d0:ba81:79b7 with SMTP id adf61e73a8af0-3d26784f3a8mr12211035637.12.1787910576786;
        Fri, 28 Aug 2026 02:49:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:db0a:b0:3d0:ba81:79b7 with SMTP id adf61e73a8af0-3d26784f3a8mr12210707637.12.1787910574941;
        Fri, 28 Aug 2026 02:49:34 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c57sm4851549eec.4.2026.08.28.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:49:34 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 02:49:19 -0700
Subject: [PATCH v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-qcom-spmi-haptics-v7-1-0367b3ac2e1e@oss.qualcomm.com>
References: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
In-Reply-To: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787910573; l=6461;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=YcJzWuwZ1RPM60Xmk1Fr6v59EnVXQyCH0dMpsNpXZwI=;
 b=K90zooDTYZ589cAtVeKL9aS4swwJGlljOoatZpGEue6YcxFrgVCTUelwbtQ/p7C9g7QCr1hmw
 dOwWvkfzbXpC/vmYQrnY5kv6zRrbZN6IzuY+Rxq0Pz4wprBWHueR4FS
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: dBxDA4p_Y644AwsfBI_sWL8To9_ftIcS
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9159b1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=bI6yuv9Qsz7HNVLwNVgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: dBxDA4p_Y644AwsfBI_sWL8To9_ftIcS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MyBTYWx0ZWRfX3+msGaWb27Oi
 19D8gVRRSPL5lEUWWxAo4IJsWftf9Qs1sMBPAa7tNtvBqk49yWFvoctcSyFlqcbojE7gHxFfclU
 vkq1N4UmuObl/OCdOXHwQSDzNVCsuyg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MyBTYWx0ZWRfX9hKKBzyxVlTM
 XxSgiUAUGKQKODgc7qmvnjNPmK4Kn0l8qlAsWub578NY1VvM6Z84+8Npwf8i2eA2TBDmcXUaJHP
 U/a1F+OKTdKnJQuYQ0COEcuuJE+mTPCdVz8t5LHH2QbEIP1WHjy49kAxHix5zeJnLhPURz1j6TY
 eHOojShYw8D88XGJn9nA3V0kKt1CdtZtk31+Fhdr6M5yQZDAshVGM35Gs5YNjlzin1NiH1hVyxU
 WXy8b1HYkGb3xqe3sWYNoaVseSeICy3cYSCg6FnXAlvvAk+TG/CWgdOBvyzycGismgCOIaEpZ8f
 1ks+Dkx7YTf7CdCWx9iDQjxvItJYPFgUjLoJPDO705X4lgPFI9xF3jBNqB84j/apMoWrCUaFO4P
 SH5wJNX1rVgha6wsGqGDpjs8RXHJeX8r02Zdl17OWNoI61y2wdXHXUVoNkQooQ8eTpv7kR72SmE
 9PPcH3t2HJ1FhHeH9cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280083

Add binding document for the haptics module inside Qualcomm PMIC
PMIH0108.

Assisted-by: Claude:claude-4-8-opus
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 .../bindings/input/qcom,spmi-haptics.yaml          | 139 +++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
new file mode 100644
index 000000000000..ce2c9e893a0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
@@ -0,0 +1,139 @@
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
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@7 {
+        compatible = "qcom,pmih0108", "qcom,spmi-pmic";
+        reg = <0x7 SPMI_USID>;
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

