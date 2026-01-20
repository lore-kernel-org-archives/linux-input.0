Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031D42DFE0
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913014; cv=none; b=H3Jv7LXMOa8duSZhaHIM5u1fEimSG48m7pbwCzqzn50qEIIG0IARtQG7+sfDIDFl9pp4aDYBAZz93R7zVLZ52Swm/KE7hiXoiBYxkiPrQCbUUSZIeOVheTg4ZcHt7PDCrTisTzsrkBBWbxbEY/CTgzXdxPxwMwEEkHuKkGlOGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913014; c=relaxed/simple;
	bh=Bqt66FG37gQPzxXo8GEua4Yy1cjRKNOcuhnhCZqtlb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWissUPxvgUA8ssRQnieVCAaiRfExnJs2JY5Ko8cicZ39gFr2QVbuqjJ3WQW/Pumc0FBYS+cazKhkmCsJLBDCmlcoBElWRRgl0Wh39jsKrefGXEDZH4E3fYqxDLqCSKLlMIncYqWCjuuPvKJ9nJEAYoMAmBwKlG9StWaTVHOvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z7D643z6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PwC0WxGl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z7D643z6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PwC0WxGl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K6ifa03154099
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vaWIDj6o3+/nwUwiV/H8Dqvr4BjKk1GgvJw43iLVUDU=; b=Z7D643z6cqtblgZ/
	xBLNFx79HvoR14QSrGHjemMePUy1Aec7iZJQmsyEjFOxZOtUUrVivAlWr6JpPSlO
	6Tn4jx6VUNR2YDmWMUj5N6K9f8crxqpucoXa5gdzHJPugKJr/PSbslQWP2rfFjbP
	h4MCi/sXv+D4nItzhsR6cYphjcC/ZRhOmC0ZYRcZZW+1Wb0QRQcyIRETdgIzlYqS
	OrtLhfp8E2GQrDv0Jx4jwF6nSgE7oE2ciiCCuItv0BzjhMZFlutp7JRK1JdHnbwF
	AfLUQvRBJhdNevCaw0PDBhhMGojTkEKEKZtDL2W8jRfJ/nNJbp7fhqgY42nYijUf
	hiEmHA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4q512fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:43:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-501506ff58fso16945151cf.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 04:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768913010; x=1769517810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaWIDj6o3+/nwUwiV/H8Dqvr4BjKk1GgvJw43iLVUDU=;
        b=PwC0WxGlvFqlv+GJYnrxIzUNtuYodDpSmjdcd/E0I0eBn7gdNd7YwXnP3O2zi5i7u2
         cGOLyItoBl9e0qEANkj1xg4EDyYvezzpX0JugMvkxMgoewnq4u333ur2cZqY05Cv0M2A
         9q1KqqXUzi3hpMAPEj0an0sqAT3IrMzGg/ANyGBA/gIZzqlT93Mh5YBmBus2rdLtgaiU
         Hk9+w8OnYRYIEoqMPqVP/zJ4YW5EpVe3mTwbDp/YcjjyWGLBzZj7nN0ejjTbBzujmfP9
         /8sEe24o5ZytYlkqPEME8mZs57F6pk0BsVayGehHisj7bjvWDkGob3gSNq2IBaOyae6D
         IQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913010; x=1769517810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaWIDj6o3+/nwUwiV/H8Dqvr4BjKk1GgvJw43iLVUDU=;
        b=kOk1UGaBwQhcrp1UKKuAJRRex6ubBvHSuK/2FKf+n8Dr/WNZEZn3RCFeK+3f6+EUqT
         +Obf209Eg7uZOTmOBnX4kPbhwyhoUWJAoicNvtK53jFm1g2tt48EFOI8/85Tq5Glgme2
         V+2lMFdqhY23nSz2V/K2+8BWjaR7mbg7oSsiYQJN04IUgWV5M42ZDb0okjttdY454Aih
         3RHYnPLnkzjAJbV3LorQyCoXf03DyB0ILmIBRk17W+vP2kd/vSEhfDYaJIy53/85wpGV
         S/vUce3pdqlrydFPONeIu95pBzBOzPy6U1vLkkdXZQ89OkhLY24IKXjo9hocdfyCd/ct
         GjIQ==
X-Gm-Message-State: AOJu0YwsASpLYWjHoV4SyBo1e4/1LFNiFS15ZxXMzLCl87P3uYPbLNOK
	OanRYZu+rYiEOpogFFcD9SXyi9WkvMIlyFoyfKN8egwvS3uAb9GpAF8VqNTrXw5vhVHh7OOQLjH
	8+dAcevTpyzbFm5Gde9nqTM77qIy0GnJiZhAFKGdsXHNtUPdymv4JDsneidh123w1Wg==
X-Gm-Gg: AY/fxX6LwQCoPSNgy01Wo+U6WSbFS4ffmUee4sHhWrUrN9fe5RngJ/36d7fgr2Ljb40
	OOO0LPsgzT95MWoIp1tvSF7xNd3/zfWK9XvirVkbrRp3suN67zstjf6FLWYxx35oPe8BGhBWaEH
	VSUQHl4krQZHgj/w0UbUsyU55JMWAcs3iktBvIZ+VrwG+QuelPWsHZjVG0zjyxqbidEPCAWmnPO
	cw2rwnuOyyoj1LPOT7yfd2Ku4UiaXCx+CYuB4YQOgrl8mMRDGCWe/WDh+tpnxENChAfnQVpaUlq
	GOxWpjEsm6jlXj82O39jb/MY+tHVoODBKGS71iQG0zqofwp9i3ILidHwzZ4r5ZgmN6TId2ESQOb
	/1jd7jrlmNnSLqBjVXGkO8XB2qrk/Q+Tmr0b9lzGitrnzmuS6tZru9S9xd2wl40MU1Gg=
X-Received: by 2002:ac8:7f56:0:b0:501:4767:a64 with SMTP id d75a77b69052e-502a16b7389mr165053801cf.5.1768913010481;
        Tue, 20 Jan 2026 04:43:30 -0800 (PST)
X-Received: by 2002:ac8:7f56:0:b0:501:4767:a64 with SMTP id d75a77b69052e-502a16b7389mr165053381cf.5.1768913009853;
        Tue, 20 Jan 2026 04:43:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654535c49dbsm13597080a12.32.2026.01.20.04.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:43:29 -0800 (PST)
Message-ID: <d2888a71-2b32-42a8-868b-090f1340740c@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 13:43:27 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Add
 Focaltech FT3518 touchscreen
To: yedaya.ka@gmail.com,
        =?UTF-8?Q?Kamil_Go=C5=82da?=
 <kamil.golda@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260118-touchscreen-patches-v3-0-1c6a729c5eb4@gmail.com>
 <20260118-touchscreen-patches-v3-3-1c6a729c5eb4@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260118-touchscreen-patches-v3-3-1c6a729c5eb4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEwNSBTYWx0ZWRfX3+hfS/GsPGci
 sBvEZG8aX155wQt0NwlDC8ObxDP2ar1GRrdCuCXwIWfR773XCvtT+2dmcB9rXLbxmzOY9MYEasv
 RIQkhdES+oZrrWeqrn89EK3xM8LGC7vqNheCCIdl6CuB+4VmoFYAP2sw46r39S06xlliHh3ofK4
 5qZF6sRkRuHiZm+PVDvd5UsoP+FgVEPAY9n+s55txS5vf9X6ajJu1u/VegtqqSgk4bVpBi/CATC
 auGp2rZNdUyWmyIMsqSSlVt2UlBQk+UGRAgpNOGyN0KLT4z7iaQaR1M1h+cKmZQNPIx4zRFKyzp
 9SSZbHA/AqbZxWE7/Ql4MrCN6KAmTLFwI2clED7ilVHXRy6oyQOa4/DG/M8g9kMTzilJRMSB+XC
 s1WQou+bHwb5U9iHwcAAJFSw1xTUqDkjDGY/lkbYmOCBPrLv3gd5x1FKCHBRlXocBlHkYCuv3J+
 QbwwUDC20YvF4DZ18uw==
X-Proofpoint-GUID: DRk15g7adu3wRLDsgX2G2LqerZYz7yA5
X-Proofpoint-ORIG-GUID: DRk15g7adu3wRLDsgX2G2LqerZYz7yA5
X-Authority-Analysis: v=2.4 cv=MNFtWcZl c=1 sm=1 tr=0 ts=696f7873 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Uyhorv2uAAAA:20 a=pGLkceISAAAA:8 a=sfOm8-O8AAAA:8
 a=8Y00a8MOIoAAH37gNwoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TvTJqdcANYtsRzA46cdi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200105

On 1/18/26 9:29 PM, Yedaya Katsman via B4 Relay wrote:
> From: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> Add device tree node for the Focaltech FT3518 touchscreen on
> Xiaomi Mi A3 (laurel-sprout).
> 
> Add pmx_ts_* gpio configurations and reference them in the touchscreen
> node.
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

[...]

>  &tlmm {
>  	gpio-reserved-ranges = <22 2>, <28 6>;
> +
> +	pmx_ts_reset_active {

Node names must end in -state and you should use dashes instead of
underscores in node names ('make dtbs_check' would tell you at least
one of these things)

> +		ts_reset_active: ts_reset_active {
> +			mux {

Please drop the intermediate nodes and put the properties directly
under the foo-state {} node. The indirection is useful when we're
defining multiple pins with the exact same settings (e.g. 4 lanes
of SDIO)

Konrad
