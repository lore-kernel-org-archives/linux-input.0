Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083435F5FC
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449464; cv=none; b=prXDhSfSZPTq9zrPdR01nHUVrRm6O+6CqEhG1PnDL8uI3BXd5GpRtjyhK5/YBKav7ysypBtvpLto95wWly4rQvfsgdTvQ+C+stGE3WTG0bPPjTpmafpVI1NK8pu+Jk1LaFR5wmqW9dRRxzgqOZZ1E5fZUFDN6mepyYTy2gkmHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449464; c=relaxed/simple;
	bh=K41JvuaQyeRwS6GPlQl4faLZBPG8q5JF8fXy9k4Pj68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPLDltQMbGx9huBf8bg02qYGoc+ZjFfLfKNI4beeJuEBN4rRvL9wM2dPspvirsBbg/XzgS31vSn9c52dcvCgf/3mPFDeWnlhNaucLTpUGZDPUy/NfDsbZOf0KFM7yEU2HxPewu+XrHoTo4NEM+2lEqmilx3g3fwgloye3hqfw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZ1dpez4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyYHOcRm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZ1dpez4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyYHOcRm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229EnMj3630795
	for <linux-input@vger.kernel.org>; Mon, 2 Mar 2026 11:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lCCmOAnoUh8IxLmdzuNREYdTDnLuWtjaX8sTzp297YE=; b=QZ1dpez4bJDficoR
	RhQ9Sb/0BsBhf+KyrowiYM+XlrAOe2p/WLjMTACPYW71uXsW40RAYZZB1MR9l699
	mXIkuW8bfNzsD8h4gp6cCs+ncFNcv4WBJ2hwhhw2zyzQKIEWGYPqsQPzXeDCQuF8
	HOl7r4ZtYbWH2Wv5Lkghjsf8jULz7jGNdYzRxnCsMfsk3uxQ0pN8ZezxOwnxo9H7
	jq0lgHH54EB2K+6YnKHFODRpiyb5cCmpI5Z2Sxe9W/PlC5BEPS984sQY+yjmq5OK
	KG+UdUyVsSm1D8/trBuXUnih4vxfdvgNh1f26Rh1q740PjEhg8I7fThUYiM+f6cX
	97pAkQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhrcnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 11:04:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb38346fdbso418036785a.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772449461; x=1773054261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCCmOAnoUh8IxLmdzuNREYdTDnLuWtjaX8sTzp297YE=;
        b=GyYHOcRm+PTdxU4Y5Q3kYXugc7ghiZ7ajHh4rtr/wykvqdNWsoJcfNy1kdUL4CmFq2
         yfPDuHvsziY1a32hZvhcjDZWhsXN6jX93mkpGzsF+HLvQ/33ysIJsqGMBwKXume5Iqe/
         M/T9kD2PyzsfcAN11JCHCW2KEdcH4V7+FD8Zux7l8pCu5IAEK2WVsjM4bJ7OgBxP+Ag8
         PzqKW+c5Wlhs64rlRgxZThrNFoCXi9RepXBZUQ4rOx+ByXkWteYh/6jh7BgA1hGz1BgN
         KMCImcUsHrAAZNUlsmYL5iCJNZpXNFq+q9MCqTwgvGm64rqYv9jJrR+M39smVstD9snz
         GqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449461; x=1773054261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCCmOAnoUh8IxLmdzuNREYdTDnLuWtjaX8sTzp297YE=;
        b=f/9LODVwQoZZP8IGecwj4KaI5BHpvAnU5W/lQcBICDPvdP705dyzUOgiDGyYtG8Z5R
         re4aqo3kvgoOLfNaNgapGv55Hm0ipUAst7JD/Wjqp+cCmlP1mW7maW/33AqM6AFS3Yun
         bK4vouGHOVeZUMMVszZUx214AZqtusaoDUY4fZk9MD1PcpaTyG/ZC3Rt8obvwbU3aqa5
         55Ij3sH8vms8S0pXJTLCokZVpPm16Txf487pH39uY2vPA9G7xzL5sO+FfaEnFA0fhcL7
         fZAZYq9jRsGzZZ5d0vVfI1aF4tAWI6YYXi3K6dXmDpXfVdDogSr5JsDuxfM9M2gA6V1A
         SRww==
X-Forwarded-Encrypted: i=1; AJvYcCUpP6RdKUmDZdXkzIBlNgcKAjLRFV0U5HIZ5bqRHBQzbmT40rdOYA3qyucmyYlX5pdd1I5RfCSGaerAEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSi4aWCO1kKga8xdkHSGNPCDxBSywcBJKOoPqCRKO5ffQhuir
	NaXr3GAmC5FtF9aNYMuEZTheLHGZEKwJZe7pSMTckWRHvd5lil7EFyWchxb0dd2RwT/lOD8yyj3
	hXtLlzFXq81dNH5XM3j3KkCVOCJupjs7wf5r55cGI19S1lGvSQbblwxVnDWWlQn4UoA==
X-Gm-Gg: ATEYQzy9RfvMw6uMHP+494xguUW+S/ocQp6q1uaXEtlSTUWgvsqVglUUXl6yf2VCYXx
	xXNr1LLJc7uGCu0uDJzffYf7Ue3qSmxgW7rVQmUquh0nJsQPlD6wJQ8Sdpo1i7l2sXb08NNQzXX
	Xc28zZokCaoevJp54KEukijjN7T3px3dPZPNNxwy+2liwPaH9T1LF8yF8XUucrNdp/q9Ylyxmj9
	fdrL3LTLtK73czzIBq1q7RJ/ub+XN1Z4vFTNZYNcC5OFoQQ/rMML+PqWUyKrBFjYdYh6gvWLlUT
	MBhDe6GkgQsJGvr7CQftojQKytTQDTewhPGFc/5q2vrPfTa03I3JuHeL3tPYC05siev5/2xGAL7
	Y8o3dDGZSy2x5Uygmng2IS7Q8HFyryep7Yfbgk0gmYFONzSdCOfZ6YBagAoH5c+xK2lf0FmxeLT
	ovZ3c=
X-Received: by 2002:a05:620a:4155:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cbc8f2348bmr1176613085a.7.1772449461141;
        Mon, 02 Mar 2026 03:04:21 -0800 (PST)
X-Received: by 2002:a05:620a:4155:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cbc8f2348bmr1176608885a.7.1772449460723;
        Mon, 02 Mar 2026 03:04:20 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9385836a84sm318934466b.59.2026.03.02.03.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:04:20 -0800 (PST)
Message-ID: <5d3694c6-57e7-4943-8dbb-41334086e8ec@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 12:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] Input: stmfts - add optional reset GPIO support
To: david@ixit.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
 <20260301-stmfts5-v1-7-22c458b9ac68@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260301-stmfts5-v1-7-22c458b9ac68@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: H5kql8BcTBtGe-zBAnC5-VA7EZNaAJoB
X-Proofpoint-GUID: H5kql8BcTBtGe-zBAnC5-VA7EZNaAJoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MSBTYWx0ZWRfX1dupvk6HPYKD
 DkmMX5bDwX7HYV+kLL1QBU/ap/63rw+H4j84kf8dieLOtYdRs7k9iIBkAkHHa/ENXGskHAr1FLw
 pKPKl5PxG1gSYYkcHkg0eDQcIeAMGWQAdrFYCzA5V3a3tlnQezlX2w1rC/ZII2ucnzq30rq+Wvd
 zA7/oyjSGzwX54LX14XIqeTzMxca5vdj5As2K7K+kO8BRLZsWeZ+107+4EaQCHZlx2rKqWXbaPV
 IlBW7q6Xh0nDaT+ldaCeSKEGADp3ZoegBN8lJooHbPcT+PJDAQ79C5dngYDw5h4R25umCdFpWCf
 qBWw32ItEJskMdDzU2cCshAPEXID3nyIqkm2DaBkiAvPJBk/bZEYGg133G5Mc3yqIFBaf5QJYBd
 sdDQENUmG1xMBf2D2tk+Sb0CXuQ+pt/lDRJMP++dqwPW3b5TsC2ntDbavk1VdFztHDKvf961tpU
 NMPK0a1TmmgYJZkiuKw==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a56eb5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=sfOm8-O8AAAA:8 a=bmle8qjEDyfOUcEunfUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020091

On 3/1/26 6:51 PM, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Add support for an optional "reset-gpios" property. If present, the
> driver drives the reset line high at probe time and releases it during
> power-on, after the regulators have been enabled.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

[...]

> +	sdata->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						    GPIOD_OUT_HIGH);

Are you really sure the reset is active-high?

Konrad
