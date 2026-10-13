Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257333B42C7
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881680; cv=none; b=CttxCBdJvTp2MAmn8eraJ8BTPQmCVoBSd4mCrD+4pL/Q0V2IVZJ8y/0MEu7jmFJB4afuMjckb9t9J0iiXxjhCEFfHasPGnzPa3FmeTy78Ow0DTIVWbuKeS2KMeQiDtg29gGjKRFeY0J7/EPvar3fS4XehG7SVC0n4ODYBPHxTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881680; c=relaxed/simple;
	bh=RRf0QNgtNhxs+QIpsqcDuxMucwHO76f+rh6FFGEKfZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKGcINwrMvPli0YgZe/Eqs3JbEu3MSqnBCm9ipP0WFk2By+8knsu/dqvkC3f+LKzlQlje9ttgU1fQwOhpT1nrwWHAz/Hjayl0BL4QC3HsRfBz8GoVNMumSdx3oQCiNUJNORCMFcE9pdhq5T49hMivPKd9GTHGG86t1aLiR2fbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQFw8Fw7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CqTvQKgV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQFw8Fw7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CqTvQKgV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D86kVk988787
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=; b=jQFw8Fw7Ma/RCxZc
	9cASf6SF6yXQruiLVtJvjcjJourUetkScclTHVlo51gLdP3t0tpW96OnM2du2pwJ
	xJez3lWwdoG2vJUdVx+sO1xBzDiAZPF4eUaVe865752JzJ5owkL7iBRTih3Y6lry
	R/Mg2ru2c2GoqL0IQbIQsQ87zKLfEkGWR9Y8RZJPtKgTnvE+Ch9NgB5Lry59xw8d
	okwPYTS2BsGbFWYbbJqE9zyB/c+xnk4jIxofjA4d6oIolTx2dG9nkSZCEi4ZJ674
	klrPchZ315kCsAz3lOdAHdDomuKPfwLchCkpMuPlfZBHh0ayPR8PhJT+veY8xmv9
	XaFzTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hca1n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:54:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc40759b2so612626985a.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791881677; x=1792486477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=;
        b=CqTvQKgVetzElRUJwfIb33T8osiRhrij0g+iJ85JGQQMo/60yPLEzh9F9K0QzWQinZ
         /ysQykKJ5lrJSCwK2tOQp194xdn1fyfNMnWniPYAqtxZQXHaEPXGlANq92V2Ux+IPt7y
         WtDst/zj8Omsp/loNFhWe+EqHieeEho62SSKNMoHXHVSg/F9oYzzLQiAf5v9rAxGuT5u
         Xhbd+qIe8Y+EzE+I85H8MWzkFs5YBTAgYgIekWBSHvd6/1Qebj+9oW1q/YFhBwmQEocE
         GwbDQ2JTd+KevPhohXDNF+tuvZa+c65BXEgQ1vdgmIdq2wuF1N1L1RPp7JqkkU0E9t06
         bcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881677; x=1792486477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7f2hNXCavRHTd0MsRhfBFPNTvN4Mh7PPmelvArEONJ8=;
        b=qMZc0bTKOJjf3XQtkf/qAh0Zcav7qpksUuvY/2G8qUcB5NoTJ0f1vQegSVONoUGAkZ
         f6vrXkqYaRK+3p18nGqMKjZRe/Ws/Wc7mxQ6TNf9x0v2Oo4ba5sBWcrZcJdIHGGrFShb
         E5w8VplYlnrGczDNkTLRAzu5ibS82nG4gN/D+OdWB3Musr08bzUzhl/eq+XitvKCex1x
         nvENefgGm6298OtNBJegfxYfOU0QLN1bUJ81oxLXUYnLe9Vw5zmty/L7fuSP6jDZhzER
         qktmdbdbVgacPVNh737oXbNhD9RWjTpSnBYLEV4nUaO+rLpUXGzfzyAVMyOe8cQEPinK
         6rLg==
X-Forwarded-Encrypted: i=1; AKwUvBwJwYgAMieGQ6ktAbk/V9q3jlsKeEqaM68vsermyP1eTNiXxQE23++IwKqQMHrrEShHJW4aU0sBDgHupA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIDJssABVflokybMtsi9EwMCfklZKhi/0yj0ES9umTCnaKa6X8z
	q+e3jCvNs2g/o2RnpRFffORhJGTkd5WQ+iMwnfr7pfKZItkdB3AwReVSDX5LIaz82b0zUXnaSMd
	wXsSNPDXErJVKdsqvXxBIcOjYPBCnJlzwysYfVXhXRjvBj/osXgSuMRl2n/umWx6t+Q==
X-Gm-Gg: AYBFou0pm5H5IYAtHOTgZD3G3mlf08K+j5i8Vq3wkf42J4XplyHeHOdRpivzgAIAZYw
	eYF/CdJE2O1qLGS+0wqCZ/YIj79Gxg9SYapg8fqoN6rvr8X5uWPeAtXMfniZ+EeNsKPliXyX0qL
	GOhDpxGwJXOENR4T49xuz++fHOKm/h2z06e0a5S33TpS4Xn9hOyTOSyOKj5DVr8h9fFffNeu6BP
	OtTSF4gBC2IwR3sEDKu7+h6IQ6RCOlOoJPeWaXvECi7vifMsvGWRw4RMZYm2GsHykmfinoSE+wq
	JoIkRL6GXyyzIvQ4SCQhib1VNvsIpHRTwqGw9z46Ez6FuUn8bCoXlb7n+OLxevVrvNaKM9l3M2b
	J7iRSvEUTR1p0GVTZ6OWyxdkHQWorNimZZidRJ9bRJrnth1vYjYpTsz4qHchk6g==
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr1872345185a.0.1791881677279;
        Tue, 13 Oct 2026 01:54:37 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr1872336085a.0.1791881675017;
        Tue, 13 Oct 2026 01:54:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm554068365e9.8.2026.10.13.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:54:34 -0700 (PDT)
Message-ID: <46521411-fd68-4ead-a487-f2277a1d1d8c@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:54:31 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfXzMpgUFbmnr1e
 77XoHGXIOItXnTiI6H7jCMfoThnpy/KU0O6vQ+qKtLvJGZJn//qmvuBT36Pn735ro+vDZFltKv4
 EiklbGQBbu5RnbK8FkgVE2tV8Gwguad/xrtX7c/fpo3b5/k6mgULaRArvA3p4wEv+INOARLJ9Xg
 p111IrLAdOmfygvHOR446wAhYXFzOdISAvND7a25LhlT8KICpitX+miHhmwjbagRVo0Uwcki3L+
 X9k7nWxjDE8C/9BYMs18xKtu5ECi8vpH26K0QkBJ/suuLpEKdznNsi+EEm26sy4eqD0tJhx2t6M
 iT33C893GttfbWtCQ0lIlKgnq+qzxhevKaLWud1GqJdHib/V/sq+i7S773JQD2V/K9Pa7XgD2Xr
 +Ys2UZxitLHsTv7C1WuA7yk/lNuZv9ijYnGsvU/uSuxfQIIkv0/HBP044pDg3jz88ozeQ+nZCaD
 tBuXQtVKt0VSyAyggGg==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acdf1ce cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=OuZLqq7tAAAA:8 a=H-LwI_JyRwchcv6U7CIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: mh7H3EnzN4MPfkII7-K-gBbuwjuPHrXG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfXyVaRBNkEa43i
 KWkkgn4Yzcpmzw3xQZaz1s3Rp6Hdai4CvQ7Z/hVgjuHvdvPpGsZHeTyBS3gUyEqywcJifrAR8ok
 /l1VlNtwPM8+84oDWOb1JfF2A3PtzoM=
X-Proofpoint-GUID: mh7H3EnzN4MPfkII7-K-gBbuwjuPHrXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130035

On 10/11/26 18:51, Muzaffer Kadir via B4 Relay wrote:
> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> 
> Ported without uart connection. ramoops and usb
> mainly used to debug.
> USB is not enabled in this series because it
> depends on the not yet upstreamed (and not developed by me)
> pmi8950_smbcharger.
> 
> General Mobile shamrock display panel driver
> is generated using MSM8916's mdss dsi panel
> driver generator and tested with it. I didn't
> include it.
> 
> Pinctrl driver was submitted and merged here:
> https://lore.kernel.org/all/20260907-msm8952-pinctrl-v5-0-9a2d8d72ffdb@mainlining.org/
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Applied, patch 3 & 4

Thanks

