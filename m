Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143523DC878
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456304; cv=none; b=DWDqAO1ByM52vcikOgMWwGW3x3mHnt9T/9hk8kYC5UuEG7fqB5tkxnH7Bxg6SeHNR13OT/etHgUCBzVV8sX+zpjrKdFpFTDuHbiQdlPsUlIzSMjm8axh/EqyuSCyFzHXAu+W+RFFJyd9spjV7vqtdGbWfhevd2ISatcEfcnGEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456304; c=relaxed/simple;
	bh=zaN8t9MuA2z8Pbjwa2ktfzrhBAhbTEWSUIOpy+NHG7k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lZqihaz7sxWnKRhbSoc02hyHpVO8XS/sxTssVQESfVDq7Lz15SwGOOk/67GKh3WKesaTVpbtUhA8ShRcRQsR3c5Cluwa2+8kzpSekCHaZN4gE3PKbKf0a06KuorQv+aQnVD99aOjbSv+M7duOwM3VUQW6MyfwH+etO5aOV3nzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqOfdabw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jny8cL3i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqOfdabw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jny8cL3i"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653186m72388703
	for <linux-input@vger.kernel.org>; Wed, 3 Jun 2026 03:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UFAojcZIrZ7Ry4PJ+gae8k
	ixitwkorhARKnBHVCHXL4=; b=bqOfdabwQTlS0ue1lPIqDZZnM4QTGm8Iy4/e4W
	HC+WmnQN3S//q6KyLRsYtBMtTsMClcHIuRe4HgRHI7rEQrxGwQlYgxAwx3tRQ89D
	LT36bM2iqlyPRYE4XAUIKRx86jGwjGBi0oF5tS9pf5QUZHIN1zfcvNOSe6koijwP
	mXbjQYrwqFJ4HfjE56WjZm7iM0ZLluytz6OojHZ832zCvHSjhX4Oo291qmhAQmvb
	x7vn36jDJ+d7cI7OehAbXKr878NKhDapUAN9jPS9nHJw5BfL1iQfoebrTCo3EPtM
	yuYY3EIS9fZtPYnPQE//dDRKmD9Bed+0k9EvR925KCUQQaOg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabbrd25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 03:11:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b74447so2511734a91.2
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 20:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780456301; x=1781061101; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFAojcZIrZ7Ry4PJ+gae8kixitwkorhARKnBHVCHXL4=;
        b=jny8cL3iXLMXfHDxrXbjeylM3wX/QrrLcYBKiGvFMWW0pk2nBdTf/3KXaQNc8aUgeU
         Nm9ygDVfxGykPcBzGkVMvs/dmIF0/tGpm9O+RWt9un4hqrZaXKkVMXhv89SBEzhBx9FY
         SsCbXu9z3KUFV6FHHr7wk59Bflb83BE9MmKnUy72Np1BtzXMp38eMS7YkpZ6DbXcZBp+
         beKL1uoSVZLvaI75DN3kbyczZ4psh9yn5nRFTzXPVaGOl5RaJw8sVNEp4tKQ+tk6du4k
         7ujYDKzYR3DhfLlRAv4KAU/unxR8q74dVstpCGRjlu3fPioS4/UnwuZytouwLM0cdT4V
         u42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456301; x=1781061101;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFAojcZIrZ7Ry4PJ+gae8kixitwkorhARKnBHVCHXL4=;
        b=s1W+9gTEwNkn30zrIg8hU1B9zIMszdxS5InwDg4ypjhPKmlYM1cSRhAlwwwKvBui+Z
         XZG55ogndk/SS3Vz75NpGZKaLSrQ2RyiKWf+7rwOogpEiPia8tfRdNB/x3Mjnyr65vli
         TLjASC6LUdElz6yqFLakUWSEd/peF3xItpxQ/DYrCwpWIr7aiSrddg8skqnnHT95DZDy
         UgkGyBi9SDaJR3KABai7cJ85LfsBLQFwAk7gR3ltrTAEiZToEASBu7ZidcNu7aErivzX
         7gcrrlUqSUYowED18KwKBaebYQqoLsMr3wYh0N/pQCupqwj2qScWrQiRQb4lG7e53wnP
         hrOA==
X-Forwarded-Encrypted: i=1; AFNElJ99JJB9FKfsRTaWiUPapKJM+H3z7wKxoA9TqDHnnvoMhxEg6M+a9vFf1XIM1A5Jiw4fXhEdgNsWkC4Cqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxioswouizBAfFOvSbqZPrCNLVAOfLX1qwqbmc9mIZW+eu9vfA0
	EIl6UN/nm1vKHkEBZejl57COaTSAz4bR8eHDmxw6ZgAOOND4O53Ir7gqzh0Ds+UIHdFG34IIfNV
	Uq27J6BV+TyIsrzExveBAEAh4kYjsr3jvwM8DCM2yzir3W/63PJbvszCYENdKwOn3Sg==
X-Gm-Gg: Acq92OF1Z5BPUGJAreTtWGdzPvTy8u6SPLwWPutj/kmePzW3hHBraj7j1yW+IyE1Lae
	7M298xx9luAUlATaerEqBOSagh8dzgmg7dnogS6xrBBf5LU5EHeNgghYgFssc2ZYnxuv1ootj0p
	JmogY4hz5nRU7T9XIB1y4rJBdOAJNtBweTjeXShjDKaDFV2Syy2lVtvZnZ2SkhS+EfmzHsIVp/u
	KOD+2DQH4X89tVfMIwulNfjTNGiBGmvs3IIvFCk9gwX6UiGeZFbi0dR+rVFxXToD3WiS6qZszou
	4qNhlTXkEiipPl4dtd77/V09SXZ30shqKn0BeOQStzQPq8LBt+Xdb0mqnLH9sKiWHy+7R0Uw6QS
	SsrJioyDBE5p0xNxmhh7XrccHN1qnBqEaGjeMR32GKATWFqRv
X-Received: by 2002:a17:90b:3eca:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-36e2eeddae0mr1466846a91.4.1780456300641;
        Tue, 02 Jun 2026 20:11:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3eca:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-36e2eeddae0mr1466818a91.4.1780456300115;
        Tue, 02 Jun 2026 20:11:40 -0700 (PDT)
Received: from [10.213.96.151] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a276892sm1269420a91.12.2026.06.02.20.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:11:39 -0700 (PDT)
From: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Subject: [PATCH v3 0/2] arm64: dts: qcom: glymur-crd: Add touchscreen node
 for ft3d81
Date: Wed, 03 Jun 2026 08:41:18 +0530
Message-Id: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFabH2oC/x2NwQrCMBAFf6Xs2YWSag/+ingI2We6YNOym4pS+
 u9GYS5zmdnJYQqna7eT4aWuS2kynDpKUywZrNKcQh/G/hIGjjaPZ5bqnJ+feTNOJhxF2OConFd
 duP7Y0uTJgEKttRoe+v5/bvfj+AJtVz0OdwAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780456295; l=2270;
 i=pradyot.nayak@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=zaN8t9MuA2z8Pbjwa2ktfzrhBAhbTEWSUIOpy+NHG7k=;
 b=Z0ovbeUx68sdPSFWpkLlZ03XjPJcV6Measm4wRx5mV1X98xOi3qHgHS5/sHDBpQ/J3X6FkejP
 22owGnklzJfABbwKZnvoPo27HB/RAAGgcTvrPSIzPM/uMNtB52nQ2gl
X-Developer-Key: i=pradyot.nayak@oss.qualcomm.com; a=ed25519;
 pk=ZAwwH8thDSb6bq4dCgFHWr80BqB7MmUAKogkd9BsiXM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAyNiBTYWx0ZWRfX7ia7IkleTSk/
 +2QoZ4Gc5gqYpRIxf2daE+jiQPiW+WP6gH/Id6V6NScmZyZWdxZoofyTJ/MRB0BsmWfpHk2iSaC
 mjaoZe3wyC/iYdILXh5g/A+Y7LrcodVD6jFTHI6TRUNi+P0AG1uWj5UNP+jQv0Z7gIHSTRlHP6u
 jFPup5nJFsYjskxhF6Gf88hYzV2zqsxCJX4qLWrTZXSY/8GSRlK1LOhLRAj3WfR0jNecR7m0S5Q
 D+KcL4He9P0e0sgSu1oIPnbx8xVaeEYo40wjGXaf6uBOLaZdPBb9U+1xgyi5wKGe96/fcpfyC2I
 eSSseSef7ACbxdVZi3r8GQdu1g7TfvC/SOfpKih+3JrR4SYw0JJoFRx5RyEMUjrq71L0Z7OwCbd
 i2GAOx8phfa6m6yvrnku4VqDDZydxZgmPsg2VLxxTmYfzW9SbyCvdcQNn/zilVxOFt2I/4zHY3n
 atT7P2krZ7BmRiqGvtg==
X-Authority-Analysis: v=2.4 cv=UqZT8ewB c=1 sm=1 tr=0 ts=6a1f9b6d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mZh00jpdjR3KdUHqnqAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: gWAU6ltskQUc7AKx6Gf5GIndYJ6Qh-t2
X-Proofpoint-GUID: gWAU6ltskQUc7AKx6Gf5GIndYJ6Qh-t2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030026

The touchscreen module on Glymur/Mahua CRDs is a ft3d81 chip which, while
hardware-compatible with the ft8112 (same I2C-HID protocol, same
power-on/reset sequencing), requires the reset-gpios line to be
explicitly wired up in the DT. Without it the reset line remains
permanently asserted after a suspend/resume cycle and all subsequent
I2C transactions fail with -ENXIO.

V2 incorrectly used the generic hid-over-i2c binding. V3
takes a cleaner approach: extend the chip-specific focaltech,ft8112
binding to cover the ft3d81 (they share the same driver) and switch
the glymur-crd node to that binding. This removes the dependency on
the hid-over-i2c properties (hid-descr-addr) and aligns the supply
property names (vcc33-supply / vccio-supply) with the binding schema.

v1: https://lore.kernel.org/linux-arm-msm/20260522-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v1-1-c7653924acdc@oss.qualcomm.com/
Changes in v1:
  - Initial submission: add reset-gpios to touchscreen node in glymur-crd.dtsi

v2: https://lore.kernel.org/linux-arm-msm/20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-0-5c333051e5bb@oss.qualcomm.com/
Changes in v2:
  - Add dt-bindings patch to document reset-gpios in hid-over-i2c schema
    (flagged by dtbs_check on v1)
  - No change to the DTS patch itself

Changes in v3:
  - Drop prerequisite-message-id; series is now self-contained
  - Patch 1 (new): add focaltech,ft3d81 to the focaltech,ft8112
    binding compatible enum
  - Patch 2: Added focaltech,ft3d81 Dt suuport which is hardware-compatible with the ft8112

Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
---
Pradyot Kumar Nayak (2):
      dt-bindings: input: focaltech,ft8112: Add focaltech,ft3d81 compatible
      arm64: dts: qcom: glymur-crd: Add FocalTech ft3d81 touchscreen support

 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml | 9 +++++++--
 arch/arm64/boot/dts/qcom/glymur-crd.dts                       | 9 +++++----
 2 files changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen

Best regards,
-- 
Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>

