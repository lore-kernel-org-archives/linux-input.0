Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295A426D39
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604521; cv=none; b=kRLp0KNDn8Z7pGLUroA4X5i6IDFUzd8hJ6UPULsGxtkaFx5c/CQJxQYHh5pVbXyGXhle6dkYkuIyLscsJvrPwM9qbWDSG6F1fTIcbs/V0NrwaqQVDLX4hpQeZ44kpBTgcElyd5v1FZ1je5q9x+IxJglAEjXqrYxjWHUPgY6noI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604521; c=relaxed/simple;
	bh=xcXbiVUbCo1OEDQ4lHPTqD8yyIpF++LPdD4e5tkw35I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDNRYptN+8W6BWi9xfWNtvyGb/qfmdo/8F4tIVVUaCP8BxhR5YMvPPCb4qMlPcDOEZXMGx+5k8B+maOUjFZOM7z/3ZKH7uFFHOdKeQ4uhQJ93cLtILYS5ZORQ7BHo0yV+mQgv6PiUG4iY1t8HIuiGbHUPQKKJKsbdEWbbUu5js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJ/Tt68t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dNfreBSB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJ/Tt68t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dNfreBSB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G65gVL2699680
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p4hdSubR9/EBgDIPi7F1kHMDLKprgVmn2VEkBkC3r90=; b=nJ/Tt68t5uavXKel
	pm/PGCbCbszXN51nlNp/M0OlOidRAjGRtRIIGVcuXxRDXH4mOr1nq651M8DBF4Qj
	71Sd7Szhk1C6SDj1ZZFLr9o/gTZ/9xV5Hi80brSRQ0etRbLLs05T0bLWL1/evDpU
	6bhxLDXA4qarDBzkI+Pi384LS/l5v3r3IYkzUL+ZX8DtigNBYIW9fJ9BlxKvzGQZ
	8iuoG9RDKN3KMw2JWkih6UFfNNFdJCMMzaH0fiFFV1vdMAHuPamByjqrA/2YGQx9
	HoxOIAU6De9TpxXpz/iW8lMorlHjW9+oxcIvnfK05ViqjVbG4CzAyYf7B9xjX0Gh
	r/QO3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09k9640-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304f23c55b2so5322806eec.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781604518; x=1782209318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4hdSubR9/EBgDIPi7F1kHMDLKprgVmn2VEkBkC3r90=;
        b=dNfreBSByfA4dBWFzsYywMimOMm8IuFrFogiTmCE0hb88ZoRzwdVgmq13SostTwJr/
         T6GPB8Rwygb9NJmW7TwXQnRp8y9TRaMtykeuNneeTVMZHdXMTCOK9LXM4DJfimvSix23
         TeKtyhMi/zq/yN5LXTCFK8mmp+crOndbCzrtwo07j7dJY8C0MJEZJpuKwwPK8Fzdwpbs
         2wPUBgN7RW1RPvXXj6Q15Z/XhXuv7Pg2FVWt4xEnVjco2evWncWVROnM/7rcxS7+DXzU
         R1fjBmS6UWy7OE70UqcRzLhFqtpIZSqK2SDpW3RT5xZFCis3s996XfkpGEL7pR8WxSPz
         yzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604518; x=1782209318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4hdSubR9/EBgDIPi7F1kHMDLKprgVmn2VEkBkC3r90=;
        b=lsY++vI/nI0ZEmv3EuGLvcW7X91Uk4VoVvewUMTHhUFbwYOS+kzkTvGn4fL5hYTtmY
         JR0b+yrSyErNcZG/FsD3a+gHqHuOwrJglusDHQSYyr4PtrVRPFgKRKUI9kYRmiuXKfk2
         MjDScq/GXATtzLHrFZfjT+kJUq/P1r+dYVF3r40xZqQ/6fSP4wIC/wyVG6V1RBamy7jc
         MBrfJzpc1kz7VQCz5ogosV9WIcpCl+L/+Ey9SCoFkhSaK3eV873Tbko7hRsbHYnREuvq
         yif2V1UNXH9yD9kOV1ZhRqpYYPU+ODWQ56TI21NbmJk1eYt+cMpO+uWg4m0WnhDm0lDV
         o8Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8nn80uhERl1ytNvPpcV2CotJVOw3rnFre6DTkrAWIcOPdUUseqgodjreOkWJvFuvBoBbpKvrGjFpB7yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fZc82zyZTxcc6dOn0zS81Qy2YxODUk8BtJK1HEDwFs9ui2gV
	qzffQsBLZT7PmU825k/lRj6hQqBtUvfaXFzIOTh6aLdnpS0JRgrjiryNK7ql0s9SJhsUnqvk/49
	pbTImIjie5FEDd7t7NUTm55EE60bYe2xPwTBZi/3oLBxiwfM+Oyn28WCdZHUqgrkpSz/o+rj71w
	==
X-Gm-Gg: Acq92OHc7x3uZjlvwmAIIvazN1S/8rhxBh/Bs0qeig6W708gWets+ciy50+89N/BL75
	2lFSa6Hm79z+BxGyht9IIi2xe3kGzPP/E0fyhBzlpMdkfjkEZyUPWr9TuxsWIhauIkw6qUnC8RZ
	IEBF6p0e4/dOYQ9vI3o89hVFDtLqViObIZzo6OUIKjC9Rj3bji2aBNL055i1fm8fOkBkdsm+KzV
	vMR7/WD600M2ARQdf5uZ1rjaWM37jO/aAYQIwLR7Ypv0NZ8dIWI0kk0+z9B/keY10SnkOj0NuFF
	YZmRUz0o27obo/jKDR4nOXW1q8RuSfUGOmaQOEkkIwr+o2T9IWZKSbQ+YqOvIfRjOdt6E/jJONi
	S4OzZ17muJlvMZqKQtNEf0xIk4ZLhsh+mnPJQTTm2djvK7033Hs0O4BSSwPU66n0emimrPeQaUg
	==
X-Received: by 2002:a05:7300:542:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30ba5fc1526mr1941872eec.29.1781604517527;
        Tue, 16 Jun 2026 03:08:37 -0700 (PDT)
X-Received: by 2002:a05:7300:542:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30ba5fc1526mr1941838eec.29.1781604516991;
        Tue, 16 Jun 2026 03:08:36 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm18401484eec.5.2026.06.16.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:08:36 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:08:24 -0700
Subject: [PATCH 1/4] dt-bindings: input: Add binding for Qualcomm SPMI PMIC
 haptics
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
In-Reply-To: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781604514; l=5192;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=xcXbiVUbCo1OEDQ4lHPTqD8yyIpF++LPdD4e5tkw35I=;
 b=VTDa0vhYlRhNzb+qLgS3SkvvhUIYfDglm1CadbzyU8vIhpZTw4oR8N2T0UXPfiHq1pMgvJpZE
 Dk4Ez3+yVyUCejHdbHOuAC/9gVC8gCNFKaeCIUwX0uHyLvAk8hKmax/
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfXyAa4oysgTQFi
 FnPN1zJF8RkGGcal9NxcTHUQifxhLTbmoJg8zf1QEeN8maENLTv3NFfCPSYH7GSKNs/4x1HmORf
 vtIm2qpT+CsZeJv4BuNEgmW3QPCHKnc=
X-Proofpoint-GUID: HoPAi0Zb5pB3mZk33Xo4LaPOyWaqXDnR
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a3120a6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=e6y1SXZLuqwm2ytIXeIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: HoPAi0Zb5pB3mZk33Xo4LaPOyWaqXDnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfX8bUsImhaq9bt
 hdRGJ1/zUYUInCnsq3rUturcb3J8AnC/fTljJ1+r2jLD5OB4js3VKf6BiRtlB6pokdbicCMdznJ
 Q04bOLz0/mwGmCgNQLvyvdgGp9z+0k27kZCeyThnmQXZNe20JTqHQUi6huef9sB0mjyKSy7UxmA
 7gdVQiFPK7B/L1yHPQTvjOWupeHwWkir32khQ6nsZGcOo+elxHOShXtwzOSk4YvhT0US15kc8Jh
 DlvELcSqvF5OA3Gzl/Cf8u8+MR4tY/BVBCM2PccDFChdXF44gTnKoQC6b+kpbFFRDk1aRxloTBi
 WUFkry6VOQee7DI1SPtXvgG9MPnM7iS21S3uQNX0Vwc0YWg6VOZC5oBbdyamgO64/+b6z/mH/Xb
 h0gZPsxQIaDKUSHeZEYYEbUdo3+p7t6z7FmsBav0nnNC7LoXKLd209IsbWagM+j1d90jELOMfN4
 FdDPMmMYnHXMiX9xDQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160101

Add binding document for the haptics module inside Qualcomm PMIH010X.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 .../bindings/input/qcom,spmi-haptics.yaml          | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
new file mode 100644
index 000000000000..0e26d68563dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,spmi-haptics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Haptics device inside Qualcomm Technologies, Inc. PMIH010X
+
+maintainers:
+  - Fenglin Wu <fenglin.wu@oss.qualcomm.com>
+
+description: |
+  The Qualcomm PMIH010X PMIC integrates a haptics module (HAP530_HV) that
+  drives an LRA (Linear Resonant Actuator) with output voltage up to 10 V.
+  Two play modes are supported:
+
+    DIRECT_PLAY: The hardware outputs sinusoidal waveforms whose period is
+      defined by lra-period-us and whose peak voltage is defined by vmax-mv.
+      The driving amplitude can be scaled in the range [0, 255] via a single
+      register byte.  Hardware-based LRA auto-resonance tracking is enabled by
+      default in this mode, allowing the haptics engine to follow the actual
+      resonant frequency of the LRA and update the driving period accordingly
+      to achieve stronger vibration magnitude.
+
+    FIFO streaming: The hardware can play an arbitrary waveform composed of a
+      sequence of 8-bit samples at a configurable play rate.  Samples are
+      pre-filled into the internal FIFO memory of the haptics module and
+      continuously replenished via the FIFO-empty IRQ until all samples have
+      been played.  The following play rate values are accepted:
+        -- 0(T_LRA): each FIFO byte drives one full sinusoidal cycle with the
+          period defined in lra-period-us.
+        -- 1/2/3(T_LRA_DIV_2/4/8): each FIFO byte drives a half/quarter/eighth
+          sinusoidal cycle with the period defined in lra-period-us.
+        -- 8/9/10/11/12/13(8KHz/16KHz/24KHz/32KHz/44.1KHz/48KHz): the FIFO
+          data is treated as PCM samples and drives the output with an
+          arbitrarily shaped waveform.  This mode is typically used to define
+          custom driving waveforms for specific vibration effects such as fast
+          attack, crisp brake, etc.
+
+      In FIFO streaming mode, hardware-based LRA auto-resonance tracking is
+      disabled by default.  Because this mode is intended to drive arbitrary
+      waveforms that may not follow the resonant frequency, autonomous hardware
+      resonance correction would interfere with the intended output.
+
+      In the driver, FIFO streaming is implemented using an FF_PERIODIC effect
+      with an FF_CUSTOM waveform.  The expected custom data layout is:
+        custom_data[0]   = play rate code (see qcom,wf-play-rate values below)
+        custom_data[1]   = vmax in mV; 0 = use device default (qcom,vmax-mv)
+        custom_data[2..] = signed 8-bit PCM samples (at least one required)
+
+properties:
+  compatible:
+    const: qcom,pmih010x-haptics
+
+  reg:
+    items:
+      - description: HAP_CFG module base address
+      - description: HAP_PTN module base address
+
+  reg-names:
+    items:
+      - const: hap-cfg
+      - const: hap-ptn
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: fifo-empty
+
+  qcom,vmax-mv:
+    description:
+      Maximum allowed output driving voltage in millivolts, rounded to the
+      nearest 50 mV step. This is the peak driving voltage in DIRECT_PLAY mode
+      which outputs sinusoidal waveforms. The value should be equal to the square
+      root of 2 times the Vrms voltage of the LRA.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 50
+    maximum: 10000
+
+  qcom,lra-period-us:
+    description:
+      LRA actuator initial resonance period in microseconds
+      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
+      rates and the auto-resonance zero-crossing window.
+    minimum: 5
+    maximum: 20475
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - qcom,vmax-mv
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
+            compatible = "qcom,pmih010x-haptics";
+            reg = <0xf000>, <0xf100>;
+            reg-names = "hap-cfg", "hap-ptn";
+            interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "fifo-empty";
+
+            qcom,vmax-mv = <1300>;
+            qcom,lra-period-us = <5880>;
+        };
+    };

-- 
2.43.0

