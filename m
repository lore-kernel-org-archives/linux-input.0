Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DA4457A0
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385005; cv=none; b=CHkddcOhY9Ashb87lkvK6LpWSd7fFO5OENXyeYysEOrjPpVn+yPTdPUZpQ5WsGUKjmlTmswBFb+evxnf9TR3CbymvDZtEKvY6zpOXuh6ZajKoVN8oD7O3tVZfxMxIFrQjaMgFHqNytFEzt58CcvQ2jDCoKbreo1vbNUq75BWvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385005; c=relaxed/simple;
	bh=9NTdtJ/TSp6i9fELQDWEuFYvwbqy3ev3R+H2YTC2xv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT5EoDEIpp7Te4oqOcM3x7V6t7ufoznIjKGmyQMxjHRDhCcG0yI4B5MjCjPmbeGHcjimkeRCjEekax3bQbjv0oh3QMSLfxSTihMU4BYv78n9CuMU8lpikMwluBfLY71vgVVUUmClHK2eWeCo+qLZT1SgplVKBWSyPT3l3ZNF174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/WVOCmY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrOOQXzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/WVOCmY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrOOQXzi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAmLbj4032481
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=; b=E/WVOCmY/+5Enkgw
	YEeOQ9dPHJUB8CWxTR20yFYOlY8UkoMJaYfEbZw5mtWvnO47B9tf1wMQPeafNwuh
	wcPa+7jFxuwllxPm+71b/159YFvZtg/2RACZvfhGXsdX3lRflqfucbjNfAT60rpW
	nT2W6tgRlLZN6L+MSJ/TNerjJkANtic5DzviOrYF00TQxSgNoyEqEGVr9kcRPO/3
	gIuOu7yV0ud+xAE5Z0o7WnQCbf35GMdm9FpQLiSsBTvoxEBODy0Mr28DtrxMTC/P
	1BajQAshRn13edHqPJho+jbGH0cD+CYPJc+8jjhbFR5E60BgJZv+Py3P6XJNpBgD
	ZRcYpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq8abu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930a312222dso32872585a.2
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789385002; x=1789989802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=GrOOQXzirK52iSooMZE7aNbwrzlPThQRsTBf+/yQ2diMYPaPjPObO1I92W0+n42Xpc
         bfrDY7y1QsvQ5HB+fGXHAi3ymOIfpxChe5Lu0RKl0pDHdgfgROAhRU2z/lW875G5cgIv
         abNpxGCU65AgRptauwI52oMjrvJiWvN338ZPF6/2BHZ+bh5U+d+Ml0BU237tVzuRYKTH
         fGx1UY7isrUExwaeILSu8JWHaU9deNktPxdi7leBz2SAOfOPJH1stAPWaD3LctFyXxFI
         HgeXfee9ZohILXrVoCBZMHIst3arUpSdGb+cYpJwsz6QzcAbsPLqw6z2Aem0GcjKVc3l
         yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385002; x=1789989802;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=bV5DnYZudSsFtGk6qqSOcQsYWkf51P9QvpkV0ZQ5P/tDhvgaFRtPOam8uyPIS2p02k
         8tjy0pIo7k++1IjjOYE39a1uqJl6tbzEev0SbxD8iqRG9UnlogNaNIGwLAfT+cnw7bSp
         brZ7WoF+0fAjghRrnTGWNp3AKwGc0ecdw6ROZZpb4VIotpGKoJXSPpbIAaT6mVz2EJGM
         JjMQSoM7KjBG/PD/ArW03TzI7ik3GXZF0HUBNvC3FDRUPWEpUOFu/HAMsurrIIj4XzVx
         az/RA/1IUO6RMKIMxrUGcTZLRvv0YglNKI8hjhd3pU5UQlHCFyX4NIFMPfL/2X64wco8
         yMPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwT6dwMCnfu2sJlnLx8mhZatXWbGJYaj7c0/Zd6REnv4p4SwVRY9a0C1x/IdrOPw6HPF1PlW4FVzB8SaA==@vger.kernel.org
X-Gm-Message-State: AFuF++mgYKB/CwmMWB0g4Rv/X1Unr1yGxB6ioR2FVoT8hXbYrn2MZB06
	6p28+G2J7au6vul0Zaa33AyGZC/WgwzsoKA905hOueP++MRyI39+N5Nvdc7u9kLnqkF01Ylg2Qr
	9GvEP7rCK3qx2W3wP1w9usD6hHY3Q2/eHBjn7MsCckd8KHyEoE5iOilAEsRCVkJibrw==
X-Gm-Gg: AYBFou1TY/1VKLJ8hQwALoRWPs6R2IvkZqPmFzUsjJHcis5FQCw+8dA8RuRZIgOSdYA
	cFjY9pHrB6rOoT3wAw401WfpRWenUA0ObQE4KizQvvHkVX8yqb9K53Jmd2Ie1dufKU2hVo1JfVQ
	R6S8nnq0DygQyYS/+zF/9md7SNwjORzW7twz4Z+ngQoOGyyIGsBSIPsDecWpfo+ITHn/0iSBHxt
	EoQZW1oFblpYWvJDH6yxFhBvPA8fiSve0I76TUdDfdph6c0NfTQLKpLArC2Db4QU/JZXr9n18IU
	3fbeT4YRTW+OPDmFOW2MxlXVbSUVtmCfl2vIypYneacR3W5BxbJewkrM1VChUCFoN0TStwCUsx2
	5U5nRBXVArPidCz3BNd0bIQ==
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214249285a.3.1789385002609;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214244085a.3.1789385002074;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296601f4ccsm406660866b.20.2026.09.14.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:23:21 -0700 (PDT)
Message-ID: <757e124a-4c7b-4d3b-b73f-19e7e39f2677@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX10gJ738O/zOC
 MU14ynT38pe52zTKFaqGiJ+9GCNbzCtGFdxsK+KpRaQDGnnOzCkjKLHu0DgSdiEJtvclBndS/ws
 Waff4npL8/Arudwc1AcrJYPrr13XFMiq6fI61wG6FvMRG81Yht3wb6qocqUPUIAB02tpx931JgU
 Ptglf0CHWBK/zemKB1Cmm5nJr896nWfv6KAAsNHmjJlRJwbCyY4muk6iIQDvRQBZFSbFMGHyXu/
 YPn6z7kCJcM0SWgwOaLSQwKzbGZ8y3HJsX9W+6b1ZSAeJgCGafCxRGJEYmoG5JCIG9jJFNoFAgs
 398eQfcDvDfiin6zhoCK9fbSVvdng1ro2/9VhEjVZeWc+8pyEFwOUNff4rJiwtdWl7NSSMoHh2+
 JAxb/q/f6llWlVw6tjmjTqIKy0PDEMns1alauPGoZWgmJQSYSW+1f34WXFSBUGN+eCs3W/Hbhs7
 Nms/wqMxly9np7umsWw==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa7d92b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: hprGnlU9NCiRu9pj4AtOUowUFtV0vUrg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX6zgjuAT6Kfli
 /bhLamPRzO6/rcdj4gd3IVRM9kZs+bZEgT75xdPpZw4CGPUvWs9UEtaCndGaV/ph+EKWmW3VJBl
 nX8oDQZpGXDdZLd3Gs/sqBtiqRQYQRI=
X-Proofpoint-GUID: hprGnlU9NCiRu9pj4AtOUowUFtV0vUrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140161

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
