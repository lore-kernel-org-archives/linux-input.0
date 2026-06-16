Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124142B72C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605644; cv=none; b=Nn92X+3MfztcYJipEzKLl6bDiQjIGBBFCv/kmHTFoTB8eUWv5VXFFqXBB/vshPzNwI+FJ68ATkQOv5gLo+d2Quwif0+0Gd19bxbtpX68j9Tm/lBhaZNfKcrqtp4dR59irlvehWtsIUtNrGA3S4gPTlL0wfjZ08658VAKVjVBrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605644; c=relaxed/simple;
	bh=QMo3iSUBVZbXVK3uwB583SZFQY/wSl9nL8ZZ5XuBugo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNYIVMkNIO+c2Kz1TV0T0/OrQ3eb3O95a51zsAn6/b3PgoUXAyeD6vemix1/4X7fI7LjUHFcbjJcyhkh+BiyfuAlqxJIxwJRgAtb+oUB9WAeXGvX45vAmGOqetTXYjhRaNjS0N3L1wSZFjRZiQNIB+AZW1es7dkzkzMA/nGYHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzmPgDiT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4/65cZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzmPgDiT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4/65cZY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAC1k73256226
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xfl7YUDOtyUDhv9IockQhbr+f+EP3g53NkHVlg+iaEw=; b=jzmPgDiTIV/kyDSn
	QxQ55kQeJcp/0gJjC/9zdSfF/zsfyIb0SdZEmXQ3PwVfAuSTU20+DoQAG6+8kTgo
	Q0EGd43ttYS7DnSHV/AnXfqdmD/nREPmUCTc7uvQS4I37GMbIUa8l+boO4xpagbH
	KdAcFpJ1xcl1BHgx46CJA84uR6UtPrutsV1I3YF0LF+Y5mJ26DMHfpxtpS5dpfcY
	42GgnFRVR82fXV/67mZNvquo2uaK7zqFrISQX+37VcSeu6KjUnpXYTZS9g5CxGWy
	ReMrJdnvb/nXotHJeRV0fBTomLY81r/NVtUhxkwlvyPrfutsP6cI+vYwCv7qiCDU
	W+l1NA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09k97xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915a547f4b3so41732585a.3
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781605642; x=1782210442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xfl7YUDOtyUDhv9IockQhbr+f+EP3g53NkHVlg+iaEw=;
        b=a4/65cZYCSi2kAekvL/zUyWeedulEH1ANCyb3eqRUtVH8VfCTcm9HsMlFfeeSpEqgA
         fKh8hSzF2+L7StLIpGV1lDszEKcv6ErlNPQs/zM+rQ5+bBlePzhvzcZbOzRpzTgcyz3b
         juPVNarrA4Q0uY1N1eo+lP/WDFZMPzAKfzPvPA/OBw31TDJMv2jS6q1mF/ge8JNlv0DB
         njpGx9KhBFTGW5OaKT5mLprIL1jBHRw1e0TTLFBwano0iKDtU8AEX0xjCNsW9EQVL4Nv
         mOBh00dSw0kFK9PDjv7k0cgrvHwMt1qNUSxSgShXogWIWdjg4mWvDG+GXPqXu1r7PTbA
         J28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605642; x=1782210442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfl7YUDOtyUDhv9IockQhbr+f+EP3g53NkHVlg+iaEw=;
        b=JVCah8eIvxJXR4uef7EhzgCokc3vPjk9kSwr6Xnk8yytrt+xXa5qbAJbZqnkL1lN/Y
         v6u+a+6WSLx9n0f+iMHLIn8ezudIJ81NZyc5H5lYG09uN4u21mF9kOdYsMKiYTxF8ItM
         8lKHghzEuhwKFO56N9QzFGUruz7k79tqNmYc6y7haJA5jLNrpHneTczdNGJXzSIXLBfy
         5XL/UqbgyWN7RiEB2+hfMSDxNzBYt5ANHx8SDqOaOm58/FDUOa9Y5/yy8+ruNA0/qHjv
         GvApNWtDc9XibRHWiLaYkL7IK0EmqA4IB7X9XLTX99TV3Ty046Qu8GIyva9UMrbzmhH8
         wlgw==
X-Forwarded-Encrypted: i=1; AFNElJ/fgFR5WY5vXhfNR9o/W43j7OriffiSCuG7XIgBkZgWYmuJtqLyV6z837rfSsAjmI9w4rH+A2PYwfgNvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4RxQvb73plng/J/vmT9H4/wUHmla8Sk64K1/Gv9R0K6D5TG9
	Kri11Sl2iCs+4eDYm1QUt7NRz3cy7+jZzhdDV/DB6cC/ErYGtwGT10IRyQ3T+1Un0xOTY8R2EVQ
	eM/DeM6RduOVOtLxkzqim6nq25xjAYg22zhJPDhPx95RU0/jCUgm2IUOzGyN7a7LJLg==
X-Gm-Gg: Acq92OHe+ICuOdi+SheG9NfylS9n1hCvayoxzmjh+xhnI5BgtFO9gNwaKwE8TVcs1Th
	yQXA6jEg6JN8gXk7SeAv/2BU+OQ1plz5vFvGQTcId8dn7KpvGS1SdqsFY98YKy6q+paFiN70h4U
	nDfDU8TIoOrlnSqsqctb9fZE6Cme0tnMLyY4hs7bPlg5spduMQ1+ee/bk5Z3M5rB0U48saUFidI
	fnftMrWnokk1DCCqc/PFvhDoLq1WT8ebNrVw5wsuWODavSg8yMNvx7e/2pYrmyXE31iWTErqT+T
	Anhtevc/5ZJ/bF2dSKWubKuAuPEU9vONrcUOcUPPjyH3TLKdAJ6RVt9XA49prDZn/xtWdm1ks0R
	s8mWbJbOP4MuLsrLeCf8O3+bLPuqAaB90ggkBEffwCBKPLw==
X-Received: by 2002:a05:620a:c4d:b0:915:4ca0:1210 with SMTP id af79cd13be357-9161bc725a3mr1758231385a.3.1781605641735;
        Tue, 16 Jun 2026 03:27:21 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:915:4ca0:1210 with SMTP id af79cd13be357-9161bc725a3mr1758229785a.3.1781605641290;
        Tue, 16 Jun 2026 03:27:21 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8e209f0sm610213066b.57.2026.06.16.03.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 03:27:20 -0700 (PDT)
Message-ID: <6b3155ea-b583-4f82-8313-7a057fd78066@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 12:27:17 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add PMIH0108 haptics device node
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-4-d24e422de6b4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260616-qcom-spmi-haptics-v1-4-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwNSBTYWx0ZWRfX+1gAp9PDXQXs
 nLQ1tKAc2VdrRGpAYCgTLF/uK5Fh1YhP6ki3d3OYWQFJ+bPiWo6JgQcWW/jLhfDeaKUkn5qhDAu
 z515KIDCcHY/DHYfjE960BhYqOakhms=
X-Proofpoint-GUID: LH6vMl6qmUCKiV6cD5Jg6u5qr9vv27m4
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a31250a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=WGoPKrXAnCDrgKufU7AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: LH6vMl6qmUCKiV6cD5Jg6u5qr9vv27m4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwNSBTYWx0ZWRfX1yv1PiGMG8lQ
 1k+qNM2SNmSitegiiN5vtcn4MJ6NexjZJZ6IH6YKZHtDEM9/zVQxdG/kL+fJ64zN9SDkQnwj6w/
 aX4Nx16zbjkTAYoIzI3o5t9PgIukDo8XQPz/umYgWGb1CjDCq63+kkvFZhdqsBaQFELWX9Dtu0N
 8St+0cYr+yAOQTQe66iAj+8ajd7/Q8SoYi42c3SldCaILDrm66HE3GCZcB3Fh4e+sfcxV6cCQoA
 DUcvVtnyh5eDNt8KOPg1JL3QNZWKg3ZC4oYUGYPiimohL4571E7EK9d1kB33kB6SyJI/YhC8NTE
 MYBBK9yIYvZyU78DDIYqAxgxvMP3x/kkYKMC7XiDUh1J85MqN4aIE7MU5QsWODLqSE6fsjc3J+c
 5uNwfErEjcKnCnWn8UIJaIXkLMSPFrhWG048kqKWQ7GF0Lun4cR2oIVOCdYGut2vT+u1xrhwCTi
 ERak5ZUNBs5qVc8M92Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160105

On 6/16/26 12:08 PM, Fenglin Wu wrote:
> Add haptics device node in the PMIH0108 PMIC base dtsi files, and enable
> it on several boards according to the LRA (Linear Resonant Actuator)
> component mounted on each of them.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts       | 7 +++++++
>  arch/arm64/boot/dts/qcom/kaanapali-qrd.dts       | 7 +++++++
>  arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi | 9 +++++++++
>  arch/arm64/boot/dts/qcom/pmih0108.dtsi           | 9 +++++++++
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts          | 7 +++++++
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts          | 7 +++++++

One commit per board, please

>  6 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> index 07247dc98b70..7e3f59fc008e 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> @@ -952,6 +952,13 @@ wifi@0 {
>  	};
>  };
>  
> +&pmih0108_e1_haptics {
> +	status = "okay";

'status' should go last

> +
> +	qcom,lra-period-us = <6667>;
> +	qcom,vmax-mv = <3600>;

Do these properties depend on the physical characteristics on what's
connected to the other end of the haptics driver?

Konrad
