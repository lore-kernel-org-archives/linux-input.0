Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BE4A7CBF
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637144; cv=none; b=A/wIDg0dzEpI9bd7oMWSW4e23QMbnjMVqpeWaos7/ELuSVILwJtNVerFxO4xU1PYFHcQci6CPkAwlaD6LbCANMoBiNovEfHACBQ/TnmgHKJO8X+U3KkL3srwyr8GC74DUK8GgG97oYM2he7DwzUNvFlYRumjRA3HkJJN1VQNG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637144; c=relaxed/simple;
	bh=wImfqcMzA2hutdV05gMXWCl9C8YAeHAtDEmm3ZgYq3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbGR29aytPIwzJ+Xov0XZUebDnMV12CH09JxXl5U1ywTSBE14JD2HvpxW2GOQItL+sC0t7qsEW6aEeL1MhJkhKzvTWXfEepSTgIPm7sf95NmMyA3bXW7RZn9lgyxJhSI2yQnYRKw5vla4Dm+oG0kdWsRb51pPSgD/eIz166ZKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGTIZaW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BPGl4TuS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGTIZaW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPGl4TuS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60tjN1031732
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bCa418cMIIQpTdgZsvi2uq+5J8yQEDdEU8Wb0WT9txw=; b=MGTIZaW4ENReRMGz
	JfeWV7Ui92RrfyLqfNhCV83iFmUM9jq44MvA5pZ4wpOREoKyAQVUUoQjPyRYDVLo
	rZ0+AfsnxlOvk7w7Cll0TQrgkjQsysSWWGfqqGh6lJvN+XrglAGl1lhEc4TCjWDh
	B9kb6+JG9jTa0aNrGymM4mRTV+KgZKNx96pvK2MK/eZaM6pb/C0buw2lCj1ayCX+
	dNHv4ya5PCHXrJ7Yss+Xj02VbPRtZEqVX33taoHi5iPT1/AnNWTkBmQ2Yt+5m6yi
	wo+gqVgN9/+sU30n2iOAt7elaoFGfYFNIR7SlxLj6QjTbh6xqghMv27JDlq8G3hk
	Bg2H6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hbgwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 09:25:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93821883e26so24493385a.2
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789637137; x=1790241937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCa418cMIIQpTdgZsvi2uq+5J8yQEDdEU8Wb0WT9txw=;
        b=BPGl4TuSm1k1xwdhTXVybM3J4Zhq8h1ADqje01j6gai3K5VDflOXMFMpi6TVO+NGBq
         MwtbRxcpvvm2COzm7lPF8ZSGqCHBy4uEfzJl4HwXZOzQsHoBHglrC/aYpAGgMgJVs2lR
         1hcX4BLrVMvOAE41DS4mXbU/+gX9Ca1wseUgPMAfl6lecLrO4PC+eyXhpOVY6LLfdBQ+
         /TO1hEa4a8UNRS0o47bTSvYidnC28eolG6A5rtyDfFi0Ha4qoxC03gsbR+C+u36G1K6+
         Y1HUCrV/cnEHPumgNsecDBYIiuSoyGEJDgDncIXZ5eXzIZuFJb01JyHvT3NYE/pTog4j
         XWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789637137; x=1790241937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCa418cMIIQpTdgZsvi2uq+5J8yQEDdEU8Wb0WT9txw=;
        b=K3GaK7W5SntPpYipkhA+d0FldY1XzcpCd4wAvqlNfqBdX2ZEozZnXvEORFOJTynL1+
         UKTF44J6kuWt/L5pJtD9eFo+ES5J3BiAl2z7gi4Sl/iqv2cY0jJl/ciW77pqUn/Oxbjr
         w6m4WCAmpx8jQzRhXhqMcdQNX8COdTXO2zh3vWIVXmqWCi1bK3SP19TESW+CmvwO9ALK
         ehYzrzkjZ3jBSSaXYQKE9Qm5OGm7CWG0Q3UgY9DH2ysCurRzyjQPBS22VSzzUmCHSA3x
         t6Xffdd53ijulaDbQ3n8siI9XyWR9sg3hr0c2suF6SGcraC4s804jxb5CWDo35POMdaF
         MSRg==
X-Gm-Message-State: AFuF++l/gDqLAAqBeSaB4aoYr6+Ap1L5vWeMVght4kwvSPhRqvyu7Ktn
	Jl6lm1FzyUCOtX40YbW/W3I8EGz+OapVZGmufevMh6BnBN/sDvIz93/kD2CiNAtjrLMuk+K8qMU
	ycEDwSjjsttj4do7+7TZBYw7M3U1so+pr7bLVAoyfFlmEB5d4TWfiH/4lSBqasZCqxg==
X-Gm-Gg: AYBFou2GOWt+rr+1dcdm+xl/FQYIFttSAfsAB7vGedRWHBgDaob5kGSiI6H7L99Mbj1
	3V2gBKkf37L1v3sMxcUmQ6PEDB7IGhTIpZoxvv8V3zNFQQyJuNw4l41pWHNUR0XOofEuIjNbhYR
	q9D6OeqnLAAof16n76og0XzjUcO86Y/v/r2zk2e6sesnptD/n/UNGLzXeYW7ms//I3rFp1zWdhx
	RXfHtSZfiodNuXJ1tZOauUwIau7oC4T900CoeXYTQMGYB4GY7xNzDIPW8s0TTuIjUc2aFPs+j/K
	YNPjZPGEPFQd26yomN6tXdoZ4XjCmC4IQT26vMmu2/c/ysTjZizyx/kfb/BNl3jb/6cASy/1/lm
	I5r3kHNMGKYKDtA8oilqYRA==
X-Received: by 2002:a05:620a:6502:b0:931:23a:83ca with SMTP id af79cd13be357-93bd3dfe95cmr24675085a.4.1789637137464;
        Thu, 17 Sep 2026 02:25:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6502:b0:931:23a:83ca with SMTP id af79cd13be357-93bd3dfe95cmr24672985a.4.1789637137049;
        Thu, 17 Sep 2026 02:25:37 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de4879f1sm268554966b.32.2026.09.17.02.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 02:25:35 -0700 (PDT)
Message-ID: <848a64de-c120-4f61-be03-181d4df92ad6@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 11:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
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
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
 <20260914-aw8695_haptic_fp4_driver-v1-3-156f7549149a@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-3-156f7549149a@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEyOSBTYWx0ZWRfXwG0UGN2jPYAn
 Q8YpTW+HtOohpoTTAnfni8rp4rUcjz1S0cN3alCHRariHTFpKEDkX387/Fg67q+ebvSgcA5pq1M
 K9+tyeoUuTaOMnaXPBvzae066ulMuS2jDK3zHkfSnDK69yiQRuTboVsnP/2sGn+XdIA1fvA5V4C
 UY+2FeCqd/a/BnI2yZQwAEqWUT4P3q9buN9qy+mRY2wD7HKI8ds3Bdi1W2A88ZHRColdXCeL2me
 juTCuZc9E9eVQtELlwznpmVjNuFj1R/5gJ1C+pPMEliQ6kXGg11f6UWFi5hWKJqfgyrvI7qOR2m
 FlocBGVE1Sz/QSA0Uf6C0XUovXfljGCoWf8AXkXgjnhyHXL+ErGrQ20/WjIrq2L4VMW4Ex6bmQC
 nKrQquvF6xC/SCmQ0gSa6Cy6UQormiw0wu91rGi6rD4+QweBCFu99m9Rt6/q9RZQk/sAy8DBF7a
 uT3EScE0scS0Ht3iGRw==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aabb212 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=6H0WHjuAAAAA:8 a=aHkRhLIturER-sMqCjoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: vABqh166f_TizWIO98lJ9nbC1TIcDRjJ
X-Proofpoint-ORIG-GUID: vABqh166f_TizWIO98lJ9nbC1TIcDRjJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEyOSBTYWx0ZWRfX9jmR+bYzjBNr
 gyBpBVGrDJQDxyvmyE+E1qyKZ9nQ5RtRSZ6xn8HcQ+YqESC2C1fGlm3FAm/HJqVzMtH1M4CK8tL
 +wfwUD6CC2ggN7YgW8m7vhMbk2brOTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170129

On 9/14/26 4:37 PM, Griffin Kroah-Hartman wrote:
> From: Luca Weiss <luca.weiss@fairphone.com>
> 
> Add a node for the haptics driver found on the phone.
> 
> Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	aw8695_int_default: aw8695-int-default-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	aw8695_reset_default: aw8695-reset-default-state {
> +		pins = "gpio90";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;

Shouldn't this be a pull-up if the reset is active-low?

Konrad
