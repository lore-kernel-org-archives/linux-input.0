Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2172372EC2
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351673; cv=none; b=DnqZENx9YxnpfVAgWb7nyr4em1HjdBLS5MBJAyoZJrxfZ/WTNrn+YCl3OdNBrvPlTRCGEVSLDgN8qVFMjC6nYY/eTl7N6ya1p7mUHa0hFd+gW0mR4qcGSQw9tn/AuIWwgSr0fEpXbnA/Sm7qxNe2viYLyH9efOrSLyPaMHAwl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351673; c=relaxed/simple;
	bh=lEH/0FVTYKey35oWiIRJMOOR4UYB4BRjSlE4Qwc0ta8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGJk4q39t13GUeoV9dFs6pagvM8wL4ldpjzUMCKCS9wXIbd81gRW3vCncGg8QvsC+3EyxBO4zOz30/JVRtdb8k64ifoE3CZauxrmELVbsFJqaCt0Uo7EEHuVMmojvqZo+TFZtLU48esm3L7UKTyazp2qBCTr2Gnbvp5Adfr3aVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maaJc0gp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hs3XCP+B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maaJc0gp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hs3XCP+B"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OLqLok486364
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2IoxnuDNAwtIVygEfamkJMcz5ltQTuXoulZAxcflDI=; b=maaJc0gpDeT/uRtu
	1ZbDSakquHwFQPTLlZTrriiTb0oELBSIJb15sNhTZIAI0UhN+NG5s3LnGIa4UNWp
	eEJVb+atgNPeY4GOpdQEMrJCvNhGL29DoRUxudF+MEscCdfPYZknc0DTySttkR3r
	1IqUqQz1rY4fsgNh1JtEuxDQOTBWjt2CFmJvLdVMzQuAyT9187/RyIWb2Aeg8oJu
	ziBEhiofkgdhzvd7ZLAfS1agCQo2GcwOU7Bz2Y/czSYB/74WB1SmwvousdJw8xOk
	fStwj1Tn2dr8aHDZetfq9Eqcm8gyTvDt1luXERGlA6FinG/8RVD4idRzLimZKIXg
	AvwY6Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0996m8u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:41:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6a9bbcc53so15997185ad.2
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782351670; x=1782956470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2IoxnuDNAwtIVygEfamkJMcz5ltQTuXoulZAxcflDI=;
        b=hs3XCP+BTqwFx11Pnkq7XaZLLF+XDegoPOLJY7BpNsleOrZbDgxWrEVZT+AUiFpMWM
         LA6pDDGva2ofkMeSE9SUSogpyAbdxYfiRnpLIuXWlpabz5wkHWxWrPlQ8ODGBeyq98zh
         x/a6OvbJ/ojTQY9gP+MxDnOSuUKfwQuOE2LUkiMuN9FZdU/Af8+hoih/p16rR7PYhrma
         DdvImyhga9i069L/NUnkO5BLWuh1hdIAZN99cTSMiCztTgCP/tNLD43wXwDrE+T1UIZV
         XiyFW2DRgQ8jX8E9mZmlCsf2P06W5kDtaoCzZ3N07ohzTDquPp0+HuMxiZwoy3cxvtVx
         jWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782351670; x=1782956470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2IoxnuDNAwtIVygEfamkJMcz5ltQTuXoulZAxcflDI=;
        b=scdvwQRckaNoIM9LpGpGHZ6OoF7mwfP9pIjiZzUfX4LIOYjaY361eQT6Z4IBvNa0V8
         /AvLUXtZxxDnSJ5YQeqwHRtcL+LTqLFQNKNnuV2VSptM6tgm34ijd6yhHFeEf4VqdjMp
         s878Z/5kDCvlID8XWpPYJ7HYqUER7KuKxtztzYSFOmL50wayd6vAzps38N1j4Ko36K4s
         PdWLyJEe6je12M8D3o6yheA9BlOJYG5pA75nNKUp8kQFRqWHPCgMAThuMfeL4pxNo1Gg
         mttR5C9w5fHNEWmgr/Iv43gjN6dQoVnmwQBiIbq5mHNU3S0KJ0o8FIOYkBA24mhCN+Ld
         Mu5Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro2SU/O3/jARd5xpzacb+KrAf324Dcq4YmH9QbUsRXHLU8VC6ZCJ5kju/C2/9UxLY+/dS9zZzEnSsKE3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIU8TCv+ohsVpRTFfNYVqGLvzCSZoqdvgFKlnQuxLgswFH/cIA
	tVcA/aiBUvkEVvKgtOmA0JM9eMFCcBdsHBLW1Kvs8BZTZHyDmvxqw0g5UGwBs4kA5bss0v3Hfy7
	6gbaarWu7bJP/PbCZP1xBCBB9tjW4DqWrOnapdUKuH0lzUKM6s+AZl3JfhH4G9qkd7w==
X-Gm-Gg: AfdE7ckSZWaE5KCgB1/9Tr+KXVel5s/NL5JsElIdjhQxMh8yOoUZfhcrDkFMLOn5bc+
	OotMsGXNrq6A4JgU6hLUMFclwI+sLxBnUVXPrBG/GPWyCL+rcwcIOQP/pAayykZGWT5z3BxM1Sq
	2vjzu0DcEtGC0Wi5s+8qmBDTmsa1oPC/JaKyPufdScVTP+3Olag1IJ96ZbRqWpxlBlIrED2GSr/
	r24AKWfBM2HXytsiloqkpbNypbcwwKAZR9vahM2yLDGYsXbhkppV933K7niTmbU/D7IZ8XL8hl1
	aOexjLmmBmlqHFE31G7YWywYWj7RvHX4+Bc2GQPxiGVKrD9GulxWVwtUsnwz/1oJDNMwqz1PwxF
	xejwlDo4qxBHFxlmwZf6+/bmrufGk2A1TQmt4
X-Received: by 2002:a17:902:ef03:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2c7fc88e6d8mr5510105ad.9.1782351669901;
        Wed, 24 Jun 2026 18:41:09 -0700 (PDT)
X-Received: by 2002:a17:902:ef03:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2c7fc88e6d8mr5509835ad.9.1782351669439;
        Wed, 24 Jun 2026 18:41:09 -0700 (PDT)
Received: from [10.239.155.28] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae7a7csm8373935ad.22.2026.06.24.18.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 18:41:08 -0700 (PDT)
Message-ID: <36043887-6bbd-4b2d-941c-bf222786b80d@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:41:02 +0800
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
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <4ba2eeed-71f8-4799-b261-e4e2c268043e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t81B2eT50O1W58L9L0TLxHkX9JEfj2vl
X-Proofpoint-ORIG-GUID: t81B2eT50O1W58L9L0TLxHkX9JEfj2vl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxMiBTYWx0ZWRfX7NVJ/g0aEKib
 /+VnvnlrQjBx7LYYL2+sPpU1Eb3aBc96leYRySsvRuq4NhYgXgmld+JUyCRpQhUReaOEUb2axg2
 PP04HupjORG5zfnxar7h/WB/0U3zAwQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxMiBTYWx0ZWRfX9Q9aV07YpmmO
 s93YEDmeuntdgaZa2sbVKdJddgCckXx1pAo3FnFTM5SIC4/mcydqpBNsrMM8qie5rq+N1zKfBlt
 /XaL9dsXODbWsh7ik5Yuwd8lk8gcVsEHkuArzInaHziw6b6C2PIKyvMdGHWoJ/9NyR3ucyaBo4o
 bcm7ddFrZzfQz3cgjmtXEx/vlcX/SRV88SmGpZ9m6MUNRLPBV0BXio+f26/KyjkJnvjK+/IjfIt
 RbL2Up94ElEAOEMvHuC95l5Qz3KoPCn0Pb0OEUJ/S7gqWmnN4cT7Hr0/vPKDoxVKweGR4Zpe70N
 NI+L6/nTOaEA7zvXXh0MC3ynxRGaCeOWR2cW4HU5NFmQghvJTVuGexB+CZCvw62mAvyLFldup9e
 cMwckQf15kdf4udh1ciO2Oa/Cj42soQP17Gf2X28XVirpez25nSjr182wYvlAETF4ZBNXJGUio6
 yv4MLerInPPZ9Bg/JDg==
X-Authority-Analysis: v=2.4 cv=Tv/WQjXh c=1 sm=1 tr=0 ts=6a3c8736 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=miLeENm1gDbChLBegJYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250012


On 6/24/2026 6:05 PM, Krzysztof Kozlowski wrote:
> No. Act as maintainer. Clone Linus tree, apply the patch and see if
> everything works. My claim is that nothing works and maintainer tree is
> broken.
>
> Best regards,
> Krzysztof

Thanks for the explanation. I just did that and I didn't see conflict 
when applying the binding and driver changes, but I did see a conflict 
when applying the DTS change. I will drop the DTS change 1st and resend 
them after the driver and binding changes get accepted.


