Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B373EFD2D
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141452; cv=none; b=fkE94D33rE4LbAbZhZMDeTF2x+SZnJ+cG9FGAXMRlZlYSKQ75WGbzqcHjfiixeQ1m7rZmFigrs8UTBIv+jtubXEYfXEm93ud5zI1g7Qgu+JlLSsjriH/1LyrMr/0IqP8XPjGikG2fdPNIxfWGDsxsvREBkqlt91zxsg3Moz2tJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141452; c=relaxed/simple;
	bh=5rX9hvTS9mKTBg5ndn4tdrp9BOneSpV/KhbdJmbZSZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opc2f5L7u+BmREOvbxZl9K315yt9d4847DsT0xR3XaWsoL/ZoC484qj1ejTOSeAIXHnptXNaJEEx+hMmXc9+dj6olOnNepr1cwysLhOHLnjMxyKH4cppdL12ODkR+rWgp/t457pbehM0lEveRCIpN9FV5GlZJCAOdix5uywgK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOFmg6Df; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gFGwSyml; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOFmg6Df";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gFGwSyml"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm9Rm1090915
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BV+QhMBUTp1YznEgtkaGXEsApIL3NyQC5pcNeHbuXBw=; b=bOFmg6DfOzZ8hu62
	ht9ozoFEEXIZONOEmavQTDXyjm4WyzssQbnemWUg8la+WlAry4sg1J0ufCZCxBgi
	ndl0LL4jG4IJFWUbWNILJv837dZVkIewSsMbOdm8IPyDJiaw8OIe2fFwdMihTL5q
	vrKtq0+2mdPsAyw3Co6sh7mxsA9Zz/GvyM2w864AKvP9vb32aH7uRh0IU5H38JwI
	DuviOCQwdOr+GmbNNm2XUnWpXxU9ypblAqBnxZJJnEKT3vVoDyYX8Av/1tehIssz
	AEw3vO1A4VrpBSP1kTRW+krvLUvjenM5cTArYRWJQHtv5aPdBDZm31oZzTNSyU1y
	5eUemg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd3akrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:44:03 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bf9ff71075so61897e0c.0
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141443; x=1789746243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BV+QhMBUTp1YznEgtkaGXEsApIL3NyQC5pcNeHbuXBw=;
        b=gFGwSymlPXukZn4jccqTc3Uhfe2ZNQ9ik7t5smCeb5HLwdwCMHANG2ahmgtcONw81+
         pddK/UBrxVubjZzPSJi9DT/iCyzhtE93Dut426FmVwvXTXgI7o6Pe2Hb8s4DC4EKmHZ2
         FE4alxTDdfiW8M6XXbfkZv/fgbdMVhjz4x2NsRPXwj8M0iokkL9YgZWtJfDEUqGOQLuy
         rLWEV1WuGLCiPutD2JrTKmuqpHNpOgguHwHSJpS40L4UO3VnzExBanFy/rJtJR1EirAa
         ayMvEhT+M3W8QYFcw3AaiHKPtlz2pnA3CUSCmqZniidsqcKRP94dckAjEGLX1ixvhof5
         vunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141443; x=1789746243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BV+QhMBUTp1YznEgtkaGXEsApIL3NyQC5pcNeHbuXBw=;
        b=ArXfRB4UbZOwK+KL/Uk4ewurCHQhlS683B5NOh4yJ1BImHQJ7qKy5zNjb6RKetOUKT
         T6Jr/nwX+Of/+fnQB7vLh74M9zrcR6mcO5jqN2jqRhhveYcALCx4PG6S9BJbOVugk+I9
         TXfOdPIKUKd/kJNO5Qd+/x6shrC08qOJQ+COY/Hq3zE9k2VukvNeeKNuG0l+nEk92TdC
         TSR53/I25i5xTvw5spEEIL/YVz1HXnnjZTuLVcN6uclNYnygXQDrwXn4xF1WvsCiWr9M
         GREPFUTJGlqsHdto6L4XyTBnZHnoo8yDykNLksWeiFGRqZGNonnEziuIcEKJkuL99d5O
         slZA==
X-Forwarded-Encrypted: i=1; AKwUvBzr9DfZuJX6V9ED8f5tHOm3kwjvNRNHj9sOoeQm7MmkORcyeYqaIUkSAVeRe4pngLua6gOCmD44DuxYgw==@vger.kernel.org
X-Gm-Message-State: AFuF++nbjS7b295ayP8PMGkMrzGi1JGU7bVPcmWRPO+167GCdVSMBEoe
	DRQqZJ+RMB+halRMQy60zXVPEf0TA5BPj0kjy2gyWpM/9QzeN9cwMCcU8zWNgz++EYwd7UGqsta
	8L+qKlBHaEgAo09QyhkXeZ/E5M4qMLdZqWsdDF8JTyYDgCI1XEKbWhNwOV5dGixmVOA==
X-Gm-Gg: AYBFou0HqHn++5qD4V2vjBJd6WwEdo5xySRhmm/ls3gyFh/PEYxlHJdZ8bCb8pWF15L
	+zDCKhn+wz7grwdhlINc3LPZA6ZcDSTPBznz0lp817yRL4pHfzJvA25cOpRmxQ6kJ+mbaZg6P8W
	1f/QljBPjM31ewpohngm0v7djopZhWSwnkbu8zfpcN5m2XkDMfNb1DKCAriavwc7r95dxtfNH7C
	8G9FywEB39yaZypIEwWJud91PfXH7rgnyxrTPZzrU1v69r5CxT2X4YWrgQ94AfPd/nASLbYfGrE
	sWK17kaDy9+zgZscxtYZVLZJFCYA8kXorimH6eK2yWjhGvi8Sd4j0ToeT4W7nXV4cD+qxMaChfn
	gk05Lkcw1tq+0wFd81OgXoA==
X-Received: by 2002:a05:6102:f9c:b0:795:250:3c56 with SMTP id ada2fe7eead31-7950250766cmr511027137.0.1789141442974;
        Fri, 11 Sep 2026 08:44:02 -0700 (PDT)
X-Received: by 2002:a05:6102:f9c:b0:795:250:3c56 with SMTP id ada2fe7eead31-7950250766cmr510990137.0.1789141442547;
        Fri, 11 Sep 2026 08:44:02 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296598e8b0sm100060466b.0.2026.09.11.08.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:44:01 -0700 (PDT)
Message-ID: <2fd56aef-6a03-4af5-898d-8a57e7034600@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add
 touchscreen
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
 <20260911-eswin-eph8621-v1-3-db447ff9e445@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-eswin-eph8621-v1-3-db447ff9e445@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa421c4 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=T5nqnGCD1gggo4biR1sA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: FmdFbKEXJiFlK52bbBaXdnbOAipwSP9N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfX9geuBDTvU+3B
 kkfkekTpyeaT9kjvWb/EgS5om+JEpmBD2LpuN7767bGaznEXlk0+cHk4oZN+iBa1xhtwTAB8tge
 uVBKf6+dq0RIqJGXBOnZRo2tVsk00D4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfX6JC5u21o1UPf
 FiISpgcsmrQxH2+vQyqiVanWYmTrSag1qIYAzUguaQzLoN8QvDocuxUM8xU8qgDqpLKSadqFQ65
 3Zeo6wl6lV6mEcg3XkchvC7HEZUnVGj5PGP7B0NV5taibGL67fdd82bJAWhaEx2H7C3vekh9aEi
 kdqNUkRj9BBfKEhWvJ/GBIdCjw27EGQq2pHpgqF93F+hxtbLV31ulA4LJxam2pSTrKhXOu3/Fsw
 mqJBowZu+i2ijlZ3WfP9UiYNVwOGx6bp+PwV7JEzH0s9beBwQEf/Vz2tk1wfgm4u6qkRZfu2cf+
 sDvPzsb253JSnizztLKt/t1YGqp51I8/k2BRtXxPvo2z8POvj9XundO+YeweuO5wxJiKtLXQTsK
 6Ez+o4tUkE0nVZoMBdgEi5GuGTzo632g8JpyiCyA5+eZyxIbVqDx7U6jlP3VYpt0bV0SazKe3bU
 p89TGHG6+IPlrT+72tw==
X-Proofpoint-ORIG-GUID: FmdFbKEXJiFlK52bbBaXdnbOAipwSP9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110219

On 9/11/26 5:16 PM, Luca Weiss wrote:
> Add a node for the ESWIN EPH8621 touchscreen connected via SPI and the
> pinctrl state for the two GPIOs connected to the touchscreen.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
