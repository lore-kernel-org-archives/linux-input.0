Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C0340264
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512944; cv=none; b=FRuAwwuW9m0Dy/7W+y6sO4VdofO0iTua1MQTXuateQZYmuAqueLjZt18VANZvIfIozUK///moCDDfbsO7XlmXNAyc9cA/VhSJHyGXPh8dgqGp+P4ADlLfadhv3JlDGUA8lUg2qEio/oVd0k7ykHfLWrwTeA71hckU4fJk3r4Scw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512944; c=relaxed/simple;
	bh=tbdcuT+g6r07HPBhB3hTvqmblkDZqNlP1F4Qz725D4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCKomw/fNzy567islCzN2gvwASJICnfCG+IlFtFE+3MAr9F0b2xi0xQ7U8RRmoVLCpTYIqWkKfjR42N/LOYhLxfjHn5M2uuaLsJgo+AABTSR3jFF53DgSiEf5oBSXfHnMisIfAseux65wKC0VTUG6SHjEsuS4UQczJu0HBA09w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WStp4k0S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alXG7suR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WStp4k0S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alXG7suR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JCxHmu159909
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 14:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZOhIku1tj9AxR9gmaDfARB9d
	FySATSSKwk2jp4g0rjE=; b=WStp4k0SKYItCw/iGfMON55XZApfSgkxXao6UZzR
	qIFL83OYLMWxcpSbA1e7VV7OxDf05x84fh1UN/mOht06GOIafbNqwdpih30DPqLJ
	8zrXCL79qdUigK8CpYdgrmjQfm1c2wWexr0nZ2xKvwgu1weU6dtz6bAQFub7QQpK
	0Sm/YjVhWphQ36KXwRIamTXdlQqaVSdoFofcRj2TZlawykk7SxECaWQziixiWQOu
	A1jCQMYWSx5jAGmbesvbhdjKyXKYaIOujk9dPdmWcSd+ga6ibYujEZpJF6wacUOn
	KNqyjQFlLOgwsfHCbCdfAzBVvIE6xbFMCLn8E5+gus5glQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrpg9tpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 14:55:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70d16d5a9so702375485a.3
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771512941; x=1772117741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOhIku1tj9AxR9gmaDfARB9dFySATSSKwk2jp4g0rjE=;
        b=alXG7suR7QWtAarMZ+MjdDzL+LWqSn2daNg9hbZtZDgPgE+a8RNEVepXy0VWkdZqL3
         ENGej7SyZVTI6W6BDz6VXHF30EPis/ZI7bWARcw0qBT8fwhnhEBTgRw4z+UD9cVAcfkg
         XmWkAHFioSJklV9jliwUziAW41Bog7CKEPGZ8Y2i8XqSck1f02/yGPS4IZAzgR9dEOxl
         ROoUv4DTJnknBrn21rykOWCT8rLHWBZU0qsW035j2LEDoi0/adVBV4QJLT5dfrAM33GB
         xfiwj4nWJXBETfrWK8iMzmrs0ojF9pXo/gbiq0jklzB2i3lEv67iHZZrtH9SpntRGNMJ
         idOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512941; x=1772117741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOhIku1tj9AxR9gmaDfARB9dFySATSSKwk2jp4g0rjE=;
        b=Pri/dHSJglDVP0l2BCAY65G33uotD5fD70b1OvmS5+eYVZDHPRBYzf3zgsEdM88DrT
         rg6xqLd3GDTmQDdEkLZ32Lki/bkYfW5sLH4y6S+44Pzu37at5DApk0MqIsHsZGO96y78
         5r3IYMF6qLrCuMyWgxlh8mQ77xFHqlGa73HDNNEwEKn+2S8k/pitx0s8WNLnheceTt0g
         i+t6Y6VLfda41hGsFJT+ugYQ1QGbMu488Bv9DPvgscmezQaIseAUWyc97SXGsBsQpv7N
         KvFrgO5gUrh/u4xzFFGbAmb/HKjkKBrQ69cC0zqk0XlwBCTLC0lK2NV2MyB9c+zAYk/x
         lzHg==
X-Forwarded-Encrypted: i=1; AJvYcCUZFNZSIUrKCMdxb1KGF6B1GcOzZyxh+Rsx61WTNOnZnaRtvIg/9hIWECMJmnE9v/JgTF5mkIm4MjHUOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzirbl9URko04A+wh389uEqc/xMTLZVLXGqzezjnV9bZvfkVxc6
	Z2aamYDxFG6IfN96PFZDZPyqIf6iLQ3PuaEcbkkHAjzkEL3S4ajVoFb0em54D99MnEp+2YV6T5W
	ntEZSObQ6S/W06KRt6xI4cKoD7f4eFVbaS7rw3cAisKTWSxBwYXhyhK4DJ/h4SiaSVw==
X-Gm-Gg: AZuq6aKmSQSRlVH/az+gPMq0DY2vzaIwCVXtuu7Voo2c+c6uP2JBjpich2tPPYCujQ8
	cbpYedryZtqEtPQtOkY1qjOJDs6t4rJa6Q0rbSLVpvlN2imjffx9mCenF7zwbtxMavpK02SCu0W
	2dyAbfYNSrME7rW44hWD96gFFgZE9/mTa21HrCNcYhklMdO1QjOAN1EnQE8xhO98RsiyKYCSc9I
	rI8bq8XK0DRDuI9lrGs7H1LKyCjWWMC0VbUOore770o8S8ydnCDAjiOG4t/pb8ya3Iyx+ERds61
	MYo633kJi1ZB43DmRJUrZrqt5pSL6Aq6qRw38OApcY/tJYJPIj3RhYAEiQqZzZ7YkXoTN66Ka0e
	29vK+uSEBhp5D5w0ER9pvD9ne5OWLfrJ1y23MuMgtsLbmnLI8Bmu9/wJ7R+fXTrQHengbWMle64
	BUaS6N6QXEX7wnjcNUC4sBSRlpad+ISg5QrOo=
X-Received: by 2002:a05:620a:bd6:b0:883:c768:200a with SMTP id af79cd13be357-8cb4bfa47e1mr2162864585a.32.1771512940482;
        Thu, 19 Feb 2026 06:55:40 -0800 (PST)
X-Received: by 2002:a05:620a:bd6:b0:883:c768:200a with SMTP id af79cd13be357-8cb4bfa47e1mr2162860785a.32.1771512939905;
        Thu, 19 Feb 2026 06:55:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5ad73esm5317879e87.68.2026.02.19.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:55:39 -0800 (PST)
Date: Thu, 19 Feb 2026 16:55:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <6kvygrdcavcsn23g6ghbutw6ycq43oodu25u2dnywo43ev5fwn@fr5pmk7pzg7n>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
 <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
 <20260219104832.3fe5tlnvjqus7zz2@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219104832.3fe5tlnvjqus7zz2@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-GUID: t0Tjm7osUUSBqGefdGekrKiqyRQVWI-M
X-Authority-Analysis: v=2.4 cv=JrL8bc4C c=1 sm=1 tr=0 ts=6997246d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Vb7ys8ifLKOb9fvY7foA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNSBTYWx0ZWRfX2V+U8HXyzaMQ
 wrqEKd6Ptk35taLQWeaL99O3wh4d+R+b79tzsKFnLs1pio1xT3MHYFFKB2qr3fjFl+qKOdWzdp2
 wW0TXb2Vlxu/fvbNZVcSnUq6grd3Lerhfau86g0nFIHd+c516VsYP2UeTsJH2DUy5adex9p76DD
 SRmwyX7rUvKOq3wQV7P87vshS7X8pCVOxn9znYp/v0OIqw2LOe/4Fv00YjWQ00jmelxbM4qQZzP
 9SInmRklqoBIj0OU/PU2vvh4bd4m5pgEjRpyqjZmPoU7lVlsyC8r4IHUSihRudd4Ndiw87fz2Pb
 nYNJF8xQ428YFwhLgkz6klLoXW1mYBTLmr8LXhv6NUzkAAxkhHkOMdLybRNcAHDdUROWpWH8++D
 nobS5cqg0C9PCAvJGyuECy9Ek6sxXD5NGRighCIeP/frsNOh8gNPtEL5teGd+tiP4GN+HgdqKAx
 B19sKaFNT1iMMdfhGKQ==
X-Proofpoint-ORIG-GUID: t0Tjm7osUUSBqGefdGekrKiqyRQVWI-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190135

On Thu, Feb 19, 2026 at 04:18:32PM +0530, Rakesh Kota wrote:
> On Tue, Feb 17, 2026 at 01:27:29PM +0100, Konrad Dybcio wrote:
> > On 2/13/26 7:17 PM, Dmitry Baryshkov wrote:
> > > On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
> > >> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> > >>> On 09/02/2026 14:23, Rakesh Kota wrote:
> > >>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> > >>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> > >>>> documented as a fallback to "qcom,pmk8350-pon".
> > >>>
> > >>> Drop everything after ,. Do not explain WHAT you did. We see it.
> > >>>
> > >>>>
> > >>>> While PMM8654AU supports additional registers compared to the baseline,
> > > 
> > > I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
> > > an actual name for the chip?
> > 
> > Right, I would like to see some clarity on that too.
> > 
> > I see there's a PMM8650AU and there's two variants of it, perhaps that's
> > one of them?
> >
> To clarify, PMM8654AU is a different PMIC from the PMM8650AU, though
> they do share the same PMIC subtype.
> 
> We are specifically using the "PMM8654AU" name because that is what has
> been defined and used in the upstream pinctrl-spmi-gpio.c driver
> compatible. To ensure consistency with the kernel driver
> representation, we are maintaining that naming convention here as well.

Ack, please mention that in the commit message.

With that in place,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
