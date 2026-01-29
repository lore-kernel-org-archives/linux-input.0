Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC322A7E4
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681893; cv=none; b=nFH5GQjMpN7KBVWlH4wLHOlG6zl4aQwFgUbcDgZxG8FGwNjo2G9xj06o9ZlgNUdhvYPCIVumxusWJHyREUlbR93MVHnJB5eiesog1m5G0dUta/klbwXbc1QBnrmuoSOh1tbwVctVIP0YOGrFZLxFT5XK8UjZPsIAtzsQBfsp0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681893; c=relaxed/simple;
	bh=fmVB8nuKTZoNDXcyCXt/SFOizDb1FQ0xC37rvDu4MXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rj7pm0jzEMX1p/Cli+iuIvD7JPaR/EO90NnSdDEIJbjEU6zOh8KT0Vmuysr3XBxwumxE9QJlBOzUseZHFfrwDD1IQ01c25FaIPjQZR4Y7aNnd9yoFPgBnY8RbJljSlYtlwRKD5c4W0s5kFiwU/vPxWdOf4uA0+iOCDTy+KjImOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5RX6ENu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HZ+SGb6C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5RX6ENu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HZ+SGb6C"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T3A1L91429840
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 10:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HCEYa7cgOuBIBFytHhgw3xduRbCl0l0EjHqLpkKY/JI=; b=e5RX6ENux33VEhaS
	UQ2VIpSmQrjokykE5eQNpFpmYjRlmbPezJS30LjtW2EUdlZNodiNYMjNjxCgeetO
	0bCoEt8YJJ7H2O4/8aHhU38Orey99XFU8yiC8h3LJT3+Jgb0zpG2YInWpZdMkT6R
	CPtG1wqL31pt4Mkr9GP5My5yPFwvT6cgIgNP7k5rOeoANr6nmJIsj5+GtB/1dEbt
	+h2sHYDgdWzIwkQ4TGxco80ezNioFpq4GeQff/rLlRNgFo37Q6mWQfL2oe0KSt5W
	9KSopcEB+cQfu/qZadPpPAMFSWPR89g61edhf3K4qp+YzCIkzXrLuYaLOaHhs4sT
	vDVj1Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byydh17xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 10:18:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso3076366d6.1
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769681891; x=1770286691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCEYa7cgOuBIBFytHhgw3xduRbCl0l0EjHqLpkKY/JI=;
        b=HZ+SGb6CLny2kMWx7rwvL6Sn94UMilueQ3yW4D6qFgJ7fAcPBVBmmyYdgXd15bjxuZ
         vW1Nu2pDMqObseLRfkwE4te/ltkpRP/6Wvw37ykdJhDrGTjQFdXu7PZI1PydIO7taqys
         bY5UY6AWaxGHSTPEOdomzkKixdh+TMeqY24ZItCb9iCOXDN3X795hItSikcuzLTZscFU
         OvJOXFZw7+3qCS6WLPIvxDGTupHkJ9EXJzJef9WBBAvRryqiQsTLPP291RRKrpYfZ+9F
         UsUI7XPaAaY/v6eYtS/oo/haalBQ8xaonWuVlcoIV1pKNie+B4JHtLSQRyX6gvnsjQpp
         6sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681891; x=1770286691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCEYa7cgOuBIBFytHhgw3xduRbCl0l0EjHqLpkKY/JI=;
        b=MMR8po3XbJ/F2OClVN+h+Ld+ugSC695bWKLm1YK4Pvu8kIv6VFIL0nu1WqjECglcC9
         5GCNdDYposA4/rTZHKQb+HUQA/E4DyjfvIWniG1iP7LyDBVJ6HfMpgTjREqAf48300K6
         yMweHyqk9Q3XePemutYmqDHMC9LPGApKX02jJO8n+XfFFDwjUAPNPoTvQMenHDir2MMB
         /de+vy609oDpcv+hhulRzNSRQ1wcHp2ZsASI1k++CjO3t3m1KdqwdspdAILFQoZmS9Ye
         /7ZxVBrwRf0Kz0n9/7dCK9O00om6/Db7tlXN49odTKLdpcHIkLumiC+MoIgupvhcxMOI
         BE7Q==
X-Gm-Message-State: AOJu0YyMoaSuSOpP4QqShoLnZ8MuxPM1wGV4fdYXqvFZqeWfQSeGMXtx
	231RsnRq6sfBa7wNb93kHR8kcwcrZ5gG7bSGJ/Fq24IYXZYM8Vf0GgZ0EAS8+aUCqLsxKenUovJ
	FQ44MQ6NmBV/QbkpzVU2qBh9tmjsE5OWuk8e4yD7GPcTE7pUafnzLGUibMzd3Ay7N2A==
X-Gm-Gg: AZuq6aISpOATg3MHdgsbA8b4Gz0dGdQ3Eexky7ztWMQkx5LkFS1mZPGU2OQy6J87nyp
	OW9JzpAVZ+tbbyYzuJaZRetszLjVsIQxmVJTBcTS/x5mLYCI5m/pouRVXSLFeARf4i2rW89FDpg
	IOME5Rilkwt3mWWi5V2/9lV/3ACTSRGyCnfiumg5DADr/4R7NHBghfbaf6UztngankeYQaiHeY4
	k5oLZt+Bq4M5KkI4Ible+bXNvnCusfebHKjS/EZfIyxHmYFqytjew0Lb50CNCH6duLmxgzSC24j
	bSH59Z7iFxqwwD6hen0xeWmoeraKos7IMRTbskfwcD/n8UoDLfBc7VLqjDGusTzHW9qTT2GWQRf
	tB/CkcCXEvf9hE43/zxkYKFHEO6WVfl3oO91MNBg5Os+QQg7w2Yd2320C9jEgn+FmtVQ=
X-Received: by 2002:a05:6214:6015:b0:894:9ac1:8be0 with SMTP id 6a1803df08f44-894dccabccfmr38221096d6.3.1769681890870;
        Thu, 29 Jan 2026 02:18:10 -0800 (PST)
X-Received: by 2002:a05:6214:6015:b0:894:9ac1:8be0 with SMTP id 6a1803df08f44-894dccabccfmr38220876d6.3.1769681890476;
        Thu, 29 Jan 2026 02:18:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4256a35sm2707274a12.1.2026.01.29.02.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:18:09 -0800 (PST)
Message-ID: <7c3646e4-48d3-4b32-93e4-69e7ce439e94@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:18:07 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add
 vibrator support
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-3-b51ee086aaf5@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260128-aw86938-driver-v2-3-b51ee086aaf5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: shxZqY2YBwiUtIIXud5FHhDas5AebtJK
X-Proofpoint-ORIG-GUID: shxZqY2YBwiUtIIXud5FHhDas5AebtJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA2NyBTYWx0ZWRfX7WTA2DvtZha9
 098/XDA5HK7Cj2/30ZMSGjm1zOsFPYsWGr1JN87XHUsrK8dQ/HVtaV9I8L26ZzfcAhhHuQYPevi
 PB0W053HrtpBvsgFLoVI3X1jxR+xT2kOtAdP/QEdCKiYtbhtAuhgc6afV28YpZfyO0OqYVkDglG
 7jftksmIAv7Xsyhtn8+Eu+fTZ80IXp9EU08ZmV8dKEl7QK/8jFNOvZ9OQhlC/IrQnkmWevRTNWH
 Kzs3W9MJ4UOwef9pej92Jzw41Af/XrCQTbwizMBffpEZS5XXfQBAN8nn3pT8WJZla0SKY+0oPC0
 +YZRg4mXQQ7E0rNWaRnnZIsUcdLyrjTgiDHPHEmAnbtcx1mNftTuj7xlrs5jndHGwb6peY7Y8+D
 BffAw2HuUpRtKLvakKiO7gQblOznpfImJS2c9+rp5XKrlzBKZ5KVMfGdPY2g7fXd+aKU3j3J04x
 rKosnb4fxQVkvow3gVg==
X-Authority-Analysis: v=2.4 cv=Cs6ys34D c=1 sm=1 tr=0 ts=697b33e3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=kndQm4PL0qyBTY2Ci5cA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290067

On 1/28/26 4:51 PM, Griffin Kroah-Hartman wrote:
> Add the required node for haptic playback (Awinic AW86938)
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> index 52895dd9e4fa117aef6822df230ebf644e5f02ba..881239d22fa97685206d1fa3a70723c5b77a339c 100644
> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> @@ -625,7 +625,17 @@ vreg_l7p: ldo7 {
>  	};
>  
>  	/* VL53L3 ToF @ 0x29 */
> -	/* AW86938FCR vibrator @ 0x5a */
> +
> +	vibrator@5a {
> +		compatible = "awinic,aw86938";
> +		reg = <0x5a>;
> +
> +		interrupts-extended = <&tlmm 80 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&aw86938_int_default>;

Ideally there'd also be a config for the reset GPIO, but otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

