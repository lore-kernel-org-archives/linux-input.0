Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF382293
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126716; cv=none; b=Ap7pd3agrcR5dl1vh8F3q2cAl5zrk1S6X6qBtT2QUn5y6SgScZf+J4hVYWoMm2ySNZ8/Wl1Dcv2IwAwS9D3wDjs6GTre2sKk0+0XSNBKxQqeNj1kg+Uydq1fLD8/Lyy7IYI5xujV8CM5q9xiYmMyUCkMuRD5gwNjAslGFRajRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126716; c=relaxed/simple;
	bh=YO0xaV+puJb+FXu8XxI7Miv+9xXb71hwJzUKynMUnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP0y5yT7FJfiqClldXy/YyEgZmtcmTaFj6LPEtNqjmCeFrzSU4jVN/SeyjE7adnlIQVWLku7PMgDM1pfEHQPT1JWD1KygEarHvii2lPZje9vsZdjK1HdR4fqjRkrPSr6Xb012xm7ZyDstl4wFKsfJlde/tQsHx4W43VYyBs4X5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0+NDR23; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDjC0tGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0+NDR23";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDjC0tGH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBwhtA1252691
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 17:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W24vIOGiSP4y29K9PfNEC3xc
	hhMtUW4j//8Nr4NBCog=; b=D0+NDR23gr0Hf9uN9SsTR97Wpa/hUSXks34Z4fPc
	ytW9M2nokM2oR6fqX+mL0I7KfQtCXwXCPHUcUkqZD/006ngkEKbeFTjSa7fMsvE+
	zMcUWUNuiDLB6MoFr2ooNeHmcPFtHDRWif+cRlWyXrPY7kF+XcEJkk178y4MIBoD
	BKZaBrXwe+FzmKeExjDx3GfI/Ad+KCq3L2djYW9f0nAMwRf2u+KeRlzn8jNfS8Y2
	wNlU3Sk4kcWZjh3yXvVxWYRT+b0yjz+SHKYU6MeX156S0Qwqz2UpnwHtTztCQTSK
	OjHRfa4h4faErBt85SDg+UUaIMe9cH/6tBIowaAbxvSaVQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82c0he7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 17:51:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-514cbe73d00so91248001cf.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779126713; x=1779731513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W24vIOGiSP4y29K9PfNEC3xchhMtUW4j//8Nr4NBCog=;
        b=dDjC0tGHbk76CsBAbyEOg/s/WIx5Sbtwq3Gmhd86dgMQiDE6vKYZhTP/i3CUTnDcyV
         bzsHc+aiNhgwQhfEEx8yf+Ws+AfyYipf+bXSrVbRyU4Df/dTvFPsIzDvmI8CmTVUBAoH
         nHwvWaZ9Sjvj94MzE7yFBSWGmv+KGh5WwU8u8E8GaNCE3C8sravQyE4xGsvjWuyBn2lM
         eDu1GG2zCYyRjG6/qe713+itq+Uj4Md2PixWcuXTjhDiUQSm0DwEh2rHvAw2r7nUcjKB
         oAAIK/W1hjnGcHmZkCW2IQ1WdobTOlGI7ZOPs/aocq7eqC0vEAGNPn0YKyUUwEEWwVhK
         h85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126713; x=1779731513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W24vIOGiSP4y29K9PfNEC3xchhMtUW4j//8Nr4NBCog=;
        b=DiyogUQqf1x08bqEQyOuIaCVtBgk/H00ZofJNpRHfc6ylPz+tgNYp6eyMnPKiPIqW0
         j8gGCpzttsilGr2N4XnUPWMoYBUwJT8FhGa7Afp175PH8sAdx3FkFenmOxvt/I0g2dB2
         ftg5r2ouWS052eCfJzAE9dyXm1Ld6/bnFiMvvRB7KqBa3Q/cfoetWtp6GrzTeDo15ojK
         H/pyPOVyq+h5NQ7LHnUv27se3XNqwg/5HF1NOC8KJIxGU0Lw7Ux0eQ+QX63wqulQJK9O
         C7ynITNRarg+9eJt8pq72zLbrNNO/ZVZRxbFoiTqcoEkfGDHlDV6jk3h/wmgA7J0Objg
         /6Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+01AdhfNkvkzOg750fpYb9Cxw8hRA077Gnk6mRR6MprTdzcHWJNS7dqetpFZOgywrvL0/z30LLgV0WDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zFA8mbkiYerxUQ5cKqzivAp6MlVuI2FtiNxdSE/UrjEnHW5y
	WeVuJB0u4QNvZG3xSuyhudr3/PNrs3CX7dFIof0zHcfOy0T/HVxv7kTic1yxeszMjtDPZoxcT3c
	MswCYChDhaeHmQm6fyPC0cE0js2Fq0ynQOUdJYkHt4xdgooHzmsGK/EYBkcVT4jTBhA==
X-Gm-Gg: Acq92OHRwt0N8XvJinidK2Gqr58HkSxbeHrZg3kD/CuAKSMqr7QGo+d8+FJTzo5qurR
	LF2sByBMkbsn8ndxiX+r+dEj6SceLkZUa14EVoqgaZ7Rdm9xs2p2mDCU6X4rzwZbPhjBbCIvZ+V
	7aXtFyunrTNBL7/AqABQY85Gme9vedA2UN4JSmGKPfb63Mz5EDzbPLpXlH7OaX6SWoPIDTnQ2gS
	KIgM/vJ/+c003aChkl3uYlAunm3TuLNfbqxuClhVI4/hOzPEI5uNQX2ExJ9YyN+9HQckxHPl0XO
	4BTGBF42hxqpz6EZbTANtqiPdohcOv6dkuBzJfdKnASlqw9Y0C5G8OAyXcWvJWwDvSVvoczRB1g
	IEwQyrq+4va8jtHx7+lTQaTKYYW4zqwYoCDAAWSpy/BwdiaSAj7XgKxIfHs6pnW0358N9OdTKsf
	DoRXNjT9WChJ4ltzep4XZtWWHrnahLtuOxxb8=
X-Received: by 2002:ac8:57d6:0:b0:50f:ca25:fb48 with SMTP id d75a77b69052e-5165a26b016mr236818281cf.55.1779126713021;
        Mon, 18 May 2026 10:51:53 -0700 (PDT)
X-Received: by 2002:ac8:57d6:0:b0:50f:ca25:fb48 with SMTP id d75a77b69052e-5165a26b016mr236817891cf.55.1779126712506;
        Mon, 18 May 2026 10:51:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958878a103sm13495791fa.29.2026.05.18.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:51:51 -0700 (PDT)
Date: Mon, 18 May 2026 20:51:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
        luzmaximilian@gmail.com, hansg@kernel.org,
        ilpo.jarvinen@linux.intel.com,
        Douglas Anderson <dianders@chromium.org>,
        Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add support for the Microsoft Surface Pro 12in
 1st Edition (Snapdragon),
Message-ID: <qfoobb7xrqkc5ivs3v3wcymbhywwqe6albcijchdmkhwrvdatg@pbsnwdrawko6>
References: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
 <cover.1778822464.git.harrison.vanderbyl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NiBTYWx0ZWRfX9mcNln1MvWCo
 CtLwsdJBALoHWdwTz6Tjfhsx3zLS5PwaoCCnBo9O7JUsF/51OqIWbcfVtoEVahjD+4hbhqu7oxQ
 A+LSa5n8W8QY9eQe0Z3M1MfSCcM4gcQhU191AtV2PDEcsDKDX/0TVBsV2g0FNC4uzCEW+nEBUnH
 EH/IaEknVnQnXubWsunT2eMKxRv+eOED0Xz++p2ZABdlnaABnzOjfkH6DndiQR20eM+H8gIko43
 FsPajaNkIqgrMbNpYvCHN7IGN0FsvtWNYiSomDgubfYKrsoF9jyW98YKGA/QC/3fxfs94Ht+/Xc
 AZbhFPbf79gwxfahdoH719Rm/Rub+hgteuEriTQeMIdh+4crBSd0hu1l64NPyqaf3/ga6QGMZz+
 pdp7a49Qv2PPa8crOOM0ktrxRjdrZniegBIIFmxgFB9YQwyCrP+Y5LfUJ7nS+U9BNFEEHJ15myX
 najT1SVcu/i9oXunPQA==
X-Authority-Analysis: v=2.4 cv=A5Jc+aWG c=1 sm=1 tr=0 ts=6a0b51ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=DHJDpsF2dBqhSPlo:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=9VIlvAo4FWx-UwQJ4rAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: MbBKT428-L9sFlIRtgLiBwf_W_DfIFSE
X-Proofpoint-ORIG-GUID: MbBKT428-L9sFlIRtgLiBwf_W_DfIFSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180176

On Fri, May 15, 2026 at 03:41:45PM +1000, Harrison Vanderbyl wrote:
> Changes in v2:

Please don't send new iterations as a reply to the previous iteration.
Always start new thread for the new iteration.

> Ice device tree: 
>  - Updated to use 0x0 formatting
> 

-- 
With best wishes
Dmitry
