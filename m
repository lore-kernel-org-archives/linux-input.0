Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE02882C5
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371364; cv=none; b=kfrz+6e+YzvJH7bAy5n3IK0QKnHkj/Xn4qPgeriCt4pIjSM6RklFJEU0D41hy9b+liuundg1iImD1SYrny+INlpEeLIBSRdxsjEpzcxmWQoWFM3Rlz9gvZWcDIYaLerj9il79dd0bwSNYl2UDPy1BUWy1jYOuhelV8VmqjLV7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371364; c=relaxed/simple;
	bh=djv0tTmb+A/Hc7vFHYTPMoV4v+AC0Sm+bPpYK67KZOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSsqLJhU/cBtsUIpfzznC48EQXo+NjwgmEI0KTr7YzaH3m60ZNx6FoX+8Jiv2AbWSuVMA8sVvi26tOtlPUlrd3l40LaygofW2Dgb2ISSBb/40AeiJ85wLEIC4WXADPscEK/ED8qgxOG/iFGwOiYMryT3se8o65sIyt8hRJ3tBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lX5L0t+o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cITUPjvo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lX5L0t+o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cITUPjvo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eDFx904468
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XTCZ+VJ4Y9dEhL3KzBEduOSLdvMBovKYtTZpjNm7jA4=; b=lX5L0t+o78Q6Cxqi
	PwLETmQBd09pv+VTCvztFKviJlyQ+CxsQvhHBUU7eAs2esbFX18un3SRzqn/wFwf
	36VIKoVq+hHKOh/yb/7GPv4cqyVWfA/PbrmKkEdqdDgt/3TkrSOGBhCd652COqby
	Iz4/nEa54CMNoeJasw+2oQyzhTPFzmVOjCvejqnr8Q/EGw6yE6tI8ARKxW2zB8YF
	RHay0bFfRYx8EZZ0MAcCxNCAy3d8mdsdrr3nuwdzAZSsJHLwddOKJ0fLnRgzLg37
	Vc+XD2fMPhlzLL9Rexs6MMqx09LxFgjoXFDj8jLGla0ipS34w6fZFYyd28UY7N6e
	7EJF1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7du2s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:09:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84534f17866so1737963b3a.2
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782371355; x=1782976155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTCZ+VJ4Y9dEhL3KzBEduOSLdvMBovKYtTZpjNm7jA4=;
        b=cITUPjvolAsEf+1QC9aJKjBEm2+v1D8/wgS1vl8PXnoB3PDEVLa0yRsGlAeZNZTUaE
         aaZ9Dbxo90AhNfXEQ5F0jfifpzT6WZFIZlO2KnSw6inhy9PCqFUjv1tklcIahK9gWhKa
         /BKUUf83cX+jSPIN/UGVeVx9HB7UhflMIT5EdAIhcbQTpRm5n4sa6/mW7qPFtABagmk/
         97P7H5kuG0zA4pFdZBkupoZCk/5fx9G0ld38XoqFAw7wVrr4W4KiBTms19/JHJFLq7bB
         /bcN7kuxjz//YOBMek+aVGtBpLU4HYwSJNp4aZQpGDeEbSMmnvhBkKb6zR8udYjgj9bc
         XifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371355; x=1782976155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTCZ+VJ4Y9dEhL3KzBEduOSLdvMBovKYtTZpjNm7jA4=;
        b=JleEHzdurKmFgRDEuQsKslwNw0tpjvt/mKlyKJc/Z/BJG4qiEJJUozT/AFdz4Vonw2
         cbm/ohHD1WlGaHfW9uHFm2/mYf1xwMSXET7p6MlHj9uEOVKP85txmOhvVaM9ufOT2IWX
         z1ADwEgXXAStuWdiqlddr44oJzvUb63M4kKcbgH+7lFVq5KWQQr4q7H1Em1kqzOJgle3
         9VjHd8N52xQcovvjUeTSU6RLh8hb1N0/KkfiQxhT4sMKZcx6UJGMjqKjgDNgJiSWnCxq
         9idOFazu7DG5MAKWR5mvY+vwbyYfyIeyI+WGGxgiVNCGsMxcNmTFKf6izXhPkesX19zd
         PHZA==
X-Forwarded-Encrypted: i=1; AFNElJ9n5eF9IPCrDjsV4Pb2WnvZT5hvSxQi3ikjr7jto0ppURrb3zU2Lf9uTGPeAvPLOfInvLf2wkeH0CqmTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NenKa5LI/T9lsBgGzUbXD8NTdwwfQNS37l+v02a0bF2bs+lf
	TBHLl4oR4mBzbZ1pSzlwzXTcj4PvVt0MWHyBkfs4Hw2MATTw3oJuIcD58/SbEVZdKSoVyoANQq/
	/Fy/D102JIiBn+LGiYUmhTmFsz2E2LzPoqlgL1DHeSDmWzBrSpImrv1XfUFOeJimU9QK12PQN1p
	NGfYk=
X-Gm-Gg: AfdE7ckIAhvr/cnnPW0Q516VR/5QiN2YD2t5dikUdJ49vPh3heGKVRtXu2q5umCOxT4
	xMPHVVItd09fYrywlaIiFSPAUe5z8tgOn4Y3h8DRfvXlDIZYCgpnAMkiFoT8KoxHWDoTDqmp8P7
	KhkfiaA8scMSDjdNVSp3MioaiVe7WnfdR2+T5da6cKR5z7j/HbaO4MLVp9ZHMREsdmALprajKmz
	4MNwwiYuPGTsKOJlsbUvP/udbIqYOkiYUTv1WKs2K3M25B5d4GfzJYTjFTtNZUbq71yDQAccWSn
	otjPpXsqlRFac7CAzLiCk6DJHybKrh1cM4jPaw4d4K6u4xv9BEVRBnuA7V+cPLkiY3mgERh2X/H
	hQSwnJu0UmFs5AEWCsSYx4XYq6jNnit4glRLNUTVZtVNnf2Y01g+X3UXS4IekY3D08+l8Wswjvd
	RwiRDe
X-Received: by 2002:a05:6a00:1d8b:b0:842:650c:153e with SMTP id d2e1a72fcca58-845b3a1afbdmr1617994b3a.20.1782371353652;
        Thu, 25 Jun 2026 00:09:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d8b:b0:842:650c:153e with SMTP id d2e1a72fcca58-845b3a1afbdmr1617959b3a.20.1782371353108;
        Thu, 25 Jun 2026 00:09:13 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d2341sm4045909b3a.39.2026.06.25.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:09:12 -0700 (PDT)
Message-ID: <9175804c-956d-41eb-9995-05a7b3bf3fcc@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 15:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] input: misc: Add an initial driver for haptics inside
 Qcom PMIH010x PMIC
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
 <20260617-spry-greedy-chital-1276e0@quoll>
 <be2b54a5-ce9d-49a2-80e1-60da874350d9@oss.qualcomm.com>
 <4ba2eeed-71f8-4799-b261-e4e2c268043e@kernel.org>
 <36043887-6bbd-4b2d-941c-bf222786b80d@oss.qualcomm.com>
 <91cc96b0-d25f-436d-a0c7-fec39bf72393@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <91cc96b0-d25f-436d-a0c7-fec39bf72393@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nxyCf-V4imEUOnk9amymOQcr8eNOQluL
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3cd41b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=3T_W3r0UKrfHlzfwz2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2MCBTYWx0ZWRfX2c71IWMTOAXs
 7dr4J+TnHwkMYotyDavwGpzjm3zO7wJchbnQbDX/m1zvb3/heqZTIrkWCbnpP94phOMtIG0ma43
 MLDPoAlmyU4ftHFuYv1Qjam9q/4sA7w=
X-Proofpoint-ORIG-GUID: nxyCf-V4imEUOnk9amymOQcr8eNOQluL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2MCBTYWx0ZWRfX2QiLM8tOBPa8
 1toaSrYz5NoGFgTC0VSQuBBBDi7U+GwbLIMXp58Gm9fQU+m1fkaR3hZL+lYmLAteZO9CQyWqzRu
 XXH9/emd032kxNF/dF/dY0LFrDSRtoK9i8u2DHsU4K80wzHipikWKucKqxC/e0IqXmWzQVKGPbF
 /+PpMK9S2ljd5RtbFWuiXqSghz0Jeb1+SpZoX5zKSwqWLcp/ikwRxGAcOt2vrOm+a9dRlKRnbRh
 bRJMhH7p+xwJomzPv7MEgoy6aY05Zx/1LheT6mxMBcRg/ofa2UAS0MMW9WuOO8MSB25RllKT+JL
 ela6SztiQzrsZxgRp3cNK7r7rQtHGC6nARS1vKzgnnKDl4kU+/cihd/XlfI8gELAi/Dackx7nF/
 s1HXQu5aMS9z5gUmaJ3XtoqVvIxgeQekSEwh4njG7K9B9okMi9/q9ucyVwanIDjcGXGW7S7+xVp
 Ly6JnYrSf9l93PxuMdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250060


On 6/25/2026 2:19 PM, Krzysztof Kozlowski wrote:
> On 25/06/2026 03:41, Fenglin Wu wrote:
>> On 6/24/2026 6:05 PM, Krzysztof Kozlowski wrote:
>>> No. Act as maintainer. Clone Linus tree, apply the patch and see if
>>> everything works. My claim is that nothing works and maintainer tree is
>>> broken.
>>>
>>> Best regards,
>>> Krzysztof
>> Thanks for the explanation. I just did that and I didn't see conflict
>> when applying the binding and driver changes, but I did see a conflict
>> when applying the DTS change. I will drop the DTS change 1st and resend
>> them after the driver and binding changes get accepted.
>
> That is not what I meant and you did not follow maintainer process. And
> why did you ignore second binding? Identify how many separate
> maintainers are here and act like them. I looked again at your patchset
> and I am sure about that - patchset is unmergeable by Lee.

I see. So I should mention below sentence at the beginning of the cover 
letter, is that right?

Dependencies:

  - [patch 2/4] depends on [patch 1/4] and they should be applied together.

>
> Best regards,
> Krzysztof
