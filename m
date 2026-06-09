Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AE38A73C
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997466; cv=none; b=HaooLpXEz+p62mEjYrPX4WpGI//4g3714+KFASnwF8FgDZOVvVK+thsuEmPOjgZNIKfAnRoxtlm85O7MekLuT4/sDWNfbRsFrujfVItO8/qWuiSWXKvfS2mOqL2sK0ztJl40RDrrCCWmKppqn1QVpywv6CNlKxwq/dvDy8Kb+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997466; c=relaxed/simple;
	bh=MNkG34kMsVvnIhkvNI7U4mabmb8YGJmSa1V1L6Dp6No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBVvDv421G6OxxH1pn6zaPhweGG7WlRhNXwS+7QUYcwpQmUKshYpSUC+9hde/6sd0WEOgGYW5I/GawdNtp5LiMhQxBQMcnTgUZCg0pG1BcQiIomziCVON2334sPPtborGLsA8A3ft8EBExhacOaEUSUrvteig9wUCpzJHZV8mPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RiQ/uF3m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NVaX12XM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RiQ/uF3m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVaX12XM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599JlMX2223163
	for <linux-input@vger.kernel.org>; Tue, 9 Jun 2026 09:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BMa3qXAR5txkpAwY5jpKqli4jX9daJVnoCU3TE9NuOI=; b=RiQ/uF3mP/XnZ6bU
	SId5H3m4HAASGnXJXGsMf3odDzD3ZsQxdsKs5Z1hd7j6+ZSLE7s0pe8eXz+9OW2w
	GMFWzmITNWuh4yYqvd26yhZrlzVN0cX0JuLPz13twLM1ot3WxcTckKFb8jQPx03t
	OcSd8PRmTgKtgNdP+Xk8GEEV2L3UKVFwVrCEEVhXzX/nhA0QBg0yjXBTl2aAtMn0
	tmAasEXfrPRJwouMqnJRQoRqdfaGWhh13pFnZpAgArLuHQAuQXpfoweFq01jvRHd
	+/5QA0EvGOwZ8xB6ezMvYtshvnHxUJtD/yG88zIVAKvcrdTFEkURRmjrS9DK1o4+
	mHj4MQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v01fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 09:31:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517796be724so10591951cf.3
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780997464; x=1781602264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMa3qXAR5txkpAwY5jpKqli4jX9daJVnoCU3TE9NuOI=;
        b=NVaX12XM42/UxPdmc1N8Cbn+lmwD9K+6LsrQq52HGDCLnuG74sSap2h7e5LMhxBfsC
         9V4JuWUlm+rJee5Yj9qeNcGyi7HIZaYLboFpZhhF75OqmmxdsgkICvC7VPTVze2psSM8
         PPO0qahvqXUYrYZybunKiDUMHVk09VojOe4MSorDfdEdA5tc+tkCjbxqvIvhcR+gHRqg
         cFTbAxZ0z3inw/zoOPXs17hStYNQgxyiSNkofXBQ8PNwMSQwMcVE+iHbVvptM9Uif0O4
         rxcJ3Pr02afvk5Qr0zSPtNMJiC815I1v4/OX+LsugL+BCQk4jpCjU6fo34zGsHPVg6jB
         BKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997464; x=1781602264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMa3qXAR5txkpAwY5jpKqli4jX9daJVnoCU3TE9NuOI=;
        b=slRkpjAOWHsRKuEK7YQgTQpBJtlP/Y5Wpvzr0Q0bwMHzMli80ZZIMFUQdm/35JorF2
         2PA5+Ioi6kC1L4wsy2X+p0T/4K6lzV561dnNeDSJmsT5dh4VuAczXggFYF00Yp7kXImm
         Pxh6F0XiDV/4yfDpq7PG7P/4R1u9sZ5acVKXF6VWrMpDu3Ly9UYnDOGa6ux+qhueJH8y
         GnrlhxFz+Xyq9674Xs0MtMIqGTUVrqrHU9dWgseDWhFmoXsIqFBc/W71S0XHra6mY2ag
         smhAQ7oq5ZEslLIhmSifr8Ge3HXXidrPD6zxMFFs2aOKIv0DdCXL0Fcryh6YcQg/nSVk
         wxww==
X-Forwarded-Encrypted: i=1; AFNElJ8Nf9biGReft3ULfw/z2Fe5sj62W9ulZZVoo/KzsPRF8tG03E4m9z/0cb3J4A+wtS1cnK1HrQyjg6SQdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOjdlWu6Ju+9XWgapsIi/iAxp/7OwgyPgIfMoRpWAPzFsbWaL
	o0OD8h77cVD9Odx2iYe8pFzAExD7r2VEoaCFWksdyF2wtytYkTG8t7gIM0xG1vXSzRU6JTurTTf
	IxagihMdcsGx+4gGf15oUbjdn8MwxwDRS+SBUKx0yNa4oXprM1dQ45IhZrVHrdzD0gQ==
X-Gm-Gg: Acq92OEK0y+2DcEqL5FvvKRMNVPtZygRHSrVfm5c3jBDZdzJ1ceGCrKiWe8RhMzRA6p
	ybec+Eci16gG9FPc3gpt7Gc12zBI7kuVc/7PuaZtuBSjjkLAcu6LbCXTZ9qq1rpujDt08UrJwgn
	QXTdB+MMzI5bhO/DtwCG5hpXDpAKGYNcIQ6ie+KFSklziUMXCmZ/Q98yLIr1O6TMwr7YqhO9Bvd
	FXh//k7mLbRpSUbbd/M4c0jGqcqBTp93OWYIZlP2CHVoqYiX2CtsfKO1YpNJ2DzPWBJhhq3mBiC
	5AF4aLQMfjFLat9vf+Mf3FzN6fpSQvQWTY9ldOjA3n3eVEmWdYZBQ5HmTWWrJdmAvZK6VsdYIHx
	B+TvImquOluoZSlELmtiuCAwtYmc4N7eR8b4Z4tX/yY7szuHtjwwlOaZl
X-Received: by 2002:ac8:59c8:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51795c56077mr168230341cf.6.1780997464168;
        Tue, 09 Jun 2026 02:31:04 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51795c56077mr168229991cf.6.1780997463612;
        Tue, 09 Jun 2026 02:31:03 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05228a16csm1005080866b.28.2026.06.09.02.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:30:59 -0700 (PDT)
Message-ID: <4ced3207-a132-4ec5-a0eb-79f75f5cb4bb@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Microsoft Surface Pro 12in
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com
References: <20260529011619.9586-1-harrison.vanderbyl@gmail.com>
 <20260529011619.9586-3-harrison.vanderbyl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260529011619.9586-3-harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a27dd58 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_XXtN2VGHKrtNHovNKMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: agN1Lr6q2kzW3fVhYkwY3lEc3KqxuiI3
X-Proofpoint-GUID: agN1Lr6q2kzW3fVhYkwY3lEc3KqxuiI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4OCBTYWx0ZWRfX195w1up3D2Cn
 lKn0yp+kcOQlTXy1M1jWqRotyI88B0iRnt3dIy1JngF4nyiwVvs1RaYnK1ViDW4IP77cWMsgcxd
 2ykBrXweRHBxEuvK40aG+dmLmJcswaXRVLuhrbv1Moey0ki8jqsAuK/W0s29nax5NO1g2eSYTDB
 jfISBs3aNZAGy7GZMjXR+D5/oOzaNnmwtopYDZytlsv5xiW3+yCBHG/LgPTllISxQ4+2+3V1Vxi
 JdeE+WbZv+XRJNUO+XdPpBtvixMBnlhBwW4f6kS/gHyuIm5gKWq9VljKx4rOjn2qSTdEISVYhz6
 /oagL1TiAb491J7jWnp4FXDVkxvQdlWNTG+V55LM4lJaDFOhfkvbL38yMR8e3bPDGfv2RE0hewI
 2vWWSwZL8uqAgtDZ/dXCm9xqx9jPNfzoxp8fEHQ0D8DnWyjlVDj6zBUiYPT5w6z/sCBxWRLivg7
 QZZ44tSN1ALfzuqym6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090088

On 5/29/26 3:16 AM, Harrison Vanderbyl wrote:
> Initial device tree for Microsoft Surface Pro 12in
> 
> Currently supported:
>   - UFS
>   - Touchscreen
>   - Pen
>   - USB 3.2 x2 (DP Alt Mode)
>   - Audio
>   - Wifi
>   - Bluetooth
>   - CDSP
>   - ADSP
>   - GPU
> 
> Not currently supported:
>   - Accelerometer
>   - Front, Back and IR cameras
>   - IRIS video decoder
> 
> Tested on Surface_Pro_12in_1st_Ed_with_Snapdragon_2110
> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

lg, just a couple nits


[...]

> +			codec {
> +				sound-dai = <&left_spkr>, <&right_spkr>,
> +						<&swr0 0>, <&lpass_wsamacro 0>;

Please align the <s

[...]


> +&i2c9 {
> +	clock-frequency = <400000>;
> +
> +	/* NFC @28, commercial devices only */
> +
> +	status = "okay";

Because we'd put the subnodes for devices under the 'status' line (DTC
enforces that), please move the comment below as well

Or since it's @28, perhaps it's just nxp,nxp-nci-i2c and it could work
for you ootb?

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <34 2>, /* Unused */
> +				   <44 4>; /* SPI (TPM) */

Please align the <s (or is it my mail client playing tricks on me?)

Konrad
