Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5E39FCBA
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834572; cv=none; b=ZI+bktvAOJYZWODAjki5Q6EgxtaiAmDMGbQY7QQUFTn6Lgb4Dhw0dVOAfZaF8Ov24Fj5JOjsC2M9W5T+0aMXDsIYd0ACGXZP9XJf6ga3kCksaaegmqIZ+CXkJkQE9l7KeXIQ8SoUk6fRRWRXYAWSlyDu1i0j/gUgLZUxaKPxp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834572; c=relaxed/simple;
	bh=rBOS0ej5yvstPJpN7/12hCBamhtOK4e9RXqnzoQFezM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/9c4qrRwJsSNDbJd2lOLiRQ5RyiXt5dPoFs2uqRzdEfG/f1y6TFGho55U4oSWBTQijp94e1b9zF229y/wK51sBICT8pzBAVeR58kJqo26Xv9EF44rMm0lNvYmZtjODr824lR9daHLwQE2DTks0VK5yJXdKFF3Ji/mkeK6szVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvGlctYe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=djo9YO5L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvGlctYe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="djo9YO5L"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I76oUO2613391
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kUN6NuA9E0A6Euv+7NTzfaobQJSV6Fe3Lnfqqc9SXAY=; b=PvGlctYeeBT1dA7G
	RwPpFl5T2vcc8r021RTxtqtq8x4jLuHXSnWRaHaLjD5859+tMWClat341bT7mLXP
	OmjHRXJFqeFGlNuwBon+fUzODu0HXpMoLg+r96wcf+r4+yTBcNpQqhYwOuVTnk6o
	GBhYXoOnpaXUcMG1GBXzSJedo0Fix1cVN4uHfl0Z5zB4eQITkl5j3W2mrZclLoCg
	lrqZptJ98MQaWqY6M8tmLSuDqE/I+EFgk7N9xGGJiYz6E/fp2Sy7zSNPFISfmdfe
	kPUqZjqrxSoItgY6CZ/KfYgo5gB+S+uyz1UaOPXObjYhyv+7vLfyQsw17eQu6hy7
	XZ5Wqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyqcds4rd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:49:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50923dc39f4so48134291cf.3
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773834570; x=1774439370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUN6NuA9E0A6Euv+7NTzfaobQJSV6Fe3Lnfqqc9SXAY=;
        b=djo9YO5LW+9Ra9ij5RIAH3ee10e9y+MKBoyxYiqVjWBQesTeOj3BAps15yk/5Onkix
         9vR7rK0NNygKbu3EGAasjKE1aIP42JbbPjShhzQCAL7oarbJgqNsH6XdtfEvIeHjjd4p
         gsRxIOKmBwE1RESZEDiux1zu/PGI3M5/IcwpVRwif2Z029y+kI9CO4xEE16Bl4PFJmHd
         vRJJy4aSBZgfINx+w8m2b11QekhmVDwxzetqPqqjE9yx3Yv7j2SNoof5TOnI0s+QSOHw
         aBpf84GSLRxBzXBI0IZeGAfwo+ofaum5k5SWPhGVL5qObXDX1jikic5SyV7c3V1nkfTM
         qRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834570; x=1774439370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUN6NuA9E0A6Euv+7NTzfaobQJSV6Fe3Lnfqqc9SXAY=;
        b=CYcwuenldohQiShfMklX5HjIJNeB6LF6/aRNSF/NTQtfMu4avDkWwFiup71wbrIy1X
         vZbfrGYulHx5ZfE7CQVOCtCqhHYmSco0bHIrNzlD19Mql1D5umfYKmE47V13ER7FhdLB
         GOuQJwpYk2YYuy87Xg0SIO7JHFGlrHrcNkXaAZft4bO8ZEc9bFkFCxDiphA68cZ7mK1Q
         p5MFbyE37vd4fm9APJRa4zEcY1nzJkuv5a6Aehafvf5w6U98F0mbWp1cDFLHCVgH2+aa
         n/d5eqzagF93N0kzAIQ9RwWIb0JJv2Gc0DFhVNWQ8EKuEui/YzoDifxpgfk39Uf8vsbb
         ujYA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQJIGPG9m28lfEJXPKcVF7TC31esgLOgu9iI/cb4RtdUpMo/zF+3hQtsCKciwTlAypvsSuyDaoIE2Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTHzpcK7A/mFKxIQ8pWw7RFqHRjFGC5Q+rnnP+euQEdY1wY0s
	i+IMa94FWYYAdPc104FRvGZMxRxAvbAm5jCanXYnOkDgrrhqE5Rm7ptqfK1FKb27gklnjVVRw00
	WXqAm9WZ5QTCmbCu1HiVD4KcCm/foVOAXzdAyIjOYctfhFspFBW9mj//6ZaJWaVeiQA==
X-Gm-Gg: ATEYQzw9aYXmIzOl9IAVlo4z0HlXZ7av/Ibu+2/sfzUv1Rclj0B0EaXdsEE/utkSoB9
	KzDZjHEsl/2P267SDj4KkZofu+5adgfXqFrgcNBPWu4PbPP3pjtwTbwi1Avmh3awmLjE5WmvAAS
	hZQfct7AJBH/wy7hSi4y55n4tQCv7bgsXWG0/HuMHe0pLYG3XZvg8+l/76Hkeehf+V2drEReMSu
	a1W4H/6WPq2C6ZHxY+O7XeTfznGQuaLqktJLyVQBMn+N6w1bHCSzaMkAbi0mUV3h67agbLygorg
	JOINNlN59hcIpwo+e+VBnwV1A9zPOC16dAc+RcLLC1VhxtxwiWNpCGQ47E9G4mSvNZwWnE9DZTX
	XKt8UyE43slWlhGcHvjvGxLfJ4nDrTw58oV/WaWDuhNKNiMAk7d6ywxUdVn3iIK4N+cetZMhW5Y
	XxFas=
X-Received: by 2002:a05:622a:10b:b0:509:2a92:8088 with SMTP id d75a77b69052e-50b14752dcemr27744501cf.1.1773834570107;
        Wed, 18 Mar 2026 04:49:30 -0700 (PDT)
X-Received: by 2002:a05:622a:10b:b0:509:2a92:8088 with SMTP id d75a77b69052e-50b14752dcemr27744241cf.1.1773834569701;
        Wed, 18 Mar 2026 04:49:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667ac611b88sm1815696a12.0.2026.03.18.04.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 04:49:28 -0700 (PDT)
Message-ID: <9148cecd-6632-46f2-88f3-152c6d6df10c@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 12:49:25 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH WIP v2 11/11] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
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
References: <20260315-stmfts5-v2-0-70bc83ee9591@ixit.cz>
 <20260315-stmfts5-v2-11-70bc83ee9591@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260315-stmfts5-v2-11-70bc83ee9591@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5OSBTYWx0ZWRfX4UB+cfl2R23N
 HbAPwQQMNdKHRLZsm75hJbaMpSAnjCAHRYwUDpPaB94vO3QaJJSawlnV3U2el9Zbb5Z4aL19jNR
 FPlE9mwGU6rjCDKAktF5YH0Alwim4Jmf/0k8QIc4BP2zJ0HyhbcWWP0eHReQa6is4rYV5UJwgVv
 NB0Va+M5/UDIrg/befciITp2QNhlEqBHczRFiQYETNNEep0F3hVikRaR4HMisiRbphqfb8JZdg4
 3BiLTTiKOHjgmfJrG0PlmgTN4uMUUxYMAIbfp+FfNzLQcOm19/9wux8dR8R08XI8numuVGY4GXE
 SFk79H1BD0/od9ohRSjUMj4TP37M2XW5VLSRs4y7EHs2Cvfw4AYehJ9oc+5K/GYrepZR2W8gEUl
 t2pQTyBTmHfGXt7MfHwU2BmyrupcSmygoeeMPSLnbwQEC4jqzFPfdsLGo2+eidUWUBBEgNMJsDp
 sWiuKFEOgHN3tjo4bZg==
X-Proofpoint-ORIG-GUID: fJLdRtrYomHKcpS0b16rzjya94agyn4w
X-Authority-Analysis: v=2.4 cv=H87WAuYi c=1 sm=1 tr=0 ts=69ba914a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=sfOm8-O8AAAA:8 a=8wVjoaYgGRnUAGDsoUAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: fJLdRtrYomHKcpS0b16rzjya94agyn4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180099

On 3/15/26 7:52 PM, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Basic touchscreen connected to second i2c bus.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> index fa89be500fb85..48d7e7f83c285 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> @@ -26,7 +26,25 @@ &i2c2 {
>  
>  	status = "okay";
>  
> -	/* ST,FTS @ 49 */
> +	touchscreen@49 {
> +		compatible = "st,stmfts5";
> +		reg = <0x49>;
> +
> +		pinctrl-0 = <&touchscreen_pins &touchscreen_reset>;

s/touchscreen_pins/touchscreen_irq_n?

also: <&foo>, <&bar> (this produces the exact same compilation output
but making them separate makes more ""semantic"" sense)

> +		pinctrl-names = "default";
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended = <&tlmm 125 IRQ...>

Konrad
