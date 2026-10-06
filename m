Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0E45563B
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292751; cv=none; b=suZ0WtVjaY4boGJDort4A/ApMTv+dcS9+43hHi8/WnG98+SG5piWdIy/PW5902Cixw74O/cGVVEq3yrGEHtdsm6WyQo9T+GEQln4e3gJMBDJhue0tWrsTEM7WHJqLHyu2z75acmB6deFfQlatT7FsKNA5QbdjhnelJoomemTedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292751; c=relaxed/simple;
	bh=eszSZMOJpj74kh0VdtVM25yFcD4ep3fqH84k7hrgH0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzS7kr48vSPaO7WgjMiqAQRD2H1fdgj+meKlUojfPRtEvHzctThL8VpUtnYtRnHbzZJgI1mhrjC4iMv/g63dp1Xaty2VfYJGgz81WpSLE6G3wlyzosPQsuzFpgUWY3DRSr1JCSB+7+21IAfuWEkyFzfpkCH7WGzYNeiXiHn2pUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djpO39YQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OquInDAz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djpO39YQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OquInDAz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPVAo088508
	for <linux-input@vger.kernel.org>; Tue, 6 Oct 2026 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3977fqgFQopqrOyetisycUnU
	JNoVrBq+V4kqibqFyZQ=; b=djpO39YQ55MRcLvTrU8FokAtAmc25B8PO6rhSyDs
	RJU4RGI6ZtKkLJ8bTvW2KxxuFZFTSiujmfX1/X85RxYrkbuMuL1CgeaZnPL9i4qF
	54XN73PDYKUfTJzZ1A3S386RM5q3T2Sh5TRNp1ckEIAV07+4eJaoO/nPw/BG83Fi
	Hq3N/Fcw6MgPuaQSCfzrNrI8fBoqq5IpYeht+/An7rgZhb+bGiAgShgYGyFrIdpk
	s+cxaQhxcHjn0+TsjzuOfzlXjRy53E4l9GFJ8lea3j5Vdc77CMbIMIuVau5+QeXb
	siQygViHTHY1l1TttPP8fjQWhuqepsqUcAca25vW3utrNg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xf7rrub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 06 Oct 2026 13:19:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c0f07b4e97so2411237137.0
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791292748; x=1791897548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=OquInDAzKHPBlexKLw5dAfzB0MyjUhrgX66xMm2UkWAwUZ2xReEAxfiPp/yvk+ybUL
         Mf7cHwXFFg4HjqD8wibuLz7jX1b6mp0lmjgc90KsSx/ehABx1xjoA92jqIU8F5f+wy4p
         MX2xsDtuOhU+rdwMeRRwdGpxAvRQf/Q6T5H+KGPC9NCuIwkSvFZJ4SDc9anVa34jel6S
         Y7kZX5SfIE2opA/jSRCjmio0Z6YcAwnCrhKlsssgaOV5iPjeWWDc+K4Hsc8IBCILBYT4
         P9bkU0yeflx3FmdhH7LqXyObYt9TSfZPHUIJrs2pVe8YO6tlnO80L7a7aElYDrN9PJDS
         1+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292748; x=1791897548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3977fqgFQopqrOyetisycUnUJNoVrBq+V4kqibqFyZQ=;
        b=Bwe9GSflSI7hmC99Gq+4+0ASWEb6bMujE4eWyPtdZbzxxgG/REcxBl9lopO4OdCWbR
         D6XceOhOXy4YxSujtL6qbaEE90A2cO+z2o7dCmwq9C4TLNqzJNUuq4OuPtRkuDJ4JAn1
         2OJ7plyUn1NAwCOM4f5q/kLOJ9iDvS72CvTyn9a908Y+S+v01dSCowr1UgIPsIan6G3e
         LWWGiL4Y22nkBCV+BfyqIZ7J1KYOaf7IkJHLmUOUXYNX1LqY+n3DxwfL9VVtyNgNR3f6
         Uj8WFO/fFEiTOVxoI42LWBhMWVYzTphhxvLHWK1mlxTZPudscUgLNyZHPWrKNyfPlE2n
         D/GA==
X-Forwarded-Encrypted: i=1; AKwUvByILDY3LqaFvqtFcaa6RriGwdKVRUT53DjeQxk8pOrQVkn+jsPx3g3KgnuSBSqbZFe98a6eEKk6OywgLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKnZz2tXO3hwkUBkdTeNlkCYzF/mS2VOGFc9KzVX8ZyXp+jXHl
	7Us47TUmfafO1cI8OcPCpyYehH6C46/AMxjAm2oOnKH4f7Vc38p7ULqoiI0ky8t84X1TgtBPbBU
	VGrzky7Dh9dbP81fH+FQs9jN31VibnARJZBC5VtkbjGvwCBfDQFHcFUeRVH87mywiLA==
X-Gm-Gg: AYBFou3rWB6Bf84sWNsvVfoqgQkJl1nZUckSVgmySRAOEVpx7zj5Kg62HJodOlR8Afq
	vStybAV6HL/kRLVbcYu0ZJvdb3r9IHtX+41f4ivdDeMykdzPAQ8WDya5oVNSVEVMn751eSWqTje
	N+drO4d/y9LzB6ANziObXihqffeTCXaBnlrBZJMsoP8X8ddxY9VF4HuoXjOMN/KV+96at6gQkGd
	Gto1bILmBtoKDIcaU2z1ZNXTXPZSSdSl4/gTobBwdeQktdlaGvxw6+VbF1zGMh6YfrBCfqpzldc
	iFmGGyjI6JQM3/p/QW7vCxLPs7pRh+rM4nFpW5xmJGtdY1n5Ul/0vnESZa3okxjARbh/Y5d6Jvo
	5RA6T8jPa0CtKIipXXUWKkdRPkOg2ImMhb5F23JAB0CG+vbMaMcyLz1U8YWLK7fzCayqbVIwZ5v
	+EuryH1qqX9jLW
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384677137.37.1791292748046;
        Tue, 06 Oct 2026 06:19:08 -0700 (PDT)
X-Received: by 2002:a05:6102:b15:b0:7a7:198a:c2bd with SMTP id ada2fe7eead31-7c87c9235c2mr384647137.37.1791292747447;
        Tue, 06 Oct 2026 06:19:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a99ea94684sm885231fa.26.2026.10.06.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:19:06 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:19:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
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
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Message-ID: <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX5RMQa1Ls8Rgb
 ylucj0aw9U2Ay5AabTuaDkRzJb+n9Ic0Ocq3/QPrfzwzPaDk91mm+ekU14Mb3MxO6H+jHpzmKMK
 bQ5TQxAN5QuhWWguzmybtu76TBeiulw=
X-Authority-Analysis: v=2.4 cv=FpSQbGrq c=1 sm=1 tr=0 ts=6ac4f54d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=Nmgb9aOmcCZNRWd-E-8A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXyKLUDx8n4h9+
 jQVg/MxkTJ8kxHkJQqA5SUnM4hIC45bMeeg3nYa/yGx35SL9+ttfqudy1tS4FGQ0LPuTU/BZdDH
 mphNH9ra9PiKc31tF7hAl/rpAiSgFiQZuyd6ZSp02HVmjqBvfYqE0tVQRuFibKXKjqkaAtyUOCl
 n8g4cXW4pY7GcyoAYw2BwQwmGa26stzb/x3eEEknkVJkgrIOVzzVB+58YOA5sgv1j5y0LMPqWIa
 9S7plLWga/+p1SrojCjBrF4xtYuVXa2hl+hgMms6QoL7azRjE3Zn7yPRpZGA7VLQnC+Hve3uYBW
 Pt84M3hVYml7oNy/8Tg67b8TU7UGca/5opR/ZnufIBRONaUUpvTuYLEYBI4zqK6XVvkKpTbecnl
 C2Qj6cqAtf4SQYqL1+5D4PYo5HKWxMK9cEPCqnZHdC4/9a9jYgaCzc5pNxOHj3FXTyTr+rUmBAM
 61k3yNgl22YmZHxHQVQ==
X-Proofpoint-ORIG-GUID: mriAsUmBXqNjF6NzMMQo4i8fkz4pW9X9
X-Proofpoint-GUID: mriAsUmBXqNjF6NzMMQo4i8fkz4pW9X9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052

On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add support for tsens v1 block that exists on MSM8952
> with 11 tsens sensors. Sensor Offsets and slope values
> are taken from downstream.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index faa5d00788ca..f4201748ea29 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int __init init_8952(struct tsens_priv *priv)
> +{
> +	for (int i = 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope = 3200;

Where are these values coming from? The driver that you pointed out
reads them from the QFPROM (like other tsens platforms do).

> +
> +	priv->sensor[0].p1_calib_offset = 2;
> +	priv->sensor[0].p2_calib_offset = -1;

-- 
With best wishes
Dmitry
