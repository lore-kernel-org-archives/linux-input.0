Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833863D8117
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456308; cv=none; b=hc2BPKvwPugaEAzxMgOgldPBuR81MPJCg2DG1j4cwshjYZbXvlh7iah0683CgJ8udANMCRlCc1g8a7DI037MCVD8aaJl2Fje/9LV/b+NAdDERN5tmUiPIppCQS4RVgyYzri27Pc3FKUWcfyiNNpQKI9zVb8hxtFinizkTJbX5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456308; c=relaxed/simple;
	bh=JWkMSEdUJC3eIOPoQywgdm6Zs8Dl4vYLdmiv2fnsAQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJplpM5p9ayIGMKnQUh+5KA6LytaInu/wXaRnY/L17f0yrA2DDWeDR+9xX+mG4YhScM0VXVqYxD882jlvzJGHmOXkmYGftEjMgplbAzvrU3g6GraGs03szf8UpB/RSfIB/HXwLQ/oO01OBpMW2/hlSqBja6NLtXTomfepH0o2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4542jOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LkIq4ddq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4542jOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LkIq4ddq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652MjhE71638466
	for <linux-input@vger.kernel.org>; Wed, 3 Jun 2026 03:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mTg/SeZ1Yb69IE/Ax/FKhwDMoiyiFvRNLyas19q7uEg=; b=F4542jOQXrbSGirz
	1QCTZTJBY1CI7vXASr5UamyNclDmq9ncAG6EgMe+q9ZreN5Sm9fH5WtbItqUg7Kr
	IB8EOQNqe6DyjS92mNQEJFwu2QVG1Pc9nLAJYTPJdUGmlcyd6e514PVh7RgeW4cb
	cNOLcEBU2tmYPaW8zQ8Yieti0rqnJooNvr5IlsIuPZ0Wwluu21XvdaNW2OCugINT
	plbrvh8Z2w0Rla+22C07CmTfqFYgh5UtRLLHkCQj3cuxxTQdr+G4DDWzFcoPnhF/
	Km/QRTcnepkj4L62slN8187zWTzoIUdB4bq/0HGN90bP6VNXBy3TB39P3oBz+GvT
	uA2TGg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu1cmfcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 03:11:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so6366492a91.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780456305; x=1781061105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTg/SeZ1Yb69IE/Ax/FKhwDMoiyiFvRNLyas19q7uEg=;
        b=LkIq4ddqIAvV55KMSnJTOybeAa2eWmQDg/S02VK5lvd1xBn46egdN/SmRbvx8xZm0w
         0q1p+QwdPgiPQQsXwPrvz3dT8OcIJ40txGWPIHSEDqQKpNXjCMOIhEzFqReKhxxWObNd
         I/SCMvUInh2CWdcnD9Z1SjSuwU2wLKcxpBmcHnU6f8L0PbHG5hrc9Jy+QImvMPeF6sie
         PTtlSqnX9fK4VX5sD4cWlA0P2Zs85pUkcA9yIPi6c8Ob1sf0g+6NxkxvbravUalxpBfE
         MfsUsSqNvjCoOaDmIn4AeIHRbFzGoFHc7N6/fVW7ZaPisunE0YlGNI53FR4WC6qrfUud
         BwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456305; x=1781061105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTg/SeZ1Yb69IE/Ax/FKhwDMoiyiFvRNLyas19q7uEg=;
        b=LPtLvzbcV6B3d9tppWS+82o8tl13w3cskb6Q4KgW/m8OmjctyoiXsR0D1GNbWNdZns
         RzTJG68o5T6kTN/SqPqL8eYkoaae0DOs+dctvVRvyh6iYHeTjIe9REL9pemhA5aZHwsd
         BbrcXAtxl2q34SQgnie6pSzrLJ/T8fZ2b915ZRRwFvFKN8Ps/NEziuqd2UrTi0RQVtMf
         qtuS7DkF/rb7F0ueCI6II9TeYPLlnmbqka6k2jqSst4fAqLxKkDPmMNWxp83nDesjwPk
         JXCRAZ4qMhsNN8XTS0Mte8l9v7mrBgV3jvDcPfMRybtTWZVbBalRmfXvu0xLfPqGkYyM
         3qQw==
X-Forwarded-Encrypted: i=1; AFNElJ/jX1/zc3KGIt9KbozyjxbqD6ZJFa2bVKfkjNmVPHFJ0MdwaDqudTZ4eWrEnn5aKCk1OTEo62diFzULHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2K7R7dAEY7gJhImmbsuFii3ev0CJN2R1rW7EFw0svBDI4/uD
	DsZETg/V2cLOTAk8+T2BAnjZccwRcLKJE0FASvVMpkTN/BJCZQ+NOdT0sewPVJ+WWNYsBEqyb8s
	JCZluVaVB7iTtCzPOWd9/d+1HoZX6h1FMowldX3WUbJwkXO3nBCFQ5X6QFa2u4PWLSQ==
X-Gm-Gg: Acq92OELB3cs0Uh/qFGsfQk8foBfnG+Nn96S9m+bTVhY8ATtuGHY7Uhno+jld/29P+i
	sjVsg7jEAhFLvo9sOeut/44I0CynA38vPVW9bACx8gxm+AbCc70tVCvXHnogxKLMClxyL9BK+RZ
	YPKgn6lboJ1xHywD+FVbQUYxrdYIRpzpdLWKvoD0Dr1DooYq8MCGrjUN7H25mDY2OIJ8uMBfbvw
	d8rw1NjzH0vqhIzXeQXppLwce6scJFgeW5OyAS2SZ/QfuGt2oQzBCcqrenQ1bW5EIFC3uJVUeYz
	q91XBUWmiZhRnRYurzuWB7GPjp/1ljaajCbSqXcw96xzp07iEck+pXcYKaXkOClierkN3vwF8bE
	as1j5cS2PH3RmfaMUaZ0PRR4b10pXh6cYzPhBcqBBMxBgkhNy
X-Received: by 2002:a17:90a:f947:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-36e2eee0c89mr1476657a91.6.1780456305405;
        Tue, 02 Jun 2026 20:11:45 -0700 (PDT)
X-Received: by 2002:a17:90a:f947:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-36e2eee0c89mr1476615a91.6.1780456304989;
        Tue, 02 Jun 2026 20:11:44 -0700 (PDT)
Received: from [10.213.96.151] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a276892sm1269420a91.12.2026.06.02.20.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:11:44 -0700 (PDT)
From: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 08:41:19 +0530
Subject: [PATCH v3 1/2] dt-bindings: input: focaltech,ft8112: Add
 focaltech,ft3d81 compatible
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-1-3453ef577bcf@oss.qualcomm.com>
References: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
In-Reply-To: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780456295; l=1099;
 i=pradyot.nayak@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=JWkMSEdUJC3eIOPoQywgdm6Zs8Dl4vYLdmiv2fnsAQo=;
 b=cw2uKjwvqFL5f10qoh/zoW5te6N7Ap1mEA8Pi5I4DlkRTSmmb1on3/IMFr7tiOv7eHmoL3/rs
 zGV1lldDeM7CnqZPZlZEeL22ePA7cbzm8IPU8NvNZ88r2jDN4zqjSvl
X-Developer-Key: i=pradyot.nayak@oss.qualcomm.com; a=ed25519;
 pk=ZAwwH8thDSb6bq4dCgFHWr80BqB7MmUAKogkd9BsiXM=
X-Proofpoint-ORIG-GUID: 9_fiePD3eoI6x9jhJvtiKKbbDnybPMVj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAyNiBTYWx0ZWRfX++SYlrj6Q88N
 TwQhO1yuAZTkYpZ9WD7bg1fzCApPMX5eoYjeHR8aoTny3F4KwBOvwuJ+K+nDHitHpWc6nfwqpcN
 ecgX9o1cJFUAu7BbYa5GTINDWyvGr8JMcsoFSTgCKN0twojp0HBuSY18CYxvdCKERh6Uhb0TAuN
 lDTP6i0s6fcZX/aqLVowMjd22ol4AxDfERR4yYCALmKdCDWV0qmmffQl2ryRfER7jl7fDCfo5cJ
 +6ncmq9X1+9OzeWSXQhdx8DlaFwwAcSRv95iLwhQSmX6jq3bxVHWM/fjQn0oCbMef/7eJj2/SBK
 PXwJwRrYXVbWUCvrggGTkxVQqF1OHr4L0rilA5kqkM5qHucC5kSx2LJO6TL76GdC7JQlSu27J/F
 8hrj7/5O+TegoRpOgz/KGglac/WZ+376qwH5bedT/zRR/HDaYGKTvKnr5/D5vRfobaUD3ANpkPZ
 NLpRfo7OMvCz4YTMYQQ==
X-Proofpoint-GUID: 9_fiePD3eoI6x9jhJvtiKKbbDnybPMVj
X-Authority-Analysis: v=2.4 cv=O6IJeh9W c=1 sm=1 tr=0 ts=6a1f9b72 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dn7p_KMudBFJuDJgD_8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030026

The Focaltech ft3d81 is fully compatible with the ft8112 i.e.
it uses the same I2C-HID protocol and the same power-on/reset sequencing,
DT nodes for boards carrying an ft3d81,can therefore bind to the existing
ft8112 driver without any additional changes.

Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
index 197f30b14d45..5ffa1246aba1 100644
--- a/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
+++ b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - focaltech,ft8112
+    oneOf:
+      - items:
+          - enum:
+              - focaltech,ft3d81
+          - const: focaltech,ft8112
+      - enum:
+          - focaltech,ft8112
 
   reg:
     maxItems: 1

-- 
2.43.0

