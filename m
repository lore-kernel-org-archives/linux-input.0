Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FE33FE05
	for <linux-input@vger.kernel.org>; Wed,  7 Oct 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356600; cv=none; b=pM+dDf0l7XWj0yqxGi1BF+fvLcfGxpLNXR3d4d/Y8Fy06IsS9bSLGe9UncUrofxxWRvfyOdkTNZOZnXkTl8l5ZrmnvjgBqGkE/UrrjXILKK7barAkGSE6Mm4jkAO8FV6JCo5Ea4yYn9h0hfSucaoFQMg+1acK99B5hCALS28+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356600; c=relaxed/simple;
	bh=ogEzu6UuBrOBMLU1YQ+/foOwKAGOPzGySwOnvVrCrBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9OzoUxTCtoi3VDGeQZlT0QxM+dsejeN1cxzn7eaVnA7SZZT7tk/09OkRMNPeqLYVSias6DUd1QU4eEpQuldUa5UWTUr1cIkH6IidJ96zwz0PHMYzzxAYTSXIYAnR6bsv1ut+8l0s+509KJC4q7gnzgCzje+85kRj7lAAdDicds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVE1ICbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YBESaM6c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVE1ICbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBESaM6c"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6975O8i31567524
	for <linux-input@vger.kernel.org>; Wed, 7 Oct 2026 07:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=821v8tlX6UL8RPAzc5juUnjm
	9WDDhS722BB+xkV9YBs=; b=TVE1ICbmkkYZgbIAKI8aLQQJ2Lt4g0HPSHosjhhx
	azh1mwSx6toh4aavK/8l7SoSDOdXqJi+EripNJZkG/yjLm3Z4qX2HxNlSDATwWz4
	R6QMGM0dBxX43rz2SRex2ANNnwkUC8EVrpemw92PtQOWg476WwSPAtlun/4JS5cr
	xoax+OAdsjDaCyLtkszMq4f85bZXGqsvSgoolpNOvG1JJv+wB3i0Bu2kH0LN+kh7
	SfZZBBHD5dO04iS/+1OUwlKlq7QHyLDVVBmIZInV6uk+3bR1IKtdFlx86HwOREja
	Btvay3mRBjCCiudYaANZ5qG5uT9mxIN2LuoLYd1/RAJvZQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8r9ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 07:03:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a3f673221so983974885a.0
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791356598; x=1791961398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=YBESaM6cJ1AuXWJvTp34xtcvB9eCnImE5b60bRG+hj5FrKsgRfGP/ncIbDNKAV9WKl
         z8yiV6U6D+BZmwAPPpnm7cbolkU/9yoHY9Pb/Ct3qLjEztHPHLW3wJhg1yPden6k6NUL
         MxEgVV5ClDy1AWFfTPQI0DpN3wUGxXr4tLUvw/CIWDtW/dPf9DsIgIGvJ+lj3E0AYbck
         mS54szkiX4tTFzB17V5ET9czDQ5AP+yWPFriUWKmnbhj9IXSIrP+KPEcKRMLuJbpmxJ5
         M4V3StCCHxjqS6JfX4c79jgA6j1uYYFLqEt7+mMXP5Kg32mb81/bYejMWlk8/cZlq+r0
         fLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356598; x=1791961398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=821v8tlX6UL8RPAzc5juUnjm9WDDhS722BB+xkV9YBs=;
        b=msddboNg9sFSQFjIgDoBGNOOK002cEBSV/3ncFsTtB86eQYtFwC6euPOU6OjXoKYaV
         4Dpxn7Ol80TrXScqWBHBgJyB3mSVO85an/xqiNFu/yAUlVTT7ba/IWuOZUoS+XcTVHng
         8Gj/juSwoh1L0WelePF3c6S1wzG+QbFVt1yIOvo42qG0bNQb2A4dRxHGbsj9Kx0uik1x
         bnlCtjy+6+8hFYsE6WMuk17/jWQXvjj7kfY5yOwmGnVQfzcrh/dbriHChymijXwrZ2YM
         +/ILcCGXsToA3jqJT8z8NQxx7dHM2LyM4NUtYgPrrJ4BVDkyip21nwlDrEfL0M9U81dx
         2Wdg==
X-Forwarded-Encrypted: i=1; AKwUvBw+OtbrBhZ/ogK9REQ9CdNspWGouUV/gDFB6eE0rhEtvg5hEeGSLQ9pj+7tmCSw4kqsqR73twQEO+54cQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kHB3bwEmzg1JsfbD7pgL3J1pe6bTPRMaikBquzkY2LriuFwhFR
	+Sl8Ie7+xC3s2EyeS2vskAyIUbwhhjGwzyHkQ9yeiB0HX426JFneIXz/oM6I1fi9JxzUObqgXSE
	KpyZ+s2+m8viSzTHeNaUnXwbY1Tnn0gp5vPLQcln6ZK9VBlEROfT2KtGJROiYoRd58Q==
X-Gm-Gg: AYBFou0udiTGFu5Nqe2oWzLE0Yl/diC2eea2d1wA+UtDTBrLY2Iy9lN9tmhLIEB+BC7
	BTxKHdbkjPH7dZWivcwprDEPa4wDB0w39Blwh2errTlxAS/J5WXU0iheUAiJPLUVGhLgBcqQl1n
	hgBogPgAUx7uRT5btQzZY7ZTkDbIgpoSXVXLw3kUhbYIVb2nvJLyiE6uyGQD92mHq04mkzy+Al6
	6//Bs1jZWsmJv5vrAeVggQZcZRVS7bUBM7dJn60qjHuNmzNg2KFrA8QgzDbOQneOY/MHaVKKe8y
	gIPU2k6JvYZfsmMNcp57Ctop7vRtXRG9cXE7dw4rFRzuXxpBu3Rbz1+gtZ8pzoe4Mo/m0YvZ7VB
	VdTiIWvh8pLyegBIqGJm82v7TYMYF3lSJuIZL35ilwQ7SIuzpvSLMHrnm4CtJCULuzkBYawy55k
	LL65Y59yEbKo9u
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263581985a.70.1791356597950;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:93e:9807:9785 with SMTP id af79cd13be357-93e9b829e93mr263574285a.70.1791356597214;
        Wed, 07 Oct 2026 00:03:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bccfe9d3e2sm417662e87.58.2026.10.07.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:03:15 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:03:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
Message-ID: <ze6klawno4rge2276cqwdiutvwbcnd7yby2l2x2gubwone36sg@zk3odztmoojw>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
 <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
 <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX+am4cf1k4X5R
 8UMGjrEfwOhsOSP7vB28fXfwBTJVSpTMqjwYc2rfTg8S6l5AcmXKl9bjrg1sckjGNr1YVcNl9fG
 7y5nT2F06p7XC0SgBjeBtkkeEaYJvZs=
X-Proofpoint-ORIG-GUID: RLaOPjPhWdPv-Vcpnzw4tejVdv_oSM4Q
X-Proofpoint-GUID: RLaOPjPhWdPv-Vcpnzw4tejVdv_oSM4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX+R1eV6WurWoC
 4WI52snXIEsQRNRZWpNC+skXLTMl9X26381RVIAfmtUgru7aXUwfD/ocvd5UU8MSgHIp2CnZl5Q
 /t0rnv4KDhr9JUMKq4My/6GLLLNV3bHsdC2eCtbGdrgTW6jdI4vj/XGfTNrWjAw0wh/XTBR2FtA
 3X5sbRfkwBvweFyR5MKMNa42v0jSG98k3xoWV3Smz8sx1D90XIUem4O34NxaEyviJoeAAaqfhoB
 QnO8H+EQF9F2mpCD41E8JDisORcj83xzRMe93UMrtmwJsLF6jmDW8nf+e90xdWL/4v+jT53WQe7
 eG5DjfMlnAMfToAzFN3Wgy6Ko21Z9ZjwKNDNDoL6MNk72vL3aySG7x4aUVmBGm8aP6yRqalp1P7
 MIZE+mPfSXgVgzzPrf3tFpwI0bdJ7WtvfMvTrrarAA4uF1Jd6eme6/hOwkGeK5cLi7wJtNW+7ve
 7zWAD1vCmtrAmv1tGcQ==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac5eeb7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Oh2cFVv5AAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=FwduPMDodLxw-pZHfsYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

On Tue, Oct 06, 2026 at 04:49:12PM +0300, Muzaffer Kadir wrote:
> On Tue, 6 Oct 2026 16:19:04 +0300, Dmitry Baryshkov wrote:
> > On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
> >> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >>
> >> Add support for tsens v1 block that exists on MSM8952
> >> with 11 tsens sensors. Sensor Offsets and slope values
> >> are taken from downstream.
> >>
> >> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
> >> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> >> ---
> >>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/thermal/qcom/tsens.c    |  3 +++
> >>  drivers/thermal/qcom/tsens.h    |  2 +-
> >>  3 files changed, 48 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> >> index faa5d00788ca..f4201748ea29 100644
> >> --- a/drivers/thermal/qcom/tsens-v1.c
> >> +++ b/drivers/thermal/qcom/tsens-v1.c
> >> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> >>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> >>  };
> >>  
> >> +static int __init init_8952(struct tsens_priv *priv)
> >> +{
> >> +	for (int i = 0; i < priv->num_sensors; ++i)
> >> +		priv->sensor[i].slope = 3200;
> > 
> > Where are these values coming from? The driver that you pointed out
> > reads them from the QFPROM (like other tsens platforms do).
> 
> Hi Dmitry,
> 
> Slope is coming from this:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi#550
> 
> calib_offset values are coming from these:
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1756
> https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1800
> 
> Should I drop them?

The slope you are setting matches the SLOPE_DEFAULT, so I guess it can
be removed.

With that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
