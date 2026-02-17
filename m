Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F007339850
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331255; cv=none; b=udLFtOFAr2K7B1llyKkEhyKstkpAcQN77pHVnBEcox+I72u978BvMb9edpMLIbSqVrr53hwEcvCiZVLAJ+IhmfYLe4ptM7mru+MDmBID9kEaTiIN2XBisYHS+zbZJ1wCfo2WqLMXseml6X+9xYnE3PoMXZO17aVWDUNxewRoacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331255; c=relaxed/simple;
	bh=m0NqDjKQV1IiIKGmVQ+XSPW7frvUNll6XnPkvEFYuys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhqq0ufVoMcf97oB0jRoO9PUogEIJhDrv6KLpxyZhP60A5dTrNCuq2TXq1JW823Xqkhs6a1RXWUaaQKDllev2PQHJuShSAWaRvvXOfsqX/P2ksf+gkYXGxwxkugv6Utljva//mH2maj//2wApnXnlaDkPBlzF5qiCmfhfPOXXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5H+jIen; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N1LMo8BT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5H+jIen";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1LMo8BT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H54KFG2111149
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=; b=k5H+jIenj3/xVCRl
	FEZ9XE2GHes6V4FXR0DYes1R71c0A/zS6JptXpxlzpRWdqVWbxADRG/w8BrFXWIt
	ni8Qn4hfH7d8yBSAUv4uHXBVxysiz4j33+9ziCkXlPwZQtJ+3oqZ0zUcfFI2azHs
	iX1YWMtEjqpX+djxKVs2Bb928D0fuVkQKuJBtCOD8AsgkzkLUagW0DbIKKeGNeyv
	QqOfeCOQDkVD3XJxTZF164XBVsbsY5tlBrIrZTbP57To0AfBGHSYV2p34AqlUYYs
	srthpdRECVm5jVWejyS0wjOeQSDc4UB3/Xcfc7ChycEfbbylK4tQ49AUvFtLEoBR
	NCIZqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4h1cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:27:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cb31bcdso305325885a.1
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331252; x=1771936052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=;
        b=N1LMo8BTi2NFO/K58OTyGFIIPHZtDTbf/+4yWD2yp9zdhL0jXghdF8LdGdhNU3b1N7
         bKmxVDO2brrWn0PbykX7mPeb2WLg2indykGXTNBhE2KC7OoSFt9T0tPHjeHZBoCbvi5V
         oVWSP5VXizFFriCDNd6C1AtPiOqdGJF4EBLCGCY8hBNF8yaWFTiedZo9YDCP9yNl1XKR
         WtlNvNyhsBpKphdhHrF3C+waNe2u0tQaZGI4YX7V3YkN00UZ2aSwGvhM5+s1W8qew5e7
         Z5iieeuusBIBauV9ETsCZkqkMQ31PNc+UWNf1B5ra9K23Mdzl23pg1gP8LAADmY19kUO
         5BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331252; x=1771936052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=;
        b=tjwUUpZtQzfddqRwkfYSr73JVV6vqhP3I3nn0B+qo0sqEU9RBo9lOOG72Hn75h9RXf
         qukD3ZFOZla73YYzGnqKKobx+OakJj8hcqijOsB+hEGSK0Y7JH9duhQDImNsb5SDumow
         beTXSFQ+/M/4omrJFu4kkR/NjFRdsn6w0EzsmWquzdWfiDjkmvVf48KwsYYIEQgx7IXX
         YqtyyAiM85ID59n0KrOR0iYVnGTxBFa4QnWoDj1hpBbLodpXpp0goqZw+i8++9T8zyIT
         B6PI6aJHWyu6lvbZ3JG97vybL1B9vSsK7L+Y09kgQnIxKvyqaKF4eWuYRVhuEMcLrtU7
         5JYg==
X-Forwarded-Encrypted: i=1; AJvYcCWD1KG06qVmUsIXbBWwuj/ydn+itBbWdWIQiE3OqvqtYgAxdTAySIVCyBwgSf/CB+w7CrCYxpaJ8DsChg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEGMkA6VL2QDGNhuN6+RU6RmS4rKrWtJbwuCFn+V5rZ50NH/7
	GHbCy00nlMMnQ7SNgxT05xOWK7wENK14laSe41qnR9h6ru+5Z6qxJDx8wKh//iS0pJlaupfSBAV
	dfn+/xCX4a7HHKYTmO95o/AIdBobkUzO2BOZyU65qaZf6aWrALHJvVkR37uMiS854UQ==
X-Gm-Gg: AZuq6aK0K+1IFmTCT8ZrJgiCbvyLpG9BawuQH5xHpskeMYzecKEkd56AfvMhuZaD3lj
	Txj1xAyHHUcNLolbhwEexQ+FHOWYflC0wgzw8ff4++CpLEw/skF9N0hqae+y+TyIBDKOGXGZJFo
	mYttxyaz7I8PdiQ0o3GaHmLSK0R8U0pAaxbSgLbzBd3RUXvjMVbupTRxuGg1By2TPw4E/K6YPCQ
	ipP7OoUxTaTWd+lt+n8dYZhX3GrB3AYHH4GbAjKF6nNblOCaVCUHr/+sqBkULqsW5+09lagvo4C
	/47Nmv0CsoKWjhh+WZSouZlb2mKbykwladUFqZfi1Th+3krEL+p2DlT4Osdi9BG6m7jjwUB8jhy
	+GYui8eUMQJI+61S6ETdQ33ultahl3tKb/m/8aRXcEZzPHMgZR0ARKEaInYAt49kXNN39IIR4tX
	0IazM=
X-Received: by 2002:a05:620a:28d6:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8cb4074ecafmr1366940785a.0.1771331252641;
        Tue, 17 Feb 2026 04:27:32 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8cb4074ecafmr1366938985a.0.1771331252148;
        Tue, 17 Feb 2026 04:27:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7691f26sm344142266b.58.2026.02.17.04.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:27:31 -0800 (PST)
Message-ID: <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
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
 <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=69945eb5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=TmaBVuYMn6Vj7WTXxxEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMyBTYWx0ZWRfX3kc44GaviIhl
 oFzA6hrF/a1gj7SxaZL0IZ4MIp8o0LwMwHRWR8eSL0b/2mZ652zc8lHAyiH9FYXIkg7iWu12MeQ
 JO45wXeMQy/7MDB7paWcFdUQSlDieRgdEds9xOYHfuWzrP1PvqyXsSoEA8i1VQnizP15sa5WFvy
 1ORQkaWNreCIUMLocaZhP5Zu0xFFrYm84MQHUHewgb37De95wVKaWWxR3/yV1uLcZsJmlnKxKjI
 w9mn/vIxFGHDmX5tZmob9sDJVHVk+Jn/DKEG8kDHLFFvB4GA8iT0kSlj25dl9WpMnaHP7MgREMu
 Vs+K0cAChpYATCqVGAYJRsy165T+vPDiDITyqlOo5YDUSvaJF5FffXcu6jyJJsKcr1Dtw8Ce8KY
 9ccbKfhWrRmhB8J9MHLseKt9vy8znpPjyy9AhIhkXWz7fuonA7osQ1oW+pJ18Kdq46G+cUTxCdz
 T6Wap2MKvyHu1uo0/DA==
X-Proofpoint-GUID: dnfwAC5-rG-vhdXa4z8ElT34uHJydP2R
X-Proofpoint-ORIG-GUID: dnfwAC5-rG-vhdXa4z8ElT34uHJydP2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170103

On 2/13/26 7:17 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
>> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
>>> On 09/02/2026 14:23, Rakesh Kota wrote:
>>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
>>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
>>>> documented as a fallback to "qcom,pmk8350-pon".
>>>
>>> Drop everything after ,. Do not explain WHAT you did. We see it.
>>>
>>>>
>>>> While PMM8654AU supports additional registers compared to the baseline,
> 
> I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
> an actual name for the chip?

Right, I would like to see some clarity on that too.

I see there's a PMM8650AU and there's two variants of it, perhaps that's
one of them?

Konrad
