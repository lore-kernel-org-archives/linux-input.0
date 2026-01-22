Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F530F53E
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089931; cv=none; b=p/qkqhoAsLzB8p2VnAFSyVpbmEXE5rVthBmy3MlloOROQDhu/S5ANz0N+mB9ECJ45pYIrFCaN5hsRsj4pODHLSjGa6mrePkI087xErdBRFS+98FluH+40/hkT/z752mfYzHP9xip8cUcwJpfcB9QUbH0NrpkHspslgYlMr/ucUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089931; c=relaxed/simple;
	bh=ga65sxhAJHUJji7O9oQdbmcVOPqKYXj//T9LW9mrHM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkNUG+1oJA+TU0csxH/fh73P4lVQWEsS3cmJrAfnq4JhN32sn8YyhmanbD4OGpNDH4CGApDXWq7goVHGZ2z+/wQmsgCEFi7dipTwLbYzkNWJ+ZKOoZ9gp1KiSKF/C7jn9YL4gW8Z30k6tOQeR5jLNq70DB0xqx4aJR/danN0FBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYENWwUR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uv/anQSK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYENWwUR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uv/anQSK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6ri8v725005
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 13:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+bm98CmvFPw6HMS+ib+QUJlqZTUeRxHzvB5wxnthCqc=; b=MYENWwURaWmwn5Ry
	dn5ZDbAyw1DFmkp8dtzansCv3ZU5ljWjEppOx51JGA8OZUl9Lffx8dVEZ2fvFG1E
	5jSrJw4MoA5WIpsWXUTGpUXUubYrvmBlU3XaE5MUyvh6XNq8XfZTO9jR/5tlH21o
	SUKf4TfC0Dk802+WlbY4R2iYeSnideTnQZkeLOzffS0hiCJ8q4whSy4SPDM4xeRi
	gbgObt42cBi1TjLCy+hIkjkr9nTwUtKqd85lrRajdyLoVrIt+iHfIUIzk1JaCAKQ
	E7jr9B4UmDDg+C42SPVh5Suaj09RtR/hqUF0TGE6NSsSH8/B7ulJENkanhTRDUBI
	1xwVJw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buf1bh72y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 13:52:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c536c9d2f7so29130485a.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769089926; x=1769694726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bm98CmvFPw6HMS+ib+QUJlqZTUeRxHzvB5wxnthCqc=;
        b=Uv/anQSKWh4IQ3j6nZJhSLT9izJ4IVZyY8OY7CXdF71rsoMWOPCj9mmTb01GH/rN/e
         mdUWZkzQFQ1CYtDdxGinkp1OxwX5A2fu5be6b75OC7VbHUbN+OUjsIICIQiSkLT8mTJk
         Rvm13NZUbqAchZQWem2d5Ksbv6C+ohrIuB5teY1vBO/Pr0dy4lc4urdWEFvO8ZwgVNwi
         HT9vUsBCQUz6ldghRHx9E8s+qS5akutHXXJeB3pQUS7p2ovi2GtJz9lDM9hfaHo8TCXs
         NIzPBars/iubXklWN2I3c70Osy90ch2vUHPfxFtdzR2JlDoDl3QjoixmbaTdNuHA3FKS
         8Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089926; x=1769694726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bm98CmvFPw6HMS+ib+QUJlqZTUeRxHzvB5wxnthCqc=;
        b=tObEXrXoloTNGGUmEICs6Pz1BldVnvT4PuuZyp1T++8FA99TFi42LEEBQauL0vpX7i
         doefe03kgqBLdeH05xOzeco4NimqF5ZptbQ6RRL5vv/z0P/i55WylqP5jVG78hYgelF0
         P/RmBAtRm6S/tc4AvLi/gacj0q7KuvBvFFYDnC4BVbVBtN76k1/8wXLQVWyvUbJtz0Fq
         QQe9VR+zVB+8S51BaDDIcyuaasUWUH/kl4sw95sE38G18nNYlGXXNdhE+fV+m8xfEV8M
         OJA3LDd0UbwiaZooz6ThOvyaf9qIog7wu5IQZqrachhH0rTWlWpbkJN7MqAaTKVWig3z
         y1Ig==
X-Gm-Message-State: AOJu0YwexwLigeGq6D+KZ+bNS3N890ChSBIgVXd/NpOwmxq+wlWTAgxP
	FpS2V/NFO/Fk8AnMdxF+dZgQlW2nodoX/I+E1TDr7NGCf7YW1cBb9FmRSUEIJb9tuz325YzVtk9
	TaMHBcYZ2Il0o/njsKnFMbUncWDwJMf2vWO5Sv7WFrTjEPaIafHhSXu7lFRVL1NvZcg==
X-Gm-Gg: AZuq6aIjIJOBRnRvI1a+gdFizng0NZPvNTzjQ8SX+62LJOIgMQR1uE6OjXfa23XUX9U
	+jK1rjXfQwOpSnz0wkgdgnqx7AIfPMIEqXveK2vgpdHX8/czgrEO4BcoVeEZtsA6mufIFfNbYcT
	HjwoigD49Sr7rhnRTdsDV6ZxLgQgeEM1sdfln5qH8s609ucEofnUQ1mtSp3fkuIpShxsgGec0kG
	2XivFCWghLgO6CJjrYsamu2cAvGnVD7vEO+pTqyp+eWML7wdQ8JahRMgRQ9JD5YTEohhFtTU995
	x4yC7I9WZakCN/k9LtVWmDn24obCOgyyhEfLk+3g2D+ejDgoBXoMRbuoG2SIYaeWtmmdZHKYmBE
	HTx3YmWqkQE8Zz6B/rHj78Fm8oWjrNQq+K4opPRxYkk+Q36AwXAJ1gW/xWn8v2jpLeog=
X-Received: by 2002:a05:620a:6c0c:b0:8c6:afd9:e422 with SMTP id af79cd13be357-8c6afd9e501mr1871028385a.9.1769089926415;
        Thu, 22 Jan 2026 05:52:06 -0800 (PST)
X-Received: by 2002:a05:620a:6c0c:b0:8c6:afd9:e422 with SMTP id af79cd13be357-8c6afd9e501mr1871026185a.9.1769089925949;
        Thu, 22 Jan 2026 05:52:05 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8844f235a7sm62815766b.45.2026.01.22.05.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 05:52:04 -0800 (PST)
Message-ID: <6ce5a785-7677-4b49-85a8-2e461c45e6dc@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 14:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Add
 Focaltech FT3518 touchscreen
To: yedaya.ka@gmail.com,
        =?UTF-8?Q?Kamil_Go=C5=82da?=
 <kamil.golda@protonmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260120-touchscreen-patches-v4-0-30145da9d6d3@gmail.com>
 <20260120-touchscreen-patches-v4-3-30145da9d6d3@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260120-touchscreen-patches-v4-3-30145da9d6d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zkGFhJ2XSYioK_r1D4NK_aGZRXPDoFFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEwNCBTYWx0ZWRfXzwLlNip4I9lj
 JZmyOfsFU5pnpkcttRPpxa5H7MasrXeUvu3H7V4M0TNkWcYeSGPZvrKk9pmkeoOcjg8gkxqQuDI
 wnLxJkzjsOi3MmKXIm89nCguyGJJT8/CcUIcqxoXWuKPiOUScbyixXH8NAviZ/7xkmidy2udDsV
 mf5u+WAZ8YkJ+hHloDTpetoGI21762FS/VF5X5Rzft835vEkuatkQZQlmjCy5l8y7Lgt94Tk6/y
 OjEft3sWwB++HAfny6peIx3ymzANGmDdhmvHqaoEYdR6jMcRmlNr5Rqz5zAVkcgrLG2PvpE93ws
 v0BX8xMi4dWUSRn2ppz7+NbB/zufGwLnnt6E6Ib/+OgjyOyHWBF5n7zmedoJLQwshZC9SMYzK9t
 Dcn3FcWvV8O3qqFoBf3e+UGzVaVA/MHCUIibKq85MfePHX4vktBlK/CM004KZ4mRGVkzsn9gbND
 vmQjh1fscD81d6neBlg==
X-Authority-Analysis: v=2.4 cv=G+0R0tk5 c=1 sm=1 tr=0 ts=69722b87 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Uyhorv2uAAAA:20 a=pGLkceISAAAA:8 a=sfOm8-O8AAAA:8
 a=6A7nkN39ng_kv1CiDcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TvTJqdcANYtsRzA46cdi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: zkGFhJ2XSYioK_r1D4NK_aGZRXPDoFFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220104

On 1/20/26 10:40 PM, Yedaya Katsman via B4 Relay wrote:
> From: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> Add device tree node for the Focaltech FT3518 touchscreen on
> Xiaomi Mi A3 (laurel-sprout).
> 
> Note that gpio pin 83 for the regulator isn't documented downstream
> except in the touchscreen node so it's not defined in the tlmm.
> 
> Enable qupv3_id_0 and i2c2 bus that the touchscreen is on.
> 
> Downstream references:
> Link: https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/laurel-r-oss/arch/arm64/boot/dts/qcom/trinket-pinctrl.dtsi
> Link: https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/laurel-r-oss/arch/arm64/boot/dts/qcom/laurel_sprout-qrd.dtsi
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> index 994fb0412fcbdf5466f87a325c48b697a37b514b..ea9dbc6927a14ca66da818b81aeb0c95ec3c2e7a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> @@ -82,6 +82,18 @@ key-volume-up {
>  		};
>  	};
>  
> +	ts_vdd_supply: regulator-ts-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ts_vdd_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 83 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;

Ideally you'd add a pin config for gpio83 too

[...]

> +	touchscreen@38 {
> +		compatible = "focaltech,ft3518";
> +		reg = <0x38>;
> +		interrupts-extended = <&tlmm 88 IRQ_TYPE_EDGE_FALLING>;
> +
> +		vcc-supply = <&ts_vdd_supply>;
> +
> +		pinctrl-names = "default","sleep";
> +		pinctrl-0 = <&ts_int_active &ts_reset_active>;
> +		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;

property-n
property-names

in this order specifically, please

lgtm otherwise

Konrad
