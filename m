Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623469;
	b=TkcyoYuHAiKhKnuB9IrlkpqzRz2LgDBghazBb0wDdpgMWyh31p0RuYugLFy+EhgdARiW
	 OBc1Yp3BN2zdQue8tXQirkPngf2kwAI5BNxJRXSRfEO0BUzmrlEgoCFIaHfnT3HOAgnA5
	 u6UvcN1z6bMAZGp+n2R4q4Xz0I/NzELbzta/Tbqn9ftDsqi0SwzMTB2/OYqNGsgb4zxwf
	 NwwjHy77IWdDkPDfugcBghcaD4Ak88j6Wu8uBq+xRxjx0ebJbGyxebPd1SAVSL2o0+pXg
	 hMcOH17p9EiMQX76AaD/sfrklbS3SOrx1ULa4OPNiM5US+/VQBimkKqdgqjHRf7QOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623469;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
	b=fEVI4TkdwTBaxcY0ssH0PiHayfRHoPRftQhIlzoU/vdvpn3eodDEJcDk4rNIeixCIa0S
	 fsIDQ/pjU6QsYM/l6abP+KwllrLBNzNRLDGsIcM6t/WsLIL6qlS8Y9Wdp2hi+Wh5fB0F5
	 A86CQ6CbztlRNGXtKWvg2vULwIx3LiH98yYuuuCm7dsHD3m86Xv+6k7ec8zBxvm1M+JOI
	 BFM5FRYrnKjL20SjpFfvZDmEOj8iY9ObZO/pV8tchB7ClWD7pM0AAUpIb8sZ6gc3pflxt
	 EPzagzmMo7LoGPoSBVmLpPwEjPFKTLLAuD9sSp57KkAwtYtjUPOL1qEypsLT9HhoLMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7QlGTJT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7160A2603
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB7160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7QlGTJT
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B2w0J077175
	for <linux-input@vger.kernel.org>; Mon, 2 Nov 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=; b=EOioltV4rTXNoKF3
	ipmP8gz3lEBkTW5wy4eLvI4Uk9sWVyL/sio7Fh0GJKxk5fXSaL0VhZlQ37M5gKkl
	utI1djX5mcfcMR2+HBR7ym00h560mBPHQ18bsMi/7RC38I0QdVzzCaVslhFxPB8g
	WOQ8v9kMSmzZEf1Jp88whqKbJ/1aklD7VKWlFCwzgWhsfVoWp2Oiw4bKNw404hw6
	HfrnjxMrD+UPUO/PmrzmEn2hqobqG7OY2RbeXRZ+2UxMZ06IrUJGvsgmVvVdvgaB
	C2SVui3qlW+SumQ0SbJk3E6Qz5H/SzHMVgy3dcp4nnWhlThLJ6KEXmc17CFlcK+f
	ur6lYQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rb7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 12:44:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5360b8cf8f5so6905091cf.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623467; x=1794228267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=A7QlGTJTg1R7aVCIxrZBno96wyT57p9MR4SyTVob30EUPPSoSOrERvCYWxWjWVfxtX
         vRfgFikK0k5G76xM2d4jYhiJymFPWnXigQ1jPCl3iohwDdiuO2MttOCSMRve8gRyM7Mn
         nhB87XZnpJqf3ciYGDiP7t6AUdFmZWBM7hpdN4L5qTZBp45kJuVLplZ1N2q1Ar8CSF9p
         D26ml7GQzQ3RGKyZHBgso6ACO/zP+FuGRWVGvM7B7sMU8ziPFRvxF4D1uEAYX+lVnuHg
         HJ5ORisL/e2+33bdKsNvUPtFIJTRXbMwLOyRR3L4NCJsQYP/l8jLef0Ele42dGrM2icI
         ydaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623467; x=1794228267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=RUY2qR7PsQJMLUDiDIuqUmiSd9fGOQmunGuOcKZ03KE2RWFweiGomSOPY3V3orY/RS
         I1dkc2HFakHynEeQ3hMBVxCCiZtM4w0OQvw0zTl4ymcRB+18FkwXh90Zx6arAfRigxif
         NHJ2CwkcAc9HLOavBZaJg6coJ/UApwhXmbA8JEvf3Rcm2g7mMCE9kxRHVL1kszqmzpzB
         76CmK1EYk+RkpVfJG7wvZ8SJ6v6w1HoYdzA9DIJjP84njyZkeqUjCUE3uUxLKYJcLO5g
         quvdf+9ToJPc51DoQ5ul/QGHWwxyMzBbjQkxkx8XxeF9N8+Vz8JtETJ3Vr16edUN9xhv
         9+Ng==
X-Forwarded-Encrypted: i=1; AKwUvBzchGPh6xY2ClF+MT7v9IC8O1JZhlPun14J7LwJ1GrsyD0jMt6GOPdMF6ShdrI6FrENPcWIqLzPs7KzhA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIIyhAwj68RqbUb7tk7z+3frOXJpoT6p9QoJb60aMVqM3A5rZSO
	MI33LcZP4VymdQFWUGwZ+sXcRjQRq+MF0KLQquriWcSC9DnIsYJ3n4Tj52DkgPFOFuaksVmrKIi
	qeGuIxgsF2HUqvRL2kPsXwEpHLLenGbIxo+EvrCR1k7pqLiBEPOlA1KInlbR21AwbhA==
X-Gm-Gg: AYBFou3c9TSxLmrOUYfhniq8DRi7nj0Gwv3jSCeSny4bGsb6DtkT+XorM6CN0+52WHx
	/yLgmjuCLbv6D5zY5vmJ/fPiuxXYhbiBYEXCeX+pnxPpvtXIRsMlD2D+QqXClKl0Ew4TkhPwdHm
	+vhZvGv3r/9Unl6WCLrEOfftqsXvyaqyoRhdwVFuNeV+b8DYG09GsbILWieULyspGxrgn+/vxdA
	FDEDab9y2t3zimdvv4cJW/hqGg2P0C4vFj2GkROmENVpTx+EJJCOnlmqJ0uLgKPAvl4wPNaqGjQ
	bpkvCnsosHjGw5BJL0oQ/tEInIY63xxkXqiHqEd7p1mrHT8nTGDUPggepE8nKFLRRJY3kswd6dc
	+pEyLTdRsIRkDX2c3EHcFehTUo0puqgD5QHvJoNQYtLYIKbkiB0PbP9j+Aquha1qI+4R8HJ0=
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564907785a.4.1793623466893;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564904885a.4.1793623466454;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe101d4sm389225666b.40.2026.11.02.04.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:44:25 -0800 (PST)
Message-ID: <73f05be8-6335-4d48-87fe-71ba5fb1d2c6@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:44:19 +0100
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
Subject: Re: [PATCH v7 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
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
 <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX/ET5sFPUu9ps
 P7gIw99iF1ujIyauEneIGvYSQjkl5yuxbnE+NSfqaSa6OsiFMaBeu+Rus8+UcHSHbgfS+CqIGAd
 VqRfbkjnw4OZQW5E+78YYzMiMVQ7bWNpf4L/IALKdPciQekOp+zg3hHjzZwRxwIO7yjaO0+SGFf
 ee/0WQMa5KEOnqnJGkeN7rRejx8M4nzG14k/X0e5PyJsHNZSk8IgBj4E/+kh7Xt+LJ5T2X4heP+
 4sKVhLiVE0YQdzgn/o8om/POnk67TBydh6ENlS2iZgelkV8QBa8sEsp/K7is/sakjEqXEsQergm
 mCvm48F4q3KWeXid5RCnrQmfEK80+iATItcSDg3QSBBPdaMr0skMW+Ob3yzNSbGt3EccYr92kMB
 VQbkqmpFTMzeW3uPm6/TqPHkA9r7l3wVWKS0ewxi8z2lFkX+LhcjZFlFjHTw994hRDFXbTCG4BA
 Fisao8S0ZLNjd5vX7eQ==
X-Proofpoint-GUID: bbvPRpe_6_vye67WTEF0gnyuVEZGraIr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXwGqI5wQkyL1l
 o2C5mLHbcLdw93P6yR0IUSDgt/94Cn7bCHCKpOJcP1r0LqdvCO0j5A2csGh5aSIQxsc0Zha6wMD
 9EQ3K0vNRW5fqE4oGLECkKm8zIsuNnI=
X-Proofpoint-ORIG-GUID: bbvPRpe_6_vye67WTEF0gnyuVEZGraIr
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae885ab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
