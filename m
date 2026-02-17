Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83433A007
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331348; cv=none; b=G8HDw8WRV70kOsPXV0eeOOLWKJ35Owbo+Kky3LCv9PM2N8vx0atHIejVu4byGWDlZVUOpoQ04+cEvAixakXP8DKXX4agm2PCxBXtpiJduF02uvG1YhrUjhE+xhJIKj6rHi5HvBYzTWQmDcU118vNJYP8ZiHRtjPxNN0GRU4N5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331348; c=relaxed/simple;
	bh=VRN60Fr3kj7zvwSlwYxaIWmnxVA6ckGzGv9Tvn2DwJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC72OfRXifWY7UneceJbTHyVgsTH7gt6PtL+LSAVZzgJHWE81H6dwshy+Dfnyz4cH/mGRSC0Q3NKTJNRij2VWWVRJootanOhWi6UDRjDd/mhx0E+fq19k+KXdEuHwKrwfwDdfGnzU6xucwzkhbAndGtC62DkfSCteK5Ak9vgm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNNLACd6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U8zBlmcC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNNLACd6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U8zBlmcC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HA8wRS597192
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfN+j7iPplW7HNJqPxQ5mLmsOyD6t4QrPPRMvKjKBi4=; b=ZNNLACd6DqncwSV+
	Ri+bSrpWj/CDBCMOF2OBihNF6XcChI25PN+EIHitEB2UEFqQ0DDvMSGhV9UroXqt
	5OVmPFSt8w7xyIUeM0/2cTdKtwIoytqFgmTPhdvEu3PuUaH6LjRStLuc0j6IHOhn
	RHAxLuca+7Vredw93rR1MUuNs/V9RJ9sXIBIA7usd1JXHYd7O5+b7/bdgYe7uqPD
	Gb/qZ0WODeChXHG3X9DODHLAe84rBgNzmmQa/tH7/20k2ojStjMdZw+G2f9XlAOQ
	4YS4g4ZcpSyHn/6ZtkRYoOKxQBHxb5ibwbp6nozT9wWj9gzmWui50MsjhiZrlAZp
	q/qolQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca361t2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:29:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8960257db65so30823056d6.3
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331346; x=1771936146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfN+j7iPplW7HNJqPxQ5mLmsOyD6t4QrPPRMvKjKBi4=;
        b=U8zBlmcC5XtobSpTJRpW0A7MR2q69nzf56p4SqUxMolRo7EqzKHbG5LThCJMXVzmR3
         gtjOdDxwndJdQZiUhPj7aH4JTRZ+YbxZTeqYAoMTFswZhpRYQRwKBTODhUbZjjXbxr9h
         T+1lx5DyAZ4MT8qaeIc1WKESy9UKUgdC3FVgAU78oRTBs6gpaux0zZmHXsKo7WevqC0c
         7vsY/7XSrpMVqxooRoK01+3lEu4TkiqYXi6kS03qaIA1y5JAHc+tclMsMXliVkLjABo2
         mWGpD1m1y1tKc5j0AuzRJczRTJN2aOPLSezfwHkuAh3WIM9cricRRQhn7BVXWLUv18P7
         QbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331346; x=1771936146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfN+j7iPplW7HNJqPxQ5mLmsOyD6t4QrPPRMvKjKBi4=;
        b=TPfpSJP1u4wZk/n+eQFhjijnzzB1e0YZvCHzrsEO0v2Dzwb7su63B8PJNkeRjztAvl
         Qk9YFjP6YmaSxdGb5kR/JHniWDQqbZnoPcBqiwPmexj+RPgfGgrHJ7L2mh9SijJo1txh
         g8SdRr+s7tvMXJl+Zr6qJvXMBqfsn/nnUry1ef8ldIxjMVn5My0HgZgQl7cf3M6hxs32
         2ALBGrmfknt2lBjnJeNHPOuw6cusN2zFk/fVpNxGfnPPh0yWNivRzLu96cMeSDURgN70
         4+WTMIyYjReHGiI1bC3pC7rLCi4xhXcXC3/J39TTyAndDRcZKAn0Dyr48IWLcEcDxhqV
         hstA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNzYYA0EmCSLkwaFUf86gexGzcp+dYCnpoSkxfkF0N7lrro5Osy7DzO5Xm0CpMgwaHCDT6dfHSTfH+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxraPhUG3B2dUJ7uff46PU1t3Jg2RVXYKy8IP/Sgx5usxRrjgdR
	ElyG+OclS2X9n8ThKKA0e6V2dvDaBUOn3WiWp3uc3fWcm+GdM5gVMTlYlxoYIX10ZAz7q5/mfSH
	q2xtmQNs46+Wmq8dQ1j4Veo7bvmFxJ0QqMP6UGNrHfqsR/krDJKaAyHVWo3JeBfE3Jg==
X-Gm-Gg: AZuq6aLq+XG4K38oiAauIPBCeV04IZVoY4YI1zT2uBKllE3RPNarvLrxL2Fl9koN1wr
	k2FM7osBYx3zlTNnjzi88EF8u2UXsQ1nxxFrBLlk1X2DAYXJWDBE8Budengvwax5j2we3PTNozW
	BqdDGHYt6ddFCXX7ynXHfNQfb2j/BBGMxZR5RUHY4rW+qX4nlONQYT4CoAZEJV/8UExUbdE+oCv
	XUM7449NBWxgMLT/k4ygyllL0b69rrDKyGXRMLXPcr2s4BMqyqglTrsxUjRy9UZxQiCY2Mwq80S
	WGracqAe3LEGkFa3TEfQaqah6KlafM7ol+28PmBBd3/TbkLAQCVxMrihqp629+cCOzI8VWxu+xV
	HK4MVvchTS+UEP1BU/8cTlCM164QSmTqvva0a9/Q1WI0lKAY6clVmQZSdpOVdC+GfW2LMeKDq0I
	w1YPo=
X-Received: by 2002:a05:6214:5e05:b0:897:1e9:578c with SMTP id 6a1803df08f44-897347b028cmr142895106d6.4.1771331346239;
        Tue, 17 Feb 2026 04:29:06 -0800 (PST)
X-Received: by 2002:a05:6214:5e05:b0:897:1e9:578c with SMTP id 6a1803df08f44-897347b028cmr142894726d6.4.1771331345677;
        Tue, 17 Feb 2026 04:29:05 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7691c48sm348833366b.59.2026.02.17.04.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:29:05 -0800 (PST)
Message-ID: <10fad67e-52d7-46b4-b785-d6c3f556ff20@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <b9c7aa89-b260-42aa-a85d-9e596e78e419@kernel.org>
 <20260211104153.r6xz7ya5emxa36cp@hu-kotarake-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260211104153.r6xz7ya5emxa36cp@hu-kotarake-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMyBTYWx0ZWRfX4ILUOj3c38V5
 06o2JMVxMlxUrLkK7mmOUgCZGlL8q2f+S0Q3U9HODkATUBxa+3RW7Jq8YaINYe018wc2IbHtoe6
 GZUMx9p7SPoXTHr3MHqRvvX8u+6WJuR6eiFComv0VTOQ9iY8e2dVKu6ic+KESaxeAehwTH/C3eA
 tLx5mXT60im4LniGF5GZ9a941wyxUAprInGOpxupN/eEBtTz44+N7IzC5pa4bYz0I0Z1btSTQj0
 izfQT9jEi1iY/xG4AdAIs8K4iHjhRG+fmRMpR9bMn5Y3fPG5HuYWsHxqo/zyR+dhvhBzCw2oQtw
 i56B7N86wpidSCqw8Jf+wu7RrRVOHtN6mx+WdjAf7xB2Cwq27E1AsGoSng2Y5JxgWwhuZmClmw5
 i6/9P6FB62ZnrpwmHasiRU8S1BLIm0hBLN5hXxrPoiFMtpR7nVacJFnn3PwZBWhlCnMsY5SYpzJ
 e9pcGfXWvffkGzMr7nw==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=69945f13 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=9iDGNwz4qdmNxc66HVYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: GC4_2X7ng1Mv4kSb8mngycE9tLyG-gq9
X-Proofpoint-ORIG-GUID: GC4_2X7ng1Mv4kSb8mngycE9tLyG-gq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170103

On 2/11/26 11:41 AM, Rakesh Kota wrote:
> On Tue, Feb 10, 2026 at 09:32:18AM +0100, Krzysztof Kozlowski wrote:
>> On 10/02/2026 09:26, Rakesh Kota wrote:
>>> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
>>>> On 09/02/2026 14:23, Rakesh Kota wrote:
>>>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
>>>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
>>>>> documented as a fallback to "qcom,pmk8350-pon".
>>>>
>>>> Drop everything after ,. Do not explain WHAT you did. We see it.
>>>>
>>>>>
>>>>> While PMM8654AU supports additional registers compared to the baseline,
>>>>
>>>> full stop.
>>>>
>>>>> there is currently no active use case for these features. This specific
>>>>> compatible string reserves the identifier for future hardware-specific
>>>>> handling if required.
>>>>
>>>> All the rest is irrelevant or even wrong. We do not reserve identifiers.
>>>> If you want to reserve something, then I need to reject the patch.
>>>>
>>> Hi Konrad Dybcio,
>>>
>>> It appears that Krzysztof Kozlowski has concerns regarding the
>>> compatible string reservation for future use cases, noting that
>>> identifiers should not be reserved in this manner.
>>
>> So do not reserve identifiers but submit bindings reflecting REAL
>> hardware being used.
>>
> Yes, there is a real hardware difference between the PMK8350 and
> PMM865AU PON peripherals. The PMM865AU PON is leveraged from the PMK8350
> PON and includes extra features, but those features do not have any
> active use cases for now.
> 
> If you are okay with the new compatible string, I will send V3 and fix
> the commit message suggestions.

I believe the only issue here is the commit message indeed, you're not
reserving an identifier, but rather describing a new version/implementation
of a hardware block that (with the 8350 fallback) just happens not to need
any specific handling to make use of the 99.9% of its features

Konrad
