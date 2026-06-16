Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1B426ECF
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604521; cv=none; b=nOPT4TTer/5oIXYxfkZSUcvFlU8H6jK6hLY63EExMNdMGw+DYnSNdtYXoLiZEXvse8K1sTKv9KjSYNqQMU11vtuG8XRKYgJufCibODDHIX7BdHB3fYuhz7gG1s+ObNWdxVEzw+VggtPJ9uqsG5nRvei5BvaqyDRLhchhI2S4Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604521; c=relaxed/simple;
	bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO4e4hbkTkHrFKQm60Gr3nEN7VwJITARHOUqd63vno1oyCk3GYHzpI7GkEYYK56XCkR76wZJy1TrcPzgYapY+skDoSxJfFb+8wnN0C+khv8F/WcjX5VC1Zviu6e2RbGivs3+s869gnteZaKZ34Ko3fWUyrFl2oEpqlw/uZ10Y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TT0eTV02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dh+syixu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TT0eTV02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dh+syixu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G6fW9f2901569
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=; b=TT0eTV02YI+wKWrt
	F8WVVn6H3cP+WvKoZZ2XhLsUfnPL14DoT/IIAQx4NdzLSpptvGHhUdM9ZZrhMs+V
	E0kNuLGXMxuVfswCkXyC2CwWjj+s9RseWu/ltAS4VOuw+XlSFSxfDE0Ie/zWeGmB
	8OuHS4TGtLv32ahY+wEvMIaED6UGEA1k/65inisb6X+iFVVR0uUMXy8jYOy9zo2Z
	cGCdLIlykTzV8BwoLduQYi7+o6aQwlp1VFhG22jzxjaPyJ85bCFz2xdidoBK2nTk
	TtTzU21orUOaXHdFQvmlqtqWskIX1tl+0OVCeOWyDm0moVwBuPpWVx379z325cfJ
	h2li2w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep8u7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304f1820babso6479776eec.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781604518; x=1782209318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=Dh+syixuSLi7bWTwhR28CpNjI0I2nLddv/7a/oz1Sz+eplF9Dd+rMUfSrhpz4LNMDN
         GtTG6xIKAOx9WQoVwz/bP2JUgnaZqFHVmnLOFiOaTKyy6DTY1ZLGeIYK88cPJ86xYCq3
         09WvhWPzf6mhgIYeWfyJHDnPXocu5vbB1SyUyFEcvx/ZWZDFT/hIORdOodPngyjPjFpI
         mCkz8ie3uqyPuwNMVP5cGWqtFJYE7PC/OXYCURQ2hdYiyW0Qu2e23yXxq6zGS6fbCRhB
         +9XNPMn00j9KQACPa0Jx8IqoqcSMQnefzMS1+d0qYLL8dVfuxvmCvTSwccfJQSXmScvH
         l+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604518; x=1782209318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=FJdt5qslGHmkRaDVMb2WueLs69gN4MHQSWZw+gexy8IP4d6zWrlVrSJoaApXGf5kGf
         whx12T7buDk2RXmIc4rr6VapveCY+ZWuXtSE+NA/HyFpYs2dz2ix9fx/cuz6Y+qT+7Q0
         lRLS7DNd/WjHh6WH0WOem6K3J4RlPx0j5BbrJuRHHYdufPp436ZOJZuarndIg8HhoUUA
         IAxYiTNMU9IPTkvtW9a3SqkWIlJ4VALBIIUI0gkcnAsocN3QyNkKOYI4K3aC8X1C0KZF
         4uwp/HoxZdDex1qH4GjtrPsgYokq9KhTRQecmLjVDeU5wyJ1z8xm6xeBWpMKYt5KIwGN
         5vTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9G0wuYrM5mQBQ4uY6mq/NJT+odrgAqVq66ostYjFDQhUwuIjKxE4t2fxK3eF2PbqrmzO2Hz5PBccTgnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+PcSD4ORHvRsVgj85hYnJ2QRcAdpYwH+IuvxDRUALa1wN1Pw
	fjB7PCGvG2+O2WyXRdKmNQWQ2/Lb+eE4ThsyKECiudZJyCG+EP87crdhNqRB6dUqOLYpUOUxf4r
	AuzWLFdusAzZksWL/Z0QcpDVfcRiOpxwE3W3g3qIc1xNfwVPMVq1POq5I4qeVlM7/s7djhxq+sg
	==
X-Gm-Gg: Acq92OEyhguOzei7uUC8QDtj3bxkqTM8U37q8gxW5ui/6fHwck5FZy+NUsoI0sIfDUZ
	7368xXmmbRK+UZ6PvKFXL3WOJ4E9qw1pktEQXHEfi09ao5ITY71qfDR1A8MIIMRTYyHanr7pDRu
	T2wXJWa4aAnbhL2yGY0/Hz2u+ShI1cbBidGXaocM44T16wQu0V8PeJXmT4tum/ZFOoF5AUK8dga
	hHNrIRKUvQMJYEmgUf1GCTIDokiaQ+dfswGXdskHydwd5NBBKTh4U2gywWKYAe53oihRjUP/3WQ
	cXFs5abXHiRMDF73dF7A81N321dJYRio4XmJCcqVWOhVRLvBrb9eg5u02PGlH+PYLD0ZYDaHyDZ
	6LH3zT6L3uqfGxEMeLLBTqENmVMLQttRGGvPp/xPaHRXw9e5h4QwwHphHnW7DHjNaWbS1gKqLFQ
	==
X-Received: by 2002:a05:7301:9e43:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-30ba5fd3dcdmr1724520eec.32.1781604518523;
        Tue, 16 Jun 2026 03:08:38 -0700 (PDT)
X-Received: by 2002:a05:7301:9e43:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-30ba5fd3dcdmr1724494eec.32.1781604518029;
        Tue, 16 Jun 2026 03:08:38 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm18401484eec.5.2026.06.16.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:08:37 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:08:25 -0700
Subject: [PATCH 2/4] dt-bindings: mfd: qcom,spmi-pmic: Document haptics
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-qcom-spmi-haptics-v1-2-d24e422de6b4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781604514; l=891;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
 b=48XWeEtbee33WhaBiCWBr1iE9nVtAOrF+xNAPyMUznrOoUclZfGlbb/r6O7sYp0bkPNWbseQY
 jjCMfJCMSV7B/GB76UKz7DSXNKEQ38JLFRGy5M+yCeINH//5F8pRpVy
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a3120a7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aKV5VrVIVVfq6qmweGsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfXx22+MVWOEhYS
 0N8Zpfy5/Qb+LBrgnPPR7PUeQSEVX40ficzyjxuWHBjCDv6TDFuhdXzKGXUy4svRJVMtthyVjtX
 S1rGPsyW1bFu2w4LO3Xndn/8A6YZAe8=
X-Proofpoint-ORIG-GUID: 8-8SbFhxqcRhwFDUFzrg7dxiK9pmPPon
X-Proofpoint-GUID: 8-8SbFhxqcRhwFDUFzrg7dxiK9pmPPon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfX28/LSr+G2DpL
 8D3HIaHUGLD8jrPJkwTYKczQyMUGl3YtevtTVhYGJheE7VBfSy/+3Erc9sfwWk/F3N3QT1/PQ67
 kD7wSPvYEMH/kxjAEujicdYFLSR/7YHcMgHFApPsmCGYHgeDzR528oV5occkJDCQIG7ByM+3mMY
 x0KD3Gj/WkqVLVw2exesIrL3zG7Wld+9Mw0RcOMCtaULGAUCpgTV0gv6I7PtjCd3y5SLPlJ4+UY
 KMXsGwwLCak/1eNWTMCFJ7gZUeVdXDxbUL6q5iUQ33Uea0gPRO1LIHl+ROIpcozP9bUBD6bdk3H
 bKt5Cj08W6CZDMAyqwi5nzWlBRYyESDyTVgcI8RtzzwZxGbSYE5v22eTyO2sQSKIBVulLXkwWpv
 S4Dr4Lz4kVm+tCxn09FJEtebWWTV4jE6T8kWj+sgFT6cvZmi88dTr7jC91j654kr+Hz/IiOZ+qh
 PxO1Qhn7CC8yeWmLlXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160101

Some of the Qualcomm SPMI PMIC has haptics device in it, add it in the
device list.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 644c42b5e2e5..773f4cba5935 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -165,6 +165,10 @@ patternProperties:
     type: object
     $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
 
+  "^haptics@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/qcom,spmi-haptics.yaml#
+
   "^led-controller@[0-9a-f]+$":
     type: object
     $ref: /schemas/leds/qcom,spmi-flash-led.yaml#

-- 
2.43.0

