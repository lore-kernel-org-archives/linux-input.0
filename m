Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F62DF719
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694163; cv=none; b=nIvwnr0uo5+iNzmpI98K83DP6Hmo+Ied+CwxT1y/V49NUrEpWDXKeRuayFeMC9FGYVljhc03ZNJsNxBIJUPpK13EHgeZ3z108fJI1bE5M6KhfLqqSE32YmH7f3kvqVXHxCkWDo7KSQeIrWkQXLxhSsYI+aNeKug2WJkm4X9OPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694163; c=relaxed/simple;
	bh=J0WyCYNudbDkep66LezhAjJxPzWMYml0V4bTjmbw73E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td/hyWW7U7YUgJYWPon93njtKWru0SGXNRTtRVdVEY49VqSnesGBENTmu1Lp0EfBmg9m9lhiteMNIynuh413x7GXO7ZrmZyV5Lg2Zn2y4tb1qY93Tddv1Rj6dZ6LdjbeSohjzqECYXklf6xEBYomiwX/vN9ynaxJksTUiZoKSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NafohgMc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZLFyxNC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NafohgMc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZLFyxNC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UetC1654254
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 11:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Guz5UHflJ3DoWFEEdxnqeNFGkLQOQlrubHs+L7C4cYY=; b=NafohgMcIv76F/a4
	5ayEzGKhYHSSwF+qRdbsKELK4A5EP+aDv3wFBmcBIPFKK5RKi9H4OubhkeP00Kuj
	tZdOTUjWbr3mJiRlT/0fYdj8EDNG9i6Z7xDJldWbqEgsb5mvPPvE8LR9LAz/OYJ8
	7qzPx3b093IA06wSGlip0zApHo2e1DwB1KyYPwdRx4suw7qE9U70co8mj5DDUPzI
	f1ccPWH93ki5YIbh5OIomY9uorBD7UN0VytRD0rbxXiNYFP0KCMLM7OS1rNxf3Uy
	u1etMmP1eTFuK2nlefJcTmk0yTD95YRzuRA3Y/jkQaQ99eUz2sEIRSPWZQNt9vEC
	L417uQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer2qfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 11:02:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422b544a4bso3920150b3a.3
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781694162; x=1782298962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Guz5UHflJ3DoWFEEdxnqeNFGkLQOQlrubHs+L7C4cYY=;
        b=TZLFyxNCUI8JYBPKYXjUIVqgd/xwX3lqlt0aF6EfntAWdOF3pLMKnBJLMc0sPtCVHB
         Mf1Pwa/4iixBhIH84dcdSNRzcjUWPr1iwIma6JaciJVXNLe4CwFW43dg4yiwL2shvcBq
         MD+DeXlGRVa2lof7d2Oi0qIjxxtg7GjWcG1i7IvUk33v2+OJsqJsUJxChzQAuQ+UYLiq
         5WxgT4L13hGn33efZPxQ2GOxstFyx0WZbGW1G/3hBLEEyibPDH2yzwQKQ6hYWPBwAjR6
         QpK1rojEWF9MD7ja3fXbun6NPq7BteUIcEQuAQ0p10nqRJgRl3NFmFvaqb0st/xUi1Xo
         5QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694162; x=1782298962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guz5UHflJ3DoWFEEdxnqeNFGkLQOQlrubHs+L7C4cYY=;
        b=sRrwjjFueMcdB3brnUxrVJAd4vThFuet/LRmYynM0lkwQyNN0+BbqerxXBh2bNvx8g
         GpyAtxBEsMUI1VMDSnn88SnB3zjm05qyKS/RvPtNl3lWInRgdR1z+5lPZUHbcUn1kP7/
         m5cHBFHhFGPtUrKdJ7h2uOABPae3ENyQY7PDHxhe7L8TUCVWAOXUQFXg1iKAkRQVB+3x
         4sT6INQpNGOHJaGIacrjoqclQtrAYyknGxxkoeOFIzoRFtqm5kxHJJYTzrmdpDl+FWra
         BKlVqcUMNxoyiPB4fDZePLN5Qd4k6Z7z+WbOgE4I4/t5xZG+cETKjy5UDwKHjR3QPH1c
         xKqw==
X-Forwarded-Encrypted: i=1; AFNElJ8iGNFYV4MGjqVwNNI3Sm4VfiJ40ox24UFV1uBxt0MzSljP+s1UCvHNdupkjwaN3br40RDx9ukQw+gmdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypqNKJt5hSpCkFbp0gp7/FbW3D8Z4YkgF5KSfoWw8xmi385fns
	LZ7zrPvpMhIJJeQsfgZp3gA5bix9jvWBX+uEYQm5dUYtpP92K6XeX9/b68PvthVS+cA9Lttf9b5
	jdbRypULfc7Xtzy5O+vjeQNjtT6729OQoBsx8CsaSE5aXx723tEb9IwjEuF6GZlAGyw==
X-Gm-Gg: AfdE7cl10HYBwWCHoCNjO2uMcGFDOfzeR6+1rbFi9QQm5UEDaN9zFTxufHi1RRdFjAX
	j/vtbjvRQ3LcVrz6VwpbtAjX7GOrxmb+jKRTLg2UvfGCumynkVuaIV0caJoekGn49wPD0ihuZgp
	l5ClEBmQrffR5Lgmtql6aZqCJG6xbizv5Sg0FTx9L07p25xja3qs76rLdC/mGMvAVULCsKSXFbH
	paJjE5C34WX0a+itvrQTC6I1cHxcDlw/ZE+AHFhTyFEzRVL7ADTg0iaSkDeGgobhf0DF89dwi6o
	FrcLsC6rR+5cT3DUYwMf7V9avfQUiVsfiTNwxVsUPyJbBmzbYh18hcrRSMxAlBCp+lpsP2r0LjN
	nyxUa7R7x/sTAzbCyFCZgdMAkL30c5sBYesAlZ1cE9fUom5FeP954OWbG0E+II4tPjEtuAICDQM
	fkzX6e
X-Received: by 2002:a05:6a00:4510:b0:842:2cda:7a9c with SMTP id d2e1a72fcca58-8452454cd14mr3324085b3a.29.1781694161606;
        Wed, 17 Jun 2026 04:02:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:4510:b0:842:2cda:7a9c with SMTP id d2e1a72fcca58-8452454cd14mr3324050b3a.29.1781694161110;
        Wed, 17 Jun 2026 04:02:41 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf2ac9sm15780135b3a.21.2026.06.17.04.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:02:40 -0700 (PDT)
Message-ID: <c7191868-d141-4095-b703-230237721f28@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 19:02:35 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: input: Add binding for Qualcomm SPMI
 PMIC haptics
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
 <20260617-wakeful-gorilla-of-feminism-75287c@quoll>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260617-wakeful-gorilla-of-feminism-75287c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QYHLcL2vkcwdW29HwWlPedabKhSadXyc
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a327ed2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SMdS_jwxfo_ZY5qVgdUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: QYHLcL2vkcwdW29HwWlPedabKhSadXyc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX5kWDKpitU2H8
 ruTfFtV4snBFhoJzjtBeB9pOHrBNPmXcTbUsFjK5sJbyhKzlp1uYjDOS8Rw161WHNLsJ116/uID
 lRrAzqMmQpO0dKQA4mQiLwJE6013mOY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX1aAOaAd1x0lM
 jUqsf+VqkLdgMfHBleYNryeSR5/Mc9kfkNhBkpd2EIx74DpubTD4dA56jsLZiB1Y1kCIRh133cG
 oUeQ/w3a4euqfVa1ZLvhnRztO0ega4/SpKaRYcM/KcNr/yVEiE+8U/pcXOuQLOhJ3M6DRPMUuyS
 kGL8BtWrqClMfuqV7yFnxCYL4eYpvcTex4L1+KJcZfDEB9FjKtM7J3IyriioI2Q5kq7YmTbz19h
 9mFaJSi4AbR1qRMAruu7sdOceMKaJAG9Tpgx0uIumpXMwpqGp+8O+8VrwKD6q7Mg0Kt5/Dwikdm
 VewTqcqpkABXptvNql2XFCMl65pkqgaPUXaNHCPgn11wp63ei+TqTU0Wg7Uf6s0Sn+4cIBgJQxi
 yIGO1pwBw2jhpz66Ao1p6rOBWa7/qkqxI2IT2pK6oHfmrzMwzOS7fpDHpClZOmZNiYniGeavpvd
 U1Df4qqUEeRTfBMFG3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170104


On 6/17/2026 6:35 PM, Krzysztof Kozlowski wrote:
> On Tue, Jun 16, 2026 at 03:08:24AM -0700, Fenglin Wu wrote:
>> ....
>> +
>> +  qcom,lra-period-us:
>> +    description:
>> +      LRA actuator initial resonance period in microseconds
>> +      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
>> +      rates and the auto-resonance zero-crossing window.
> This does not feel like static characteristic. Isn't period depending on
> intensity of vibration you want to have? Why would that be fixed per
> board?

This period is specifically used for playbacks that require 
auto-resonance to be enabled, which I referred to as "T_LRA-based" and 
"auto-resonance zero-crossing window." It plays a key role in the 
"DIRECT_PLAY" mode, which produces a constant vibration effect. To 
adjust the vibration intensity during this constant effect, the hardware 
does it by scaling the peak voltage of the driver signals, rather than 
changing the frequency.

>> +    minimum: 5
>> +    maximum: 20475
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - qcom,vmax-mv
>> +  - qcom,lra-period-us
>> +
> Best regards,
> Krzysztof
>
