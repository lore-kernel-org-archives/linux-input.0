Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294A375AD0
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772404831; cv=none; b=c7ANtyzGGziS23oZNg1KUDrOyMEs//H5PLL/tvDnxYV8BVS0flFiFfXJnQqQjbCJhUBbSO8JPvj8JjMH/fKYk1EpAlhc1w9GELLLRhySWy6uE36c+uI4QMQt2xoOKAYL7a4mwyPFbpNYkwiKzqBsGnvs0DfmqedM0dLropofjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772404831; c=relaxed/simple;
	bh=RoF4CYBqOCcTIp8+OeNsYC8UEsKn2n9wht7SnNtDGfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flpktIsC6QfNKcFIVdSZX3KKC+pdzxvJJLA0FVGWk2TBtdOwSVptHSJuGL5BNcQkc/lTfDsJX4HpUmm/JqCI7xParFMmSHwa8EWnHEUB6c3vj2NFIkaMxCMETyOZJ2lVheMsRvLnI5CyZ1moG523rjcgJFTHsYRILzMbVdbIAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FmVl9CSH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CcfRFH21; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FmVl9CSH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CcfRFH21"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621LDKcc055870
	for <linux-input@vger.kernel.org>; Sun, 1 Mar 2026 22:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=liHMhkUZwLObZQKcaR0dCOsp
	FbGoGsXIqL6LcZpPJfA=; b=FmVl9CSH3WuzakbWRWrtDYLnsJ1shhPHQUPlDcIe
	+9lv7bblF8fP0J2Pw0MmfcBT7vGoLQmrPCXiIyWaJu0Jpx38Gh8RfROnel/TuF4+
	FK8jVR4/TdHq9zqhye2kFv4nJoZqwxlJcfl5J8qRo40FtvI5l9KnemiwpioGxqWy
	2BKC+M5JSMqOQ8tsfh8ybY2Ho+JnCHu63zxiQh4uw/2OG1SYzfPgHMYDB2q3qeWx
	gGAk5611x3LjEVhtnZ1p8DG90CP30UrenFVjdemKCH2eU1rbTYOYVyRxM42JCdM5
	pOKXaUr+dFIY4po0vGSiOZXqlE3IeQ0GEjUxAoNgI3xOhw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw6482gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 22:40:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899edf01747so123025206d6.2
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 14:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772404823; x=1773009623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liHMhkUZwLObZQKcaR0dCOspFbGoGsXIqL6LcZpPJfA=;
        b=CcfRFH21mWxzdpaRfR3TO++Ob/4XgvqrAImJXhAnH3OLnF+QsearLgsFj0fN8kNXie
         YHyZa4s726kRibxG/C0XPG+K3h1NmegA5pXO/03G6iigQB2dDGVRk6qJn5gdElYmnByH
         7ALcm8YlQ66vF7P0tzCJLLngGfCnNhQstvCFsBzuoisUK6IUfSWSpp0iY8Xrw1avInOF
         RIUAOwibinClXgJdIrlc+aHGNk7J6yYq/o0uHdNfOK4cQjwES/sihif9bYnD+bbspAHu
         OINq3TmDqpJDXZYkA1hjEdxt3HfmZt9xhQx8wDMCHTLMdOjLCqf9RfkYbuYo7LoqH1SE
         B87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772404823; x=1773009623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liHMhkUZwLObZQKcaR0dCOspFbGoGsXIqL6LcZpPJfA=;
        b=vdMbv7ZphCf10GqT71QA7GE6tX3j0ZDdDQ0CeG3iyxJhaE3hWcmOpS7giCdMkgOzqG
         EgBurrfozUkV1QLdxcHviUr63VSnqF4wSmyJjSqhCRhXFSvVgNOzWWwtMYn70BoHmA+Z
         Wd5X9Y4MsZrbsEsSIcZkY4zY1VLbo21iroaHaYGv73brA/tTqmNWw8v/a5M1Xy31K2WK
         cXT3Nah8wu1AFSb3K1CqdCZwuRkQyEKe7JbBF7F4CDrAHq6x6RWziXsQMY4ONslzo25r
         FQMMZiDo2qkPHbtrchp2OVxzM+we2czS2Kuavv2ZPNOrh6zwitlKkxfV3an3APovVfy9
         WvBw==
X-Forwarded-Encrypted: i=1; AJvYcCUlusbPvoRa1ju5Rs1TuWPMsSM89vFRWq8dAZ3i+NbYhrB+sgnHtuqXMmCVthnfsYdgIwZ3CnHzY7DVpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTW6lbDs2N9pXeP7jtSRGwyA172Cxl08j/z2bwh5WlKtJdLopw
	Vg6/6QWtfUVegbBIT22GFDFhUy2zUZIre1Z+r94qi/6sNrbyb2jcxpRW3h+5M0va9FekmeAbwTJ
	rIOP6Vg2QmqD678DkDRe5TzInssUvcN0KLC3lb5j9JcadMo3/ZVpLfEbxPvDcm5KTtw==
X-Gm-Gg: ATEYQzyPGpREaFE/+/gUpLeDJSNoijwBK5Jv6NW0qmwR/BYolktavD90tdMPrK2xcht
	uQx5NLE+hfQOJi5rcUPE6tJ7DMNO1y7p8hnEHKl5U6kg7gPm1SJ6tULt5aMuCBcLfdzE8xexWN2
	XRdT68M0bITXlk+MHHQ6zXOnANfhEbJAM1ieHN9VBVmaMvmUdwUmRnIrKHGUdsdXQveD4GFmYXy
	LPmQAZNYs9L7KqWIyoMVY3Z5LXLNu0OTeG8ZlPZW+xQOq9cR+ja9r3tpZSCWRRcvahzp5mJif1w
	3KC+KsYviwYTA/l8bkho0m3MpmkOWc2wSmBIwqaB4HLEgb0YAgzACfOmJEbN2gCDhS0QHJUWgv5
	SY5XfckXx2OYQMCrElM7BxzXe4LVkL1DEGRZOd6PABScDHTl3p7WwslcjWtjLANJxY9Y8ir1uiT
	WvS+vMpZL/6juLoGVbdKhZ7rgDprOgZ8vpLEg=
X-Received: by 2002:a05:620a:4413:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cbc8d83cc4mr1468463285a.18.1772404823118;
        Sun, 01 Mar 2026 14:40:23 -0800 (PST)
X-Received: by 2002:a05:620a:4413:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cbc8d83cc4mr1468460285a.18.1772404822548;
        Sun, 01 Mar 2026 14:40:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f3016bf6sm24553701fa.32.2026.03.01.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:40:21 -0800 (PST)
Date: Mon, 2 Mar 2026 00:40:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 08/10] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Message-ID: <qibmsgfttxo6kiaqyjljj6otamqp7okfr4abwpmuo7daanl6qu@ka33zvoz7lte>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
 <20260301-stmfts5-v1-8-22c458b9ac68@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-stmfts5-v1-8-22c458b9ac68@ixit.cz>
X-Proofpoint-GUID: lwvoWyqzdF_Q8RgjFY8vroJASu2_ns9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDIwOCBTYWx0ZWRfX92AFgc9+4Xyi
 NoympM4ZLTV8rmev0fdCtSK/oj1s9i6V71jJDPj5ow4kIly4Zllq7aRYZE3tDoRIMAOuYyBAt5b
 Pb/Cu5knutgt4tDsI6TM+BjVUUPcRxth31GEf31ieg8XVi/EejNNwjTimwnQYB4BYMjjEM9LAX6
 OB2yEzUpusV+9hyjCXc+Q+/lF88akaqvdxVj8qXjInXNj7DLvvE+7TwV5iZ7ZOIyfzZpHDXAsEg
 yiYuKO/ukdvXWHTtoxuVkZGKldX1kAycex904PrEnyRvJigAdSDLoYENx+3RMYHxltsk5VlWJcX
 a+nT41U4hmr/B7LjSoR4ul3Hj6nf6kP4h2qdnIAbO5/mkfNrIoIuOyX0HcLGqFHwNj1iJWFTUIZ
 oidaZskkxdUsLeiGiPnj9Ttz5QkkoBggG+txT8aY6xIb5k/1+BDgUkoXZnNLirzMw0XgMssZSaM
 JG81QLkWcKiUxo0e6FQ==
X-Proofpoint-ORIG-GUID: lwvoWyqzdF_Q8RgjFY8vroJASu2_ns9J
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a4c058 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=tZRLSl_A3aL-_mRAmj8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010208

On Sun, Mar 01, 2026 at 06:51:22PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Introduce more recent STM FTS5 touchscreen support.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/input/touchscreen/st,stmfts.yaml           | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> index 64c4f24ea3dd0..329d89977bdbc 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> @@ -19,7 +19,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: st,stmfts
> +    enum:
> +      - st,stmfts
> +      - st,stmfts5
>  
>    reg:
>      maxItems: 1
> @@ -53,6 +55,19 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: st,stmfts5
> +    then:
> +      properties:
> +        switch-gpio:
> +          description: Switch between SLPI and AP mode.

This doesn't sounds like the GPIO on the touchscreen, more like the
external schematic component. If it need sto be turned to one position,
it might be better to use GPIO hog for that.

> +
> +      required:
> +        - switch-gpio
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry
