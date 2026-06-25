Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC53A7F4C
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352849; cv=none; b=cQ76nMnXDGQLYx40myEjR9Ns2GOXCxt5o+O/0gdo6c1x2KimR2SJHDVF575LFjzcDjUtiC+IpfZ+cdfpfVZLHkJbeas1WrTdV4NsV6sSRzSE52aBT8B8LpsSLG5piot2/51FygS6VPsuOPBPLcVL4jYPza2dK/GYcg1muoK06pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352849; c=relaxed/simple;
	bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vbxbq2H+ws4ozcKat60GoSg59Dpc2E2VMw0GTm+jFk9sxfT6v9AFMEDIbtvcEzeWMXawqmb86Qi83ReaseNOz+hspbppqV64a6X7YDYDAeSvPPTaJiGJdtFniZ2zpwY+q1wjP/cIvb5PM427ElSadUpy+hJAShN4E+ZRVP7UPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nw94ETJ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eLsZ432E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nw94ETJ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLsZ432E"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OLqcok366646
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=; b=Nw94ETJ+BM4TaZRu
	ZUFmUCB2c69twa3XAWukijHgrqfHzSrgXNxFpf0ppVGssUmjIFd/tcn3/vxj2qJT
	nb7SO+y8GF2YHuoLshphnV1JfCXm3LsQEaRf94gHXBpsBa6zTRLMkrRTkU9bZ7ex
	Xe0l8gHszTwdFZlNS1OKN1/AoFFDS2IMpkkGovXW/cD1oNXXnw63fZUye63JiCdO
	ywL/VyLi+6bUuJfYxgXSjAWM18tHklB42fJL5kWEMG7KgcikSeE4TMw5QojKAxIA
	eDTRKjYp94a+CbkwiZaaGGDDcr6dMIgHfFq5HWQKIERka2q1sL78NvSIfr4FBMvg
	9PLkUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ar515j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 02:00:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c62861b3bso852191eec.0
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782352846; x=1782957646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=eLsZ432EQw8XSbjQVn/Bbh1PqJIeciilEE4gNPpIj3IMP/JWD0cPu7LJ/MaZ6e80UM
         mDmalplnQXI5NIOfjWTmmqwfqGtFAEawNVgeIEK7jj9ei30fvlBwyE+pWOOZmYGRFZCp
         PIC7TiTlsO2u3TJpicGpfdCY9eVU7VcGBKPd9kue0hb5N2Iq0cPApsypifRO6wRszJEe
         6PdL8dEY3p+HF9c8Q9UiGehbwvyOIB8ZBIRSvksy3Y996d6G/Jvet/EPf9jBZa/u0V9C
         V128uI39nWfIBOvnIeYTcMUzyIa6+k6aRXrKhO60qiz83khRhiZSORlxZ+oDlHPFg5mU
         bcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782352846; x=1782957646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ze57ivEQaVhQmk2GKsdaZS8G8SlBGCxdyc/OInFHA+k=;
        b=jNa2YANruIuazjfmm37OUs2hRapaQld+QFSh6ppkxa6CrzMHeVjSSQ36Qml0JaAMdl
         rz9ryqfQ9rwJOtUKnkkozei0FGJ12OIA1nCX9YpgI/BbZcPbS2i/0lJKXpKVCiGv1O4p
         tE274zh3mNmfr7lDihlg0lJTRrAibm20Tb05x1EmgBpehRWCnj/qAv43kFXrOZ61NSAZ
         YQfPyVd34vcNgSTXyE1dhVD3+RDsihwaVBeOoX40UUnj+oVrNPqg/O+h49SKWq0yyUV4
         qsrVeuhiuOVEYF7iSdjmXVMYhpds6qYDCcvNdjbBHdP5TvBVkjBEQr55kc06XyOhL+BN
         379w==
X-Forwarded-Encrypted: i=1; AHgh+RqKY5lJNEXign7KzGRKcPXTn/b9Haa/eMvokqELJht/thj0IlUpOB7Tk+x8twG6vo0FP6vrpdwREXEAFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3E/K9vniIGJt1exYuRQrElnAzewNtgX3oOZ4QDBNh2DJxKqIU
	e9U/0VqKGVDfBzV67nvym/OOR9FexwxQ2RpUlsbNcs4oP5E6K//Ol0gsLHUtzckqtLN4dODFqa5
	y/0q/FcZ37MUB8hhkk+WmqcoIgXDPGlRt2lRcddI671R0LylYFheKD1UTbb+tRKO4Nw==
X-Gm-Gg: AfdE7ckPRsMRG97aT8Rg6BcetgiPTsA/CiDvI1Kf+LBv8vFn4u+a8AXQT5/nylwfSSk
	IxhTidH8PWFodWf5U0BxMDvQpQtYYXpyH5UVOZ8X6WaPFcyKe7t+owPhQI9XVPSUWM0zPzmi+HT
	R/nELJBfOr+6/J89BOAGnfeb/C/TuplAYsYvkklyoZ69Rweqhl7SsYyahzmqC/1/e4L/V0R0o3D
	AIQ0nkcrKV6WTPu5LZixrd0YtqvQrsTkSyaUljhEACD0eOUqTxFWFClYEkM88DTrGAFp68Ovr0Z
	QXPK3tOM2MAYpUuEN7wZudwniu8UWdjaSqGRncDOCN9ryCKYSjEMwOK/LCIysUV1HzuTTJ7o+8t
	z89MoMa2loGnH7eLyWSL5KdxxiCg7mMtyf/eI6pyntMOpEacWjfps72O5Y+jmoZA=
X-Received: by 2002:a05:7300:b586:b0:304:18be:55a5 with SMTP id 5a478bee46e88-30c84d15d55mr618622eec.22.1782352846406;
        Wed, 24 Jun 2026 19:00:46 -0700 (PDT)
X-Received: by 2002:a05:7300:b586:b0:304:18be:55a5 with SMTP id 5a478bee46e88-30c84d15d55mr618584eec.22.1782352845742;
        Wed, 24 Jun 2026 19:00:45 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8afca8sm2933939eec.17.2026.06.24.19.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:00:45 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:00:37 -0700
Subject: [PATCH v2 2/3] dt-bindings: mfd: qcom,spmi-pmic: Document haptics
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-qcom-spmi-haptics-v2-2-b9118e60f3e3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782352843; l=891;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=TwIeX7dWxmVsmvw4YK0bm5xz6TMcOrj4WJjtApbR6H4=;
 b=RWnpqqugPMLb6oMeuWHpmn19vMXUaJk5ZOAwNR/9o9ryQgbsienpos1/5XV4LNqWOHFvmGnZW
 A4o8ziT8+UqCpmYZlno6lb1wOF9Q8udFWf78MAO41Gq/20a8UhWA1Bs
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: XbKQHBRlZ9XdQ5FYO_yZdAPlOLUiT3oS
X-Authority-Analysis: v=2.4 cv=EuLiaycA c=1 sm=1 tr=0 ts=6a3c8bcf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aKV5VrVIVVfq6qmweGsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfX+yxt/tyUhf86
 lhiL+5DCigLePimYO1k+3zcOcVW9sq/d3irpKx9uQWYc3CQOSkdV3Pihpe9XPPDYzpJ3/WWwxvL
 vufe4t5o9Oruv5XIVkD6zYaUNAmX9VI=
X-Proofpoint-GUID: XbKQHBRlZ9XdQ5FYO_yZdAPlOLUiT3oS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxNSBTYWx0ZWRfXwvgUzokXfz+s
 4g4aRXop0TdSen/RrbPRV1mz6d50ZrSDqG/GwVoAVV/pLBA3/WIdzasM/dwe8e2P7fQpIs0yFqT
 W503Cj5HsFWz+olppXLJsm+1locrtQxH/vhJMw2xVrr9t65pRkB2pBTloR3HICLAEF+sNC0srQC
 sedbHhelVa0DVGvAfGXe7wI7P0Bxc4YsAXV5mQz1xofdCmYycHIJnwrvmX3NK7xYUNtn1KFDun2
 3is9gIEVEZmznT3w8yDzxg20+cHJRDDVV3X7tYp6UzcrjK8iLUK46a5LSJp+bGGoNouJc5spUho
 4ElMDvEASJuu4all8xLYDbAB91GG/CBbKYI6FtHTosrBXNmkvMk+5pcVkfxa5hGBPTTzMoDZl2W
 JKYb1ya2HnffOiYRoNo0UbLlWh3/bL6rM4DXqJN5W3EO742l6AfnpZw6icO3x5WdrAIvDvkPuP3
 loBbOWLr3P8CpSACJpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250015

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

