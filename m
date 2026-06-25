Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57D305687
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352852; cv=none; b=P7OuA1bnfUpT8Hj0lhltl8cpM2RWYh7vbYZxrrtrYfQFYdbEK78s4UGzzkZPVzYXwEtffOT9K5pAQyQZtzkL/eAdXG0L7fEmz0hMbdHP106aAZRbeLyAV/ZWgqrbl8+Yf4HzDDRnDux+a2vZWJFyQFafhGjJ9tploccZQi7EY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352852; c=relaxed/simple;
	bh=WKowj6deeFFVUYYJTisg7eSkaNMHpYJvSdHfSbtjGCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtFIyPpYVO2izglAyuqtXVujljCfOv+eYhtztzppg7J/S6UX5MdZH1cyEEqpGmRpL33Qqq3LYpq9DOQ2Lw9qjWdFf4N+zRbWLEY/MJjaFntRzVF9LcQoPR/v2VVmRXMKccbdLi3n22zl4w/8LMuLr6IgtM1eF7lkQcEsBPi3KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mREU1L3b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ESRFDNgA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mREU1L3b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ESRFDNgA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OLqT5H451089
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wO+E7+0KJdSr8b4hjM6cq0xJgRzBsO+EXsSR8uCCiag=; b=mREU1L3bKFEcuWQZ
	T4EWXSbubTanw41Hvw/Zlzj1lexiIZAgIYMEOvGdD8g+QtvGjnXM77lIuYBQYz8L
	+4XYSCBFxgveIrRQoFC+4NpWELiSC4U2oTnU7B9yOG1XFdhHxwelS8Z0gvkxH8Hi
	ECCG8i73PS1ZfmrSx1s4gSYSwGvuN+Vq/g2hROEwSyrgUYNvh3AzCWS0thowljUt
	iKK5P/5bTlDlMdkJ/c4A7qA6XRq57tMvAG4+erztk+/XS3M0/p5VhmZcwUu31SWb
	cmi+is2t8EyVBml5S0mJJQP5buGfekFzoAzJk5qecjk+Omdpfa762D1otKXOtwaP
	xQWsyw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajn1ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c5b9f6a51so320028eec.1
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782352848; x=1782957648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wO+E7+0KJdSr8b4hjM6cq0xJgRzBsO+EXsSR8uCCiag=;
        b=ESRFDNgAWkcmFRBmkxciY5yapxql/RmGi86ZNRIik2mYG/evArw3g/LeDUNFmPBa5o
         Eqz6RPQ/A93mUb4u3wX4ocWIHPelyEJJM9CkiTvp+tz136aPmoEDFnaTJh/afNBLNoGW
         ZvmMW4+78Ueg2Dj+sok4niZY2gRxJww56xz6S54UlnC63BhXDy7m7m0OfxPPA5huwMPG
         K9Vts8iW2D2BMuhKi/J7cyPVxK3emm6P9CVONOoh5WlYg3tLDCp5cz4IeZGNR0NaQVkk
         pxZTN0junIU7SY7Ttq35l2NFQH7lJCA+TNyvSqOjA6ABaJaURqd/T4BFIIIJpTI446Qq
         mN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782352848; x=1782957648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wO+E7+0KJdSr8b4hjM6cq0xJgRzBsO+EXsSR8uCCiag=;
        b=mLNugaG8JmBr1O1ZzDjqjYxZaKIC+qF+gETe5iFToWZu5AYUoRvPpCdl9cYayd6BuT
         s1JdWQHr0dDMYjkPd5BIqz9oPDfsDoHQIpuHWXcO8X2q86xzP5A2qCTqmNeAnwSkak/U
         qnCPKesaMW50a8OjIjIMix2J6Up776rL2Iid4b1gW/JHgXvkYbwVMM/V51xsTI+SAE8g
         hXGZvoYvOEMW+0vvvakbJ2iILriaWq2CIr2aNK0e/NH8U1lChLitp0/2AxXf/ZBRukdR
         IoXSzw+H8sgWmaCpRS9yeAIkgCxbt61hOfNRfkmWhz/SGdYUOLjMwp4IZhMRIx5qjGYv
         2O9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpjgpJe9kywd13R/M9KxnYWo2xBszWqHO5fbPyf2JpYcNI++vDzoYDHYrBX/Lrz4mqS5Rxm6WH/+47DzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpupJgdPu53RhsnUtgw+cRxRM5v3GXkmyNKmnko49SeoirnK2n
	bfOmzcOOSSjb9xuvZXHSE+f74c3qm41pylUQA4u+KwU5/LnMV4HKSNAXmEOtBrNar4/djT/Ouxa
	9UBoZ50yTcTxCuXY/NN1OheaqT00Oa6sLhlUG+qb8l+7KfZMGBLajcseDqjgsWXhAAg==
X-Gm-Gg: AfdE7cnNZATDciQ9W8K8wozarko/HicRtPmHd6BHO1YcwE1CP9p/f1EIyylcJfgYp8X
	dZXMFnjeiphi54uls7awqrSREdRVA5Pntj8RZquSiToBiJHm55CW9rP1V+sCfuDs1SeZK+mMy/T
	HeDoE0dHh2tKrxcGtXhg5ecx8+yHY+3q04kJIFkT4xkdZWjEVz5XpU0lR7vcO43oqg+9TShu9Gc
	1DKwuImG3YtjzsfG15kdgxCL32LpjMMwiUB8PS1egdRFS0nag/7VLC3CxLehp7BaW4/e1PedVBA
	qfpYTUH4KvXSh0lA8Pek958SfUNEbU6/FKbGL2dx7aUs+kemqTP1sMQeBXOoec4anufrv39sVin
	Hbe6kHiP/PWE5vH+GBlTXwuMoBQT0ax1DdD/KGobeMkCqHjRQ/Lj1T+f3vp/B+3c=
X-Received: by 2002:a05:7300:c01c:20b0:2da:13c6:f27b with SMTP id 5a478bee46e88-30c55537540mr6424935eec.5.1782352847183;
        Wed, 24 Jun 2026 19:00:47 -0700 (PDT)
X-Received: by 2002:a05:7300:c01c:20b0:2da:13c6:f27b with SMTP id 5a478bee46e88-30c55537540mr6424840eec.5.1782352844905;
        Wed, 24 Jun 2026 19:00:44 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afca8sm2933939eec.17.2026.06.24.19.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:00:44 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:00:36 -0700
Subject: [PATCH v2 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-qcom-spmi-haptics-v2-1-b9118e60f3e3@oss.qualcomm.com>
References: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
In-Reply-To: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
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
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782352843; l=6045;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=WKowj6deeFFVUYYJTisg7eSkaNMHpYJvSdHfSbtjGCM=;
 b=nmxjEngup4p/1ZabzZtuqSrdBsPxUxr89aSKWThw7McXLLqENP6Wz8Xv2pao/YvkNaqJKxYnR
 5RNIQw/BE+2A8/8Izgwsww/qJpRH4ohK0DHuvKYLpg2guXXkt3kf5xk
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfX4tgPc7b9W5HR
 XcpXJHbWtcSfF/BHcUl4sBRMNPaRKem/cUZVSE0tJUBOAsfTHZSANm7C9yDDsJwzIacmMewPB1Z
 U/3TOY6qOBVcp7eSQ23ciNNXARMcNSM=
X-Proofpoint-GUID: FvIACj5u3i121tDOBL-tQ-sZqwnzuAOY
X-Proofpoint-ORIG-GUID: FvIACj5u3i121tDOBL-tQ-sZqwnzuAOY
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3c8bd1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=S08N5iZLQJCOTSjAB8kA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfX+/DWqBnC+WXn
 0IY2YD0LguGbwAxCrcLdIaP2FysrGLPzAGSWSbeDNsUO1JUbXFN+uxBVfa221He3fkh1DzxXqqV
 GCgFbQBh7GwzwSB6K/asmbpZ2n8wyBAkL0ruPA2UPCNhyRLGxcRmtkYd6bqUQZvcfnGczpgjZeE
 rpqPjzPdkTLgdZz+80xHHwjA2/vODJ9k/vrlqf2yPlpJ82DPpjpUZ82Y8mNwA4/T1MEM/Vr0ymO
 6McwTKxr70H2oQjDdslqev0IpmPFqGamRPL8lqutaGFFSYlAwApD84P4Ur46EUutunpQjMnsBBX
 lwvJdnrDQIb+uQkAHPo9AMhLuHAZKRqSUiCXIqIc0cbmIXyrY0PY0zTg8vt7t84QEEQien437DP
 SiAcL0bg0CHxRFQ79CgUXCQMSHXzm0wpNkP7FZ4dWJ55xq3YRHEbkPWXQKAhEpKzJ1+4/Pd451g
 Xox3njgLEFq7ZrjzEGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250015

Add binding document for the haptics module inside Qualcomm PMIC
PMIH0108.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 .../bindings/input/qcom,spmi-haptics.yaml          | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
new file mode 100644
index 000000000000..3764c3e113a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
@@ -0,0 +1,132 @@
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
+      defined by lra-period-us and whose peak voltage is defined by vmax-microvolt.
+      The driving amplitude can be scaled in the range [0, 255] via a single
+      register byte.  Hardware-based LRA auto-resonance tracking is enabled by
+      default in this mode, allowing the haptics engine to follow the actual
+      resonant frequency of the LRA and update the driving period accordingly
+      to achieve stronger vibration magnitude.
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
+        period defined in lra-period-us.
+      -- 1/2/3(T_LRA_DIV_2/4/8): each FIFO byte drives a half/quarter/eighth
+        sinusoidal cycle with the period defined in lra-period-us.
+      -- 8/9/10/11/12/13(8KHz/16KHz/24KHz/32KHz/44.1KHz/48KHz): the FIFO
+        data is treated as PCM samples and drives the output with an
+        arbitrarily shaped waveform.  This mode is typically used to define
+        custom driving waveforms for specific vibration effects such as fast
+        attack, crisp brake, etc.
+
+    The drive voltage in FIFO or PAT_MEM mode can exceed the value defined in
+    vmax-mv to achieve a special vibration effect, but the waveform must be
+    short enough to prevent the LRA from being damaged by operating at an
+    overvoltage.
+
+    Also, hardware-based LRA auto-resonance tracking is normally disabled in
+    FIFO or PAT_MEM mode, as these modes are intended to drive arbitrary
+    waveforms that may not follow the resonant frequency; autonomous hardware
+    resonance correction would interfere with the intended output.
+
+properties:
+  compatible:
+    const: qcom,spmi-haptics
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
+      Maximum allowed output driving voltage in microvolts, rounded to the
+      nearest 50,000 uV step. This is the peak driving voltage in DIRECT_PLAY
+      mode, which outputs sinusoidal waveforms. The value should be equal to
+      the square root of 2 times the Vrms voltage of the LRA.
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            compatible = "qcom,spmi-haptics";
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

