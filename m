Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869013;
	b=iqSN3imErpXE3PVbPlryv+uZ7IT7B6HgDeVADo7DRjBJ9JPIpRcBSladh+Xi2y9phWOp
	 RJwZag+ZBwIyk/tI/GvkGt0sMZC0HqQcnjY5CqTO9Xc3vbHNehCYxnvxLz+pCHd3vjzXK
	 0YZsBjvywC81IgRK2fx9mQbZxw3GNQObPeiYlwSw58rvP+Yy84Lpncgd0RdD3dUPbI9AR
	 YwH3duPmWM0AjWscX8XFijx/wx/Lgjaz1U9OJ77w29jF6rSX/4BsBTIWoxP6J5dH+igfA
	 retXOzaIyBL3XJ7wKPUUF8yP88E4uxhJDuKAFDm0tlV2KJMqM2h9YVrcdzZXsovpfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869013;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ll5HHjmuNho7sSH/k8QiuGBNexPrd5SRjnX5v1inucM=;
	b=fU4GzAFitcCeUqNYs6CoE7U57nnC6UFAB/3zGhN/839sBD089EA0qH2Ir8Xul/MjLr1j
	 y6tcRKcfbu1n+eqwWzbyKlvsBJUCqoD1JVywcQ8rBNuIzgY1IF3uum+q+8yhXusAaA/c3
	 pHKMIcj5+XmARzodn68/r9p3uxRtn7xzhAdBM+augEAb/tyrTcJExkhPFSj3iMMVHp/Jg
	 F/kDtAksumKGkgvdyf1NE8eiD/HFzHbi/B2e9chv+ncb0TTN4nfolqdI9yk12pPq322fC
	 igO7IUbm49uVZa79RagDjlDk4BuiRcRk2wx5KH03CICPcJTKeSgKvpSWA3fA4dZPXgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFGku3p3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXRZPdzS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43B606A33B
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 08:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC43B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFGku3p3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXRZPdzS
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56TomM3223016
	for <linux-input@vger.kernel.org>; Thu, 5 Nov 2026 08:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ll5HHjmuNho7sSH/k8QiuGBNexPrd5SRjnX5v1inucM=; b=cFGku3p3DX77c7Od
	hScyCf6gq+Ionde83X23nIUfLXVdmqqusgQE6NmZFxrGVZChKwXmWMOt+lCCsaCq
	rS5iVlzBCL3W26ai7m4EjDXwmrdC6MRQBbCIKtsEPQsBO3EfISJ8D8ZQNAicSpZv
	FDxFTLxesGz9rGnMQemaytfY88E8g59ck0Z/Zd5ua/V9DPvMdWlmexmYgA6GH1e8
	Nflk1KAdsKYadeBpXAziTw5UuZAf9cSfa+xtYMR1L+lOyi1gGoKBNPpilmUFXRzu
	2FjUKLJrD25/I/2NqfZnYl3gIl9E6ZIGZpxosFpJHcEz4D6HOtzGyBegQu8/BBrA
	YZDWDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h6t7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 08:56:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so1609228a91.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793869011; x=1794473811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ll5HHjmuNho7sSH/k8QiuGBNexPrd5SRjnX5v1inucM=;
        b=LXRZPdzSBk6hG7METAaIvNcKTRuM52N7KGWPG89CSvwRTS5yOR77KVPvYpPijD20IE
         pUH5Aa0tHufuqs/vajUAa35IseanAJ9aqF9Nt0UZt7j+lG1Vur+Q1MjDeDqqVLmhL9Nb
         Bi0c4j/IDEApNQz3NNuE+FK0CwZwTmCTYl7SQXb4w7iKikjufDFoFIUuBffNP2dLubBf
         K27TEOcyc12Oc67libY8ljhtths3DZWi7Dr4BOWRKQEVb3dEqh5YdcZVcPazAsUQW5O5
         RceICo4057hkN+K5jEYWxDVFOCtiQmzlnWG7+kXrq2grI89W7c5E2ZbyXKfVTu/1LfL5
         lpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869011; x=1794473811;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ll5HHjmuNho7sSH/k8QiuGBNexPrd5SRjnX5v1inucM=;
        b=SW7TjA0F1nKs90cn9x9+GPVHYrDOTU1SQx9zg1kr7zwIl+r75blAG51GlY3wybq7q/
         Qtf00IaIwMDrt0HE1StTYe2HxXWc5utHx3d84qak3NO9oxBiqZ0yTOQbsYCJimIN05bF
         KHO58NtEVQSxmeIABKgRC4LiZXnYhnPkhli7Jgaip0RtZa3SFa6LOR55HsZHA3akO2Jf
         RxJKBesuLHWvZ8KmxsOd25aEn0+rBARud5HemXXujhVVxNorbRCRTJxWALjxFIKUMWhV
         0yCSog+T6SP/RWuCSIq0g0c4PHtUdDWskF+IoYd9YoC/NjF1kyzGsuVp8n6rDxt3TU3j
         Fx3w==
X-Forwarded-Encrypted: i=1; AKwUvByIys4ov/RgHNf4ABfDxMw5BybQZKuiLCPsT7j3tT2hQeMLRaTkrVOWjKmXsnHf18yv4dSHkgB1F1h5aQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HpruPUBNd/6bOhMOCkomz9F5SfIf941n0Zne/k6aHEa0QOK4v
	33q71evjiDGkP5WBqljRH61Ggdsxg16C95loNTOJ9bNhaxlx+sIw04MZGVE6jiS42cFiaHIGZc/
	MOLo6bAOiLbgYM0BfVRT/GzuqPT5iVcAfom2c3Nysc3LD5AZn/89s/LKxflDM5J8Z1Q==
X-Gm-Gg: AYBFou1SDTFiKV7tRP0qPcTlyWfbNFkvKmw0uH50NV15Cadtq35DSam0dRJkKZlU48v
	udOMi8tSt47uvdBsQPi3f+zVvclZLCveEQ014xTHrIO1lXEmceSegN8G6PidmdHPtQMs9FsYCcR
	w+yEPuUxn9DL8fk1GKMq0hjqyhc7e/kbfqbJuPdcDGf1sbGQWgTorlazjl45qDuafcOlhdaDtT0
	hHvPY3wd9z6KMuXBoCRhVBFfmqHw4DVGwa7u2t9u7V0VK6dSiv/J7TAvUAU3G47EF1BlKnA4Ca/
	hVebZqo3RhPwGndFL5CNYkKwfdJQlObiFZZnPt24AM8fm7z2W0DIRP8QSSDowH99G4pZE9Q44Wi
	k+B9614AMOhVo5QpPCAZOJGr/oIb56EmCixLUQ03zs91gyITEnnGjfuODzGCtnVktlYuqcPyDgF
	kcgsfNuHFAy8nFBaJS8yUf3CyEhWj8zn8uTQm0pOTJSg==
X-Received: by 2002:a17:90b:33c2:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3ae897e076cmr13614223a91.54.1793869011126;
        Thu, 05 Nov 2026 00:56:51 -0800 (PST)
X-Received: by 2002:a17:90b:33c2:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3ae897e076cmr13614209a91.54.1793869010516;
        Thu, 05 Nov 2026 00:56:50 -0800 (PST)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31f8804sm2910640a91.17.2026.11.05.00.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:56:50 -0800 (PST)
Message-ID: <f8ba83df-f149-4703-b0ed-a7fd00608cbc@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:56:43 +0800
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
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 <4edbe80d-f1f0-4e85-9973-86da7649e9bf@oss.qualcomm.com>
 <1a83f9a4-73c8-4a13-bd53-2e779f6ade22@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <1a83f9a4-73c8-4a13-bd53-2e779f6ade22@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: U_NMxtB8pEUODxjwlh3Q632m9OLvN2Of
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX6Vd5vWH661Hz
 Q4SLIf5xXoTYGnsnhBn4iUi/rBDrStoZKWTtcQP4uPuzGOOPIqtdvFx89aKuffM5rbvwOJhtiC+
 7NRRXd+mc7XeJJ9XaDXn2JUq/SrEq06BDffmCfYe/F9smsIV6A7iX36UiANgIAruDdUJaHXvkzG
 ZOOoYHQhjULhM1QtirjXr1czN18oxcNl44xUDFIKhOvgY/u+Y38DEo7zCWygayDCukBrGwIhKp+
 BvMnwZj94JGJHP8iEpZJrqTcSNvhyImduNO++XRgb6ldRPD0sAWS2WYb7wpIAXhvsp8PPvsSjmI
 LnAQERnisk1CS1V30aAiuZlUlSOrpjmOw9hHQdX5lEFJ1PxcpqBDWZFVEE+MQJMmopGz9POu5to
 J+yaf3PDu2OMJ3I1XVF6UQI0Yv1R7HbnCa28hXDmZ02rgIeUiw5AykNgc0VnkxcKjV8XizKFQOL
 JoZXNWDeUOufyF9QctQ==
X-Proofpoint-GUID: U_NMxtB8pEUODxjwlh3Q632m9OLvN2Of
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec44d3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=yLkMS7TIAoMVBHN_cM4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX2lG3YIhxaJww
 cCN+1BHE6hcMZWhJV1VPrVYccueCReZyulMrKqdo3ASdrDKap0PZyZeuNuQIBOR161VXfdL/Kto
 8Y4qM+zTzAyACvvQS/Xfp45gML9KF2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050035



On 11/5/2026 3:27 PM, Krzysztof Kozlowski wrote:
> On 05/11/2026 01:48, Fenglin Wu wrote:
>>
>>
>> On 11/4/2026 4:44 PM, Krzysztof Kozlowski wrote:
>>> On 04/11/2026 09:29, Krzysztof Kozlowski wrote:
>>>> On Tue, Nov 03, 2026 at 08:51:17PM -0800, Fenglin Wu wrote:
>>>>> Add binding document for the haptics module inside Qualcomm PMIC
>>>>> PMIH0108.
>>>>>
>>>>
>>>> Why are you ending this? On what sort of ancient, downstream fork are
>>>
>>> s/ending/sending/
>>>
>>>> you working?
>>>>
>>>>
>>>> NAK
>>> Best regards,
>>> Krzysztof
>>
>> What's the concern on sending them? I don't understand.
> 
> That they are based on 4 months old tree? Or half year old? Or longer?
> Try yourself. Does this apply?
> 
> No. And if you tried to work on recent tree, you would understand why I
> am asking.
> 
Thanks for the info, Krzysztof. I was working on the tip of input@next
in September. I understand now that I should rebase them before resending.


> Best regards,
> Krzysztof

