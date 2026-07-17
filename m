Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E903DEFF8
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289558; cv=none; b=cQCyUjKYMO0j6FLfmmFy8NCkxv7BoNTELKaXZV24Y4rP6tury6HW8OqLSVdifp/Tt197GsrSheFpUCT5OHj/hisGJCwq8mc1awnCasl2zp/eIP1xGUDNwKqnM1+h1W/rW9EIIa9gnF9ZPlyTaALqm834y+pBMipXdky8fZ3HMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289558; c=relaxed/simple;
	bh=zhAF3clxg2d4IEdqvRWULHoq8pWFPYQ8gc/wyjPetms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmH+miovimnV2nsxsuuQcMzeJ5uV0/up8r+5wFp+mZctsozlQvvLCq2jscpFav0n96j5fKNnypC+k0p9VMSavRKzi+W22ZhR60U/z0hBWRhY0Ld3p8BRsvFRb/w/9l7H1ZYXNwktCLC4+LBh7I90bN14Iw+envLsE3F6k6hkv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvDao+J1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LOqLZ5sy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvDao+J1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LOqLZ5sy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HASxsM1632141
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 11:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPUqEZcV6Ndhoz2WcNYj/6S/xhagxfKu+O5tgE0FQ1c=; b=KvDao+J1EEYMfDgj
	X8wgQb1Ga2cq9iQQQSNdzyMHCNPxd/diNFlckqFvOojsG0H3XyMJDH9uwmDjUnpS
	AigFrUvyoV9GPH7X+94YWGf/ZjVrnvSnEzIgFo4kGIV87K4tofQIIbpYA/GXRlU5
	ZJJDA8B9SCs4jGu6ouXPRDsytc6HkLwtUabYIE/Yf536MnpcgKoo1ziJCBRLXceC
	gfAzE5PUAbq8UMZdPRxpxwGuI6FgwgGVPkyy+HP/FYM4BSq7ZLAUvt9VMgGOwcHJ
	+CCqVCijYQ4Hjwib4xGoCDa1ZqfZ++XQRr6rBoBwpfeffLFs1a8991q1m0i6WR9M
	/L5LeA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0usgqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 11:59:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so107320835ad.1
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784289555; x=1784894355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPUqEZcV6Ndhoz2WcNYj/6S/xhagxfKu+O5tgE0FQ1c=;
        b=LOqLZ5syKfaTWSseDXZIb8eEWTJ50LM8H0cAbUz4lp+R08P11GBmVCC4T4WFBYJuch
         O5Bo2pNyDrlSrDCGxHcsNO7gCVo09fWe7vH17R1i7WxxWe4ySKGDyJqlrjzIcRvKeE26
         YMzhpBBYqTXxo4vqZC0SwcmqCkw2/H7dcmDhCyX3i9IK88jLZL0ASpH/9rZ/8KHhO1dn
         pg/s2eGxYZIlEajmq1YyaV31d+zzO+7HSCYfF0uzNG9FUsjqDPWvbQpUYNaM/P9hksKG
         xLondSHP6lWM9y8owndhKJyM3BQUAX7dZsbbj80RVLtYn6LhGeLJsY3Kwb5tiMEroO6o
         w/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289555; x=1784894355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPUqEZcV6Ndhoz2WcNYj/6S/xhagxfKu+O5tgE0FQ1c=;
        b=Z9XwXcKKxDGAp1ydjmbJ/j2HHjfjJvTW1Lb0bhk/126vaRih9KCX80DovEqswd+ir7
         lOp0Vse+dsxCGK0bmGJxRKQpt712M09xIgD4w+euI9MXIKiM4w01LEhAhhvV+e+V+/aE
         5J9PfC8M0H1EzfiCzPS11N8tXzim0xFA7S7Rb609vN9XC5h6qpqwvtWyV+0X3gJqgIFU
         z5moZlO1ZTSBX7X2pJiTw5hmOpBp957SBQy+RFNkQN2xOzTiHTakE/xd0q73gL7Liyz7
         Muo96l0mtUkUjBquou4MOFvYbWRQaWb5hi3+s3XIP71q+K0OsTIkIlNIYHGtiAvabL9y
         A97Q==
X-Forwarded-Encrypted: i=1; AHgh+RraCLrEmO8RCS52Y+aSjxzGLVgDXmJBwfqAdtwW07N+nlJi71FzY33AExQf/dfA4flhnXQYIHgzI1aLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHC5mKW+6H9C1whrMNSGH7lyazrp9c+/KhmXWLdC1dEbd2A7Yr
	+a1EFd3W6Cy14H9PYXjqR3yaCM8l671U0n//jmFvzNCRSHTWQIXMagr+lkQbLKCxFXO4zPeG+2n
	Hvr9EnTnPjYYq8+5HxryTDC35kcx/mPcaAwkMulF8VXtDw8V4OGpXfJWu3fJJPeI0l1xVfFqMYg
	==
X-Gm-Gg: AfdE7cmaeaIGdXCHsJioNApRsGOQvJQS5rfHfj1HzRlMwPJXOG2lsnRe9ghlPZeUaj5
	SMmGuZ+gG+8YlZZWDiE5umggn3F/8lx/MxR3lFmDi6/tXVsUGyxJTUuBleWWR04nMkwX6hTYmL8
	d9kWTigZF+9QK7vmRdA421rFSz41uCTOf53GVuN2WHNXgOjCn6VYyidaYShp+JFB43iW+7bKbfz
	NH4X6t6YSoTEAvBbKjHlpdneNDAiAUM81rR2uXkL1LWZaJlOPdB+MVliUZ4bDW0J52ft1+KnF6g
	wbLLa+LHw/Gy+pqoWZE8DD1HgEq5msGdFw9LjVjZZAtY2z6AZlJ+lQm4SbeWzKAscrJQEMlhjnZ
	pb2gZf6Divikf6bFm
X-Received: by 2002:a17:903:a8f:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2cf3485335emr25318685ad.13.1784289554749;
        Fri, 17 Jul 2026 04:59:14 -0700 (PDT)
X-Received: by 2002:a17:903:a8f:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2cf3485335emr25318415ad.13.1784289554299;
        Fri, 17 Jul 2026 04:59:14 -0700 (PDT)
Received: from [10.213.96.151] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da07csm9444305ad.52.2026.07.17.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:59:13 -0700 (PDT)
From: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:28:34 +0530
Subject: [PATCH v4 1/2] dt-bindings: input: focaltech,ft8112: Add
 focaltech,ft3d81 compatible
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-1-5dd091e25801@oss.qualcomm.com>
References: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-0-5dd091e25801@oss.qualcomm.com>
In-Reply-To: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-0-5dd091e25801@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784289543; l=1172;
 i=pradyot.nayak@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=zhAF3clxg2d4IEdqvRWULHoq8pWFPYQ8gc/wyjPetms=;
 b=xMgWkNyP6Z6wk23Hs2Lb7jJeGjb8wLnxlixolqTuG0i8CxVq6jTzTkI4gb+s/UFIvjtL8kkGw
 AuxMub2H2YVAPDcd5VSbiJQFQXSlA071SWDLqRJQoCh1OCC+bKQ1Xxe
X-Developer-Key: i=pradyot.nayak@oss.qualcomm.com; a=ed25519;
 pk=ZAwwH8thDSb6bq4dCgFHWr80BqB7MmUAKogkd9BsiXM=
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a1913 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dn7p_KMudBFJuDJgD_8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyMSBTYWx0ZWRfX0jWDdXgkP0Qr
 UZsWuwzqbfPPf7yl+CnizSfJcz+ic1CQAg/1fzo7lASidVPe0L+qxkH4MlBrqlxM4AS90k6h4pW
 xrt9Jg7qSh+ndJz4ZEhUEgGIRHzOP3gRd7v+Qv0DBDw4NIJydnh3InovGWiyyYdD4lvUx+QKMcF
 t63g/AlO1oWgDY9mb8PoACLAdKDFI/tnJ5CANjMerqxRqb3gpRzqHnOY9lRUxUvnKIlcRLL/AYC
 mMYOjfmcq5SyhN8OT2arj1GukNChs/xQT3teqtCZ3lOMfeTcDD7m8ZtmQnA6W/Emd7r9qqMtge0
 V5NQbWZiP/V3LqX2/K7ij89OHseMYPqPIfZU/paUqgyUMZjck053y3ReOJ9dHnIqc6EoeHgjxgQ
 a7IZirIrXFb1CWZnRUgyA2th/NR4xWOpA6GcE9CzZaFfsNIFZ3yWHKyTG3bA8/rF9R9M1rcy/X6
 O/V8uRnqJnWOWXQwPvw==
X-Proofpoint-ORIG-GUID: dlrSNyjFGbcO1zVKYKKPFfqC32T4e1wL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyMSBTYWx0ZWRfX3TKAtbYaI4z9
 Kjh0w+87KXZv1X77QDeM0c/1z0OaV+xODAcyfLbqarEhivDzgJbbUju3TEt1iVgJkADQ43Gzamj
 rkRkzXXaxBF4ha/dNn/kDDqIbIALZJY=
X-Proofpoint-GUID: dlrSNyjFGbcO1zVKYKKPFfqC32T4e1wL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170121

The Focaltech ft3d81 is fully compatible with the ft8112 i.e.
it uses the same I2C-HID protocol and the same power-on/reset sequencing,
DT nodes for boards carrying an ft3d81,can therefore bind to the existing
ft8112 driver without any additional changes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

