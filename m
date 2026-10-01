Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522B344DAA
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858562; cv=none; b=nIjI3WuC1ZauUpPcSd0gEvw6qeqwi7vpRWlSQIm8CMUN/qpxXX8TV096xcRU6aK29eGCRzsAJu7WNViUd592x7FbeRB6+MbS62nPy2Z4T59k9UKeOF0x3LVWFWUyJH8Uglzyx4U0Nxls2pB5gFDyoYd7vxCd2bokKcp1lcYMQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858562; c=relaxed/simple;
	bh=sJrCCX8tcWClNWsB9aBPl/sbOgEIN6wKM2tSio4UL+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqWceoJeXcmkn/V7YPGFZyW2k1onKtSdtL1Wh2FL0k48DRVcBFcnpNk5rVMUAbKHmbJ1l1g14r3qh0+JieWolAFyNFnnAme1PKIzWcbjOnLAXsVBLIWIkfcya8SmcFKLGf5EAHYXN7/eN72Sx5VEvD+FBciCevU5+FjhCn3xdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebqzBtb4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WpomLXNv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebqzBtb4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WpomLXNv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xf6t2337471
	for <linux-input@vger.kernel.org>; Thu, 1 Oct 2026 12:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H1C08/BFJu+sP1f8Bo+zqaA1pm5ZDOP10ddNZOYzauc=; b=ebqzBtb4eUNkMlVi
	NcTjfjQgGqQXTiPBjyQbvyVFY5R2ym4Z3HhPvALAPuuSNIGTm53/8E5dZqPIe2h/
	Hm6jUfFwX2u47tU/Vy57CoiuGMQsWmzApOz49ySvNV0GyfpGHvhFVrl/f5Z8PGr3
	aLIWB2vGucALMRNzdB3188oZrHJc3eTVmETDEQkIEmaqNyCmL1VP95576zHH/XBX
	WCMNu+GsMl/PAm63rezgfFZMRXq/U00o5p8wcTafn1p/2Pv8I9LtoZbvmynnIHuC
	CpxTMUpegYbI+s7Uf8UJlOW4/up9zklXDmt7KymQ7kCc/WECzy49zJ//LwqTBqay
	TUAOUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n24whg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 12:42:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c9a1cec69so44905185a.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790858558; x=1791463358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1C08/BFJu+sP1f8Bo+zqaA1pm5ZDOP10ddNZOYzauc=;
        b=WpomLXNvJuqgD2zgxL661Ta8TalNDiMtY3sswLN5Sv+iOH+S4SzheNYIUM7Ee6HaCo
         OsGqCpPbrsiQY6Pzu6sxIxemsPvaKTZc4hkhk6QbS7ZbV3HHcggpPfQ2dljmpKCXeE+U
         2OyoqL3kP+kFeMrUCkX0ivNdS6S4+KVjQHiZxScHRF2SU+KxNetEZd/Rii0dRHiq3A3H
         6Yh26KhyzwbWox4RFy7lwy1VSXRBtBksTUVx6VjEO4wofVJFy5J28Ag99cgEBZZle5KB
         jb0mktz2T17As37xJfi8+hik7nG4ur9jN2bUW/1KE3nrNhL/Rw2YFtlRS7SBrxLcE9tC
         Jokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790858558; x=1791463358;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1C08/BFJu+sP1f8Bo+zqaA1pm5ZDOP10ddNZOYzauc=;
        b=E0V4GuEJ7RPqzTkoR4+KqK7hxRzceWVh7QaUBe2bCD0u06jDRmP655FPJ4q4FLH3VC
         RA+y4gxz9Q51aon1aDmx8MB7upn3brZVXU+Dce6WBJ2SnsWYV6QclsDCbUSeXaqscepy
         AtmSyOvuxiZ/d3mFReIYdlHVrfnwP0GQHDEu6nlkUzNxs+bW+30YBK48gDDBq9csS226
         oSYico+x+F99/W7jPE8AQyoadPfCcmmfTNp6Z3Mguq3PT6Ct+h7/b4HyLKaTUauKnY5T
         bKLNBVIb8KpeMUaFK//2K7zlSMqD1jBlEi/WpXzTaKugcavzdDNzTOcUwHG0MEkx4Sja
         k0WA==
X-Gm-Message-State: AFuF++na0Jj/yxAK5wObgehUPBRdKXaRYnx9TR7cQxr1PZobTr4Vq1Wc
	ZbrUHkGdr40P7EQsqyaU5itHYPwSbYc7ubUwpCif7aZsKHha3QzN86HGat0DXJpF7FtMAH9SpQ2
	LooE60o20uylsRsI51spWPsf6vqALipAdQMzMKtHJLY/FvswXXZiwYkEQmY8xyxjeYMCztI9aOQ
	==
X-Gm-Gg: AYBFou1WvAvKjgs3UTX6Nmj8cZ/3S18JQ0jV+pbkAtFBwaAY1Rc/BrEess+M2s+7XIo
	pBC7cmEuZ8wpS4jIX/TxWUJq+o2a9OmM2D4s7aH8rcDFE0MpQHrGye0akUg4To/dSu+DlPiBgFV
	FhHCxMeAiIhEHMW3nqNpUWdzHPLbn1wueuqE53Q0yUvooQUK4NhsxJgHtst42RW6U++GQNGk3KH
	ALTkIlkKHjczAs1Bo6YvEJafsb/EVfYFXsPY9vGZ2NNuSCeKZORlheI64LuKYfsR29VO7Yb9Wy4
	GJhZt3snCvkLck+Ue7v6R+GD08535JjB1DpZegvs7mxNhE1G9SxGEKpLoJ6zdA94OLsYXUfLmm7
	Ng8zh9n+m0uh5+At6IcKlcA==
X-Received: by 2002:a05:620a:3195:b0:93c:5bda:9711 with SMTP id af79cd13be357-93ca980894fmr853051685a.6.1790858558457;
        Thu, 01 Oct 2026 05:42:38 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:93c:5bda:9711 with SMTP id af79cd13be357-93ca980894fmr853045285a.6.1790858557821;
        Thu, 01 Oct 2026 05:42:37 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31c93c31sm151473966b.11.2026.10.01.05.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:42:37 -0700 (PDT)
Message-ID: <e5fc5d23-d6fa-4b57-b6c6-a7ac64412d15@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
 haptics
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261001-aw8695_haptic_fp4_driver-v2-0-1bd38b1943de@fairphone.com>
 <20261001-aw8695_haptic_fp4_driver-v2-3-1bd38b1943de@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261001-aw8695_haptic_fp4_driver-v2-3-1bd38b1943de@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abe553f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MCBTYWx0ZWRfXyN/c7uQgtoak
 JZg3+0eWCyLmN0kyKxGCD28Edm2yS2IL200aH/Jattgrbl2U9WECypLOgQaQLAg/8nW962rdiJQ
 JcUfsArmbB9vPooPYkq2rdD1raA91b8=
X-Proofpoint-GUID: JL-wVC135Xc4v7EF0_xFjenqCYzq5lc2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MCBTYWx0ZWRfXzJMFKwS7Y0GU
 1QqyzYgZ9ka3TIInKg+rycH3Dba1hFQ2tDkH4qfF2tQKhVVSuydHjLx1PsjxouMycN0tYs2GvgT
 9LiZEgEb6gKf9CmzW3rYHfQzAsHn2WgEPIOtre/ZEzCp/YN9nrYhtFdMr3b4HtxtGrh8LnV3M08
 HvJAyKcVmI6gcyAzbbUA5JS3jyRhSRY9elNH2nc4RoYS31+yftGzXAN5azcmjineK1u15xcD/7u
 GE1PTCcfA9NajWhsDMNJXIQ5axRjlb98LXIo5EbSVMShxsbel+Ln7P8/TpGLrGg3tpW6ELgfXwO
 oDjKnK+fkAYz/tdOOy0TZ/uttkzNkoVHwX8CcRslbh1gl812Droxff2e5xLVCBMA9B7rRia3NpY
 JCJshtBLKcPm1XLZTxRY0AAp8KQT/AwpQI9ascs9NXfNzYvG34aQxsGYK215nVvpfiENXWJx5k6
 uqurcY/oud5VGfM3wCw==
X-Proofpoint-ORIG-GUID: JL-wVC135Xc4v7EF0_xFjenqCYzq5lc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010050

On 10/1/26 2:38 PM, Griffin Kroah-Hartman wrote:
> From: Luca Weiss <luca.weiss@fairphone.com>
> 
> Add a node for the haptics driver found on the phone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
