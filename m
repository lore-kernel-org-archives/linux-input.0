Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623160;
	b=3BbSEoQUPYFjXeSoJQ+LFtuRkuEHfxzm+LHcAOuQDRCCyehoPB6fuQ5F9sOuxfH2CyxB
	 qodBIUDk8K1qybaad8VgZPZz59gBTL7xkZ0piSsYIXJ8Cw55B35d0BU9iwu1dSHOuYj8F
	 ANuY86TK6VqZIFTOWK3YjTFSihIHnluYuZbfoc9nP3oFDlYLABvgn8Won/D1S81iM5bMf
	 JdSQwX0+9npKhgQRMVuu/z1iIHxY6hbqIMiguu5uYuBnTw3L6eYMpY50pdELsDZfskLoN
	 msksLkyC9adXwjTs/S791jfoodZES4ubgaG276d/NqegVWbwDhMrjPb9weoNPROjRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
	b=zobIft16AOWE6dc07qwc89O24MpJBLLWKmWuSUQwq0rpdwtO3qg9QU9Z2COuSYZ7cWmx
	 Nis3uzgeBW+R2jnsvFhN3wP6A5e5TcWjLfXknPFcSSqRCwikni7fV3+FxoATYgIw6ocXy
	 xxijQR4dGo48wccB6RaTwHd6uuOFeTFu8kTyqfr5Ag90/SiplHn6c94rWE6cjruYRJeNc
	 GawpfjfYNFPr4T1Aafckt8aCfJkyBscBMSk0GP7skc1MXmXjyP1ijIpsdXze6g0PxbQ9X
	 DRESuyaX68ymgmBrfDLRpb23QUUpboW9VDDoYKFJeCUJb6SH4ojfxq8Qx9kNG/Rp2Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tpnfups2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F306606A32F
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F306606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tpnfups2
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AMUO1821123
	for <linux-input@vger.kernel.org>; Mon, 2 Nov 2026 12:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=; b=o0saIndcVHp8vZ6f
	CZ2rkVhjH6ouSd/s4V58y71yXm80mPHeAGEZO+CC0GP+LnpJ9lCUFhD7KjU0mpol
	LhVJHiTkF72NE9l1LmUq3b+c80HrkvP15aK90GU2lJB/zwQOfZqylENqYUtyeX3T
	AU2f5gRStFfAqYDzzvyjk7lLa8GfK7f1LNdcYXLNO11BPKqQtLcgkmyZ8Xpsixgn
	g37lQ3M1AHJJonE/at+vRCNLpPUe0IyzOUE1/wTnknCOiKOrUGj9i/319/V2CvHM
	KJxzu1UhoCsqrbX7DDFAWEqBWoRlU9cGIIM+8f3H1kFlqq0kV5l1Wqm0ffwKkjQG
	GNbzDg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hpbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 12:39:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ca23ede8fso7188566d6.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623158; x=1794227958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=Tpnfups2+QSRVb7I1L0nKeK6XuBUsdWasskFT6gz395kizEjfAjtra6zsE+NL8Py1u
         3CjuXVj0dZYKlzPxR/8yRmyRoapKU7vIliy+5Y9pHcdngkK2UX/r+TGQRWK2Quk5f1yZ
         B2qE0aJzewN0aMeHsK931S3AgGDOf6Ywlfvx+uK130x9MTvo/RPDbhp7FQokaZeTfBct
         ugxJjtSyhI3MWAJjD/RYVAE9ce+AR3mXwTqRer79AXrK2xeTZRvFpDCWBzInAO56mZKN
         RwY5TtYITH8d1iaW4BEjKwH4SFPuBoyxXYPW9BLlPZlisegm6RUArGKOrZlsAe5zC3Dy
         rF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623158; x=1794227958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=0LCnUTTXgPiMjXgjWkUJvL14rzK2woIRPqnIDX7tsYxkHDwVNTqbSmC1hFbJ3Qv6qm
         QInKLZpQW3IKizxjmb3VDxgRinpfciKBxhrAhsnOf/KrbVYwGdqxZhPBRIp32ryRxQVo
         NEsVicjexl5s+R+tmFXfHkTcXzVtMAWPBqBVAE6Yjbs9HFS8v7FW127+fwWcHHFuVZ/p
         k6t3M2TjSgMmoSx/AICLqnhTwbtwaP2cjRwlRPQJVopme6FxfaTOP5fC9F7Tpo8AMBG8
         0TRWuZjA+oB8W2iPpPsjMlojOl1PRIuwXBj1IfNEfNqykTASmNKgsUeQj3jIHvV+f2V/
         7sWw==
X-Forwarded-Encrypted: i=1; AKwUvBybbQJ9odOvH6S1p56fLyOK92YiOSgUdjqWZGbayK9XwJFeXy6B31WX7mkYjsBN/dl3+CQZFGyNTouebw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK282yeIes9i9Ypa5Q/8md0kkQr89O9y6WUtx8EYMhCwpNeZZOA
	es3Zh4hN7IrMXzaXd4vlPNlqQ0Sf2yR+nOODE0dgFxiBTorwzhDKD9hueFPHhZ0xoE8uDh8nqbf
	+aRi6oDSDlYkUXhLAMwyg4+cQY41c/yJQPB9UH069+sV3oqpJR+BkbaquG//iE2iU2Q==
X-Gm-Gg: AYBFou1YU7X0y+9LPREj+7TsKSdHklL8k24kIq0R3iau8TnTkTnjgoHbaWOZUMnLaPP
	FO4GwYtG+Z5O6fEa8vQp98xoCaRZWS3rYC1UrzHrw6zcpAxz3q9tSq/IAYpLFRI3oaMXUNMTjzB
	S79njGUqYl/bHWfDNl10JEgqtQAQntVv6ckhJKanpU0HzVYkuZeol4pFEP1vmnwT4r76vBcO/Tm
	h6pPJINtgbrdePCXX3sjQETK2+1/p4P+0f9IhaZMdouI1Pv1733MVmEgoHxgA9Uhe4DLBymtuaa
	hbmJJc+zaEDz1Znm7SdzqmNJy3resqmOrFxTznSmDRrkfrIIk3lV5TuEX5F2tGxBca69YYou7fJ
	wYih8slWcwFedDRUr2ez7imRCsMdS5uCN0hitPsIkfB9qDxhu3AmH30fkhWnUIa2/w+tMIDQ=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815614385a.3.1793623157911;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815607285a.3.1793623157435;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbebddacsm23222831fa.6.2026.11.02.04.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:39:16 -0800 (PST)
Message-ID: <ee443167-963f-4a12-a49d-0b4523afc14f@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:39:11 +0100
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
X-Proofpoint-ORIG-GUID: Qvq0RDqgY0Qtw_Ha3uH0iMLvlQKKyzzB
X-Proofpoint-GUID: Qvq0RDqgY0Qtw_Ha3uH0iMLvlQKKyzzB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX1keglmEfdZsn
 W67Jg+ibMIcr4kphIlgR8xXVghDQzkOzdhZrtCfhGW108x3pu4r8L98JC6kVTlVMJLeN5Mr2OPx
 4QUGmx26CyldNpKJQ8vgteMy9AlGWFQ=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae88477 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OuZLqq7tAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX6bRNkZMGltpB
 8Bia0KAzvGS5G2xeY4eS7DPNFiZ/XL9EXgtEBNMw0GPH6iyWnxNIcP7OaOSB0xBQZAJ1DstOUtz
 f8YkTLaFzRjqz0pJ4Ft6ze6c1EluOKC0tMJrx5W6geP9CvRmlPb3LK8aTGdpAEsZfUxZXDIaYtX
 5iIV/mgfe5dYKAEHjrfxlosUTaz3nRUQFNb/wDtYAFAu28NpbPPE017CdM5GtvJo9Wni2Me1Xcj
 VoTEVlfg4a62Uv7RFgxGSXO5G0ROyVpNejJHgqPHjuXEH21iVP/biWbhLg6l/pJyJru4SG7+o/J
 ut2NsqK1F+d8sORbpxueyyK8X5EhAXv+UvsusO91bsBzS/gOevULnzXtxmRFUCa4lw8kSdNXhsY
 Hj7BZF6nFMqbzWnAUiB3Q526bhD9XDAt9/uuE+EPs4WsY98mhaBmwmeXw/RLT2wcIcm7Y77AmOV
 ii55Y/I0eiA6GtJQiTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.

[...]


> +		gpu_iommu: iommu@1f08000 {
> +			compatible = "qcom,msm8952-iommu",
> +				     "qcom,msm-iommu-v2";
> +			ranges = <0 0x01f08000 0x10000>;
> +
> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +				 <&gcc GCC_GFX_TCU_CLK>;
> +			clock-names = "iface",
> +				      "bus";

The robot suggests this is missing the TBU clock (and also
sister iommus)

Konrad
