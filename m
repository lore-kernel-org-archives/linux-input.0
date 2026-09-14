Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4D4657D6
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392561; cv=none; b=ESmDYsaMmnIX6Xh3l0R/FOLIfOByeidbcSuKq9ZWsDav00Cr3+kFIFvnmGjPf/BkBYtYsryLCv77Hg8LDVu4QAb4R+iCJraNSwXIjBGa6K9auNbh0iCpzmlrSID3O3DiHHYpdg+YAH0qCd70nvidThAIi1fPMGA9Zr2WyIyUEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392561; c=relaxed/simple;
	bh=qg/RBhESd51ajr8WDi37wRKO0z5KsP/UjDdEMv+gNuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0A9HwEu2mQLa7c443DsUZacrw1UaQlz7V+yxkbK4U9m/L5kd1M7ToYzsryjQhhPHLvL9G/ymkLrKfbXVisJ3bQ7iMIxbL79saz0S5t9mVQGdd+t06Ex5sXlHsASl/pTI+v6+ZY+pc9SyINHxj3WQSW43arZwjwd+aaygTKKSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdYADE78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1aLWJWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdYADE78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1aLWJWt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0OqN607373
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 13:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=; b=CdYADE78z/zH8CyG
	FRA32jzDGmlkiHgOcX90VEsNibqKg/uouUN9JLiWmCTe8cYgWKsizhKfQukbbUsq
	LLZx+/1Qi+Dh//KFH6kJwoOOFdS1heOaaKFHktKpOLdNugLgGTIksinRlhfJ6fM+
	m6KAKvmQsb8NadTRgzZ7Okrwi1LvB/bSttjNBdMc/jJM/oscOCjSc7ndzJBhz76K
	uBB0+EGKpZ8GUJ6lg/OnGguFMWCpNfHLMSWOq4UgNBS8kIAPWhCTRgAzDargEb0/
	Ly51XRROf1cLP+1/UDZQukfmlDs3dW5Q1JUlkAYYLyiQnsst1o1h/FFfKQKudN1Z
	4+66BQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2krd70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 13:29:18 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-79129463b7cso2966821137.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789392558; x=1789997358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=;
        b=d1aLWJWt55cLMxt8PvstfPgip3MC57q8Eme6zEjGGPNjYwwxpk0DGAKlF/95HBx5zi
         lTTP542hXhv8VjWH0a7OWA2732wcArVRB4C+VDeUJffDUDlCIfROFTL7RYVR3sjPGNNZ
         B5CoHWfTO89igDxoU6UwhuIuORf9kQUTdiNCfLqtkykInCVD0l5ZegJF89WF5/WysY/t
         6bwTQRujgfnuyZKMEyg44PFWlRiKBavG1nq5Xn5O66vVyl3b/8jeZirSu+cHzp14Jdfm
         x1cBnrQkgn6E8p+LOkmUe+sXVJd8R+oCqGWeY7Gl4z5t83wR5YblbwwPSE0UBMqzuYn5
         EY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392558; x=1789997358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A2oe9WYaH4TAkTlCFmhnHizk5lGknQxaw0iqFnj0J8k=;
        b=rrD5E6KV5VIEsEqpA8uPv0Xh3LujBbgJ/N1E0J6A/UUJof/S5kf9TLL0C8tzHUDydH
         XrJtXVHxPXrH5h5g/C6jNl4GkWOmKdlSrr6p3bLJG27nV2HpKvF9oSvqSzQ3XFweKwgX
         twzwip88cSTXgNp2vd5r+mOATfdXIARm9gk2BrBH2CHjH42w6cTA5nEvsiHDWtnDqDvl
         rRhiM6myLWzkcDWcqro3L+ey8z6S9cPyvofQPXkOPKAD8bTJKhKSFXPKA15aGCJSE+mH
         fdQRsyEGjhJn9c+fwAuWof2GXn8eg1P7LS0XBV2oZgxfoswT0wcpK7d6FmmQE4Wh9huX
         c3iw==
X-Forwarded-Encrypted: i=1; AKwUvBy72fjtVnagXcm1cs08Jk7koojD77qpMriNSbb2DjvgFkZfBl6sQ6HUk4UmYjECzi+rhNvTU46ChFCudQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lXi8+nA4jG5PVbAhrur67kPn5MHK7AKGVmZ7AirtfGJvqdlb/F
	CXWhUvwBqxZXcD8NBp8ChlD4lqJCp/Pu0aeebIn0PMnCNvUzWHC9kMMtEciHlcSuqg6aovoPfE1
	knRwr2TJW6NBh2OY1v7MBMKhukMj0bFJ2B6GaX1c3810i8o0+PJQOxaMTlhr/uOpkAg==
X-Gm-Gg: AYBFou3iJ93fQAcFbdBR9fes5QuizcoImrnzgSnfhjTDsposkKQORtd2NV+k9vKjgZA
	ApTrqDnmF8Duj4nKKKbEmhKaquPtmGrfB7Ppzw7vYxQqUVYg/4En7PNYjSWEWXghXxscVyTyjVx
	x4ewcOxXjrQRoCPcU1f1vrqc2SdzzOOrrzxk/LCjZHlPMjCf3ujxXcYxctqPY/CAZPIZfc1vogW
	dWWDzLlEbwPg/JmE4J+B2s4N/Zd4ntoI0SY+aOES0NzaNWvGXacvkdMcBblljnRw05NkQ5OPiGX
	mFWmi0uicbajb31MO4x9bAEKD/5LHx8nCQqRzXGjnsartT0+tVWOBzHrBGz75Qwutv9bq0L3k5b
	4Oc5L1jY7qEp8FgE2ZYDrq74xt1rq0oTmqIF1P//zpPZoI1RcGxXB+X7nXZDwjCIQno0OUmsS3P
	2rqyhoL5kTSrPz
X-Received: by 2002:a05:6102:512c:b0:778:f972:32eb with SMTP id ada2fe7eead31-79b5c515679mr1850354137.12.1789392558278;
        Mon, 14 Sep 2026 06:29:18 -0700 (PDT)
X-Received: by 2002:a05:6102:512c:b0:778:f972:32eb with SMTP id ada2fe7eead31-79b5c515679mr1850285137.12.1789392557779;
        Mon, 14 Sep 2026 06:29:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3144a4esm26968051fa.0.2026.09.14.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:29:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:29:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 09/10] drm/msm/dsi: separate host link enable from
 video stream enable
Message-ID: <2wj3y5o5edya4uifambdpzh2jkpo7xpxtjgrmtvdxk3z76uty6@tuoe2vkh7p6u>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
X-Proofpoint-ORIG-GUID: 9SOCDAx4MMTjeLCzUUgfIGW-qpv8uSxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MyBTYWx0ZWRfX+L20Ps37/ywc
 /Ws+sJraXttYhVyPz+7q703kRsFFm9PbmKRgypuTr2N8cgFuoGSG0Zh3JaYHnglSqkvsLz4nDT7
 yf34w7jxBfGJqXy644KhabLDydU/snQvsRt+M/KpEYIl8aZpD4AF5TetnYRdYf34XxDhJnSkiB+
 eMFD+4bHHK5YRFOgfmGJCKKTHw4uWZ02bOGm4VoFllEUlv/Yxvh7n02hlB2i+oAVRMaBYRyZYEG
 6iolE/6EAEa6aFRtCkXeNTBEgXuvTg9oQp/wn/LBg5PY93k5dkPfFcmM2TKwFW/dxVbdag+x1Yd
 w5bWg/xwasy+6dShBLb4U2HENx8J/12L9hUpeHb92YOHFytqkKDOb9Oto8Uwekig5dZl54zNtQN
 6j/dJ4rkf5D+kf9oM9WpJsnIZ0qqSwzerd/JyfB1PXeAUdXyArWctJGAT/n6n5z4RLtXWdpOL/K
 6FKFS1HSePlVH5bBJAQ==
X-Proofpoint-GUID: 9SOCDAx4MMTjeLCzUUgfIGW-qpv8uSxa
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa7f6ae cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=4I8C5fWqZRg8XWo767wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MyBTYWx0ZWRfXydiHdchqjN2n
 mIQIXlskfHKIJdTMWZwWmgeqElZyy85oBcsocNlK+6jGETnAbAH1XTb0fNn4B89ipIq06Vny4xs
 F0Egd4V0X35M2nOapJHAabQz1pPUR6I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140193

On Fri, Sep 11, 2026 at 11:51:06AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> In video mode DSI displays, enabling the host previously engaged the
> hardware video engine immediately during atomic_pre_enable. When panel
> prepare routines transmit initial DCS sleep-out and setup commands,
> concurrent active video transmission causes DMA timeouts (-110).
> 
> Keep the DSI host in command mode during atomic_pre_enable to permit
> clean panel preparation, and start video streaming in atomic_enable
> after the panel has completed initialization.

I've not seen this kind of issue with the DSI mode panels. Do you have a
more exact issue description or a downstream reference? Is it the case
that the bootloader has configured the DSI host for the command mode
transfers and you are reconfiguring it for the video mode?

> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h         |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 23 ++++++++++++-----------
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 11 deletions(-)

> 
> +	/* Keep DSI host in command mode (VID_MODE_EN = 0) during panel init
> +	 * to allow clean DCS communication without premature video engine startup.
>  	 */
> +	dsi_op_mode_config(msm_host, false, true);

This sounds plausible, but I'd like to check it out.

> +
>  	msm_host->enabled = true;
>  	return 0;
>  }
>  

-- 
With best wishes
Dmitry
