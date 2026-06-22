Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35513126D6
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095349; cv=none; b=c0EDX/OWZjkfTRhw4WocdlHX5MZW4ANbiNLYCzLiHKep38jmB9pbi2B1YACrillPYLsO29caAq7S6WUOCL8pALnxD5gq/tQHyLdV6wpFr2HHTKFc/8AJ4tjCO/Qz+v//Hu6rW7x74UdZy9edUQBkFyna5gQvgihCjk56buY3fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095349; c=relaxed/simple;
	bh=Imnb8guT45fj+jnS+EFxeQAAPmLzZRhca0s8hOhxRRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3axyn+2WWdbyIkcOiVKZ8m8UxmXtRGYhDNbSqPEuJNufSIrtqYX4WealhZvGogHqiaDLRR6VhCo61dqd4XIfNokcVAByViw2fsKbmn8CrGMnOLj7wzVmMmWp6SGXdWaOLs1wlsN/GuO2OHYckKmuK21juB11Zb8R/LFOLcA724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jcVjcJGa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HnUYUM5V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcVjcJGa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HnUYUM5V"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LLt2qr2900247
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdCcN1CC/CVMzb2L+hRp7Ek9alBi4Jrp3KJK3rGj+sA=; b=jcVjcJGa12etEl5u
	pxQU19/zni0jREDkjsnWhG1u9VFEf6Ndr+cC1Lj4Ek61QohYZORtoboTWBoxHgEO
	4ZGsKEuja/BgP6eL8LOgSGAY4WUesjWiappR3gtihQ0PzJ55a1NBlZABfkYt4FBk
	2MJEyYNEYa8FH5zk8Oj4lnH+JMp1Tx82MyHY/LSsCkq61pxWofhgF04Kt0TKHw1r
	xgeSpFUwC/Cx1Cp3LaJEzj9yrSqRlF9GVbz8WuWecRihWlDF+uWPegWi4Pao96+H
	SJ034RkUS3vma/ENQZMiA+IHgInWcd3Dt6UwDGK2d/BnfSA+LxWdNGVsfq5YoQji
	LKnRHw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm1k48q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:29:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c10cd7df22so67504925ad.2
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782095346; x=1782700146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdCcN1CC/CVMzb2L+hRp7Ek9alBi4Jrp3KJK3rGj+sA=;
        b=HnUYUM5V4gbYwCX1WAONHW+sbw2D3wrCjeJs4FoDKkuWyan2TTR8zMR5V04NlicyHk
         hQzv6gR2K9Zpe5LYOA8dIWQ5xLgg68cx5BP/yPSL7HSFg7REDS4NHgYtbZrkuxATDw8J
         O/c5hpxflrIBlUeTsOT3eUujL7iAgw7u4TgKqLxXY45N7oQS4GBrlwZRyovcIbRIDsaV
         4aYPHA/s6H9uOa0HtZ64cTSrygyrCKDIqd5g3gijJurNdeIwRmCtEq+ZgMfdzrTp+Nc9
         phxxluJEwFsP9ZHmjQEI7Qw7VgIa0cuTyxBLoXhWTml6lHIbdNTZLaJyXbCaLdZCD4uJ
         vZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782095346; x=1782700146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdCcN1CC/CVMzb2L+hRp7Ek9alBi4Jrp3KJK3rGj+sA=;
        b=O6LWcSitHQU3gBCWy0WuG9gZ8kGvydilcsXj4FX1ID7M8x4Rq9YV6qvPUopaYLtsX/
         cchgewnU49B+ZZ0h3RTulHTolnxRuado6pQXWCePwiCxEf3gnchjrsyD5hsDBfR+lsVC
         DZlHUWwCTdAPkeFn008u+B9j/ACF2i8Lk1RDfrVW9iQek1W/PkweArKRVHIzab3uzvHB
         SciCc8VivXGEfj96vFmfV7pteW9wfIrGWn6iED0lE8/uvMTQF2DP3dC0sMjDn4KuLTde
         5dEHtfOB/oBdvsTCMdnGH61Tp90QjtoL7QTQw0F9snlA9jjmIAr+H/rsla5sWq836phb
         LHKg==
X-Forwarded-Encrypted: i=1; AHgh+RqO9JXLoR/fbKx7iIPN1y2aJ0c9rm3rFOGujusa2TB/AxqliVTY6pLkKFyXKlb3aCqaP4j2cB4K9HXi2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyelotsNy9ZwSCDsd5YLVjQajfPA86LBDT+IE9isVJzlsxMU9DJ
	e7Med52iQRNsl6Xymmre8iNJAn/DcfBcWk4B1lPbhmP4reRxHM1FCuS5jfNPL1y32gxZopAmjI9
	JYJfGRyXd01S8YooZ+VmmfquytA/GEoAxLJRtiix8RoFN0kf9Var6huvm4Bxqac+TJg==
X-Gm-Gg: AfdE7cm+hAEgcJ8bRxlgp+QHxFNRMtP0BEKAZu1avv5xqewj8iqv0RUOcywxCujEilr
	svoh0IHCv4kBusAK7+f9YDv4nleCULSu3ugdar0m2CoAoEQxzf2QNDiM74jfSH6ZE8TnDiMBMji
	QdggmuTzlXhfIyJovfG8KzKfbyFUzRSHUqPiK/kqfriggS5k9h1YmUx2pLY538ocJcaj16FSdEM
	zFPBHRELUIIlE8wqCylevPI4+G5cPtit3UDQqqHCKyc/rZY56QvBMMmqToILRAi/sG7wBdTcrSs
	iCIY0n6Mn3RKCnQQrrjgh8eeken8zGOj+mb9Dvy+f5jSSk5a6XDF0VjnBotTIb9J1ybZg2F2pgD
	FZA893nY7veVD5X/VnAsYnLUIlVUYHAvUpxk=
X-Received: by 2002:a17:903:1c1:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c718fcc7a6mr138565955ad.36.1782095346328;
        Sun, 21 Jun 2026 19:29:06 -0700 (PDT)
X-Received: by 2002:a17:903:1c1:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c718fcc7a6mr138565775ad.36.1782095345891;
        Sun, 21 Jun 2026 19:29:05 -0700 (PDT)
Received: from [10.239.155.28] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436d3505sm60225495ad.19.2026.06.21.19.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 19:29:05 -0700 (PDT)
Message-ID: <20fa15e1-316b-44fa-b59d-99cb7fe78bb0@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:28:59 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: input: Add binding for Qualcomm SPMI
 PMIC haptics
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
 <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
 <20260617-wakeful-gorilla-of-feminism-75287c@quoll>
 <c7191868-d141-4095-b703-230237721f28@oss.qualcomm.com>
 <44778bec-68c5-426d-bc05-b4013630b3ee@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <44778bec-68c5-426d-bc05-b4013630b3ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cPFQzardHi_rk_HKelhnHsKPY9B-QDQU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAyMyBTYWx0ZWRfX7YLtL3zXW/uY
 iABjtt2sCGjRbrBvfkkPkbQe96tTCQzK1u/2B8vA/hwPsHiqlLe8TLTmCncsrphcaBe9TThm/t/
 C+LqBggvwHzZtYaDIxboHiWF5gNYOzQ=
X-Authority-Analysis: v=2.4 cv=T6S8ifKQ c=1 sm=1 tr=0 ts=6a389df3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=G-0MMZ6kwLWl7lZkNOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAyMyBTYWx0ZWRfXydHiUORZ7Q7q
 ZcrJaI4d/I8R/ARJAnHRQdxx2UMo8OUY7RRZ4mFncGFML4Xmf5N1nlcZCAsz1whCpbIisFiFdcC
 cZcJJjQI7z2eyE/xd5PuePtydVjC+XMth5N/YLmfTj6es1iWj/gCHsj+5TW7zfClIj4mQPCbYyi
 EkSK5B57eXdkIp8zxLgWH6qiqeVwXMyqDUo0DjNFI0S1WQwVKrPbryMeQPNDwXe/LJHoBvBe1GT
 ro1WWWfp+/pgP+WftcA9rhkNw5n4yCXOLHaUvMVOtnixAvEs3MCaJB3Op0wg9kPksh1qAmdQdmx
 xvEXsqPCIH2bxjsqIm3qnH0olzGS4B0/Fk4PG4V4U99Kr2lNSVNuTnhpTeWbSg+hQ455A0yeq7/
 3TLdOwA49gn7NUlxiHRJUcdELkQZSvHhd286xwxWS+LurZCh7RccKNDpv5TW/aDU5LVlQbogv5f
 9zYUW/yjWxucOi5rp+Q==
X-Proofpoint-ORIG-GUID: cPFQzardHi_rk_HKelhnHsKPY9B-QDQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220023


On 6/19/2026 12:18 PM, Krzysztof Kozlowski wrote:
> On 17/06/2026 13:02, Fenglin Wu wrote:
>> On 6/17/2026 6:35 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Jun 16, 2026 at 03:08:24AM -0700, Fenglin Wu wrote:
>>>> ....
>>>> +
>>>> +  qcom,lra-period-us:
>>>> +    description:
>>>> +      LRA actuator initial resonance period in microseconds
>>>> +      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
>>>> +      rates and the auto-resonance zero-crossing window.
>>> This does not feel like static characteristic. Isn't period depending on
>>> intensity of vibration you want to have? Why would that be fixed per
>>> board?
>> This period is specifically used for playbacks that require
>> auto-resonance to be enabled, which I referred to as "T_LRA-based" and
>> "auto-resonance zero-crossing window." It plays a key role in the
>> "DIRECT_PLAY" mode, which produces a constant vibration effect. To
>> adjust the vibration intensity during this constant effect, the hardware
>> does it by scaling the peak voltage of the driver signals, rather than
>> changing the frequency.
> But maybe changing frequency runtime still would be useful?
It could be, but the LRA F0 (resonant frequency) still needs to be the 
starting point. You can control vibration intensity by driving the LRA 
slightly off resonance by a given percentage—for example, to reach 50% 
vibration, you could probably drive it 10% off resonant frequency, and 
that mapping also depends on the LRA characteristic. Keep in mind that 
LRA is a spring-mass resonant system, so its output is not linear with 
driving frequency; it is a High_Q system, and its output actually shows 
a sharp peak at the resonance point. By contrast, the relationship 
between driving voltage and its output is much more linear, so scaling 
vibration intensity by adjusting the driving voltage is easier to 
control. Qcom haptics HW scales vibration intensity in DIRECT_PLAY mode 
(for constant vibration effect) by scaling the driving voltage instead. 
That said, the HW can also change the driving waveform frequency by 
updating the T-LRA registers, and this property has to be specified as 
an initial value; otherwise, you won't have a baseline to achieve that.

>
> What does the frequency depend on? IOW, how do you choose the value here
> - based on some motor-part characteristics?
It's the resonant frequency of the LRA actuator that's mounted on the board.

>
> Best regards,
> Krzysztof
