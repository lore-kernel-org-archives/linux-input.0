Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2639281B
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285621; cv=none; b=PpapBDEqf/LTMAieYRKJbkHl3MLNgf58NKKGyyDxfjUBD6nLzLmnoYFs1f4sdjJX7WsE1ADbq1u6AB9OKl9QpY0n2wk1kCzi8qK2Xc3eneC+D9g4Li5C7x61GBiEGZvV7BH+212+e34Rzok7tILz6tAxl+9hE8jVtmc2kWFCo/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285621; c=relaxed/simple;
	bh=xlY0uacPa01koNo1kE2f0hDhz5c8EWJ31wVjZqXkscM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFvFTBasVg0UoAthN8Nd+W6DlXprRqlCqycFoExKaBqbNHcxrIQhr6ofauAO9vrIFA3XThTM+ca83iROp7nCZKQp5K9fUHn42G9uEdjdlLNVgsSpwCy4OU1pJFK45Psa1Ls8Xdvzfj+tNQVAvviD1dVeCiVNlxD3J5Ifm9xXhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeoHuvbB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bnGOS53T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeoHuvbB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bnGOS53T"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5tqBx533328
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 07:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwrkizMYse0bcX80v+kV5BrSxP1cuVvt+qMAhQ+ZeWo=; b=YeoHuvbBVxVnUEKy
	FDPm+q5O2hu6yTQaExhdS9jB7ne2OpxgHjVd1OUDhk4CM1E3A0/0Fsu2MB4Nt2DK
	8aTnqTDx0ka5eBPr8ajQl1fepxW5cTyDwXE/jEe/cmtZFIhqxjgjy+pF+30kEXo2
	APU+w0El5yWrfKzRQgyvd85HocOhr4yeZ8pu5pfuP+Jtf08g7hA6DX2CUv9OiwNk
	n1Op7N/B40i+xRWloyLg4+HZYbMUaRifu17ZU0wniyrda6eSfplfx35zLEiLPtY/
	ayLpGe4Eo8Q8cTvvUCdek/LQUrfbWhM0foW0H9z96TVE67TbNA02n26hYDb26wIL
	WEfvKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r30uak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 07:20:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6b7d5118fso11346325ad.0
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782285616; x=1782890416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwrkizMYse0bcX80v+kV5BrSxP1cuVvt+qMAhQ+ZeWo=;
        b=bnGOS53TI6iVlW9M50eyz6w3QQGhYgrzoplXfPpIH5EFIqTA2SqRfNbZwo2QXcTQFI
         TG5rGGarnYw/0dsgIiZEmuYJGJi7OD76A45S2wnYJeGJv9T8fMgJNoh5DL+6YJa3YUWX
         FtAP7tqk/MF4yDQbDGSPfekuGUuHf+EOKcNCugQyMWgjOLJXsJdsVbXBLmSf6VR6HmBK
         GXGraMkMjxRYzWM9xEjUJVgA+DDTvUbdW6dEus2yHllqCtGhhYZcz0tYBFTjghJTsz+D
         NmoMyaUmUVDxcn5IfIYcevbC+cidg+4WCgHbpa8udxshL5aVQGYShON1FkpveM3KuMIg
         55Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285616; x=1782890416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwrkizMYse0bcX80v+kV5BrSxP1cuVvt+qMAhQ+ZeWo=;
        b=c4PA3tmOsgliaBpVQ2gnuBwoWFYt38LbPDC2100JstnWPIbgFBKlBUQBXyV0JnpLqo
         qjvKigY0skTf/yDbSCcjhAnqNXiV6kczCQBlIhbFc/vTt/4J4qWTpUiZvt00K1lNw0Wp
         3aelxz29/j/czLsKREezafCLbPZbrz0wNR0HlQyk/Oq7MoXT+xctZAWF4WoxGphHxROb
         m4m7H3mo2S+xQsdLAHtteauwyIujZ455HZ3Iuhi204ccnHpB1KVIPwhCOFcMBqL2bQD0
         PohD9MatqgZoEya6jIEI5JzlOvu2vIssx4IHW7CuRofWfftoRfwniisJtmsRbhi7Vpqv
         UVUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTbLpUr8sLuLmlBLvrxLCkZySrHnjh+wRxERi3sQs7/8eAXHUaxLg6cjF+mf7Fn+g/AtghrASwwPnz0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywixh0dH9JbpAG7upWdo3Yb/lSW22FO31CWuO0OqdjfRoGDB64p
	aJzzo79M4llqqP8LC0Wws056YucFTU//cPSTop/4dyaHUrEPi117g46wbhHBrkFbTfrVV8aRdF+
	fMhZHeCO+BVhaPXKBb0Phi/yhqFiVr8e6p7FcR4Kwafb8n6N1z26Qocd8+lToMbv/VQ==
X-Gm-Gg: AfdE7cmLPWnHnp+FDB2nIB65dvxLSGBI4EOgweSsDbixw7N1PzTQaLAKIj9QY9VV80n
	QZJsUodr6No5r5dGd8LIhXTRNXVBzLgQcNfL10biQ9WhHjtjE8k4kwr6udH2p2hGfAYO5yhvqpY
	RAA8DzVhfMRS+hrndNyoAnBpZMl97mvncH97Aa7lsLJfd3a6I28xV6Z5Mbmyd4f37oLFbHRse6F
	w0rBiGawHyugsqp0DKyfyp+iWyAhuK1NBZVoxjMzrOfgNQmaIXvt/YCs6lX55AiSNbzO+kd9Jrz
	FIm2Qt4A4tu0JBlAnNzl/rIhGTcW9BO+l4fZ2pGen1xFwx2GZo34WM3nQPOvU4aQMZu2AtPpHtV
	E3UlZc/vaHy19FKwwdAmmPDmFEYekrrrepqIO2b9fL+4pBGcH9Lxqnvox/bZnj5DMEmdX/TIHwj
	v+fRnv
X-Received: by 2002:a17:902:d54f:b0:2c6:a2a2:13c4 with SMTP id d9443c01a7336-2c7e14e7778mr25647875ad.24.1782285615573;
        Wed, 24 Jun 2026 00:20:15 -0700 (PDT)
X-Received: by 2002:a17:902:d54f:b0:2c6:a2a2:13c4 with SMTP id d9443c01a7336-2c7e14e7778mr25647445ad.24.1782285615126;
        Wed, 24 Jun 2026 00:20:15 -0700 (PDT)
Received: from [10.133.33.188] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f86d0sm119429115ad.40.2026.06.24.00.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:20:14 -0700 (PDT)
Message-ID: <be2b54a5-ce9d-49a2-80e1-60da874350d9@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:20:09 +0800
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
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260617-spry-greedy-chital-1276e0@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA1OSBTYWx0ZWRfXyucZPKEHzuSJ
 ngwgMv8lqxGL1jh4r92SyBCWPvByBzH4cQNQv5w1xtUC5XfF86u4FPaGPBk4O2+J8Ax7eLQdrd5
 yq0LRQlIX36RSq3gcGjwMf4iFMqCIvcsAdXyBWs1+T3JSUthvHnsvyRPUyfaJ9hbKUCjKWWICfI
 asTfySkCgZY7tzgEbWPCmqhg9FlqrzdY0QbZe/eTvbv95wObpws96EQ4ZISUcoVIkIZGwNx/vDS
 H/sF0yO63t432RH3YkIvIe2zqDAy8sGxj0m/Z5QkMUqKe4eHeGWvQp3oqxJw2AYvAotbEl8qVQi
 45Ol99IREHbKNMahW8y2Z/qNiJQaZ+chZSLjXijoc46w3aTIWjY2W5Sfs+N+kiS2B0Asr6opTNN
 NJHzr1VzXc2YyVjb24qTjHy5RINI7A==
X-Proofpoint-ORIG-GUID: -UYtYHl4detN_j8Ewb-vNkhNF3bkN6ps
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA1OSBTYWx0ZWRfX/aJtfpA2mxer
 OadRbr+SMVCjXy6+/TBn6Fco3jG5K22v1y8POqnKdxagFeSDHnDsKd9XOppI9MqQAeBfKG1X2aA
 TGWvRHAEt1S4x2if/7aYOCoZBeEhpE0=
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3b8530 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pZM1ahQh0IU9lKbVnbAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: -UYtYHl4detN_j8Ewb-vNkhNF3bkN6ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240059


On 6/17/2026 6:42 PM, Krzysztof Kozlowski wrote:
> On Tue, Jun 16, 2026 at 03:08:23AM -0700, Fenglin Wu wrote:
>
> Here - the first sentence - is where you mention merging
> constraints/strategy/dependencies. Your MFD patch depends on ealier
> ones.
>
Did you mean that these 2 MFD binding changes should be listed as the 
dependency of the MFD patch?

https://lore.kernel.org/linux-arm-msm/20260609-pmg1110-v1-1-6604d0adc907@oss.qualcomm.com/
https://lore.kernel.org/linux-arm-msm/20260610124119.253456-2-krzysztof.kozlowski@oss.qualcomm.com/

>> Qualcomm PMIH010x PMIC has a haptics module inside and it could drive
>> a LRA actuator with several play modes, including: DIRECT_PLAY, FIFO,
>> PAT_MEM, SWR, etc. Add an initial driver to support two of the play
>> modes using the input force-feedback framework:
>>
> Best regards,
> Krzysztof
>
