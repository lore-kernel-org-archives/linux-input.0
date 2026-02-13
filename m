Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCF274B39
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006682; cv=none; b=nY2TP52arJPiuKXBybm1bQU7LUNIOYs2VksyQp8z9ZRrl8asjuN3kAY10blIj0+wPZ4lg3stGMo+eq/ychgWcDQeEXjbKNrTqe29MjTV1UGXkPVjFmazPHy2GK0WzEUjPKYH7XBCnrzZHSEWnfoOW8GlITwDVFcWIWtNxdnGTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006682; c=relaxed/simple;
	bh=Do4BGO1LGcHGvCJPpurgH3E9R2Ist8VqiaUHKtL5y8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnELmjcR9FtW9isMsm37lBH+XkkoFbCAVV2FaEVgoBHndiyqxjsvD/nWEHiFAPQjYj1K0O79xIjl5TaNlT/1Kbf66uMBkjdVDoj39TAdzl0OTbtGM5b3WJnazrR8OIphE8Lz9UkXX/aPGi026baQtCQTcyyzi+hBXNWeS/bF2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mSPhqAaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pxy0petO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSPhqAaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pxy0petO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DCA8BG1827984
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 18:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3SdWpZs6y9lD7M+9Gt2ougNs
	RDsaLktIwBXMbAcdzug=; b=mSPhqAaVolMHDdpabzyqkpZ99wtSLj4yZW8Weiy9
	p+jpaQKF1nFlmL0TSFIQ07UP0kA8Z6gFm4p02edS29gUfyxYHqYBEhD9MMzQon7f
	RpbECtNFDStBlNwgLWLKN2DZ8vMoF8zqvmqWfeAjSGFumvoa+5OFVOr7/iPQ12IO
	MuqtgYey/sV4Fas2bovWr3nvNJKGk/OwC+FOfnFKDuT7OD0Wwvzp4/GwO+/EBnpY
	r2YWaJfLZ9ko9XrJj/GP/vFGxU8KKAPMOP7XvqocBvwccmsBvemUAa9IaYPlNloK
	UhnYfVMgWouL0+OvNLhXDI5v4LfU8NPrsQQ7MwXQXs/3mA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9wg02uhv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 18:18:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52d3be24cso223403485a.0
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771006680; x=1771611480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SdWpZs6y9lD7M+9Gt2ougNsRDsaLktIwBXMbAcdzug=;
        b=Pxy0petObSpM6rLiHmx4UMW2ZOnLKPxrfYLkbcV7vK38YJFR5FjkLRFCSbbdqKsJ3K
         Wx9mSk3S4kSSyVB2j85NqbYEpwpkFnbv7TrN7+zf4B7RCZEf+0+wam+A/igbEeVT2JzI
         iaRGQWX6x87zOGiQ/jVOoc5oBClnjJnkS9OSVcVi6GoW+8sUo+2lciTAUm98IVxQ6EG7
         3oaTcU/NfrufTxqDg3rGfZ2fxb5R+EwEc5TvGiqNeUvgfopgV6jySw35ktiGoZcijRJ2
         cIKGc07jbWo6XeBq4NNl5rQ4GCrm3fgn2ygiQ5kDeM67SWHUU9plyWGQwsMd7r91vxZR
         fYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006680; x=1771611480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SdWpZs6y9lD7M+9Gt2ougNsRDsaLktIwBXMbAcdzug=;
        b=hODI2DIyjZ+L7/VlxhCb8hGiHTJKT3GRvtSLHlv4pcPlPk8uBfdA4GvbpFIEny34V/
         ZNkdqM0iQ5iUsSTsq3CZ5upnr7PhrYvE60UAwTM9Q8w2dmBB1lEUAVyBuITxvdj4Rcsj
         Y1q4WL70ogFgaF0D/3gDdsOoc6SwBJzqdqF5stnR0HpvIn0xTbIy6AnIySrqrqHaVMXJ
         sw9SrK32fq3ci80LiKMo4y3hUibKw2g7kNEqq6vk+2leuD6Br6YlMkGWofJ5n5nnrGyF
         DBjezNb1TJM2kGazodACU0aF+OHTgun4TaKRf0vaBNzFlViC18reevf45+QCuFnX4+MZ
         XClw==
X-Forwarded-Encrypted: i=1; AJvYcCXNwkN5s4W8pX8q3/eOGBgsnUAKYEU34CMV8ocKiCenVKV+D2GXMls3C5daPJrCko2XrODh6B7DeXtfPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8+4358uKWrHLkfrL4ye3pNIabLHjGgeitE5UGysYV2+oxTtY
	npxLTa8TAvGSB7wLOMwnquyUMSZ+W5fLxyCKFd+N7PUX4IE7US7oTrBNeQpZLWsQWFpeXsxb6AP
	bvvmdbCZgBrXIx04QpzKWn+fxQaHA6c7UCPVaLw9OSZRGtvSsYPYZ/mpurj7+YEtIbA==
X-Gm-Gg: AZuq6aIkfLRP6hy9ZEnHLrQqZ4JBcfVX1a0qIAXL4xbJorFt9jqB1yw8qrTDV4hz0p+
	WnLwOHfCRaSaRVLiJnpQYfSEBpaUrK2BRG5LZFODlwB/ZsAsq8zi49H4mg/eYYLh28jD0iSC9Xw
	JEVthERwmK6TwW2GiaJHSReF2paenAvoyFI5Q9ou0JJnjHjN0H+ok1J4M9+4NjKy1Kml3N/F2tS
	3Uy4DYrcbpwKoIQNl67ThZGgKU12WG3uxDgWKsyRv5A5lbXJmGOOVpYWrO0kWTwFdlm1UC2Gy0K
	ZVf090PXGDLpuR4aiIDcSXcNuMpuo9i0Xuv1c8QcI533UtxW++g2Cn6p6uZZpk8jQrwf6s3GUa3
	JsRAeil/CfN6JbjFMGmrNvQ3Bw6FoBNXRuQFXV1BeYGLepxeB4C17q5TyseQBCVMgyiF8RkjJxP
	9WobLTMC9qB8LOfb9LUctRCdLraWmqJcQlRug=
X-Received: by 2002:a05:620a:4406:b0:8c5:30d3:d6d0 with SMTP id af79cd13be357-8cb424601d5mr320831385a.48.1771006679882;
        Fri, 13 Feb 2026 10:17:59 -0800 (PST)
X-Received: by 2002:a05:620a:4406:b0:8c5:30d3:d6d0 with SMTP id af79cd13be357-8cb424601d5mr320826885a.48.1771006679384;
        Fri, 13 Feb 2026 10:17:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f5fsm1710581e87.56.2026.02.13.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:17:57 -0800 (PST)
Date: Fri, 13 Feb 2026 20:17:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
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
Message-ID: <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0MSBTYWx0ZWRfX0+shOrZt/+TC
 gp0FI6pZqfbyGNV7wSmuESHxOIuGpV30NFKxBOOInpMJdCmF16mCEtmbYGrgzwv8+iO+CoZJHjB
 vbR3+Rf/kdmfFUWbNSYQ5WT4aUVgWKeWfCcq1L4QrRBN6soQQdOyc/v2AxeSdPP+QDg92aGks5w
 JNyWwVMvA1r0wpyGZGL6UKfN1w1VBJhbJgVPKyvsVqK+ogWaptPT++DCKRczNOoL9wx58RG3klU
 73Z4jIDursMeYxNASg3SjEGD75IpJCdFaRXn9rlD4varLhThisRX8WLIlBZK8VrrwUjDzF/Y5CQ
 xPiLTM0ALhbSIldyrhflks4FCnCjup6s7n29hufL8iAe1w4d1PHIPRQhNdTYjdhxbj8V02whK8u
 iGkt1J0h2JRQkH513828g4EIc5bRFM3EStWKYGty1wFDR06dUb86mJyW2fxQ4gwdxV6/yBIgYse
 wxga7FVCp04jy8OdOdQ==
X-Proofpoint-ORIG-GUID: ewnK3A4U7GStw2jaCaQuJo6tIklIneCH
X-Proofpoint-GUID: ewnK3A4U7GStw2jaCaQuJo6tIklIneCH
X-Authority-Analysis: v=2.4 cv=bo5BxUai c=1 sm=1 tr=0 ts=698f6ad9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Z7Cru6KvyN3eZcMTe0gA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130141

On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
> > On 09/02/2026 14:23, Rakesh Kota wrote:
> > > Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
> > > The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
> > > documented as a fallback to "qcom,pmk8350-pon".
> > 
> > Drop everything after ,. Do not explain WHAT you did. We see it.
> > 
> > > 
> > > While PMM8654AU supports additional registers compared to the baseline,

I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
an actual name for the chip?

> > 
> > full stop.
> > 
> > > there is currently no active use case for these features. This specific
> > > compatible string reserves the identifier for future hardware-specific
> > > handling if required.
> >
> > All the rest is irrelevant or even wrong. We do not reserve identifiers.
> > If you want to reserve something, then I need to reject the patch.
> >

-- 
With best wishes
Dmitry
