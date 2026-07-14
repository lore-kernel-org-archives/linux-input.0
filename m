Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEA325707
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006583; cv=none; b=VwtPYjpbpUh9hEjCnXFWQXnhM5ir39a0bkdLqgq8+RvdNXyWdVvRdx+lICWvE5na4pyLABMb7pPovg8CRgwAmnQT0TYQXuawRKh2lqGq95CxgdrmAQxSUjses4X1AdNrMkggRSu2eSCC3s96pVwKQ7zHNMD8si2xUJGSeTpZ13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006583; c=relaxed/simple;
	bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8jMwptIw/FzJqbmiy/+5VgH5FaI5F840UjJBlA4T/Mq5iBcMM9T7G2pp+SjBqzJ7IOYLTXMpgoJ0FYrKxSaC4xJ7/P4X4O/XxzxQes20bHiBl+DfQzMsdbB2pvP9HnFv2eusWzLhEPDM3ohSo7OuUjiTCL8HerDDrll/tOi6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKH/9fon; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PTGcA01h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKH/9fon";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PTGcA01h"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E38IHC3556879
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=; b=KKH/9fonkBNOVpR1
	rVxgofexQH9l47h7TFO31yeECJe7CMzRyK1uLHjyFsJfcEmv+Cp26pbH/gavqEQS
	67ldic5ysX4YDKZEdhkQBSI53kjdvVf6dyHyeeEF9e6RkoVqFxvv8HYpiPC8QfA0
	K7tbTRl7T6TxkrCoG6nChRoLWZM+dQ2CI3zZ8Ze/vUffDQ7cPEAZQ+wCsg8HRsB0
	88iZQ+hCgl45a5WDa3v5zZjsvjDb9bm4wszCHDUeMLkk4vMzIueN9+DLySpqh/dP
	UvMu6+x6YAOaxIkcUULZhfRGKFGSONnEf7TRCfwoNEnVoiPq8mVwtjxVdD+ad0C3
	uTGdCg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ct3e8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:23:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so7060985ad.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784006581; x=1784611381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=PTGcA01hXiHuKtntGxGSWVIXdR8iriuyiRzZTMEkMidTrmgwyhfVzo92QHqKeToUfC
         3RiPJktnMTeSPYm5uK9unU1cXVLVKm8N3rxuv+8NSza5PSscEr6JjkemF2vnLCROr8m3
         6xF4eC4/dlulkYNoT8IgM2mejvWjKfhF6ZWMP8FW7X46diKDLP3yu0kZ79RgZnt5wYs4
         YzT+qcwO0ALiJAZJlRaeSUNkGxCQMjf/8gQJ4GuQWorixNsyUBtLHyWOoJqMbXk84LNZ
         csoIuSAqjOTLVM7KQSCYIiF50mw9EcCOmjYnuj2WmERimKR/JHDhAx0caBw+Tn6sxxp9
         IC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784006581; x=1784611381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=tXcgvKJSSsxrUB24GG00EZ1QBDqv5fBzD4kjMP9g/ETbrXg08Ff0aqOuHY5zZSTS3p
         IXDoD1tRWRZPQB9Jf3psxca9ILdYuQigKdizCd7PaNiRIy1vBVHTRyvw8rYuiTr40lLi
         tPxJQy7rUMuHf66emK85xYg9c23Apvnt264oxSZBoJx8P6Tita4757hLSCe+k2rVjDQC
         HN6OtxJ1VlHQzQSCIOmc1FhCbNurAF9yz7iQ/EmP7UUargJLoqChrJ8DP+MZR4V3uGfE
         88oWkofNkzRE+fHHlIMhFBKf0NnKOC2k82xIkjgp22XN+MhzVf08ouk/q4/Zu7/dtuMg
         vU4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqrgMhJgo0cjLclD27o5RtVs6vtTUPt2BIDkLyxym7bBdJU49Wya4OsUyv8O0HZzm+BBKoYDWP7W6xvng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEa+avHV639jgRSYIE+WIGkE+QxpNVtPuvKEr7zybtL7Z69hN
	8pKevQfXyF5FH5nmKW1+Vo4WzyhSyO7k2UG3o8IlvQqP7HcGRwEtZsSQQeL1gVmczQJrhn+g4bE
	SwxTJc+YOVLk7fuOsblF7lYkksnwuKacH2iYXeGk1U5BHSGE8Utep5V+XTAm7/NJnow==
X-Gm-Gg: AfdE7ckIU4PyRb8ja13JmwKyJPLQwH1g9nr2EXbCME+a0ClOHSUTzDB6SBi1AQukqBv
	hl+kXdD5t8ow6bm702uH85s2/X+EKGUKE3G26+mtP0P2L0xiqiTP8tL9k2hMKNy6jFUch8XL218
	ekSseP9VWVwBfCM1EloaLXYkg75UOlpRypp3wFcRe4qvcfFsG8V0IZ+vFpxf+R/mrlpwK4duMgk
	SPozMJu1/uxV9RH89GIj9yRt+96kfSxRJrTaMDWAqn+CRxq3Pxv4ZMvdf6pnLUC1FE6AkKXajkB
	6+rjorRbUJws+s/vzXZnBiIMLIgjROnSPUDClQU5UbSR1zBHdeYUWUSODS6GSUkvBIm+OQl2D0R
	VTsT6Acew/Mkhj9kfsrfMZztt2wnA4aT9HKR4l3HZfasBgU3V3gGRC9dsHbqVgos=
X-Received: by 2002:a17:90b:224a:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-38dc782c68emr10333553a91.7.1784006581014;
        Mon, 13 Jul 2026 22:23:01 -0700 (PDT)
X-Received: by 2002:a17:90b:224a:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-38dc782c68emr10333515a91.7.1784006580441;
        Mon, 13 Jul 2026 22:23:00 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm78609864eec.30.2026.07.13.22.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:22:59 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:22:55 -0700
Subject: [PATCH v3 2/3] dt-bindings: mfd: qcom,spmi-pmic: Document haptics
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-spmi-haptics-v3-2-c931bb7cb94f@oss.qualcomm.com>
References: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784006577; l=891;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
 b=VT59IsmSkwi/GREk6YS6SX2prtA69LcG7Wi16Kl5Nz/EXdWB0alyF11HCyrNxaJ2xAxBj0e3c
 WBvKb6enjz4DUycA1Uw5oKGokzg62MzZFziM5BXM6YGasVjT+JA6JhS
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: VBnD3h4gaoeKeFdbLhNuPWjcyb1Bdh9G
X-Proofpoint-ORIG-GUID: VBnD3h4gaoeKeFdbLhNuPWjcyb1Bdh9G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1MyBTYWx0ZWRfX4jxAK/iwGqMQ
 7+nHpdKzJcIoZFd0+ecoKflY/98C7rctGt0Q9vlV78SEnRs6uq/r5zRggaGTbEVghePf8vt6Was
 vn9IsmNF3u4lxz6qt/WafQhj6+QmsLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1MyBTYWx0ZWRfXw2clLDr3Uio5
 co3xYqahXHYJXBl1r+BgTN8XmyeMXdRmXjRLv1cw0Dxh58ojj/G9UIVVPk1NiAwzq63BKXqxIsP
 GeuVY4nQtHWV13o9HIORifayny5LaDMdBFtR6ccYHo1ADxvN7BJG/w8rgDbCPzhHkkswYFcWZEr
 CbStN+FUWlPIU4ADiZdYh++X8q+R/3LWvijY5+/+w0tiEQA0PKkPBRK9hokiAS636IA/55Ij2iK
 JrMrvV0pSqqTJU+54gB+SRFTxsSGoVifdqxMxVbmT823YRb53+sq0nei8vTKWGb7sFL9sA0RfdZ
 93bukFKq91cUdEGEtl7yo9evhuvIe+yhrb0gUN2ENpfQs5HaYENXLPo4SXiwUTntm4DGWoQ1DnD
 RMdU/KtjuTXZAR49UIuIlOuKfQZ3JTyF8n81QHyWG62rZ+0sq3RNv9Kytf7Sxn7wOfgUCc9igH5
 O7fwTManomiSckVfmHA==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55c7b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=aKV5VrVIVVfq6qmweGsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140053

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

