Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC737CD55
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736961; cv=none; b=gSxZ1eyGpLN+EJIaQ9jsYLF4In2tJn6NQl7Zdl7vwBlh474rCLcM9TJgnArrHz2g0DF15TUOMzDr+VMYoXHCCJVwv57FfmD1XSFy3i4nNzvViM3XplY9i8PjIVv+GIx4bd5sc1hB1uHfM6qLzZ6oIWORV4bXIDHMxL2ygwErkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736961; c=relaxed/simple;
	bh=K8ekZJA7THTLn3ZUpFVlilgkwvxw/Mw6zqNNZdgLBb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6n7uq1jsLYlfutumRfXhRuxL4z4RkyY4sXmhuHtAXKSvJsutyPT5J6YiVK3ywnNfFhYr0UYuDFwhgYL0bq6coA3GmXgjVdgC3+dCFITQAoSqN1LePgFoTn+/BuOUyez/9V1qdWJ+Mzji99kGrfj87BZFhtQ4is7vMG0l4IiDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L50HHqsS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HdAdkPmL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L50HHqsS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HdAdkPmL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PD2AKU691683
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 19:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=itmu+XDGDMrVTyuklbP8cmHl
	NlCmn3eMyCh8ieSAYyg=; b=L50HHqsSg9ui0E/noT2ysx1/uqFXvF+x4DPLIobx
	U5FYqYbntnQjCjtsyQbbmdP1URdr9fn0iST52nG51iDqQ2kAhf65YmI2RUnow8Y4
	jx8/LCY7aARy7aSjILqU9JuD+dIJjb6PNfaCFfe9FT8LZdl/IzDnqqzmoP7+/TFB
	Rba8uo9B+Mr2GZSXdrZNkR/UKNCxoGDdNMlJ8/g8jEzqalyy0s5vig22dfVGza0u
	UXu7lSigF1bruV+C4Akn6fnmmqez3sJeplmRvV/Dtev+0nFBRkezk98o8hjvpFx0
	uj2C1KvFq4k1SE1g8splFvw9ocffA7kKXocOi7ZLkTiwNA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2h4wq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 19:22:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f69a1a9f5so24840409e0c.1
        for <linux-input@vger.kernel.org>; Mon, 25 May 2026 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779736957; x=1780341757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itmu+XDGDMrVTyuklbP8cmHlNlCmn3eMyCh8ieSAYyg=;
        b=HdAdkPmL/McT/VNkYysgFKuZUiWPOCJX2J6l5FEhDVJKngo13pkeAfljPUs8gaVblJ
         R9qqzAmadzIQ2XRnyX87gPlWW/9t5XT8dWGe9JWH+wBqw7sSYsSWWLf0KP96bDiO1bAz
         Jr5DgH+8D5ntbGgt5++Z8avOWL+8vPr7jrMSr+R8wrzIV2n1dIhMl6PMoKMxhPbNRNwj
         bwYcSXSTSav4KmO6xKfj5t8gMnNPUjK6D6J4OOlU6V8unMGzbgFY+rRq1v91eolONZw/
         3xL7KBAsT0lq9MFnM/x35i9+/8/GZdDYbRRjJg7MlqTavgRAOFLoIoMNFhtUfb6x2o1F
         9y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779736957; x=1780341757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itmu+XDGDMrVTyuklbP8cmHlNlCmn3eMyCh8ieSAYyg=;
        b=j1c4G1JsDwp0WVUpO+bipySniGRRJkNJlxa5xWo4UrC3mMr7yFvBl/xhi9EUXmzNQp
         eBSpwwRgGYfbwATk8u/34+so25ix8l1MZ+Qtlk1aq4KbTfQXPGzkNfEQ+1BNGY4fVsHn
         e90qe8zQDOdeVK4VW6Gi4XMkirQ1pgQrxiASaMkuEYAhGkl4vGxDxY+JidPJk8ChDReb
         Sb/WWouVOw9EukDgW5nqSCBdB/qJq1mHf0SQLhHXwHmWH94LKvuzzSuqug4i1SDYX7t3
         uHGLoguJ0bWUvRElLl1IfD0FuKa6xYb/+NAPkkSCXky1BJmed/4wsx7vVOx/NtQDy1ff
         CNLw==
X-Forwarded-Encrypted: i=1; AFNElJ/4dUqynSfYjpI6oxGNiMC9m+2aD3ycOSD0s/HUfEiLWV/H2jr63QrsW7POHgd3PYEO8jH4kcums+Uk9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+EtOToqtvPrGV07b7ziVCR1DS53n3MV5aZtifGRcTDKPbt99
	+uHe4de91sakphyXUkfvhrlsxE2TqYV8g62hlsYIEj1t92dh/95JEpM4t5tob5EYA3uwUNTRjPQ
	J30SRzgwsyjUN4WEIOPXQ8vb4DuGEu9itXETDfg7WRB67qim1eigbO0HpGJY/s/VsVy0+r2W6Sh
	f6DsM=
X-Gm-Gg: Acq92OF8noTkQH5tsFwegYhp/sL91BPgu84nxKTAtRIurwtAcbkLu6X3ctsuFMdI/tq
	HovewAN7rjueVJ+DOIsDpeqcbf846F/hBKmMY8B6NDIy9zTDMJbS52KR/xV9oW8jo+qcmRI092z
	OBHyCY00q8ISnZ6SVaigXL1D2+MCnYUcEZ+jciYhgqkEvSdaOVRJ7l1F6VqObnUhhtqetWtd3PH
	ovsueNhf3lTM5ZnbzH9EnK4VTbK8M9Su3UgqMdR3y+d0M0q0+HMK1MKRpsAo+bQPAcUjaCz2eOu
	bFOTG4KSQiQxdL3uc22BOqyhzhUVBrWJlQxZmJlsIe/X+jc+ukjn4yUgZPNirdfmUS+4G1eO1KR
	8VX9Z49gOlWhgWEYj3mqomCXR1E83oAtiI1ZmNCTUcjzbQS7OGaAcPFiuIEyDsPMgtcizVyAdQH
	0gTTG20HD+Lkt0sPkaDe29nKBv7owCNcm9P5k=
X-Received: by 2002:a05:6102:2a4c:b0:631:44d9:2ca9 with SMTP id ada2fe7eead31-673cbd0a917mr6095679137.13.1779736957303;
        Mon, 25 May 2026 12:22:37 -0700 (PDT)
X-Received: by 2002:a05:6102:2a4c:b0:631:44d9:2ca9 with SMTP id ada2fe7eead31-673cbd0a917mr6095671137.13.1779736956860;
        Mon, 25 May 2026 12:22:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb367esm2908378e87.7.2026.05.25.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:22:35 -0700 (PDT)
Date: Mon, 25 May 2026 22:22:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        20260519-glymur-mahua-common-nodes-v2-1-9f1b89a3f398@oss.qualcomm.com
Subject: Re: [PATCH v2 1/2] dt-bindings: input: hid-over-i2c: Add reset-gpios
 property
Message-ID: <bz6imhhfysbdqfushdcpmejyskkefcmeed3lqcugz5ajyteubz@dpwum3jv245j>
References: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-0-5c333051e5bb@oss.qualcomm.com>
 <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-1-5c333051e5bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-1-5c333051e5bb@oss.qualcomm.com>
X-Proofpoint-GUID: 3e1sdp1zTY0-bo89lCNTB0oQDzj5K555
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a14a17e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tnEVqwXQghL7X4JZ1RUA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: 3e1sdp1zTY0-bo89lCNTB0oQDzj5K555
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE5MiBTYWx0ZWRfXx2UKrtXtritY
 ZJLTsEEIfitW0BrBOkQdH+RIPwTEkQJeFUREYQDvk1AY1xJIWqAaB6KUs6xLTzB7vVuvtymmdh5
 cJmgmbfCuKlOjpeEGZ9vIrA9yaAKFWGqbFT1eILwr9pCH+lO+SJNo+t8HvUCojAXxyq8WLz7s1H
 enrdA2bv/tQs1CkXyG6nPn3Fs8ZQWdqRGJxmnagNwgXb6IXN+i9Ky8eVQU/y8cpxFKc9QbO78AH
 hNGkYBU/Xh+anfYpEv2M6T4HuxgjGEIJLHTeH6rV4VQsJUMb3fkX4x9b9Qkb4Ig5TvLV/DMfbjn
 nsI7qEfPZt36aFXYBSlp05tJRxXL+hezNtV2WydgPrmGlx+NywdwGOYg8imvaDDnkLptGVLD1gd
 OYppm5ZgeRtXX9LBzoAlPPVAzHhVFJoSZ5ok1dMyz6R9BofhAJ2J/A1mxcQ5oXiPJYLX1RufIcm
 6shk0nB3a78P5sFQSAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250192

On Sat, May 23, 2026 at 01:25:37AM +0530, Pradyot Kumar Nayak wrote:
> Document reset-gpios property for devices that explicitly require
> the reset line to be de-asserted during power up.
> 
> Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> index 138caad96a29..fe0ec4fce673 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> @@ -50,6 +50,10 @@ properties:
>      description: Time required by the device after enabling its regulators
>        or powering it on, before it is ready for communication.
>  
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO line used to reset the device.
> +

If you are extending the schema, where are the driver changes?

>    touchscreen-inverted-x: true
>  
>    touchscreen-inverted-y: true
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
