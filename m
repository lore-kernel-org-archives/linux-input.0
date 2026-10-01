Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CED36C5BB
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819901; cv=none; b=DAlR78mrnbu1LBa90yBeWkL5eencu7WXHjYvPNmnQS/298JyeISIqy5ZnGDc8d3gwDcdHObGIHQByccdMI7Y+zu2Cf+ZSrWKWdSZ7EsMRYacaoYYhp136v3G7XEK+eYZ46JlaKSiVP8VdH5cTL2+va1qtnjNQDZOOiCaSuGgSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819901; c=relaxed/simple;
	bh=WNlxAVW9sEGah+tbexj/J3vs8zzU01+pV505LfFfPdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6M06EgHCVpWd6CWD1fJB5zoolAqbk9CTJ2FKMSvvOwN6vGR79WZwPHFIUKCxUdGA60V0Cp4IVtu91+g84Ivoi7K5sC6TKHlT2BXwbVEROUoj4er96QyLPX3jowhChwk+6FVvgfg9DDI8PxfPpK7F9070VIy0yU4lV3L7Gwqut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Av6XhOcW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bY0Qp3/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Av6XhOcW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bY0Qp3/t"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6910jh8E2098503
	for <linux-input@vger.kernel.org>; Thu, 1 Oct 2026 01:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZdeAUChydPqhPIvtw0cY1t+X
	ErxSg9azs+6bi/qs5xI=; b=Av6XhOcW37SpihgwTkGfs4qIDt0nNlPqo7uM+tTP
	csNja1zSArvVgJBXalT9UdhucfFxx30xWP3vbe9cMp/ntSP2ByZNm90EG5v4c7VJ
	oJRM6K0oQAo2/W6sdLegXqhDjNH6g0ZWQl4iej31n1Jnf43bB7ZmmgH7nRQ78Uvt
	CyODMykncY4RRlobcyM8BvdeEg6lyJpGykgjRJg5dDYHUGmGCcvmRu1UVvwOuJpW
	mb8tx/7QI09N3Q+Js/9N6NCgSGYOWJQ/8t1vMMmS3EsV9vI+8nS8lm3nZpdqimoq
	BDGxotkozDyWaDVXRZGMY7T2nOabY3jC70ckSGuF9uyvGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tjxe8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 01:58:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso48826985a.0
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790819898; x=1791424698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
        b=bY0Qp3/t2awbl3T+qU7Edgm0/eXVi1P6dae+l6WoYuR0RLgHybvF44XNpT9KWO6Hbb
         0f9fzHrI5KECehOSYy/X4nBBabB5Ck5fRxx/ti2JaFjuKn6znhStU/zVY669Tm59CZsu
         LQMugyn8RH5ghmoB1asX4l8Xdc9IkNBfJq+jJfQgnexsjuLw6zYOeBWBKwPxiVpyibka
         Rlrbtc9VxActIDxmI3qwV3+lDjUcFl2zrmp5FchYxlOxhc0ONVldjFJ8Z71FUEayFdDT
         jvvwgSMezfjoBII+nzT+J234YahEKdmoiazXJ/0BiNczqW6wohijn9lfQ3Hj1dexbeF8
         lfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790819898; x=1791424698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
        b=yFz3GUDhPIwUd+7W1D8gQiCJNH/cN/zvp/6epN/1e5Hbn2T5qCrm3XlSRvaDA/Z041
         sYDPnjBE4inGMjrMQdrNPWRoKa1wUXMb9T8oTPpF3Q0eiv/ZhTQ+QYylHQ+POwNULgrP
         w7a377puSkG8vTBanGZ7N56Bq5nvrGqozdxDFiVxk7BG6m81VLJ9wVjC+reww9DQ0Fgn
         TcU80ikmVj1EOLfAcFip3pOdQ6N5CFJ4iyiasS8MyVHo/50sdO0ziG3p8AplOEOMOhjl
         3X9Rh9iy0iebD6BeojAY+I4P33XKf2PViLLbDiJhJYi42AvC5oxQKuGxfpE8HFULeLvK
         Gbcg==
X-Forwarded-Encrypted: i=1; AKwUvBxPVLjyYGmssDlblTcSpHbfYPkffiKLMKr5nd42wU3HllA24jyM0YERwnLH7xyGivU/v5jcpimi+4hgZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l3TuHTujeC1DVU2YrEPQOHSGCRarzmihzcxc1kHwAwFxNEN3cc
	KG3ml8SClfsHIHTVrq6vXns+UXJ9rOXZMy/RqXTtavmw3tSa1ejll99fOqAEI3yp7RM/q0pVcw9
	aHGVlrCA9NPAXkNEzNnk6eFIkcyfMsuk4EbZf52aGO/0qt7EqnxZH/r29syj0R8+u+A==
X-Gm-Gg: AYBFou3h199eiUv71M33exFNOr6D9UmzjNpIdbeRJjRhnjrZXgT0ff9L+uuId1fF2lo
	Xw7y4gYUjvI+0/vWZSoIfZILRIKP6zQkosnQdk2CeXwjDYflcXKXLZ2TCXoIdbKzcBjo+pcvehn
	btiTKHK6BGnUiVgVZ1+IpyYFwoyFZnKgD/oR4qESJ9lu0NHUMcJzjODUs3Jjgsh8HL5LwRVKpQ5
	ytzGGDu/29fChX8t/9Y+/sEPavK6LjdYJEgUbm8IPrCvQCwtNmjVfNJbFwNtG0HJuh5oQ27KXDZ
	GO3iVlE1h/+ELKB1KFDO8Xa6v7eB/a0pRboRNMsp0TquQoyo+SYiVF0esHU0D2J+4iJ8Lr6XxSq
	zpeeR0BYzckUSBNec7qqHSJhdPPRyWiI2VBZGNZb2fra+FcD+jt3sJuDuDzHKiiS777LqczyAfk
	zMVZaXDF0fO4gv
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id af79cd13be357-93cb5c10d42mr278081785a.32.1790819897732;
        Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id af79cd13be357-93cb5c10d42mr278079485a.32.1790819897286;
        Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba440595e3sm175732e87.8.2026.09.30.18.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:58:15 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:58:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v3 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <lxil5g2zx3gr2li5ola6xyj7khwfltzbyqfuflqygrcetztryu@mr65up77ioec>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX8WkWfrV1QD04
 VmALclzDick5HIZykLM/E48yqHIQGC4sWIMI6nAeUllhsH2KTz+Kct/LCwsR0X9MTZWe+Skl2nx
 smaFz977MCki/vaBjEgsgv0MAnbhlSU=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abdbe3a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=bqz1LMNPX605IxUfdh4A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: zY2L2TORByp0EhZJNgNuwkieyOscBnj4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfXwPBhb0lSbQvn
 hlhGRTNBkCtmM/3X2BM/u3PK02VA4cc06S9OJFP+5XWSIsfm9+qSa2dumoci6hhtMbRj1UzyXMX
 m1GPeHbmHo/srB4s4pcQcRg5anO/3wtjgjCTfgejblMaVO2Ax2UfI7j0Q6/1xnQjFJu46TmicvZ
 /Gn4hsVGvaFSdp7wCHZ5yVhJ7UnmmiT65dZxjtszKyt+/he5GpJIoLpy/1GDIIGhhoqG9OpLlGH
 HOpTamclmOeKQ9gip3tZ/LqmvvobdRAATiTJtOM2oaj2376ffsv5b4CLygbhMiPYJ7diuXOXzEE
 oJPD09u7DR1CHBnSFAcj8AsvP049Pc5VmKWEIEF2ammpb6/BTJY/eizIny05UZZOSPiwMevwQpZ
 s4MN9IGcFvFWPuT8a0DpPrPwVgc3k2dmbV+4z54JfW95LIZonVVohEKeCU+/xib+h77k6aH2ffR
 k/NJjHMx1vMwikhAOVw==
X-Proofpoint-GUID: zY2L2TORByp0EhZJNgNuwkieyOscBnj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010007

On Mon, Sep 21, 2026 at 09:19:05PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
