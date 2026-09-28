Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850F4D489B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603871; cv=pass; b=gJhyOa+PoKddAgNEsdwRr+8PU8jLMFBuK7GQ+Qgryt+1HM+Z/eZoGCoj7pZ/olwWE3SlpXXj8/1GEKy3HcP87mQr7ke1xyaPvMndHYJd6CR7ukUtq0Q1629ZGrqbonBYtHTsHfDV1lkBlGWNHvTInLuwA0eeJm3qWAHZZWoP4p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603871; c=relaxed/simple;
	bh=N0apPBi5a5rdeR6XkE9u3uUSLlm4uI9nB9Kynheh+l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LegwDX715uxy7kG3styXTssGHZpG2I/ezztr5G0bawYNmDt2WsKwH7RU/atwsugl7aDAfBij3K7scPyuukFHWsC4RKKmygMTkMi49PTPG2yOkv0H6CYdFPxNRZ9l7Fxv1oNFKlUMfY3m0MtBqV1UQ+hbGYfa8C2/2snEj1QMt4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4tRZgHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZm+5Tke; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4tRZgHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZm+5Tke"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAL3c2404454
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=; b=Z4tRZgHZskb8ptT5
	TWLgXlXd5ZEfOMXoSIMOXv3xiSCfmZPrN/BXEN2Jx/EI7xgxsl/mhtg23qiOqhBr
	lotZeIr931hrlSEd5cQ/+wfndIUB7MMIEPhy0N4qQaoL3vx0QDP3gKzGCBMkjA4K
	qZEViEARpzKBw/bZJdJ6k6fM60UXmpX36/eFY3dIVjAN/AFSwPSLBAOzinZyFOZG
	8mAxM8Svcg16uWsn2JDQlVfu7pS1jD7EKG1O73xL6IcpK9DHPvN80Fj2n8ZkDcIH
	gzgCPX/52m/fh2UgSttxIDJ4qB8q8S1LQf9euuiVEAdLjZcrqYl5RVZOicTCxXKu
	X1l8WA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1ssc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 13:57:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86ab8302b54so2399893b3a.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 06:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603868; cv=none;
        d=google.com; s=arc-20260327;
        b=nVKQGJ3ByaKHoMPacoRvJSMKq1e+ikFS3DuMme9ZrD0lXi+EjydEveMlueoIGiobdH
         Y3JZVe2AT4ttB9oreDJYat5p31/u2KhXBrvDug2EvqoSGdndTk/JYUCmEgmYpOUx14oO
         vT4GEB/baIRF7NcA9q3x0lHxb72rKD3oDW1zjh/5+7NjziK5i1Jaq9pe0pCSWAqynAi6
         qosWmV4SAOOTkgR5EdIJ7/pwvUFMpTfkLECJe5dvoZ8dzd0AMqI8IDlA9LcHSwwdnfcF
         xOee/36txrxJcRlMLdbgMPCbfdDTzRLC2Cl96hAZ+8HtBIAXP7q1eEyH0UZmGBpozQ0L
         nOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        fh=Ukt988Qw9sNmLwqE5O+bvn+Z0PQJeY8BeSxSILqwfDo=;
        b=B8ozjnCftXprkcv4KJm7fFh0StQmOt++v2bbf8EX3tRi3eI468qk9BVq5cQRNe9awc
         lwgcXfIf8Q22zjf9PpglhOgHYTj3MMmJQk6FkQ7RHYF4OD8X+/M9vpcP842rBLpLHlLT
         k+b0kjgo59XkhOAubEnaUu7fmqJs0FjA9Udj7x8MkPV8Ix5/5XxuTSbQS38ackX6trI7
         QqiYEK0ADbze2Ycg7mSpqedR7KeKoBbfR1UAoLE75JhYaHxsg6xpCYGSmDPeO2JN5Gng
         8xwp6AkrJSOU6M9csGL4+Qui7/o6lp4WndcamLDvYZDjLmFykYJKnh3TBG5GpbLLnslt
         42qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790603868; x=1791208668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=gZm+5TkeNiuNCWoMFmByiGuXPWyeZfYVqr2uIkJNz73oKjT5kMP3a1/PLCH20oeLe0
         xcvk9SuiHU33LZ55Fbzpfxo1NFE/GBDg/vuoWelGhue22jmQ8AZDU0QRjzBVyuk62/HK
         pohM2L7obX8b66ghXXB9PSYRPQlEfxawvn88RDeEYywCxhFFV4rkCqwxuRdiC8P5I24e
         wA+SBuii5pGi4MhJHWIoXYSph59G0Q0iayJbv5z+vVNVBDBVkY21N9yu1IDSzYOFOi1j
         XrXt2aO9RGNzSTW5/ek7Wg9xq+o+xZaDAI6G3NrmZIDngCZvK9zlDMcXh3IiziXH73n2
         ybxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603868; x=1791208668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
        b=SDhsFgk7QTff+pMA/zBBm4nzI43ECqCjvX7y18f3C9CKa8w3gD2jv2u9t9ZF1NycK4
         rKS1aKi+kWlvhVdbuqQi1Gy7ezfVJtDOabGs4uglhiTJcbZ+sx6YQHHHBxITYVR/26dl
         /fMGNjmq9ad5//5RDmFJGM0ulZfLCqaLHtb1oyf+YK0DxMl47MeKZs9OQlpGocOSQyOM
         NmfiorrGX5D4iqjP08iWT4+FlqN4rYnQ1yyd67vCqO5MfhsPSQ1uXhn5QOtvS2V9ESyB
         56O/L8fPcL2oKhy2EFSBu95g6PJd/UAOD8PldKpuQSyLqAO7EO/cK7cqLK5vJOQprcd7
         WUMg==
X-Forwarded-Encrypted: i=1; AKwUvBzEtlAytOjjuAVc5RXQd4TTrovin7g1rpkPYbhRtZmfqPPg+7Vvr4grPiE+xfanTiNoCQB52xd4JsjsRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLo6LJBrOyDAQQ77TP7wW5VgNPvZmyDSpy8zYJ6pa+rdLp0+D6T
	vE9UjESKtGPsAezGwTcOaQYdAi+0UNJ+AeUARJhTrGdvWQrWJl/A1RBZcSrmy4zHZJrzW7ZAMdn
	IQbbkTjydQW0vCuoeEaE/veMK6AQSEcbAnzyVvX9lPLnvykEnStnauW4Fn9EcqFI6vmvA3TdRgO
	KFQT4zt5dbYniCEgjZ/O7WrKheVl/GBWN9MHk6r/Ez
X-Gm-Gg: AYBFou1B5115iW6De2+tbBE0Fxa+FFIipNaIpURglRTeC/OvhxFNx/KM3Ov5QthBDJG
	FIIvGG6CMkorOPVtzIBPXJ7ork4Pq2/72bke4aGA4r627lr+URSK7AoIA2GkoZW5v6oCIrqT2PU
	/ZY9iKdMEyTTpM3jENkw2e2Cmjm5XClk84c0w6sN4iUz8tDlrn4OKQf4zPUw==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-881c8819a45mr4006749b3a.23.1790603868158;
        Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006707b3a.23.1790603867726; Mon, 28 Sep 2026
 06:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:57:35 +0200
X-Gm-Features: AclHuK-nE9h16BssbY-0V-0Lcqrz78yNjoqqCVRnCD5BWpC1wzqbo2Hd-T05VXY
Message-ID: <CAPx+jO9Vj=42dHEwLzTHe1b+nrvip+ibVv4iPquxwJKbFAkm=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX32vkZEKV/g8B
 /P6VRzscLCX0vsT2KEuRcxPNTJwQLx4kbE3iW9qztfxyd9ogjfAWmhtXPvdkRE34wwW9iyzq2eF
 d2bgDUp6mNt+22ANyO7JejEJfZjv/UzAhYcjrrup/OshdTltgRsKZKCejXuO8LlXa5n7WyHKoAe
 atnZBN2EmYcxeHs0Xmo2sprtG8xZ+Ql4q7xNM/Y7ghzEc+3x2xiuZhpT2aTNhynD8JcKlq0kNVb
 NiDKCwWbuIi3I5iV8rNmKeFmPRremSKRAWF8qgi/JnSuslP6ME4fyO9k1+ZtepRhbM2FhNmNpe/
 K5DLaBQ9T80ZDJV8IlOxZT1Pb88zcwKTJdh1R1aXZJbxTvpCXXLSmfgTyVsSiun0hSCCNq2yx5s
 ZgQ2yEaIizX5p1JHBH+AD+SNzlLtpWoeMMvHmpaDhVh/6qFElNNI+7Gx6z+RsOum8sq+odQ8Je6
 3yl2TDNsZayE8DI3FmQ==
X-Proofpoint-ORIG-GUID: RQwWj4PPnB8DE1TjgB82Myg03ooRK-id
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba725d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=xo1k5ONJVskqAlz3UKAA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: RQwWj4PPnB8DE1TjgB82Myg03ooRK-id
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX23WmWd2fI8h8
 nYMZ3BI7cJUzqUR+POJlJyZ6rMs39X+bnLD4oA/8ATD5Xp3FccMn2/7rJk/LVFu2UWqqGCH6xDD
 iCIRKXVC4IH4G+buta5YydrxqjF7KfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280055

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible for the rpmpd found on MSM8952.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..8ee1c25a7c9d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -76,6 +76,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,msm8937-rpmpd
> +              - qcom,msm8952-rpmpd
>            - const: qcom,msm8917-rpmpd
>        - items:
>            - enum:
>
> --
> 2.55.0
>
>
