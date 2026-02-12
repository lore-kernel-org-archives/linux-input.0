Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A235BDC7
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903672; cv=none; b=iMm5ZS1X1SmOZZbihMGs2EaIUxu1pOlT00z2Or/A5FJsp9eLUWLXs0+/ugmykMMp1haySahuPlachUGr30pjQVYKmeG/gC3jNmLZjWHEWBk2ifjHVj83gGfNeY05bBPBVbbZnyOV9jvoW88Xf2W40DAK9iUQ2cPlltzGbD3J21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903672; c=relaxed/simple;
	bh=nAcWn1YhQ3PHXqMYJwlRwitF9aeMboZWC1V3ud+4mtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTx2EV8W3LaoDty7Z3lvhdrQV+l1IJipx5uNHS727zYXDxIhd5ILxfVC0qH0Dm7pOBbBU0XjAvu8NGf3RvFHVZCF1Gq8hfHClqXE3/fiseX7haj6Wkro4DAedXP3Jgoel1tABWHsMIn8o+LEKdFjwIIUKY+HR8KU2m2vjkny868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIuORg1i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=amqJ4c8j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIuORg1i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="amqJ4c8j"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDS9m31075184
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 13:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCRCDzmfXns7/oXNTWW53o+t1npEgX31smcF3lGgN8E=; b=pIuORg1ipOMazCjN
	Nj9FuVe3Babh7ivPL0Qf0n585mBcBTzm7Kkc4Vx8tdFzLI9QdBMZQT2QOQzdITF9
	7nHvnHnIGZuzaCeQzs3UjQBOkoS3kZ6rB4FajSK8uuYpuGiW+HvlLTqKLEejaf/6
	jMGwIJE5i+dsSol1WjUvUzgBsDcMWe/wuPsHLTilomRpfGSGJ33kyI5DVCl96J2o
	rgA6dm8KI0HADyl8TpWiy69rB8US7D3OIjq5zAB7oFGG0QOXZPWRT41k1Hffr7NR
	9qTtomsRNx8x7fFbS802wtAs1KQ66gVoYEuGMfvNNJ0w4dwv3Ia3x0PLM6T51wLl
	C9wTQA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y8nu5nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 13:41:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb38346fdbso17929885a.0
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 05:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770903668; x=1771508468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCRCDzmfXns7/oXNTWW53o+t1npEgX31smcF3lGgN8E=;
        b=amqJ4c8j+D6bEC9yiB5i0Uq4wiC/gONN+Sod5JuTL4DDeiHcZ6wvP5Go18rFR6lCkF
         0LcXZA9b7mEIi0sNh+5W4SZNPg5oHdTqDTTvpqkaQD+jVRysYFFoWL44kngRPVo4JR95
         68S0tMhGy4qQCgctBRf4/VKMSS2NXj+Zi3lioWRASRnbdbKS+f8EStsx95pQsNEmZF/H
         NUA1ZIHyPKPB8geS6vMWXffUlCSGDQCag4eEhMUo1PSNIE7qTMBp1MxlvE0kIu26HfOM
         E8tx2Be97w/VsERkgHxAqOKpWXmUlyTL1rmhrt/eSMCGY46E3rNHsMin0HrsYR/rMQF5
         M7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903668; x=1771508468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCRCDzmfXns7/oXNTWW53o+t1npEgX31smcF3lGgN8E=;
        b=HOKV0EZkJMKBn3y6O9K1pXMdqrKQmhvYQPsL/uczqMcqt1u47cUK0uBbncd72aE6Qq
         keDGB7oKWfPt4W01B0p/Le4JG8+NPmQk2rOxLUGm7pYKD0CIzMQhXRPFbMQsY7BCKDVm
         2BFGmwisF1KeqFmSh4M39V99lAnPufdCU2xLc8OjAiUz9ydX3su+7Je13dkDnKssPjnD
         wb1ob0KDFfMi5cqM7bg4pQ0jK53ShaWAOXD6Wf+B/+Y3URLFSpfT6tIaMtpzLJssDaEi
         fhBws7fFTRgCUXpWP60VRKjAoi9IsaaGvjU41bQoe07IQGDznUMWgTiQLrKwCVAJ1pxx
         YjaA==
X-Gm-Message-State: AOJu0YzCHAn3Y75IiNK/10lvyCkn5Z+HGCqpHcTVyDgQKe8Jxt1pplvd
	ilzLf0XfVsmkErHkYd66R6OHKCjVTZpuMBDyByrjlY3Jwyu3MtgoS0YFkzRcN/1qtW2Zt4hyQ1D
	GnD6d86CZVddDZcFqth7T0yMZq74ZUgZMViGeiQ3XpBMi+TPVfBjmNfkkrUBqAz+FdQ==
X-Gm-Gg: AZuq6aIQrd1VWnl79/kqsnYE8ClvlXfpg2at8Ce0JaKbZqPvCWRXfwf00TbnD6T4LtH
	22elPJAYTi6cHJEllEm57C2SmVraMkapdRUpsFRTHNZcNr8xnf4OBwA/LunA/PrbH/xgork5CJY
	nRlM7UsqSnzakhsVKg/weh+2gWjb21D0olrw4dGiBCLT/L8odQNmKJWrDXoy+gIM/ow6CidK2fH
	CqhMyHLLOQha9g51U0YTTgwnTyxXF4gMGwVoHtMHheRZYFIGhsRNK2BHH3D59yFky/mteuuhCC2
	jb02MojdIrHDFIl64jBByxXGW5K8tADK+9crQDb94kzPupORXxh5fzwY6YM9RwXRX0+A8jwVc6k
	/SEViWB+JdgsEK7vxwROmZOzFgsrcnMhhsZWWbAp3FEzpBy342AGp17S9gq12AHnw0U31oGtNnA
	jRt+A=
X-Received: by 2002:a05:620a:4407:b0:8c0:c999:df5a with SMTP id af79cd13be357-8cb3311bb60mr255615585a.6.1770903668217;
        Thu, 12 Feb 2026 05:41:08 -0800 (PST)
X-Received: by 2002:a05:620a:4407:b0:8c0:c999:df5a with SMTP id af79cd13be357-8cb3311bb60mr255611385a.6.1770903667788;
        Thu, 12 Feb 2026 05:41:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9bd846c0sm36946766b.3.2026.02.12.05.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 05:41:07 -0800 (PST)
Message-ID: <0dffe84a-d41b-42f0-80ac-fbb8e81970da@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 14:41:05 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Add
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
References: <20260208-touchscreen-patches-v5-1-5821dff9c9a2@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260208-touchscreen-patches-v5-1-5821dff9c9a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwMyBTYWx0ZWRfX2D9DLWL4Chan
 vqkt1BEh1/JHkBqhgHQe4VS6wZLsptUnzerrJvUGocquY60owL0t6rxtf94EAszV0luICOWdNGa
 IKUE8i1rwEGMGu+sADyZLRm5JR5HcR0iXiEdsoU49r3c7o2SgrnUzvJBHWR7doFyyigNjKcnLde
 eszHDTRL+QDhpOiKqTi4J6M4sv6C+EDhaQ+u4XkyG3gSU1M2b9UmBF2X1nrxVLPwkr/QWFjgPvE
 Z2QHXxVEa6jIGw5gHpaf3LiH6ZLfnRAysZ90OX0NTrOd+XRh2XiCLKeWAE87pM6HNOtN8yzwWZH
 VUzYxNWotE1BccrFtqmKYvxKe/fy3uz+lA6QMUIRu+5awjyH2CPr7RKFO0qMk9CyByeed4B+CLp
 jh9c2PMqdm1i1Xw8jMXjog1DiJLEs53lacu5sZi2/HBukzhdn5F4TPsRahHdkujr3Hs0SRUN63Q
 hwsMvOZ0ooPqqB9pdLQ==
X-Authority-Analysis: v=2.4 cv=VNvQXtPX c=1 sm=1 tr=0 ts=698dd874 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Uyhorv2uAAAA:20 a=pGLkceISAAAA:8 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8
 a=SvwoN8VrOMzw8yseGhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TvTJqdcANYtsRzA46cdi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: IhGkoV5-YvJJyU5BddRJ1OXsS1GUqxN2
X-Proofpoint-ORIG-GUID: IhGkoV5-YvJJyU5BddRJ1OXsS1GUqxN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120103

On 2/8/26 10:24 PM, Yedaya Katsman via B4 Relay wrote:
> From: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> Add device tree node for the Focaltech FT3518 touchscreen on
> Xiaomi Mi A3 (laurel-sprout).
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
