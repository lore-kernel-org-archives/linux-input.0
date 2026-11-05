Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839744;
	b=LirSsUeJV60HRlmivFIw7sOMxbVlVv3KPy+1b9x9Mq89qdGOA42/9wJ5F760JxtIk6hd
	 /2YQlC8IDLes95mC6En93kVg7MSNi3002RosOcK0U89Ho1CZwQFmZfb0en5jSDW8ZpviD
	 nGrdIX8b/P6GU1jSk6Hn/CNhWSo2Xga1VK3AprA8t5LQKj32j3fq93AhuLR9vGGtm/rzy
	 Wpg0Urcr5b9EPPHpqOyClbelMZybUwXABC80WqDuL6WZ5OKiKHbGG33vhq/33psqbhkN7
	 bDtQKfq6Du0AlxUh4QNV8LNSKEMS6md/6lOQLXeJ1kVZoRdPMVKcjisXrSbXKPVJ4Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839744;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XqAWGD7OCucT8InwBEeCfRvI36YPHr11mO+feKHi2q0=;
	b=DX3+b/N0y+pGCAU/iPERh5n3uc3nOY1yVKcPEhUKPfnT78bW+Kanay7FWQEGJt7pVG7p
	 WYJl7j3Wp2MkMrvWNWi9S4uOIkZbZLPF1ObZ2WRHIVFdHjRN2kZgqkZQySsbAU4zImxmj
	 4Pf8i6RtSYAFdpzHj0xT1wyExvaHjHvyNGrjpMStQknjW9WxoNBvToQWtXEeMD1wPvobM
	 3xAZpvFpuyHgc+I9fF3e/Twg8z+zv3TUkuh0xNmH0wPqPsZZSDZw3kr3riqj2X1qPQktn
	 DKbG9zWeVUvYSOnaGHrejL3qU7iTCOG+HII7Eoq1jeif7kj8cPqzHLAAVRyV3RRmn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mi73K9DP;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5wBzvAc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE606A31B
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 00:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DEE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mi73K9DP;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5wBzvAc
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4M5bFF2210821
	for <linux-input@vger.kernel.org>; Thu, 5 Nov 2026 00:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XqAWGD7OCucT8InwBEeCfRvI36YPHr11mO+feKHi2q0=; b=Mi73K9DPa6E7vBkJ
	bQdUeEsC2XXy5CzNcLHD3Is9EV+IokS2ni3s4O9NDJfPlQC2GyzqrcKzQ9y+nf+0
	j5KXnB86hJEjKK3EHX8U6UDsMb7kIfOjfgk6VRxVgl+2ZZzNG1NBd2nkwOAI9ZAy
	YjsZR8I8Os4w3d0kzitHAUtfKXzVL4cMFwnEPtHw9472SQOA6kJN1qjO7+9OT69u
	9svl8dDf2ba4LBV0i/En4Wpz4gBxNd6+DJPtDVtVEJnhMYiI6mFMEbaBBym0dfJ9
	l2TXtDKFkwIyXBbc6kmu1eR1Pkbj3l7mGogT1thHhQbgEsFdZ8seZvR8x/HyMA1H
	OU/pTw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdtdyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 00:49:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e94f72fb9fso12832585ad.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793839740; x=1794444540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqAWGD7OCucT8InwBEeCfRvI36YPHr11mO+feKHi2q0=;
        b=C5wBzvAc3rZOpG2n9Kas/K1SHBOFInIzHAGLiYaOLMeB8WokpUsDywo08dUuYPP88+
         1txFpS4lZuQJO20FGr+tMGCuR9b27BSE1mmHOTwY0BDzCdsKrj7gqhT3E3kgsWcgQjDq
         cUsY6S5VAkRGLqJmas9uVAW/0g5+vCxZ3+UjPhrrgqUf/A+TNsVDKKy/nWrKgA7QALEQ
         aCnkb+gw88DMxykwr09f/T1g9wHuEpyhBmm1BT3CSikU9VxKq/RPSYxKjvgykMTKXOVo
         5tbVKoWe9JCMCzfx8/pHvJBoQbmVGiwrcDS3nfbVvogvRxWsWVRgFQ4B9UqUjnneNe9E
         wYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839740; x=1794444540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqAWGD7OCucT8InwBEeCfRvI36YPHr11mO+feKHi2q0=;
        b=jbyioWa1QWAHzJ/FDdR/jrdiI0RtEMjaDVFBgv0ckyspweGk+/Es06ShtuEdKHak9A
         qfgcVLXiycPFhB/ppErgAIhIIyMa8WnO08Va1a28oZN+pIaud2dVt9T5GVsqNrE7qILw
         my9RHWbxAzL/xg6cDONSpbgRWsxbPjqvDFDYNDVgLYj4vRDF5dgPlQg+WLMLmjFJAdx1
         J8U716kr5VWV7Lk650VlEHXAQSfIKdhuCurgJS/3eC86V/H2hGN5TTfVbV48sQPoxOJK
         +MAAE3DU3Tn4kP2Eh0KUIRYTybnBAxa1phBDbcI+xFFHfnWWNpFQEeHq1ctauDXDwekC
         MeyA==
X-Forwarded-Encrypted: i=1; AKwUvByQ7hJY4RYTuy/zszUXXWyfXPa425fcR5WIkuh2P4IfKK222nb/TM9aNcw1ITri5zqA/+XiDN1pq0sWVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QFIhOSGY+F6ilRDz2agqtKZrVEqleo8jYUw1rZlCUaVaViF0v
	wMBYoGSBmz7Sp+aPAb7gd7j3k0c2RkyAeBg0eV+pXeXQokAuryL/L/mk3qjmxov22Bl1GuBGAES
	W1kzdzExb63UREdvX9mg/nyCikf9wPmHvKN38/w5zEB2o+/IjLLfroblLqy5eZTg/mA==
X-Gm-Gg: AYBFou3lj8QVHxrT2C/Ceg+V8akw2O2I/c75zPupo5S0li5eMj0SjkuxRnG3hiOAVm+
	l733PrLxBi5SKNLSuKC/QGI3QZOAVFRosF2uVkxr2mT4ou01b0xZod8Adm00cFCFQ4SUEM9QUMN
	WtQBnjjaW26Qig+W2uR4oqbRM+wzP7wSFBm7SgqswAOVLOU7LRd/CIytr19t0OT57T0WUSlPAES
	aUJWyf3JuMg9XqfNzazBs/5fsmpRf3CJWzaIqYUB5S4zyIzkeVWl6+6ApFEhjtaQ5gRPVDaLwbA
	F5BVKcpKAH8V1y4bafyrP1eQSycpdAZ/B0f6OA7oC2c1Y/J5baPsoiAMjTNsR9eBbQ+lkzkQXdb
	n6kFxHriMDZxae8jModIkBORAZTXbhNNn0sz2HlsUKNHB4r7RmvfdTB+g3kp6tvXO+pgEZH8DHw
	==
X-Received: by 2002:a17:902:e5d2:b0:2e9:5175:2eb with SMTP id d9443c01a7336-2eb364024ecmr175302885ad.1.1793839739721;
        Wed, 04 Nov 2026 16:48:59 -0800 (PST)
X-Received: by 2002:a17:902:e5d2:b0:2e9:5175:2eb with SMTP id d9443c01a7336-2eb364024ecmr175302605ad.1.1793839739240;
        Wed, 04 Nov 2026 16:48:59 -0800 (PST)
Received: from [10.239.155.32] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091f35cesm11791855ad.71.2026.11.04.16.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:48:58 -0800 (PST)
Message-ID: <4edbe80d-f1f0-4e85-9973-86da7649e9bf@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 08:48:53 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>
 <20261104-myrtle-kelpie-of-chemistry-de43cf@quoll>
 <6964d550-2ddd-463a-a142-9e8f72588803@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <6964d550-2ddd-463a-a142-9e8f72588803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAwMiBTYWx0ZWRfX7wSjx8E6o+yE
 564/zL/CQtojfr5nR4yeNw+XRiEV3avfi25j0S81/kiN2LUCXzq9Gvie0nTTMrKQauAaXbfnnBc
 +OTtHrWP+Hmmd7VMDyt6XR3adnzjSd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAwMiBTYWx0ZWRfXzFVFKCZ9MSuB
 cYeYH0YSSIh6c4GyvI9Q0ZOfc04ZYsF1gdSa42BnLNwF0UVb+mSBVYflNbbWOdUjC9ejsZ8qVck
 oOMC8k33RjR8aOIwpu6sKkfzHUyDGkGAXG68RuASlosSVkIU1VqPPjbmYskvbP8uVXJ+7NvBI8W
 ckuVtXA1edJpAuwt0W8Zc1U75vi2WYQojZTE9ryOIQx8/8XsYnt6nuAm0KljDLxxhb7VbbqUAmJ
 IL22Cwj919FYolKzwWxa/pviZHTyC46TDlYy8qP87Mw5W64Ux8qEve2p8lH/nRMzxHZHLrRXrzu
 FV2N6sCnS4gZy0r7OLKrAATru0VEkHFTyeHjyul/S/lANkq2ouCcdYDIRYDidCa88deizKHXlOw
 vKqRjv5EWDZfNJAlG5lJIX1oL8NAxa/IOc4HESn6BoHPQHMuXXFv2QSHBmQhphHYAKUW6HE66IQ
 MPHmahitjrzXxZL8nGQ==
X-Proofpoint-ORIG-GUID: MlZktAo-pJjATmkOfwgvOLF8gX2qO_GW
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aebd27c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=DT_BFmYFbp2_FYglL2YA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: MlZktAo-pJjATmkOfwgvOLF8gX2qO_GW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050002



On 11/4/2026 4:44 PM, Krzysztof Kozlowski wrote:
> On 04/11/2026 09:29, Krzysztof Kozlowski wrote:
>> On Tue, Nov 03, 2026 at 08:51:17PM -0800, Fenglin Wu wrote:
>>> Add binding document for the haptics module inside Qualcomm PMIC
>>> PMIH0108.
>>>
>>
>> Why are you ending this? On what sort of ancient, downstream fork are
> 
> s/ending/sending/
> 
>> you working?
>>
>>
>> NAK
> Best regards,
> Krzysztof

What's the concern on sending them? I don't understand.

Thanks
Fenglin

