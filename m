Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98375449B13
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083715; cv=none; b=mIMmTcvQtD6GykFwClz0xTQBIR0/qj3ly6q+vWi+wKxTjU95aAdjnGsWIjb2WE+yoXNc0YwI+AxOayk4XhuNAECZJpGTaRjBVrfML8NKuhCSrC8QVnUAr2O89rDW/9qGe+f0r9JB9Ss/8IU945qrXTZIzQGUA+4v9kJ16l5EcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083715; c=relaxed/simple;
	bh=6OpzcuW/vXrBd8EEvVAzR0F/OfZ6uSTpUvNzXmgWi9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnXpIpisbm5jBasNysx+XuLWBWZUHTOxz+4d5SA8rAK7yDLib2B8v88I4tdPL6Rz2YX+fP69XUJ0oYPiWN8TMHDCdKKlBObYcixgOkrfofRg3uOnllBvq19k4WNaLoenFo2SPOSnCflp/7T2+9f0neVZoPvzfzLjEiMwEq/kjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjZVpV8x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMwkVLos; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjZVpV8x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMwkVLos"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Gde33176985
	for <linux-input@vger.kernel.org>; Fri, 7 Aug 2026 06:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=; b=JjZVpV8xGPmPfN5t
	xCbzxn4yJyhcaLhhtF1mxIHkNT0zHnqcq2cNgPQJkLY2LNa5GJqzaupZ1AIHtLCd
	jFw9RkAgG5vieGz9ljCZU97+WqOs2Bitxn3iM0yvTF+P5YKsGqhlHxvM5guaOa/I
	iihilP+B0bD4yPiYCMulC6lqcI5x6XQAiR1DzTA+nQ5f1xrplpjpJjyjbR1O5gyn
	hKCn0pq/ZIevCc20pyN8D023WtKoRBjUCWVxTNEg7cdXdRYqNR3SLhg6HDFA9Hsh
	rK3Qy7KyNPUZs0aZ9TfyI+rKgT27GbBEbeH3EfTXSzVZQsZpuWAgzdAJqNBwlXQN
	VHHKDw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jjfr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 07 Aug 2026 06:21:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so3164351a91.0
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786083712; x=1786688512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=;
        b=eMwkVLos1yVt2mVIBZ2QX2cXEVwABUn8KXEZZzQYFAQUwFfLCJoiOQX2YWmTsYSVp/
         EWGGCGXKF6dKppBUn2nnFv7FDd7jKCQnEb3cTNQcrrlHNLQ199BFW5H6p7KlmDtSG7KT
         GdnYAN1+Eed4zVXYrDa+0JOl8YGBaDpGWm3g2AQ0z7YHYMGphUw5o2c/bk+/PMMEd0m8
         85o5jnt3jwctp/GCXpbjW9x8uMrAGW6S1z+fqpEwMU+ZggiBWIosuohVg3aHY/zFLKJT
         GGMmNbK+O5TdDVDI4pNz1Oel2A9LfZyZ0PRB5sLdQa/lPnQT8mynkzMSmJPKFG608cXz
         yB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083712; x=1786688512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68gUZ7LqB0jU7pBbWZu2QhSNvnpL1hcdM6zSdwGD5Nw=;
        b=n8NR27V4azm05zsTD2qPYvCVwGNXL8srj8bDyhkFrSo360d7r6SgMU8ofNi2LGvs3n
         S/uDB7GoTAhL+ZlEk5cK4pSxNzEHXgNcQYZuY1Bbk8UuDcpBaoJDMbGoSn1VovAmrg+6
         IogOJyUedAjtTZNPYiRFrvQuRRbFhI3UfV+ger/0iVv0f7M6BLbe7Jnuos9LSOr75vE5
         EBwcfx0MV9+fsA8ADXefebTzkODxKX3CQxVejcnZzkso2A4VN5UCS8AM06u3yuTUIGVu
         OqIFR5H+NP8w67dUVh6B9zd5a/ZKFXxUjZsR0sUKZlmQHut+XZQ1gIkD1KpldRcbhF45
         /JdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFrVtjdH1olR0cC00ChDepKebY5N02N1Mfrsb+xOxjd0GE6woWfpSAJ5miTyrDufA3TlGth7jnZbmtvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytp2m1SqxBLMNNEUnmh7ofXyZEuhYwwl3h1my7Yk3U2HL+0ivV
	6BcdKTr9BAnLbCd8B05OavUrCKB6cjGWMM64e8lwDMu6uyp+OulGH1xPfQg8bi91+0Lh7m59+db
	GW5V1EttLiCiUdEmvGzfC5hJqFszDY5s41K79HXDVpestV0ymU9tbbBYXDjswEVhVvw==
X-Gm-Gg: AR+sD13mn77ziqWeamFtipgS2xxwHjxSn2PFVLeBNaL2s4dDfdDgRK+z0kRfqG4fQDm
	ffhy4CroMCVKtYX/WYytWorNDHs+D0da9ovJhEeulN/faRHD5fFfzHG9gCWdOVfIBzfDWE5Y3g4
	/xquXNE1ex9lGnlbOHZNFtswKACkakRW3lYMF2bOSqW2thRcaGPBCZjv5wKl1jNKgDzSbFy3KmB
	obEDviUHmp+26kgpz2L0bqS+1019YrIsdtUyGzMFRIUCH36tN4ZHazX4SfxvD33q0vgyRxbrVH6
	6ZGgm6TAEwg9gAX/K5Gd5mDVP5NeYTfz3oa15pDXiFkQZR45/lxZCBwxUSzXbHw8tWFp8UiztL1
	FoV0otqITMUUSk61UJ+SIXUp0T3tr7PX6Z7uS09FjD8E8D41tQDaF
X-Received: by 2002:a17:90b:3889:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-3903c5cfba2mr17401013a91.18.1786083711777;
        Thu, 06 Aug 2026 23:21:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3889:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-3903c5cfba2mr17400955a91.18.1786083711183;
        Thu, 06 Aug 2026 23:21:51 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24552sm1047301a91.10.2026.08.06.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:21:50 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 23:21:40 -0700
Subject: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
In-Reply-To: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
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
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786083708; l=6327;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=6OpzcuW/vXrBd8EEvVAzR0F/OfZ6uSTpUvNzXmgWi9w=;
 b=QqRFkP1c/s0o92YVjR82g3PQz/jV3JzfqqMozYIUJUIvgiIGXq1VnwqZnjcJV0NLLP69RI51a
 csCnv3C407JBf5aTSDaTWHIoNQcTBYdArTU7yV31t8IKA+cuaaNV0hz
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA0NSBTYWx0ZWRfX4VKcTCYpkmQ2
 ke6VM7Z9hBULW05nCmlqsHgft8c9Rv9TxNxjoIjG+XiSpGkLz7KjhxI8gJME7lJmwYp5F/vyWGz
 9YVxDAubmBqXwnkk2vVbG14gX65sgU+ozwouTDRapPQBhd1gyyCZ5MAqwlWhHUBG+vyCHczGqTV
 679kX2W1u+sakI07iJVSmLJKSqIDHC2HVbWkxFcWccN8b1NsU4OAKJRWmmlebL+ZDQrGvPQPFWS
 ywTbXp1xkT4fubWkZsicsI6DlG0Y3peIB3tdxNVBtVxMFaC+wVcuTa6Y31zNkI+zZ+MKVxumvl3
 KMTQC0rNXs5RlM+w44RSJ1Uu8UX3ZVIEGdImc5ozpTh/B/5xcLzRVJGtt/qb6LqRZAYWUbu+Ukv
 QiPHEet0lF4qTc+CzfjQQSZKvEDs7TXexy0p9nbAtG/Ong0cbDW5vbYr21uVHzi4KKi37eJz9y4
 LlbsDZRIp+f2WHMzYPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA0NSBTYWx0ZWRfX25DNZi0XJHQE
 xArfAp6/ef1fo76namgBXfe83OhwVlqp3ukAgaU8WPqfotWFq2JLJmir7chmgYJRpWvlGNWHMHX
 oRe3KUw4vsOtpKRMxWm2Ooxkc4XbWIo=
X-Proofpoint-ORIG-GUID: NBVdA1SRjLznODRLT9R6zMvX86K4CZkP
X-Proofpoint-GUID: NBVdA1SRjLznODRLT9R6zMvX86K4CZkP
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a757980 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=bI6yuv9Qsz7HNVLwNVgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070045

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

