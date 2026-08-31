Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0026ED3E
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135858; cv=none; b=GsWUjsdAtHo9Cy8O5XZ92AP7sgZXKDdgU7fAZgjEwT27P46bXzwUpHmwHJgmHwBoTC4RifVgPZElYxciRiC3KZhKj4DD/NbR7XDGGmYUGL+Mx/sj00Jy8rPoTXCexOMOgfzfNcTR9olSbTK+wrdULFi1go4PTo1yL8aq7dnEW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135858; c=relaxed/simple;
	bh=6YIHXqDUJ/SGIN4IgKl1wQt+dbTm0xIWC7JpfWou+vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvxpyUWR89wp+HrUW2z4tJ4WTsUB6dDPnXRpaGWMH+9/k8wUubTct0mwWKC+lYm9mVADuECnVzRf+TcG4/5KWl/Wad0g/QMl9ZWUCIMs7jTDz1WH+JLuG8f7pOgcZhTCbzKsEfirCsScjSKdpI8DP64lVV5xaLpIAIickkqjKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5VVaw4O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWpXMRtw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5VVaw4O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWpXMRtw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UMgAZk1227014
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pd8erokzzkEWmKV5QqgUd5p90sn7H5zyhTLLdFPMX58=; b=c5VVaw4OCpzNF1r9
	/rx3hxU21bcsutBp4q1bbe6x5cdEAyumFaGvmaChcQI9aNUZ4e9G6N9twkWfNX/O
	k15NjflQvPOtvvKOWwYGlu0BB0NLhe4K+pxGGjbfLPP5s3AXISNCGkToXm0fC/H8
	xdF8bg3Y+//ocvowB5vys+fXG4UE8CnoTye5gJ3UOqPOuydmdczoGCXdyFmRh3Os
	f1Lm+7bnKW5MMIXdI9LrKmT2Vcuc13soVXdRw2JHX9BLMnDNNmy8+Z/CmwSXtVmz
	AFwl77Pd9OC3J3YLJPmjQ60mQr5t4STy5hsOlyIeJHvIH9JnS4QLkgiGOoLO+aVY
	lE+91A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6kwpk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:24:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0aso831292a91.0
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788135854; x=1788740654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pd8erokzzkEWmKV5QqgUd5p90sn7H5zyhTLLdFPMX58=;
        b=cWpXMRtw5mbwm9GXeXlG0ezg4uAP8XsNinwsDK859BLwGC3oLpDitM5ytGb2eCJag6
         02up4vROsPjYsCBtRH3eYUgYJNySYiwrec/4ZAun0JDYvXfwxBsiMH+RnHrBXiMKFftW
         UYELFCKGWSCzsgaZ1kglScbjHABrdsoZtTXT0VEeRebXzKHc2VZfjPnTQ9KfNmMTLEWS
         fnsTGbUMT49YVXyBTulazLCa+d+sEuEjD7h6aO3EcC8bxlBS8WfLiJF+A5poo7l/MMxi
         6/2wkdXwpgJaZCx9slrNCdoslLy4zsAF02EMds8eJPlUPtMIxqeE9OY20iTLLqW+i0Iu
         gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788135854; x=1788740654;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd8erokzzkEWmKV5QqgUd5p90sn7H5zyhTLLdFPMX58=;
        b=nJbL7FPIoTX/lR8Kdn8RivKWLRilxSZDokgIqEScKMUEK86XpvMCvRZ6RFAdH9+8A/
         fya9Pf6AF52EfmRBvufLQprA+TGzj83WSI6y+jtPwkB32ydnN6ggIExToxmRR5+TL8Yj
         GSZ0KauKEfVAoC+UqDoEsEHzxDPuoogISYcY5GKddJMiqCSndwsqChz31q7kC8metAIj
         5On1rbKaA130XEJ2QnbmhFhyLKYpLBuldrlgMnqsUpsUuKRqzzawo6PPEHbg6JsAqhAE
         rRM2bOt1T5xbLfTq2lFpgfmyX7PARmUYkz/p8iXQm2W0jI+DUZKU+CEew2knxjKVpqeH
         pntQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNpDS/9I62KE+d31bj/P26PJpp8EWE5L3WSUkG49lu5hLBbnlgAYtWlTejHctiONoxf/cr/Y2QZY2Vkw==@vger.kernel.org
X-Gm-Message-State: AFuF++kCLVmk1l6d0gQZNomUIHvISJfOUJzjsm8rbtN1se0ZxLqcr0Uv
	F2kVDaYkt24IwRWZj9HoJ8X0mpiKoQTePqoOpK9Ej8nt3InEapBcmC5c+A/yzERLZAVXcpEiuTJ
	8z1LsyoeWAaM8g1xmJhha4xus6moKszZ3CbbZE5SDn5+HP5jfADUAqHsHDX+GbnT6SA==
X-Gm-Gg: AYBFou0A/TFGhyAPlkORPmvl/MJw/xkr1aqtKZ4phT1A850qorWitT1gOIhWCFqY1uw
	UeWF0pEVTkcN7c12gGyEFdI9CtKp7bkcScf3bua7+/7jLx+rvoEpxYJT3aXKqNqyrTsFA9rA5JU
	dBdj2ERZ9UbTrVOGHJahui+r6f9ePa+MQq82pBadoa6kfODaYedJFiCX/LbRkhKIffl0TmT9UDz
	W8PZVBZZsn/X8d6+IZ9HDTLF1YgAgBlii3YLB7q/aICGrIF52TR+vc9kCzDPgxgtkzZPVZucEY6
	QWrCHBVRFNBoF1rEkGPX/QsjFlqtdtJsBIOncwFJJFxUFXcGE7iorInrmRexRk+xNo1zdV8d5oj
	DN6VbzVITlC32j3rfB7yCL92E8i0KodH6JPX+2kJ4ND2y2eaUVs6TTXBrata9vsEk4qGpVA==
X-Received: by 2002:a17:90b:3c8d:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-398da58f3bamr4020610a91.3.1788135854398;
        Sun, 30 Aug 2026 17:24:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8d:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-398da58f3bamr4020564a91.3.1788135853797;
        Sun, 30 Aug 2026 17:24:13 -0700 (PDT)
Received: from [10.133.33.138] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm18299048a91.6.2026.08.30.17.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 17:24:13 -0700 (PDT)
Message-ID: <7dc6b68a-db8d-490a-89aa-596d70d2638c@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:24:09 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
 <20260828-qcom-spmi-haptics-v7-2-0367b3ac2e1e@oss.qualcomm.com>
 <cfa1d6c7-267c-4e9d-b3ab-2c483503a1e6@ixit.cz>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <cfa1d6c7-267c-4e9d-b3ab-2c483503a1e6@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1vM3LL81agcbtfpcre509SV1kq2kVyJV
X-Proofpoint-GUID: 1vM3LL81agcbtfpcre509SV1kq2kVyJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAwMiBTYWx0ZWRfXzfBo7ucgORN6
 6PWCOaWo0VdAUXP8UMa+wB4Z5QP7P8ErjJ3gtEQZBh8BOTb0tK/FpTHA5GSGSbs6ZFw0hq+coxu
 pvRufGTQvOFCATMa+cWcXbwUVPRmkUJGxcMhszv81kgaZnmovQ5T0GoUkYtl+Hcfr2BZX2SQ7JG
 TPPRe9zLtCj1FKC/s3Z1cQTksuPmm9bVO0uoQb8wAPJLZm957shtek9Gf5V2M5OLd4cItK4qr+q
 oXk3nfU8bpajcZMI8eo0YPfVurybq3uqMb5DBuMk8SIfGhByUo12YirlV6MygP7X+6tZybrDQHq
 BCD09/Txa846MNZ+yx8wD3DLNN6i5L6iBjPNZ+8cH0lfN9F1WQd8i39OZffvgpxTruZ4TbeOGE1
 24tYGiRIVIXs7Q8z86dYn7RsDVhjD7MQBPKgN6vQfTHYuKKYm9WgTiIFHv+G/Y15F2DJXaWf8/x
 JYhdu7vYRtgzehfyUHg==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a94c9af cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=W9oJu5yFqjHUb1IVf5IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAwMiBTYWx0ZWRfX1Ar82odO4ruv
 HdtsvFDtvZF2n1sPYMiYElZhhu12Rv+xsZaB9BS0IFMX1i7W6hXHou6mf9EjlUOLv66HmxHssxO
 oT/uqw0EJ1JSR+lgh8GK1bKf+clMAbg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310002



On 8/28/2026 8:12 PM, David Heidelberg wrote:
> On 28/08/2026 11:49, Fenglin Wu wrote:
>> Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
>> named as HAP530_HV. This module supports several play modes, including
>> DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
>> and hardware data handling logic. Currently, the driver provides support
>> for two play modes using the input force-feedback framework: FF_CONSTANT
>> effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
>> waveform for FIFO mode.
>>
>> Assisted-by: Claude:claude-4-8-opus
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   drivers/input/misc/Kconfig             |   11 +
>>   drivers/input/misc/Makefile            |    1 +
>>   drivers/input/misc/qcom-spmi-haptics.c | 1251 ++++++++++++++++++++++++++++++++
>>   3 files changed, 1263 insertions(+)
>>
> 
> [...]
> 
>> +
>> +static const struct of_device_id qcom_haptics_of_match[] = {
>> +	{ .compatible = "qcom,spmi-haptics" },
> 
> Hello Fenglin.
> 
> Same comment as for v6. As you mentioned, this driver won't work for:
> 
> compatible = "qcom,pmi8998-haptics", "qcom,spmi-haptics";
> 
> which I'll be upstreaming soon, can you please use device specific compatibles 
> here, thus listing the devices which will work? e.g. qcom,pmih0108-haptics or 
> any other you tested?
> 
> Thanks
> David

Hi David,

Like I mentioned, currently this driver is only supporting pmih0108 PMIC
haptics but it would be easily tweaked to support other haptics modules
inside pm8350, pm8550b etc, as they are having very similar HW design.
PMI8998 is an exception in which the haptics HW design is very different
from the ones that we have in the newer PMICs, so I would suggest to
treat it specifically. What compatible will you have to support pmi8998
haptics?

Thanks
Fenglin
> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_haptics_of_match);
>> +
>> +static struct platform_driver qcom_haptics_driver = {
>> +	.probe  = qcom_haptics_probe,
>> +	.driver = {
>> +		.name		= "qcom-spmi-haptics",
>> +		.of_match_table	= qcom_haptics_of_match,
>> +		.pm		= pm_ptr(&qcom_haptics_pm_ops),
>> +	},
>> +};
>> +module_platform_driver(qcom_haptics_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm SPMI PMIC Haptics driver");
>> +MODULE_LICENSE("GPL");
>>
> 

