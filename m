Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9C2E738A
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109400; cv=none; b=gqC5x0ioB/e5wIiQEpIbga9AIHkSBoQROqoRypbX98LemESpWsLaryn9TKepG1u++o2bAOvYERq8KbS9B8ms3Kay1rB9AQ63v1rkpTgHPeRwhyOFb4EnZ4ubRdz/K1sv93Rfu34s8PuCMgXl2p2jao2cEm7cfseul9mPMlhZZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109400; c=relaxed/simple;
	bh=F2Rmub3kqynxFCpMUaKCzbW3Wn9kxlczWQbB/Q64QTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0uz9fVGXYuaRF8bO2UonBpr4z7HaiXbUByzAhgCH6pCd2SGwWb83jgKRxO+pry39zU58aoJ9uHXUJwz1m/AGQU8PJKd7+mVAsaMCrRSURqUOBstrLXH8DyroQBrrR7kbO93WcHxHjmHwR31oIp2hb1ZmyRD9NMtijHfVwIwZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gq1bXgXF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ip0CgMha; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gq1bXgXF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ip0CgMha"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7vYQ767704
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+hpos+oDMvB//kGlWtIFvFC8
	JGuO25mX9RiSy0nVVWI=; b=gq1bXgXF3s8Ra4n02W3SuuXBHDj7XCY1aL1sxa9c
	u2ix9mNTUjoYemXIUH9MUJBag6g96s+TaF3H4UV4X0Wwh4Jp4C+bT1bvRGIefFf/
	evLcj9iy5K80G4tgUlTNm0+6PM8pnK+UlIK/rQHU6HORQq1dobQdsAQc0sOs2yVP
	l6barOdQ00KSB1x/v5eVSy6TCD2xX5HcAR6wERBje5qrpc8jf9qzQK1pZrDDPGLL
	RPaiXl66re5XrVB2T0JhfiWpX/Geoo/8x+tGZHhuAEDzeSmfJIODDBAb9vTknyUK
	jnvkqMl1sq27dq08hW6w+a7KwE/1SdLH0GWY6i24Cmp4Cw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqkgg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 20:36:12 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c82fe2ba8aso354130e0c.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790109372; x=1790714172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
        b=ip0CgMhayu6gB3gsAPCS5yxYEqc+dwLSCbuGbOjh2Nt9Y3rNTHqxJlqJLI1dqE6NbV
         ncP5LngzGNiDLFA3naKTHyvHv6Iu/GvW9y1PGJDMqB7+b2tucjY8gPjdNqTYBbS76voy
         QOp8+2YEHvusbSCFsBMM4CzX49AjvJznet7YYf31awLcY3ANXNujhvHEBaMDxj3XKpaj
         BoMKiO4ofIVyKfpcLME+sxcLsCROkKUA7ejBThgRV18Htx8z+jnEydvU89gCJbt8r05/
         +H0O+z9Iah5AjZrYbi31pdjsQ/TJf9U95Uty2BCCwufdgLvZPVM1MYHUrhWuBd1xstNF
         NLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109372; x=1790714172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
        b=2NRUSrLPFjyXpaJD80Iy7DLtHoS7yHe9M+O5T0oA/0AwoedCFGfm38FUIl6JCGz093
         cnAT87PaolPcXCV3a8YsbH7WaM6LxnbAB9Cm21coba0F616uBN7X51q2N56F/CLBfrV+
         iTByb90Ea2zc4p54qjMn7TuVr1U53kx8LZwD30NmMHuSD5JKonwaHmUKdzmJl30+Nm2q
         C/v4zilZLen3Lt+OiGhK1DtAVDpd5ypTiKAMR4zzHsycK91i+vCP3M1usJb3sHvQNCsn
         xMOubKe551mLYRbiNmwbXE8G3q9OdqQuxbGyvCLCp+twvJual1IN3o3gfh3AjxTROOri
         PHjg==
X-Forwarded-Encrypted: i=1; AKwUvBwHpJ/TjPsIn0jFsFyCQLGFtSqR3RhsslTkEfkjPeUPJ5pPUfvTjQEcfvor4yZsyQd1BqzxTizEB+U+wQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kgtGCgqQ75858DPkUhvWLlsfPlL7codDQQZdnwq7goQPcpJFNb
	Q09WFlwmwIzGGIA+sQoL+wA9B89i8laWe0lbuEGLAKunvmxNBfOFqthtv2j9S4dfnhG3m4yolOz
	vzPY6BF5ZOBW6tyh8BLqZ94Cmb4UNS0y8eUb5m5bHdOlzec0QVNHtsgXKlR4fTiYSFA==
X-Gm-Gg: AYBFou2dppvo7xh15O6DRt+p7OD61rM/2e5/z/MewAI4BuPWULXhkTPjVOXg0FObZgu
	IjGBdEHO4TgFk+z7YNzNGgSdBTsKpETHvoogRvOFhYg0Z/kGRv71lKb4YhmmuFPHNjQKuoRlFHW
	DAj+Ut7B3sq+DhGKFvnTMKz6nq459xN+v8HQlkaDpKsAGsYqvTr1BLm6LtQhwHTnidOrG8gpo4i
	spop8Qd+wBCzIJI6kNqii1kPtbViq/OzhcG5Li5J2oKXEbKq60bHMEED3VgCB5Lw4TpESNAtc0N
	dcYvXqT+ptWpWqq8wDp9JVNdJnGPFEoPUyF0X4nYV2bIVYm0wsNNtyw3D2FVJpVcfbclH5Dlf1E
	QQFW6EO897nsUHg==
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5c9f1597c52mr1337310e0c.2.1790109371715;
        Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5c9f1597c52mr1337277e0c.2.1790109371230;
        Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm965996f8f.16.2026.09.22.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:36:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 23:36:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
Subject: Re: [PATCH v3 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
Message-ID: <c2jt5rpbmys2fguk6ui7e4lwzp55vio3vf73akeiega2wqb5pf@ewp6wsvtxm3n>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX+vkiA6ZMu1Yz
 tG1MczThAXG6Qug21ZYI+p2JDygp30lUwVsf3yUXh43/ZZCsvR7YYTdRZ3NtCJHM/AQECrP4pet
 zenk/3+wXhDZB7kIHasORYFixdgz6LER9OSYlGEsPHz0aKZWN2B0AB1OG8jz1vp/lWlO2XoQ35z
 84kNgvpBoLTMTQKpCZtk8TaRx6SG/nskERpw5JuAGldKc8Yjb21F2xNaDF2Ovl5Rssvn9gHWfFm
 c5rR55b4h2pkg+k5fm6b58SYdzHbW+mnvhZ9Y9KSTZtsFwBNbXcfkH3yT1no/kOrjCA5BbT181Y
 N8RnGqPnZS844/iyOTWjTIbWo/eSh2DJPIVbRWg1RrNeMgVabOMtLX5iFlEkQJ1uFl/LqJO9vvX
 xhUqWiYzneuciWnppPjVXjoBeQX5pbh9qlRzSudniafSvf31GpWJ6Reuks0PVPM9NQ0m4v+RoXW
 Z772ypy9HirXxbTLuTA==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2e6bc cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Oh2cFVv5AAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=n1RHFZ1giDiXVFLDIJ0A:9
 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22 a=7KeoIwV6GZqOttXkcoxL:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: HltF3wiK_lHUUT10nBBgsLdZ-jyXsuFg
X-Proofpoint-GUID: HltF3wiK_lHUUT10nBBgsLdZ-jyXsuFg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX88aIk31E3CQK
 N78RVWn1sC4tgkOQIQciO5jOB6gMW+K9l5BXom5cwpbhNnVdZddL4iY4G9AV2WFaQd+FJqNU9A4
 gYc9EadH4kaAPRYu1LTmUcfFmeVFU0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295

On 26-09-21 21:18:53, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
> 
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
> 
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver, with
> some parts added from existing other GCC drivers.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
