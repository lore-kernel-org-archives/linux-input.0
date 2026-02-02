Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E2378D90
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045118; cv=none; b=O8nAPgf7/FGxpxxIjGderTsR05X8CBnEcqZXZ2k5b/eFWdahNLeQ88tUpz0pnJW4PDPL4GfZrQtrSJ9rrDHhqIht+wQhu5j7RO/dkQqKJ28nNx+SFIZ2eJTo1zpyiKtixRxbXbPkILWiUxTL4o7BdfgX3hVRaPS6y1IcJzg0qVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045118; c=relaxed/simple;
	bh=OZr9ZTlaroAleY7MwtWXX1cJKnosxtGblpAeyNoK+AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSqq3Ex8Ez8L1VQoIpnv04okCZO9d+f8EcJ+iRH04nLFWpJdCUguOQM7+Qt6AkR5NxC23DXdZ4y6OMwXRya7DzMu1L8UfikU66t6eMkrAdhL/KkeK3uN5+i6iGOWHNHv+6HPup9c/6GWG+lc2bVA9xh/jmZoOHoxi/dN8Eivtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oEXYM0LY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+jtW2cM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEXYM0LY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+jtW2cM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AP0ru2100879
	for <linux-input@vger.kernel.org>; Mon, 2 Feb 2026 15:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pmf+AHruoKI1g45Fl88mwp2EJ/7UQ9ULt/yYUiyYEc8=; b=oEXYM0LYygJ9y248
	t5Cc5u7L27obzG64rqeUh/MxtPYtmjBB7VD/EB/s7jw8+HgwnEpbELV79RNf49mg
	tGgqUjsZ9QQZgfcFVrxedjZSWxlvrQF/ho8q2aYrUlp75980a1oam8c3u76yOqLX
	dG23x0GSzShejp++jpzuT7gyomsDpwc2rEjh8RpusUxPx59bpQiT2aDzB1VuZjpV
	XzVpl10+CyMr2hfX4wMCSWDRTalT8BK6lXYhlBA4mDX57Y//gHszHE7Iop00+pOY
	ptkkYAdAv+qDnNXWsbEwtMuYetZt+36B6rNvvE5fKhmEdpJMwjzjpXGhMFJb/rA4
	DxENMw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2t5e8sum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 15:11:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c536c9d2f7so124876585a.1
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770045114; x=1770649914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmf+AHruoKI1g45Fl88mwp2EJ/7UQ9ULt/yYUiyYEc8=;
        b=f+jtW2cMgerHZ9EvK6ihHjyHvObhYhaGjqH4RekEDntRZTFkY/HL+iYYus/yVIKUmD
         PopMqFuPoAS/eflRo30FYJOyELQVsMF9dBLAZT7xsbdjcAtGDH4l2Zx4j0r82P5g+RIW
         1ezgMujZuHIj8Pzrlyq3J6P4XAYNM0t1NRKl0KKfmUi8MbQPMh4HfZsE/97ES62nuVXk
         7GEcp/oe4yf+RJ0zCW5eReRSueCulOoid+FoLY8vfmilBbKG6Wk7sNjPhpcN+1u2THkW
         Lvu5fJAUowP2ZlzvwUgP1MwkRA035NVhnnMUCFq8yhSl/aKiXCsMrFePiwurxmnt38ZQ
         /k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045114; x=1770649914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmf+AHruoKI1g45Fl88mwp2EJ/7UQ9ULt/yYUiyYEc8=;
        b=UEYp3DWqDeeYMHOLhWUeWKYuFicjU5pLOhbcULKKbewc8Nw6kMYkfK2LtR6gfVYSOl
         Pzkcs0HTTLidTi4wvCCri9d89+d3HlXKEq3/bxchch/XaPp4oSDSsBeA3BFrF8eXpRy8
         acq3gBDeJqyHxGvv7mTanQSJawg7T3WV6dPVHrYpFZWngZtbx2px9WTHV88HKop72Xu1
         hf91ysE0Qt7EYZBD+hCa2sx8ukazpo/3mSpHwsNovO/ynMG0Os6SMNeSq75eoWBtfUle
         YtpHdvvFwpKfhjwt5UlgH0wMvANBzKoZR844XiXfrbpf5YL6CIbFsCCWVHlAjUDPbtlo
         qdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT/kRitDuFh6O0ir5VEV2LfQbTdgoaS19wN+lQy5h1cjZvhZ9mMUOfCgqEO7VNq6FHrzOGg3mLJX+MoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCPFiEtsKal/Wsxo50E6aKflsObi2evS6GSPsiClyknlno9cc
	+dDcTxboPGoz2yd9p567uZBwcsM9N9Hs+FdxH+N1SoSG4BmxlY6Y8eg9+DQSUhP5p1hkQMMY1kA
	8MmKocXlMnLTzn2VRSyavFaW7Ee6e37Z9riiVksubj6Jr63muM8NwgJ5nllfF/W6xoZYeqfKQJw
	==
X-Gm-Gg: AZuq6aJFc+gNmLiW+yTr1vjRN/F4Zwe579KcJqUkHAac/gbH7QmpYY8BtpfRqsknSZe
	V19waMcF8OJB8CWPpDLXfP8RHYLkz0CpoESItA8u4f7QHf+eE48gCcJT87sntFcZyXSlzXbfs0t
	UMCwhqY3PDeQSZkFyDdc5ZgEc0+EvJnbwFinfdfQrcj6DHFA2xgyjMvrS6RSM7TFgg/Inwmm+uv
	E3jSSPHSbFFKe6m+AJthfqmE7pQL+CmacAAZ5wQk+QNrCFHiStKiTTHE16ujMt+UpFunonaO00h
	Ry2P7EPz0eDmUIAzyeTwMzLPc/serHc1d7YnUZqWHyZh7Genl+0MChvUKBbsS6ccB2SXp2VLziR
	yK7yFVzuFHgkqtP1sw2I+pfq9XweJzM4Ma+N+jQ0rHhdCvQWInn1QNCVGJjyBii7Q5t4=
X-Received: by 2002:a05:620a:1908:b0:8c7:17af:7ae with SMTP id af79cd13be357-8c9eb2f98acmr1116691485a.7.1770045114358;
        Mon, 02 Feb 2026 07:11:54 -0800 (PST)
X-Received: by 2002:a05:620a:1908:b0:8c7:17af:7ae with SMTP id af79cd13be357-8c9eb2f98acmr1116685285a.7.1770045113527;
        Mon, 02 Feb 2026 07:11:53 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed584sm897220266b.61.2026.02.02.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:11:52 -0800 (PST)
Message-ID: <6fa17bda-4d4a-4b31-99a2-1d2b606b663b@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 16:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
 <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
 <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
 <34fa533c-b9ab-4025-b9ad-4041837e790c@oss.qualcomm.com>
 <aYCCv6nI2QkvD8rb@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aYCCv6nI2QkvD8rb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyMCBTYWx0ZWRfX0L7qPgMG1MEI
 MD3AxlKm/2/Y4S/X5Xrd5SvmYTCgv6orx3lT07ftETqZZSiTXXLuleyiKP6GQdXOS/lavbYoQPs
 yJjc1TB74r5ddQ/P3sbLvCn985Y3Sv4G/Vz9NCnPEh89K+gPR3trT43NqV/ZZ3PVEAgc9hdnh6O
 u/bKf5ZslZhcG7FQaMyDD2kLXTift5Da/7h5Pvg7cTCRO1a+NK9LB5m/T9Wfp9Qfk84rdtxt1GQ
 3SmULbMaOfilnL7TWx8wzknkCGfoHaUsX4h2Cn199IEsN/3Z8umgV9rRmeh9rgibQKIXYNnl4Aa
 vjURNchY+/QxQAGIkskPumsDxwyPoOdp7Yl6nHyLvjn4GACacXdlq3mCmdZBhYd7GQBU3efPVZx
 FKAE/+Oasn7pioUSpf2sTMuPqfjTBxYOks84jUgRIWiR3Wx3kQXsygNuUtKr6d+E7RFSmy3iVsK
 20V2Qdl3vdoAn58761g==
X-Proofpoint-GUID: aY33aVp2LbX2LI2d1Pgq5eXPRKy3jfaS
X-Authority-Analysis: v=2.4 cv=NOfYOk6g c=1 sm=1 tr=0 ts=6980bebb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=R3g-FwLwWl9o4qomehAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: aY33aVp2LbX2LI2d1Pgq5eXPRKy3jfaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020120

On 2/2/26 12:04 PM, Dmitry Torokhov wrote:
> On Mon, Feb 02, 2026 at 11:19:36AM +0100, Konrad Dybcio wrote:
>> On 2/2/26 11:14 AM, Luca Weiss wrote:
>>> Hi Konrad,
>>>
>>> On Mon Feb 2, 2026 at 11:12 AM CET, Konrad Dybcio wrote:
>>>> On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
>>>>> Hi Griffin,
>>>>>
>>>>> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
>>>>>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
>>>>>>  
>>>>>>  	chip_id = be16_to_cpu(read_buf);
>>>>>>  
>>>>>> -	if (chip_id != AW86927_CHIPID) {
>>>>>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>>>>> -		return -ENODEV;
>>>>>> +	switch (haptics->model) {
>>>>>> +	case AW86927:
>>>>>> +		if (chip_id != AW86927_CHIPID) {
>>>>>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>>>>> +			return -ENODEV;
>>>>>> +		}
>>>>>
>>>>> If we are able to query chip ID why do we need to have separate
>>>>> compatibles? I would define chip data structure with differences between
>>>>> variants and assign and use it instead of having separate compatible.
>>>>
>>>> dt-bindings guidelines explicitly call for this, a chipid comparison
>>>> then works as a safety net
>>>
>>> Are you saying, that
>>>
>>> 1. we should enforce dt-bindings == CHIP_ID (what's currently done)
>>
>> This
> 
> No. If there is a compatible chip with different ID (for whatever reason
> - maybe there is additional functionality that either board does not
> need or the driver does not implement) we absolutely should not refuse
> to bind the driver.
> 
> Hint: this thing is called _compatible_ for a reason.

Right, the reason you have in mind is fulfilled by fallback compatibles

(i.e. "vendor,actualchipname", "vendor,similarchipname" where the driver
only considers the latter becuase the software interface hasn't changed)

> 
>>
>>>
>>> or
>>>
>>> 2. we should have both compatibles with no handling based on compatible,
>>>    but only use CHIP_ID at runtime to change behavior
>>
>> This is spaghetti
> 
> I really do not understand the aversion of DT maintainers to generic
> compatibles. We see this in I2C HID where we keep adding compatibles
> for what could be described via device properties.

This is because it's the only way to allow for retroactive changes that
do not require changing firmware. That's why ACPI carries new identifiers
for even very slightly different devices too. Once the firmware containing
(ACPI tables / DTB) is put on a production device, it is generally not
going to ever change.

CHIP_ID registers are a good tool to validate that the author of the
firmware table is doing the right thing, but solely relying on them
encourages creating a "vendor,haptic" compatible, which I'm sure you'll
agree is totally meaningless.

That's especially if the naming scheme makes no sense and you can't
even factor out a common wildcard-name (which also happens to be the case
quite often)

Plus a compatible is used to restrict/modify the set of allowed/required
properties, so having an "actual" compatible is required for schema
validation to work

Konrad
