Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027086;
	b=QHVr3iK3AqTGTQGXjTnBYuOU0o1AWJAXhAlxzzvpRpn8emfF6pT26tUr93xG2wCsFXtO
	 5ItRDtjEBNTVOk4q7mtwEmjpMKsI+omRUEduODv6dIbLXocE06cnlEcmm23gCAhvS6VKO
	 esfqCc60mjLtY47bKRA+72vb99uIDPSUUmC1MomGD3mKla/gc2NKjoksDTTxLaKbxLed1
	 3HFLGB39B4UrMzzKfKMMazlrGpOt41JI7bpP0scQyvPvKcXhGp+lSKe6hWWOb0+190MC/
	 ZEOgKv6xsdcITc1zctD36nyBD1fwi1sxEOgLHyWHilrs+MneD82C9AWCJGo3ZCt33fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
	b=bYsoHFC718HA3R61dtdvwC5SwW7/wwbCMRg/O/2DL/fMf0loE5vfzuO7mzycSwnEwjIW
	 Dv8mTf3LGfj5Dh2cGrMQ4a+x1M+vWT/qKAfjvda4TiiMzRItia343eKhO2/N7SV+M92Jj
	 JE4sksupcinhX8FuNN/f+FlZbBUaJo/G7E+Qn1S3jgz67Yy5SNDGBiu62JQyBp8jaQLfS
	 UpoKFuW7BhKd1oPe50gSWQq7Ha1ETqIr2bPkTN52WABeJo+e+RPPljYCdD7K5JISBVJVT
	 P8leYvcwLUT1cxta6Hg/hcPYnHyGgDsJyGVBMYnbyZBk6ZlvLyG6du/TwrgnME1KT1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="hi3CS/w0";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B911606A334
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B911606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hi3CS/w0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvfrI465880
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=; b=MQCM+Rmp+OZKHlj/
	ciKNByeD1VCOEeHm/cod6l/pyvN2YTQHAFlhorvZqwiKHrUqvJkCMMcy5+8NzsJe
	dMMeh21KUtXzbdhwyWnjSTWfoqDqaz+ua+npTwqYYVPbVaR4wcuIPmXxaV+Z0Soj
	7bvziDtshD6feN3rD3xS4cQSlN466v/4zq9C1aaPSG7sL5YezH66fQWFD4B1SgW2
	ANjibawOqc4WYIMXjujy6A1t0z72lzPVBkAtQJQnbGl+/fMMAOcyHF6r9cpgBhJE
	oDxNwtLwXz3Hw58HMTyQswM9SIaYHH9TunVE28H5F6B9VDmUJRw/Q2bHUg0ZM1dv
	zrVBdQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshptypf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:04:45 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c382ac3b8fso553025b6e.1
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027085; x=1793631885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=hi3CS/w0VZhpnvpAzVfNK1wzX0z9QvpV8ZWs51pe3ru7ISKFgRpjPHnnoGHumVU6qr
         f5DOUQt00G4rL0bQe/BEXfvgBFAzug/jtsdCOuYpn+lRZyDSeX69OnetF74gB/0AGby+
         Su3o4a4D7xdrMifOcemeeE/7vPf6hs2cWiDdXTrNugPCICgLLWn0BQxJNodWyEz6KItf
         UpkItjM+H52+K3Hnm6ZZJrSIkbG1ZnCWArtwtseSLBifS8j02eVJVPVJgNW7vi10dQ/l
         UiGUBjCFqpV4OSARb8Sydc8r3QEVh/B62xeJ31LO0ZsZW1t6OzIkXvrDfjCIjhMyEt/C
         jQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027085; x=1793631885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=PRiqbyVEk/3XDgzIdKJiApCk2hKeEzZWXNvqkx1TtEBmX9Cr058UlQDO8z1Y3hYUn+
         ccbSn9/vT/NaSLCWiuntRmm6LlLiIGcL45u35mnjcTg9Zo2fmdPd+T+xISvHkNQwVkM1
         eChQyDDvZH2N6QzXa5ETzfy47St+VOUNOnFF82hherHQrrkb3TBwm5JyvETWE4bd7rAX
         +gLvxkYz7CncM/5idN+hV4rXsZLGfQfj/E7S6DdfcvolSdduUdPrt5OExb2m9C29lAyo
         zgBDS97IPEE5vfziWYAMR+2oTdBUPq5So4aGiKeoqiDZC6abfSEQsIsZm/fqFU4KyYYz
         a8/g==
X-Forwarded-Encrypted: i=1; AKwUvBwMVFX3l6OzqYoy9WpzJRVh34dCPPUXV0SR8SChkHQcpYfSHwn2ZrhktYnVB+WLQV2hRwbQBasDlxDxPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK/hzVh3AoSR1RVoIaLWuEFtLtkh02kL4uOCZJM30vp5qVi6oPK
	Jm4bV1QhqYtizZoRgUUFFss0PljcueklJUaBBtBy8hVOQtUSAeLZhCSmlo8EQgGH5AcmEnDjtx8
	CqKF6JB5aTL+J63/9qJTUTIr+huK0wJ6EISsPvz3E3hKNYlZZDnRpzYkoaTzscVUkzg==
X-Gm-Gg: AYBFou2utQ3tI1eWWo9lcxsVRkqec/LF/POID2nifArLoO5JN39zHLzRYf46NxRzXcz
	C1s0Gx7+6REwGavPa7u164ZCmZE0t50a62fm08DKpB1i41I9cU32pMuKDX8wyR0c/yAkFK6xleJ
	rdNcJy/AzJCuo/XEOGmV8PGqJkOEaDuCrxB8owrZ2ILMoWp35Um6v3knzxIClobmHOFdRw+90vb
	vik4fY11MU5RGc/01jj+L3Z7zNeJlD2Y+lIoEZ2Em/lFGQyRkkiAYO546RzGvdWJ8q/OYtADg8B
	M2tlpN/bXZe/plZNOLRAHbGVGrbdgzx6LYASB835a2QRio9lxezoWggXF39PMMlEP5IWOA2o/+Q
	xVSIHNTUaKdHPNVzVSZA3QQ==
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808474b6e.0.1793027084561;
        Mon, 26 Oct 2026 08:04:44 -0700 (PDT)
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808389b6e.0.1793027083999;
        Mon, 26 Oct 2026 08:04:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595e70asm3844350a12.9.2026.10.26.08.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:04:42 -0700 (PDT)
Message-ID: <2d4e66f6-7187-4642-9371-4385a46bbfed@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:04:38 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: generalmobile-shamrock: new
 device
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
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfXxxuqvfKMbP/y
 FQni3SMbSylqcTXEG2fQXtuRe8Kcol9FYeLlSxRQqtCmQc7Pax5GFQjfzRnPZxlVbPHfgjJYNgN
 nmBBWJ41FRGk1NYJaX1EDHq6VaxtYao=
X-Proofpoint-GUID: 2rL82bwC3yOCNhb7Z6v3TumA8aVG1ydo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX5G60GGLyEsIL
 +uNAie9JavvtaOD2FJ/kQDQVq6xGyfgY8QRimYrDwbyOkh4Z2SCp7WtCtoza9VfKRtVxLFF75qK
 8jTw/b0dgmLhvYo3R9GvU26RHp/0O4dLoXhoEDD1P2RIgg+Bc5nSt7oLHz3rOVmKv5PL2xiAwY6
 89uCXQ42x67H3Fh7VX911cB1UgvbKckp3Mvf4yT76Zaw9G82msn6i7IJCyqK0DKieYiBcCvAmEH
 5uavDZcEYIF0WGTZQ13EDcjmDfMOjBg3Mj6EL0bhwlhIqDnhFp4kLKv2GDnR6zuYXWBLeAX0amQ
 jwc/Mf/Fg4n29/w4HG6kNEvqce10tqNCEhWf2TqUIHIxF0Beyvs6SXGjsB2XQjXiNmi+xiCRcMy
 vs4AM9pVuWbSVIzFQmJ3Z2tLrdXFr/HaofydYwtYWR4/lwRqSqfN6BWOPr2gtEv/p6ZF3ujFOaE
 47E5Lxe/iN+mojTbRfQ==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf6c0d cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=CrGEZSrvnsKXYSFoqd0A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 2rL82bwC3yOCNhb7Z6v3TumA8aVG1ydo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260059

On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

[...]

> +/ {
> +	model = "General Mobile GM 5 Plus";
> +	compatible = "generalmobile,shamrock", "qcom,msm8952";
> +	chassis-type = "handset";
> +	qcom,msm-id = <QCOM_ID_MSM8952 0x0>;
> +	qcom,board-id = <QCOM_BOARD_ID_QRD 1>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;

You need to enable this console if you want to use it (stdout-path
also points to it)

Konrad
