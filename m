Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7337C113
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932487; cv=none; b=sRawUJaNFJTmawcwoPDQmWEiuuawzk6LjZK5KXLUUXFUwSj+2cVE6t0t5KwNEnrZZ6upWF6ahXd4xo7fApCHlyOWPJVC+1fkcPHYQoXbCcC8LuQFuWa1NREdkknWksbo/lf3+6JODzQhkjtSajw00SJORrorvqp2vwcgak5gI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932487; c=relaxed/simple;
	bh=Kke3tNYzY/p8Z8MnBRLYILdDIXMtufHi00/zJVWlmIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdH2GkJ5W+H9y1+a83yod3AK8g/ziRmPnU1HACAjhavu5Ynwaqlzbf1F/2fdfOaSjOyxoDyVnQM7PKr2Osfnxmr2oZoVBlqNYSwdR2qVi7u/I6aEsfVivTXkbWzOp+BiOp3uT2CiddWgoI4N7wMc1J3Pr1T3mMLe8qBoxnP4xts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DF03rBkY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSyK084a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DF03rBkY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VSyK084a"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFUQ73884521
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 11:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tldt2vxdb/j7diXSGcWaW4T39hoY50fjs8hYeXvGavc=; b=DF03rBkYdlpHf8lD
	VLHi65qBGC6PvAaXaYPRQxBiL/TAMHLZTXyzN+ofkPqYgAOznfnNQTwQEfWYbESx
	I7AemICEmJb6HxbqZgYqOfs3gJlhAsts3bdkZH4rjj8cvKGLXumb/Pe/ubdHgFcf
	WhTey0D5nywlYpeqbIXyLYL37QhGVPEsMOgO1CFWtKCFihlG+ZghPhDJapEmB5h1
	PL1uqFQeMrEh3a3NoLC/mmxhUhblMbzpV5oWGkvKZjytoAyRbOGMqO8LtKQlXbXc
	b9WJ/7nQz5l0H2qTpvhJt5QHhsLC7o1V4ORI+ZkHjiDF0b6vreqx7SqnswuabPDR
	eKiLUg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8txwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 11:28:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb39de5c54so532770085a.0
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771932484; x=1772537284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tldt2vxdb/j7diXSGcWaW4T39hoY50fjs8hYeXvGavc=;
        b=VSyK084azX5dhGbq/vufvIzTMl+j5/US97lADStI40KsdUmC9mBBjF4LaFZlDPbd9T
         3PvUb99f92qbynnMSPCNDVYzn71YG1FDFKgUz6KneYfAh7h2YYeO/EQRUjrCZTf2pG7w
         AG8MpvT2uCA9NHfYwQQS7k3i4Ot1s3pHtcJgXbx0FQfLf+P6Csht5hI/pnrErhzISrvd
         7nOmxClGylNT0QH6pNv/Z+KPXQFAbDkyyUDY9XCDxEZ2hZKNdS3zUJpuJ5swojO/YSej
         OxqdqTfgtKulX+dku2FvR9HW7Tn2ZMzsmFiupgbkcUy9Z8sV2hjBDICVjhnQEy4EGMGN
         u40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932484; x=1772537284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tldt2vxdb/j7diXSGcWaW4T39hoY50fjs8hYeXvGavc=;
        b=A6lRflyIDmwlbEPyqYkpe9J1r/r1aQON/aMLAy97if9dfDAlylI3xPsvUqkbf4arMM
         fWJzZx5MsXHKH8+nXiLnki4dhyfC5Xk/xuXdUg5UDXYl0E9IDse0B5RhDqZwfqayrQ5l
         tBpd8KxAqxehc26baWPCtSWXez4ZDrGG1gMG/LJlNpp+r6XfehmtItQnJkS6JiUxcYEw
         k96K9GNfp8spdeDC/O46LQ9FtaRijO/7XjczV54TaTXXe+mkZ66ILbdIjCT6dkE/eWpL
         UH1AO3cLtxD4TFwbPgHQXYenK5abAKUarr+H30lJfuc2yllh8s7cAi00QtNbSXNTf5Ju
         4Q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG8DKVIyq7X3UKzk0DUcUg0RQToOwLM13yghE3vTbXxScL9jXDox8vfyYN2629C0M/xC+M+4u4jBE4Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymKohxGbkq/g6N7DXpmNxXX6LyGraYlZx4Eo3cUG896KxgTORG
	Aj/KwypDMGMby1tZNDxXY4MT1V4xMv1/LyakmN3TjSfZDSTiyU8Bx/dwNWnZUDQTgCOCuMAEQUA
	MsTdVTwWPdjweq5SzgMqiichqfcDb0DkdtIJ5OYMt3CH9ChnIKggwj7IFnxLiBpBPOg==
X-Gm-Gg: AZuq6aLmuNkTjXVobXc6nzWYBr4fXeNJMk6phKwr03tdbeHy6P5kuXytVZ++Fbs5jST
	unCZNj1EFPLLdlT3P0ia/XQ39Nn5tdhv+u6ZWp5A7+PlE1S9zoJREuh7fTeL3JzO1iFKYIs+oN8
	5YjvEjqwfkBEtrCUHDPtfmZQgRpQZHLxwM/bqA1UAriCvhBn7BEfzkb3rBfM4b0ByAC+eWTYNLw
	e/F7VCrC/JaaH08494Sa43drJ5M6Glz4J2fBjqhm0lb1FkvsAZAdVbhyif6j91TTKFz2C6I8EGB
	uXzCMJ1vuZZD1hJ5+0tUO2tiLnh0qrPj+sg/kXsBZaoTIljynlOdtufWIFn7jsr3DxdnZTpFh1C
	wB1UViVH914PGrj3mdeHfslIg/VVfL/8Qr4+1yhbj2tzLo6bBdVyPRKscySqF5xUuGB9GxEO4CI
	Hqjo8=
X-Received: by 2002:a05:620a:298a:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb8ca1e9b0mr1136539285a.4.1771932483953;
        Tue, 24 Feb 2026 03:28:03 -0800 (PST)
X-Received: by 2002:a05:620a:298a:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb8ca1e9b0mr1136537985a.4.1771932483484;
        Tue, 24 Feb 2026 03:28:03 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba2d966sm3497148a12.23.2026.02.24.03.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 03:28:03 -0800 (PST)
Message-ID: <5a86ca7b-9356-4241-a09d-47d37fbc3a18@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 12:28:00 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add
 coreriver,tc360-touchkey
To: Rudraksha Gupta <guptarud@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        beomho.seo@samsung.com, jcsing.lee@samsung.com,
        linux-input@vger.kernel.org, nick.reitemeyer@web.de
References: <20251205-expressatt-touchkey-v1-1-1444b927c9f3@gmail.com>
 <532531d2-8f26-4ffa-9355-7821a4d64200@oss.qualcomm.com>
 <1e74b956-a45a-4d3e-b7fa-e4d5dc0390db@gmail.com>
 <97d9d942-236c-4f8a-902e-0ad2ab684a76@oss.qualcomm.com>
 <1ebc2e1b-f1aa-4559-90a0-feb628d5bfe1@gmail.com>
 <aZvPUn2RxUHDahfO@google.com>
 <41b4f4c1-f0c3-4ce7-8267-039bb77ea953@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <41b4f4c1-f0c3-4ce7-8267-039bb77ea953@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SrhZdJcSoK-NAyje7QugdXnpaozvHUxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5MSBTYWx0ZWRfX6gVcZtElHcoz
 37lw8n9cPr5RVWLQ0pZgPGVmyOBTrdo+e3NdmUMtNhRzbSMy9lpccmdinNoKpBYPrtRgoegb5Wc
 mQx0+ZGwq3a0N4HlsErm1/4z4rA12PX1oy14ccaMYRUa+rpGNrGoj9h7oQ5uT6qqDQyQ60ViUFx
 br/Lbv5iu2uOoeIjTgqMJ3kREfpbab3S4z+ueB8kRMPMOYdu/BRusjYg79F2xia/lwcaQ09+k5x
 wQgUce8DF7qqVXjiwTErQwQIOk04TA1FgL0q/tJiMA2jNxjXenmr9d6SgEH56z10Dh78COPRu+C
 NOhsqD8NB03DCoLE8F+kgIsaJWdtbXQCSyMf3jQgN25ULV+Sl07eZ0tB0IHWyajA5TAhmzGw+Wt
 5mPyGnz5+kBWDkLgpFlIhNhdtZL51phZdP710Jkq1uTe5b59//+mndSHxyd2kSrHlgd+oxhURaB
 mizPqzFUMgDHzxy1fsw==
X-Proofpoint-GUID: SrhZdJcSoK-NAyje7QugdXnpaozvHUxU
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699d8b44 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=9-nzwwa_gMk14nhaKgAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240091

On 2/24/26 2:00 AM, Rudraksha Gupta wrote:
> 
> On 2/22/26 19:54, Dmitry Torokhov wrote:
>> Hi Rudraksha,
>>
>> On Thu, Feb 19, 2026 at 08:33:43PM -0800, Rudraksha Gupta wrote:
>>> Hello all,
>>>
>>>
>>> Top posting for once (context below).
>>>
>>> Not too sure what the next steps are to get the tm2 touchkey in. Should I
>>> resend the patch, contact someone else that can help provide guidance, or
>>> something else?
>>>
>>>
>>> Adding Dmitry Torokhov (official maintainer) and Nick Reitemeyer (person who
>>> introduced this variant).
>> Sorry, I am not sure what the question is... It seems that you made the
>> driver work without any additional changes?
> 
> I believe this patch is blocked on Konrad's comment:
> 
>> This driver mentions a register called CYPRESS_MODULE_VER - maybe
> it could help confirm the model?
> 
> 
> This was in response to me saying that the "coreriver,tc360-touchkey" tm2 variant works as is on my device, but I can't tell for sure if this is actually the variant that is on my device. There isn't really any documentation for how this peripheral works and I was primarily relying on others in this thread to provide details to confirm that this is the actual variant being used.
> 
> If I'm mistaken that this is a blocker, please let me know.

That was a suggestion - if we're not able to find out, then we're not
able to find out!

Konrad
