Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026921;
	b=0/6b/ig+Yh6SrmLzqkQnqW90FB7Q2Qj6PZmtl9PdM+JuiBn2NubylDT6ODMhN4XmfJrX
	 gVmhjn/ZOpoYiocpFKfEfNYVGx0BH9boo3tke8PAc80GqdbVyt/VE2Iluq+/w/+MEWCcB
	 u57jhsgAmAuZKJ+CEk4x6YEJ5VFbkM//wPhZGcRKHSH7Qq0uR5552HE9VwJaZ9mVZosqs
	 1UhNCYS3xI756OwlUcHmtzLcCiQ7vdLV3pl3/7jsNO24jdiqNjgl5FgBt0YC+/LZYFw9P
	 hCMDNeJhSzWJNm45XYPXdaqFNPTAt8XtthNlQqidz1kmAi5BWIuJ5x5pEMb+zaQsyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026921;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
	b=ubu2pxBjuOFSfitAKyfsKX48jN+ww6F0AJDdmN2D33k73Ln9SJoSYoPcP6UWGY0zeBmt
	 V2Hb3Fk6/BgyFr0iJfza+J9LcanxoP+riPzxjwgo6vkzj0lKqTY9KPkW9T3qignv/qqTk
	 +i4G+sVAhDhl1r4yb8vMjDYLXu/xhx7iQNKMBFa0YCN3Ub/ojxzpEOAO1NVLg5TWBu4Ij
	 eWGExbKSW1eKmS3Dy6/oS6VMOrzrLxucoDFqvPfCqVJ6jMnn1IdDYhHetTbaz6Zgt+qYY
	 ui5MZL+vV1+nrFSvfzDfgn00WtheAyrhWncilTB7hOgApu4oB8bEHeJb8DQe47TedEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OTKp1JuX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PhkQHM6t;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B879606A33B
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B879606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OTKp1JuX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PhkQHM6t
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvapQ3618567
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=; b=OTKp1JuXO6ngGHdb
	CxbYX1WhhHvfgBeGckmjHW90sgY/QNxRNnbYF0Lja0LmSz49rWN5E3mTHg+oRfgn
	ELF15Z+2RuqOucq6t+f3km/qRww5kKoY/Zasc0NV5oiIqebIQq7lullQ3e9QqgkN
	02NjhTCacHKhEGpj0i+Q7/za6qljNsHxOaH/O/RqYppQ1MD0iPVND04Gxsuulm/f
	n/ArG5EcKR7D7DBmYlu1/31X1JfIjJlCC7ym1gflyU1NssaSsT/h6YkRBRX6qwYO
	ewmwDyrqRzOUZAljTLZSpxAe568pfsGLksNeEe8xDu5UYZ2WlBcNbpLTGLy0Us59
	OhG8cA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xrgff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 15:02:00 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9909853d264so150437241.3
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793026919; x=1793631719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
        b=PhkQHM6tBdS12n9UI7tpzvBIIypwQcnznE/amBHKexK1fjxUxVCLETQMohB1cZnXVO
         wqxHiwaNbbbcFvteGlaMud7xobMRfnyxg4oOB1qvzGwTO77pIgmE0Z7MvcUBNgfaoY2Y
         P7fFNs6xM/k3rZh/c2i24akBZf4hC/NW2YfmBGLLhjdeW0m0uyB4qEKSVBRImHgiGelx
         eaRK6gNoOklErmj+PSYMtyn8OvG+Qy9LS/iszeTu9+DJRqr2S5Iu+MIprklb2sebAsUD
         SwtOEVrwI2vRAVqDOXdXMgB7jXJBw7SuZbQey0k8n2QgxgsHCh/o3pPr572TQ7S6cdi8
         Pseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026919; x=1793631719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
        b=dXlFe7FJjzKQHNpsL1yI2DfynWVU2zsjh3mq1MXjFugRb9P+9kh9k+4HW12v1A4wx8
         mfyiW5fHhvLXZM7uICE2+Ilc3VPuXcHNTvcVXF+tGt20PrzkDfkyxj+mT8CpRggRYxPw
         9M+VA+ljAXD6fsizfeF/TA5CLg505Tk0PmVBlyagrtOQoKAFVLfvmcLF2p7yDPRpkw+c
         LAYU+Fmu3Z9jrcJAwBWTmhvYs/BpdwKH7zXZRydZMgFNYK471UYsoaxUaaoJ9WZHKB/i
         i7OyMH5Bli1/Bs+SHUQ92W9gMPQpHqI1pLpktCbjmtxhSbvhnQOtj+NyDmEbQ40wGUS1
         S3lA==
X-Forwarded-Encrypted: i=1; AKwUvBwGcdUIvaEzSa4mVpZ/dfelB2MR9RYuWXlj52CvLmtPRy0/ZjicIsWTmd7Ez4b7xLDPu+MWbL6KudPNlw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmJzYqRZBUoMKtJ2aO17DjIBdY8DzWZ4DayAwEyqG5dIbSxbII
	Ne2pc87Oyzug0J2CpoEaHv3TQZ1E4FOyvEqE3HdDNvwj/h4e0g0GgRtK28MJQm5+oq64E9D7bKc
	/37LAXMsEswObZN5NfW65IAT282X5j/xSYT8uRT8oVlCBSHjl1X/Zvo4iQNPZ8IYUGA==
X-Gm-Gg: AYBFou3OxdI8EMZihdYdIKe0H/u0ZhxUkBxxzG0YH4od8npDxEE+Ua+b8ZwgIoU4NxI
	q5q33UmELYy3zmApTECVyKUEtkzpuTj/UoxMWKVZ4TLuMCkJgEY4HGVuoQae4La8XMyycnKrVtS
	raBqjMyvmWMzZibakXARCyeEBMwFlhWytcDDKkMWQ4pbR+Tq5x3MjBIM/jZ+JX3Gqmr4f6vHdPy
	UzeOaZulaHLOCS6U+oSN+msRtSdtY7KOFHc8LdX+TwBdKnIT26CeaTT7EYSR4egf2k8BlN5RfLJ
	uNMCm5HuF+dUEaZA1W9Jn4YVAjH2z160iOMC9nOHYSGf7w0lLrEWTjk0RcVAQ7r5MlQ5DtzsAnn
	LUiJ04H5lqNGOygwTaH+NAg==
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ec2331473amr2105839e0c.5.1793026916429;
        Mon, 26 Oct 2026 08:01:56 -0700 (PDT)
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ec2331473amr2105731e0c.5.1793026915612;
        Mon, 26 Oct 2026 08:01:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89cesm335488366b.13.2026.10.26.08.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:01:53 -0700 (PDT)
Message-ID: <cf9aa65d-5603-425e-b09e-0a5ae86fa551@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:01:49 +0100
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
Subject: Re: [PATCH v5 5/7] arm64: dts: qcom: Add initial support for MSM8952
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
 <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0Qn4Cdt2whXKsb86jdmJFIdt6jycA_Ht
X-Proofpoint-GUID: 0Qn4Cdt2whXKsb86jdmJFIdt6jycA_Ht
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adf6b68 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OuZLqq7tAAAA:8 a=FRBEkmYdsRQmicOyHakA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX7MbcMFGhZWRz
 t4fIGVKBZxPhPA3Igmt38ybsFbYX6zt+UT3NGN4v4gVS4nFzVLoBuQ3rpC8K8kxY3qr/Kl3udQP
 XTM8cbt250jwdGBbq8uUzPh2liy2INih+lg07AL3j+eBNGl0cHilvrgVhRajL4J2oDgoqFPTMlL
 kSHPTZaVx2A7DOIHvyjE/3DFuCJuHwh1f+tUkT6i0o50k7tAUH9dAJ0XBmBAHaSYfUn6OyWg2wN
 hCP01tkFBPZvK9oPbJo3Ffdrgiq7ahCJiyRZqgYIJXKUjTyj3mBcgf97mCvkedOhIL3UAYwpsNx
 C859ag0leaW7S89CoUMFazkytqWjX7j1/FAduWuJ8CDfqKlZGmuuSXLC7J9lS6Udh7ZUErf1WZ5
 o0NlJ4X5WIYrW7wJu7bb2Sz3j+gvgMT72ZH3aVeL0pZgSPjKgsb4AAedpXjOhznVAUkBUEZrzjI
 FrHecGhR9X3mV5Ufn3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfXx5dylaSVNTrx
 sjY+sqqLUFVlLIMpZiNbGuV5jw1UI5Ui10mzGgzQzHsCOeQkghyYyVtc8QQ5E77LKRG0jR+1SFB
 KFuFLnVobeCdOTLhNlvUIm/A5h08rCg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260059

On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
> 
> AI help is used for calculating qfprom nodes.
> 
> Downstream reference for port is [1] which is very lightly modified
> version of [2].

Generally this looks good, couple more comments

[...]

> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		ranges = <0 0 0 0xffffffff>;

this is equal to `ranges;`

[...]


> +		sdhc_1: mmc@7824900 {
> +			compatible = "qcom,msm8952-sdhci", "qcom,sdhci-msm-v4";
> +			reg = <0x07824900 0x500>, <0x07824000 0x800>, <0x7824e00 0x200>;
> +			reg-names = "hc", "core", "cqhci";

Please break up these into one-per-line (also for properties below)
the last reg entry needs a leading zero

(in general one-per-line is cool)

[...]


> +		usb: usb@78db000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078db000 0x200>,
> +			      <0x078db200 0x200>;
> +			interrupts-extended = <&mpm 58 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&mpm 49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface",
> +				      "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc GCC_USB_HS_BCR>;
> +			reset-names = "core";
> +			hnp-disable;
> +			srp-disable;
> +			adp-disable;
> +			ahb-burst-config = <0>;
> +			dr_mode = "otg";

dr_mode = otg is default - you can drop it

[...]

> +			pll_opp_table_c1: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-499200000 {
> +					opp-hz = /bits/ 64 <499200000>;
> +				};
> +
> +				opp-806400000 {
> +					opp-hz = /bits/ 64 <806400000>;
> +				};
> +
> +				opp-960000000 {
> +					opp-hz = /bits/ 64 <960000000>;
> +				};
> +
> +				opp-1094400000 {
> +					opp-hz = /bits/ 64 <1094400000>;
> +				};
> +
> +				opp-1344000000 {
> +					opp-hz = /bits/ 64 <1344000000>;
> +				};
> +
> +				opp-1440000000 {
> +					opp-hz = /bits/ 64 <1440000000>;
> +				};
> +
> +				opp-1516800000 {
> +					opp-hz = /bits/ 64 <1516800000>;
> +				};
> +
> +				opp-1651200000 {
> +					opp-hz = /bits/ 64 <1651200000>;
> +				};

Drop the last entry for the same reasons you explained

[...]


> +		a53pll_cci: clock@b1d0000 {
> +			compatible = "qcom,msm8939-a53pll";

This needs a 8952-specific compatible (bindings-only fallback
is fine)

> +			reg = <0x0b1d0000 0x40>;
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +			#clock-cells = <0>;
> +		};
> +
> +		apcs2: mailbox@b1d1000 {
> +			compatible = "qcom,msm8939-apcs-kpss-global", "syscon";

Likewise
> +			reg = <0x0b1d1000 0x1000>;
> +			clocks = <&a53pll_cci>,
> +				 <&gcc GPLL0_VOTE>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "pll",
> +				      "aux",
> +				      "ref";
> +			#clock-cells = <0>;
> +			#mbox-cells = <1>;
> +		};
> +
> +		adsp: remoteproc@c200000 {
> +			compatible = "qcom,msm8996-adsp-pil";

And likewise

also IMEM, DSI, RPMPD, RPMCC

[...]

> +	thermal-zones {
> +		aoss0-thermal {
> +			polling-delay-passive = <250>;

TSENS sensors are interrupt-driven so you don't need polling

AOSS is surely the wrong name - that hw didn't come until years
later than 8952 was released. I can't find a mapping of the
sensors for this SoC right now, so either drop these or give them
some generic names

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;

Drop this property, it's only needed for very broken FWs

Konrad
