Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623367;
	b=u9M68FdSpT38+lCs05bxT8KbRyhis69JDXMZJrslnBolMd0YKPT+Ds2f7HziUina5lt1
	 h76yF3Ar+FQe+FBruebZF/fvE4YOfaJ/Om6rDHYEMXoaRg2aiUEmyBu3gwRzXGLM/i2BM
	 yDCDQJd9WGnxaOZGta3hhpwGjPmYYLFXxIi2ZhHSLu4aY2QPogDDgAkGKA2dh7i3TGhfD
	 SQDkhBhGHN/rDIIVeNLEpgzkgRfwDTSnCDd2+B4TTJD3rt8/rnflMxYVvhqJZJxebWLQB
	 wMVJp8+ru/wgZ1ev9emuJ1YBDmjp9QhLit/+MIG19glmlSqEGDK9RJlMkcuTegIaMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623367;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
	b=zqK0GHwT92C9246o90MbYb53QRLdDA9/mlz/xC9jDUzFH+6GfWLFAEICD2srMstPTD9g
	 PpPLL+b4HdJjG0cRVLeBuoyV1aSBs+j3arxsS8ZlWXdxHwqCf2oN6cqGh9iFknX3SXTZ7
	 lbOpgNBMdwsYmzlIpbVrCo426k9AboH7/FVBfyxBe60LYkYeIF2gNHXPEXFpZ4+sykh8R
	 9QdMy5nW0Eg9tL5XpA9nHcJodIkWnBTRcz00zwb+V0LlXOBVLz3YO95++RPMU6fvWzW02
	 +LWxLejBi5TgwekCdoln+wCzJmXE3OXz24DOSpI5sHyXgnzEysN0dkxHHsCNS3V4tiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uwy0eDKL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462C606A33F
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3462C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uwy0eDKL
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A299v6B3402360
	for <linux-input@vger.kernel.org>; Mon, 2 Nov 2026 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=; b=imzn9mgE7jpQF7UJ
	l5NhN9P2tCVnLxb4TdTBR2FOSNJYdj8wTOT26//AF1GPF5PuPIQFSP5ViGDCvCa2
	4mmGrgG3D6wFmc0KCDipUueSrm3NRhQkBzh3GoNpLwmwC9BYu7cq7Ua57vaYcUdl
	7YgM3f7Fj1J108Q1ZgoO2WvAuWPIwY2sapviVFR5lXCi3+SLKGXIo/izg2gXY3oL
	7iTbK1ENuliAtSaY73WLoFYMb56uptzP5XHbepiephZGbLxaLYsO/JhzEU4QKGII
	YlJK7qieMGwQeYo3B/Q8gJ8RC+Ywd4G10lvOIH5zpCYXkTkGoH1cH/FMvobYmo0l
	TdgZ3g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe94gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 12:42:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c6ea5aa1fso7979396d6.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623366; x=1794228166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=Uwy0eDKL817AUB94HBX6tLm3kyv3bSLuz66wWOUaCe5TwmrFzkWAadRaZj2aTLi3Ed
         nN5vH486S6zUvguBMIf91IPM9KMP2sXLUpfl0Qv7dj+2jUJhoa1LEGs9a0dla5kpOGo9
         mpf9rW9yyfURBrM22xMqFrNpsGNSk0l3XQY/239vjpV+VobsFQNxeK0fmVno6sv9ghP7
         YYXAkYvjJUOFnEA1Zgj+tP0gSn/OxbM+VA+++g4GyjZR/8MeNfLV1rKOgCCSxhia4W0e
         n3btgkFqwSu9L3gcmT61VsxngpodCq8lvlmZiV51O959CXQid2Et2Gxdh9t413bsuBKO
         Yazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623366; x=1794228166;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=nkoX1aiOAjfgYJttL/RCDXyNRxTO4JzK+Ug3nJtWFLqpQDDk8USFAsShpTT4d3GWiF
         OUGPoNCyxWXiWhB/M1VzUkJ6YWtcr3vlbLAh0cGzPON/I6d3r6DBncW+ZeO76Vj6nBo9
         y+9FYiF7OU8PDD4+Jea8y8gN79aGdzHwQM1GVcsiwh6XOkErvTDasQPNDWrpkFAR3rIa
         FZ5uhwWBMUYu7djhvViJsCWoe7JP2khc8wOmadccATv6U7DsKN4rmH3HhV8JUYq1DgkC
         D4kL0oCZ9jYw99Jj4u+stD31qf2vhkwxDfbIjSxN1LhbFzgdnxAvfv0eAMHB0DlyJCPA
         XIUw==
X-Forwarded-Encrypted: i=1; AKwUvBzSI5HgJR7ppGhZqvlngTLRtO8JOvLb5HW7Ax8cF3TOj3fam65YwQ7szpHF5LWHAs/UeWAN2hOi/78uzw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+1uOOxmgI4YLn45M4cs8MAAIBuaq6aJTMQS801mBM3+Y8i7fh
	8DS6Y0HhQUy/zNjKTpONOofi3PQjIxoGrZLNgnoujy3J5zb4a/av6GI5qLQC/DwbGfUK9nXRZGR
	bosIzFxviZ+niEEMfVNFGrSFtDgB7coL8b5ajXAAxZs4uld50S4ZmwjGBKT4sdeeuIw==
X-Gm-Gg: AYBFou1jKiP0NUYU82uFCffatJr7MwEWcJ7L1h0X8WyLmcZQs/cwslxKYQjOynbd7Iv
	6FfvPU1KPHSRpDcXBk87XpydVd520PFdq9YG/FqSKlq73i0UTda7FutqSuTtW5whb1NwOjg71yH
	crYyGNpiVoaelP5Iqm7fAntAtxLG2++U+pK8GMAlK5dEsLqVuctlzgSyGH0rKm7kZMeH245vCKI
	sX/65lJqIPxEqinPKdEjGQ4XA9dT23rdI7JtNf/JOpZkAEYGwe+pmf2rRAeFLSp76El5u1Z0dbF
	DdjzRAZKV9micwYF3DJ/gAqBDOpPmafS5KyuKNpgbhNS8drpUYRextAbFqXO4k2e9SCdNy89a4e
	FQq8ue0rL/9zJxKDKZbowAYrS8uvQdqzHxKAjHw19liKSutwOv9XyNboTWW78UhsetMijmPg=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608068585a.2.1793623365444;
        Mon, 02 Nov 2026 04:42:45 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608063585a.2.1793623364967;
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18e78sm399183066b.9.2026.11.02.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Message-ID: <99023059-0d9f-4ad4-a861-299006ae32a3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:42:40 +0100
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
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar
 <jassisinghbrar@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae88546 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OuZLqq7tAAAA:8 a=pjH4mUHWGEoP9p1cUU8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXxIZs1NWKqGvM
 qBAgUSpnIGA+VRCq6Foe94AlvBwFk1wSQ4kxcnVNfdM/nh7FL4QzUYW1aZRDq6cA4elv5wcplYT
 2jXVbyz7L2Jhc+xJPEsagQk3Hx3OQ1nRsxgNxH1o1o/qP/jBzTgQCcaGGzS42MlJqs/jLzD05Mz
 o2uKoAMWv+OCdO6LlBre17ovZsQPcPHdDPqZyBOkj15dr8KW0MUWBfjcsGobctM9uS2URyizhyD
 TBba0JyWu3FCwU6CaRz1izUoPLM6DoMjNqlzIZ3DfndCYqE8u5aZPs8Ar4OG8w60zDZdBTu5V+m
 rum6oS+FWOyzaU2Ctk8NM7ZRgcArhmNUakxV2XLz1kqxyUmhaIufxBLsGF9H5ChFYJkwebW2U8C
 FX4GLGe0/w6I1XDjKRw5uKvKcdOgbFNOmooo9TRmFJfI6MUZttWEPX7Q4ouJ7ueXL6B56Q0D4Ky
 qhALpUe1WsxbqjGpipQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX1zpTbsnM76OV
 7AQ7UIV0OkoRghY47BIP8bHGvIiC7sgFjnFAgfQRSQTQBc2Sov+Aqc0ThbPor3+0yAJJLpPA33Q
 yhg5zWvCthTVKOgsnsrZtB9/e3zP+Lw=
X-Proofpoint-ORIG-GUID: CENO25d03UnR8qqKvQLbVkkxIyHI0R8X
X-Proofpoint-GUID: CENO25d03UnR8qqKvQLbVkkxIyHI0R8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
[...]

> +		mpm: interrupt-controller {
> +			compatible = "qcom,mpm";
> +
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes = <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#power-domain-cells = <0>;
> +			interrupt-parent = <&intc>;
> +			qcom,rpm-msg-ram = <&apss_mpm>;
> +			qcom,mpm-pin-count = <64>;
> +			qcom,mpm-pin-map = <2 184>, /* TSENS UPLOW */
> +					   <49 140>, /* USB ASYNC */

USB DP> +					   <53 72>, /* MDSS */
> +					   <58 134>, /* USB */

USB DM

> +					   <62 190>; /* SPMI */



Konrad
