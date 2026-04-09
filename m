Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2573C3C1E
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738480; cv=none; b=RcXLeDH3XtiFPJdZz/TV6tyoJpJD2IuCFg4n7GoMeuqN5RV4aSWQ+iNAucUpo2U7UggD6gjmx2N0XcPBwSO6eZO9skkkJQ08NCVPUX6tCON0Tu4AmlGBY88EM1NOt9v5inMplD+FKpjqSq+CiKe6gQl2omk6YGl4qUcCxtL1gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738480; c=relaxed/simple;
	bh=jIcG6VH2f3X5MPNz+mmqq26iaNfbbftnboMVLVcU6Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWDKpTocznPlUwE4Aa1ZzG3On/22miRypReGkxDboVd1I68hsBUwgHjL9OP2sQCBcnOfcgLouGhemv8cHKRgA1jGxu2AXjtglw23uC2aRT8z2f87hHxyI9W2iACHmENS4O6RSfI0RWyF3hkT26p9SVHnsgVKSAsssbDUyT5IE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mEHu/BVJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=agSbRofz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEHu/BVJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agSbRofz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639BbWjT254985
	for <linux-input@vger.kernel.org>; Thu, 9 Apr 2026 12:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+5arrzvnS3rtZCFNC1+2oTuK6mQoxDzomGnG3jOxXM=; b=mEHu/BVJg+KXny1x
	vPSRoyrKYI5XXWJTlHc/O9kjFj+/Hu0dyjfU1Hnn/tkvEJ3bCOzJ1AS4c2iqiork
	Z7c4Yp99uj47pPtZQJVWt/FAB4VoumofVxyzgUNe29EWZQPJ914iCp1ziVskOKL2
	QD6lWoJ621QS4rL0SAqiljpNY335Z1DlkB+q3UHaKOj5S6f+e/FnMnxPKGDZ94QU
	fcU13AqDxnqxvW+AW2eykVp11cepSzc9Y1sAHT/SaMwuenN+tNoc2FMojBCOU+nT
	bZgLk3kZdYA0N8xyEDjkFF/5WcqqGxox89+FAjgnwr5O5sakONNyMvTA/Ki5Mq44
	6QR7Kw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt6yc316-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 09 Apr 2026 12:41:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfe29579d5so13663185a.3
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2026 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775738476; x=1776343276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+5arrzvnS3rtZCFNC1+2oTuK6mQoxDzomGnG3jOxXM=;
        b=agSbRofzQBzhalyx4zmqwcqUizqtfu+8dGtapH9Mqno9BYbIEZY7erAVJhRdGT6m74
         7rkhnqbV+y3GrfEz9X7qbDCQc8/SOXyLweZKRqPAqy/mPLqDMHgB9ZChLcbg1vsBePa1
         7gPWBoh12pCcCI+uHVtuNtIK9DxPAkoWieLHyBt9jN2nS8GmouwDZaicAklJ1MJSoI5h
         UJFj9aFFqEZSluwP6SO8KgpSxIgbivole6ujLniXeNCT0i22ohvVR/AMaiBc4LPIzHAH
         /euzSC9RPSNLNL61epmn7764Gi6KmFcIbDNY53iVzJJ6V40mL3/VOb8ATmaXLX4qDAxw
         J28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738476; x=1776343276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+5arrzvnS3rtZCFNC1+2oTuK6mQoxDzomGnG3jOxXM=;
        b=pF5VGtIJ8G2aEGBHWUImQix4rINVH51RgDwkTF04lhVipUEj3cscUzNl6tRdbEVmDD
         0F5pBKpEllXsLt5VlDieM/G8kxk5XEkWET4ZKIRY7jTweYiu7gOfq2+MtGgBkJQHVdNP
         zxNlKv67H8hXImpQeWwu/N9h3N18u6452oS5XfeBRJAECDBNLdCW68/EJcQp7VAw0mOA
         Yh7e0dJ6e1AjunJ26VCXgfRoODdn9+RpzI9wKLbQ0BGC4NTJrGVOyV2h6njGPXdgj3pk
         dD70y0M/WEXxZYaztqyEWjdbMiQ8b3OvxSRXRTQuXW+P9ejrBG+PfEG/fmrp+JqOv/SA
         6hIg==
X-Gm-Message-State: AOJu0YxntDu2r44yAPx44AW7tqOhCechh2xDJVcX21+rSbKrEMf6AAYE
	ArxDAa87zn/4sd7j0QceGY2LNEPejOy1M0/dO4pS4ZGXSjDiuuEimbWfaUerxDUBoHg4xChyB1K
	cWdsyrr2xFJ2ham0fCaFGl6G5VkH4WSGYoi5ApoPjJOyZQH497gie28KkNFmF5zzdig==
X-Gm-Gg: AeBDietEVvu5yZ6eqjd9ojBma7Bj0SUOsB8SFgIgJ1IxOwJsLpz5seF8Jm/2cxBNdpS
	4Gqbd/OEjNxVBXijL0/YR7lvK2b7GR6y8BPnBE0Xo5WQj8Qg2O8nsWH4C8KHgOXan0fWmmgXcfb
	rd5U96Qie1GM76neqWYi9F5u+Af0yzY3q5YYIFF8/KJ5IQN26pKo5+IsLedg8NDQR3XVHJTULp6
	A2/9sIBtmnunVcAT2FscExsMg5iGKmSuw5SJBPHN41Ksiomxu/XmiLJozB8+6h7Wl/9H2ayxXUX
	xpucHLonOp4HWoGaE2Mst7zez/ObDNHkKgcsQxzRzliVoikI6Xg0O5AyjhrWxsFl5NH4smEQOVt
	UFfbsVvEQUx70zUYtXOKqRjfmP0gRU7w+/eDpAZt5PRgrnSELLIOk9mwa5FYefbrVC7HyaHfr+V
	vgIYo=
X-Received: by 2002:a05:620a:2682:b0:8cf:d2be:5796 with SMTP id af79cd13be357-8dae2489c96mr821418985a.6.1775738475987;
        Thu, 09 Apr 2026 05:41:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:8cf:d2be:5796 with SMTP id af79cd13be357-8dae2489c96mr821414985a.6.1775738475540;
        Thu, 09 Apr 2026 05:41:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a74e8sm5705345a12.16.2026.04.09.05.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:41:13 -0700 (PDT)
Message-ID: <80067706-1857-46a0-a281-7f4ff3937468@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 14:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845-oneplus: Update compatible
 to include model
To: david@ixit.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
 <20260408-synaptics-rmi4-dt-v1-2-2d32bacce673@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260408-synaptics-rmi4-dt-v1-2-2d32bacce673@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fFSMpASVxGYMaIqbAzC2L4iNHB3rbhkU
X-Proofpoint-GUID: fFSMpASVxGYMaIqbAzC2L4iNHB3rbhkU
X-Authority-Analysis: v=2.4 cv=R9sz39RX c=1 sm=1 tr=0 ts=69d79e6d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hp0kwjZ9wkirG6XhGIUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDExNSBTYWx0ZWRfXxXtUjSSpcJSW
 8QIa/S5JMlcqZjo1YV2BLwrLIpQujEBn5juOAWudGIc/+low6XW6jpxI0omcQqevBBTEFYOjZnO
 2FJOoEn5yRYJFOoZQlbOAfWHSFh+rdR47/GLTr27KBF7D+Srko5gPwMkpQjJexwEUAI/bmoKYHL
 RNLj4M0HlUkFl+XMFqt5iuPo7YwIAYgUHk+1gu3/b+W68vNmnKVi6tRPqwTX8PzAay1p0Z5SD8Z
 Qn4hoe84RsTOFR5RNS3lA98N5P++zjcc31zLV0FfwSJeeotfPFhXI3ymxIO/+c59p4N346pXy/4
 WOtu/2ngStP3xI9f6X9Sk6Nuuq3oDcAOdiBBjEi1++4shn1zMEqEzg3SWkyd/EgNTkBCcKgUWHe
 WermzB82OdfNpVawJLv10YTCPZODkvruFgSoOIUm62Q89QCHHSBJFzt5Eub+Xf/FA9Ic4hr2CO3
 IiLdeDTbzmXtksZ3nfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090115

On 4/8/26 7:34 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> We know the driver is reporting s3706b, introduce the compatible so we

via Google search AI summary:
"Bon Chef S3706B is a black dinner fork (Roman Euro Dinner Fork)" - the
more you know!

> can more easily introduce quirks for weird touchscreen replacements in
> followup series.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
