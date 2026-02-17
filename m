Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CC33A71A
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331428; cv=none; b=McMhUifvvqzOwpljdkUQt6BJO1uJ2AcBPufGlnsexARoXQlWkT4qXMf4ItNpBo+d2Cw9y5IZTkN4tk3risDlEVgtZtR6v/awz13T2jKe3Axh1+Z+c6dnQDbnj8DMJC0ud20WDG6LPJ54SzuJq+WYCMzlvPyDkOCX8RkgE8gLQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331428; c=relaxed/simple;
	bh=iaOjQh6oj22SQAOvuDXoKCh79HvL3yEC6boAm8Sbarw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjkB9qt2EOZmngDWbfKA/CGBKGQ527SDSOx394RIX1o52WdIENvK/LmgMO+4HYQ6R/fX1dNc9WhS0T4PW/GW6V3QGoNFU7RoyF6HrNRwNf0hwSLNQaksz3IG5OWUtJxJTIJleerznEXjXkYuUquhNdULZCsOAq3Nm7lv3Ww65II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpvQK+Mn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2vVqiyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpvQK+Mn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2vVqiyo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBVjsj910591
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=; b=lpvQK+Mnpsr1OXoG
	gGSCb37+QAeYAHvYCzWdmMGX4kzOYeT4i9K1YtQRtonZvF6HNWv1bbdiiEmy+7WE
	ooIHyk0PLYeq1V1QnFCVODEJWJZm78gF6gqnlNkuP+3JcnGQomzqIytit5Qc93QQ
	Ft/3EQPgGIOHJgzSnzWEKk018nd+Vasq8hHWj9ZVjQC/Ao6RyrEN2zLTw+iGE5Si
	FiYGeXJUmEq+NOyitvYqdlvHRPxNbABIUoZfQbuUlTnoBhX4Ggowb8YcwHF+q2PK
	x1ZLfMGlXae+jwQhS1O0ChZcu/SM4zr0Ps1QhTUqog2mwpLfNwvl4J7STbrVvx14
	k3BQVA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9tbh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 12:30:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8966be97747so28947436d6.2
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331422; x=1771936222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=;
        b=Z2vVqiyoHhajwwzDyt0pnqGQJPBcZj/7BT4h6RCRlSuv+ylWc/ra8x6caw6b/rUR36
         ZSIB3YQhckYFm8SYEo473Y8TWoA8GLDKQ0NTFU35/kXshSMAOzHR5Opr7cFmNtbL9aXC
         mW94RLay4rYzMNBCftU99WOpuqjg1gTP7echJCcFi9RWWIBhGVtvin+cMJwjy+uTi7ii
         bCmb26SFyFpe19DnbPjeULs7AtGHk/G9bNzGsnzb+C23f3kyzkZumm37E5k7UojAS9M3
         aiIB1fUJasTzXLNA9y/CSsp13C1KIpjC4XWELxF87yQHXoOvJGfTDyP4ESUEtw6F6JI8
         5AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331422; x=1771936222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=;
        b=IiK086Qs7pUe9oDjowLRtUBMGWLh5zvloZLFgeh9hijLZZg8UR+0H5hdDFehbQTM3+
         R3VL/KxL/13xhC5nTFQ8JpnL0I/F3922wyFDQ5hhIrfxAKe5oSqunbJDrDKTt7pGPriN
         qzxqsP2C+i/9niN5wRMGZpgtCaOVO3uJP3QX+XRG1/2DlWzJXr9HAwCgsukSqoknp6GC
         mrNlum5ndDVhr1E4ZmhCiIei+LoE/OeGfK0BS4sl+Bq3Fuk5LS81kH+Siw8XfN8dIjvZ
         GhWPEV/2wwdg+fA80k+AhaEAukFpuaPL0YbXT79BaitNf1DvVYDhnY2yAcuL8AulV784
         hE6w==
X-Forwarded-Encrypted: i=1; AJvYcCU6HQUwz00TNN1W8S1IMW/Phi2fiUy5DLuVGxblPcXjVQQjsn1Iy1MXVund13Oai+HZyumLtEohy9M9hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnsdVMkJG1Uutc1tFQ03fAfh/gqLanJQJG4FIDdpbDXoA1ikt
	wFHRqz/hnkO37vHf6RXMaoRz4Faef9Fm5dKCjm8G+5V4OWs9QfgLowZtYXsTaE4wcKwjgNtadnH
	qTtItwIepkHW7nTZhTfM5Jk++uhg5nM46pEZkvxB1oEv3WeY73UKfDP+zmr9XDHG3fw==
X-Gm-Gg: AZuq6aIq6RvTmbCy+HPTLzzcS72qCJ+iMOFJ+5aDClv6zmu4KCfTtBxcdpXkmWynLy5
	+78emp4Cf+4CFdYu2z4zz9UsjkJvYgZQLx5t/8tkQ1unbjhSf1Y0nTSH59EMISZWMRegLlKmcMN
	+6EK81kZpGfCnfSqS6re7RVmOiJsmxYFajNc5JPsBf9up0DMeOuMk1St32wnQ4R7sq5Kg0sfj8l
	+Gy7LbdJJqxrNw3uYdYbEgi6aFBxRSBuSJX2SXiomC3jI41Rl4NHp3SlwdOf/s2UcvRAIZM4cAa
	ahXVAMixXHnr+X7D5PpyFsxQChvD6FUFbJ34N2uvI+9WoJ/Ag1/vXC9ON+ISkZtBHrPkZvNE9HD
	/YOhb/YcrAoHC4vVvOUeXTFgcjikkGJgRYed4goScEnscodcp+Nrsm6UWBhgOVGH34m/iEdvsig
	hpbbA=
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139048246d6.5.1771331422403;
        Tue, 17 Feb 2026 04:30:22 -0800 (PST)
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139047476d6.5.1771331421773;
        Tue, 17 Feb 2026 04:30:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735d66esm336267166b.4.2026.02.17.04.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:30:21 -0800 (PST)
Message-ID: <253ca948-07cd-4ded-8e15-619589f2d314@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMyBTYWx0ZWRfXxoimmC3R0KII
 +DgHc6cwO6qcDyU6tMfUGxKimhGsMcr9LIjnrUTlSODao2kzgDRrKiFiEMqnnCgPgJIJ07xs0oR
 DSnOJAFKBjKvGAp+yKounH/h/t0iIXs4CEWzfzhZfiGaeu6D0gLtE0NVO9q1FauT9l3Sz6DL8w6
 5sBIlU7gfd5QDxANeC+UtldttRBUFWO/PZlDk4m+fT1nnCndFvK7229RtVY/2DOsqbnss5ij1Yz
 qX52Jb23MYhRu49Tzj/RusNSHJSw4iqfR0hSU2qnP6ngzNVFg3t/gz309qMEJAYGSEeBZjOZu5V
 sK7grzDTYyuNV1SaWY9Zqw8ZjxdRet4XR4gFSPzDt5vUIRWgNZcMPhPzLFEThkjxyT+7Ki3uPZy
 u7K6yNlzhggLiEu0s3tjSPtYzc/R701j8PbEPWoYMX4gPReo9HipsrPgrJiW0GK5f7SKMpq84Dj
 sI0HNjoivxxjTWOzCzQ==
X-Proofpoint-GUID: t8I8GMi1eRYyUney3om62i-GQ0tBdokq
X-Proofpoint-ORIG-GUID: t8I8GMi1eRYyUney3om62i-GQ0tBdokq
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69945f5e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=1fdw4J3Q9qDLbzPSb8EA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170103

On 2/9/26 2:23 PM, Rakesh Kota wrote:
> Add the Power On (PON) peripheral with power key and reset input
> support for the PMM8654AU PMIC on Monaco platforms.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> index e990d7367719beaa9e0cea87d9c183ae18c3ebc8..182c2339bb11af40275050a36c4688227e89497a 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> @@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pmm8654au_0_pon: pon@1200 {
> +			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
> +			reg = <0x1200>, <0x800>;
> +			reg-names = "hlos", "pbs";
> +
> +			pmm8654au_0_pon_pwrkey: pwrkey {
> +				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
> +				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				debounce = <15625>;
> +			};
> +
> +			pmm8654au_0_pon_resin: resin {
> +				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
> +				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_VOLUMEDOWN>;
> +				debounce = <15625>;

FWIW we tend to disable RESIN by default, as it's not as ubiquitous as
the power key and only assign the keycode in board DT, since it may
commonly be reused for either of the volume keys (or something else
entirely)

Konrad
