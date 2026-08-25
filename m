Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBA318B9B
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625571; cv=none; b=m6Q/MgU91EmOIU/IoG8+GlB0cIJpTkbsxHc9DHRyoD12LjEQK073SuV3pwtQUiYXrdFy55ktcQ2HCX+PrS8iY0wJmUv4qf4mgT+alPiWTgq2oWUTLXbPqemhQEAeOwQsN7JcNRyPfTn8mZ9LP/b6QvmK4+auGKDG9ZLQ63r651c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625571; c=relaxed/simple;
	bh=30xKD38o73VXa/hJ0JOvY2xHjIVXoiWOnOPEV1JWW2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpYX9lK159GgYMy1tGxn9VSjECaqCBLMvA38D7pNUDwlbf8GPbGSLMAZDXHHHObJvi2Sf8VEFqdv3u0OrLzbAlYc5ITo0KBTCiULQI98tqNzT1sA6bobP+zxsXDF8IZkZ6pqtqsMH1cDi1qEn21QEKMA4IiwVRbgomGIdiLGJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3iG/7UK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TWCA00AR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3iG/7UK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWCA00AR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R2hG1633778
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqoeoOu+8PfjGTZBzhg+XakMcLe1cSmMdGUV9GViNyg=; b=X3iG/7UKzeiRBoaI
	VmGc2DyxCYAbbvzfXRLabwbVi7hdkpTr5t4X3iJN+Ha+D2LBOXEgTyo/d9egZWfg
	ktzK89fNSq+/1cJuT5Sw1di88WTsPCPOfVKs6O5LZ7uQKEED28Vvq9lkUfcO0lSF
	LmxjnNmnToVBhSm9/S2yuj5N3xcEvTMIIHHCjtrOAYT+ulNawIAw2upjzcYnDwtM
	ocDoNMFefuiNkZSHhsxGC03zL8aNP0lZx6TPmVeQgRjnrtngtbLA2Q3RnBezAUKV
	dOHIwfN5Ib6wfa9dQTIiRSu7ih1gXP06AfihyvOLO3DpQ6/E20L8GTbXxIDUVLXA
	z5cIRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8swr9u49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:39:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so44183275ad.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787625568; x=1788230368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqoeoOu+8PfjGTZBzhg+XakMcLe1cSmMdGUV9GViNyg=;
        b=TWCA00ARyL/C5wIb0qcBv/LIKGlKpQduxIsVihAP0OxyGBDoAVLfDnMWa6sGvsbOmM
         MbelUo2A9dBtNs9NSfe8pQopnRXWBwNzLgpWLiz5wuovv3SXaJcYWflAYTm06vXvJ3v9
         j/55ss+tTqLVEZ+8FAh9X5/ILxzs0NYgjvH4ZzubbswS4/bi6rBkmJR2j5mXtgYud18H
         LLPUUbWg6NbzzZyglHrvI3WoALV3pSNa04Wzzl5WQw1HfeJoC8WYa9tq8SQIffkF2NFA
         l4Cbcf5xgvB9LCKDO1fMQLAG7wQUa+3inrBJBJOfTx/zqCo3T1CGqvaXsyifHOQo30vm
         /Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787625568; x=1788230368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqoeoOu+8PfjGTZBzhg+XakMcLe1cSmMdGUV9GViNyg=;
        b=ZVBcHlkCA7AiZVnQP2ZD6GoGz+PycGXcKA1niwISeAFwXGUBlY7KRVu78txEAdfUva
         Hz2iHPFs1CqkfcQbCqcfRqXQkv+fLj47uOosc/RA5yamsDDxO4FQ0pTBOfRU/gMy/mZU
         H1wt3bUKhv77MpOsAtpLn4GjYIzBcGZqjvxlUhpYixJB+DL3plA4XegOhlCt5imuC4Cv
         dQRkZuBNPXLAei73Nd+SV8YUaUjkUO149CFod0jjUX90kFrJkSrFt/XUna3WG8/uFeLU
         lgUV0XycD/z6UmrFHCY8E8O6gogEHXP+3nj7tupnyjtuSG8oHJ/fywZD05+W/BY3LfIq
         bLdA==
X-Forwarded-Encrypted: i=1; AHgh+RqVd++f2bKu+wrn9zHfAdCh/IgJ6ybZ4Q+y5QncPIeVh79i5YYc9MfXhLaK/kjmdaqFwrNwhyR9r7D/Pg==@vger.kernel.org
X-Gm-Message-State: AFuF++mGrKhJF3LgMyIGNoO85ciqG8NwefRsByQ0HSpGf06GjP6K7Mle
	wjGWqO6jwdi37/Zd6Sne6+l0ZtYpmp3gz/Q66aoa9gsr8uxMxPBEdWP0wGwbpCO0jCge/mI9vXg
	fP+z22lt1a0Rx0TVeHX3riXwcahcaVZU3SqZwlYYJ+Zy9XI5euq8sfcKd5rDFGkpVhA==
X-Gm-Gg: AR+sD11+KqH8/bAdLJBAKbW0GdWY6Iy7djktD9LUycOy9gJj2DyECmtpJI53/3u7RS1
	oK5ZRiKFv3bZ2y2HrbnbGSUs7vAW/KUUK0yqr9JbymB+shF4fSup/H5V30umZ1tIQj4j4Wyw8XY
	DgrsUh9IC3r1GP/JIW6hOqSZXtv3p4BNXDZ2Gtit9kysqhElt2hRtO99pYwjUgorf72VQJeJahr
	tQqoX86fP4rzEvHTP7zEybnPHPJGu+jDp46jNEQ4NANNugboZqpwMexBno8n7ITVU/taNF++zCo
	W7HI4BgvhvEtIXLC2dTu4Y2ayp0aLcb1C/6Qs2ZaVrR/zVaxG8nf1/3fOH2j3Au57NUMxk9usHm
	ifMeSd8HtzScoUlfK3GJ1k/M/eRSMyJxzGnZqGLeBGCSADH5qtBAm3r91gZ6lgIBmLaEr
X-Received: by 2002:a17:90b:4b0a:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-396462ff21fmr5422588a91.1.1787625568402;
        Mon, 24 Aug 2026 19:39:28 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0a:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-396462ff21fmr5422537a91.1.1787625567955;
        Mon, 24 Aug 2026 19:39:27 -0700 (PDT)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39646138f87sm1707105a91.3.2026.08.24.19.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 19:39:27 -0700 (PDT)
Message-ID: <d129ce45-0769-432c-bbc2-76e992325dee@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:39:24 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
 <20260807062927.548EF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260807062927.548EF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TNJ1k9C3CxmJEXV_mlfpN4Ycu-juo-u5
X-Proofpoint-GUID: TNJ1k9C3CxmJEXV_mlfpN4Ycu-juo-u5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyMCBTYWx0ZWRfX75xl9WwsPS+s
 Tigcjcl0iwBAv99wXgE0QmAgJEzefZNFAqI6i75g3nNiiTZxzLqAs2m5C+GRLR0TSRackI4RL5H
 h8fidlXE1q9lIOxpyKNAnNge2c6wE8Y=
X-Authority-Analysis: v=2.4 cv=TqPWQjXh c=1 sm=1 tr=0 ts=6a8d0061 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ED_tUBg3TPI6sqZwEIEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyMCBTYWx0ZWRfX44C9TM/PHYiy
 8cTbpxeb6yTdW+fpvR/VgS91rRnP2Qm1K4RyuV4+FrxQ3FdeszIxt5MHL5n9I7Pe1QGZx+pmjOl
 xdnzuOwaXMX4ER9S+rX1wRZQzxPKttDCaiEpa5R/C87rkO2eYGTIr7HlMI5qhmkskV91SFnhrTB
 6CSsTyfNOaEuz6+43xNe/3oG8VEQUe9MtHTwarkjeaGXVM1iF6CU7bXPRZ9+RHjxyDYpLihAM8Z
 kW7LQ/amd0/oAsHNoa4tUFYMzx7F33PmYU8LzemTx4Gm9P9rQN+nsJ+Hj20mpnR3ujAPJo0HD8+
 qUesw5eokfg1WmLYJpmEIw3F3N4QJDjZmIvML6UvJbO5bhleV4bAGJ8jwYotHBL19NRzHy18k5G
 JetINvUQ+zt5MadomvBuzbLfg89rWyR6Cgrq9T738LLkKKcpJ1c4MWJYeczp+5AnnaZ/p04vb3l
 CUeXJL55rj25+CUdCgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250020



On 8/7/2026 2:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing update to the parent PMIC schema `qcom,spmi-pmic.yaml` to allow the new `qcom,spmi-haptics` child node.
> --
> 
> --- Patch [1]: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics ---
> commit eb446753c24c30e9b557074281da814e0e94aa51
> Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> dt-bindings: input: Add Qualcomm SPMI PMIC haptics
> 
> Adds a device tree binding document for the haptics module inside the
> Qualcomm PMIC PMIH0108, which drives a Linear Resonant Actuator (LRA) and
> supports multiple play modes.
> 
>> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
>> new file mode 100644
>> index 0000000000000..b1a69e9886ee6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> 
> [ ... ]
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pmic {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        haptics@f000 {
>> +            compatible = "qcom,pmih0108-haptics", "qcom,spmi-haptics";
>> +            reg = <0xf000>, <0xf100>;
> 
> [Severity: Low]
> Does the parent PMIC schema (mfd/qcom,spmi-pmic.yaml) need to be updated to
> allow the new qcom,spmi-haptics child node shown in this example?
> 
> The parent PMIC schema has additionalProperties: false and explicitly lists
> allowed child node patterns in patternProperties. Since it does not include
> a pattern for ^haptics@[0-9a-f]+$, will device trees instantiating this
> haptics node fail dtbs_check validation?

The change which adds haptics child node in the spmi-pmic schema has
already been applied, so I dropped it in this series.

https://lore.kernel.org/linux-input/178602255123.2917765.7426706813083510078.b4-ty@b4/

> 
>> +            reg-names = "cfg", "ptn";
>> +            interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "fifo-empty";
>> +
>> +            qcom,vmax-microvolt = <1300000>;
>> +            qcom,lra-period-us = <5880>;
>> +        };
>> +    };
> 

