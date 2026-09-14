Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE447F78C
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395685; cv=none; b=cTxOcYr1EV4icBA2uSOl14siWDUSfVgYoljD7yky+YxKckjOK3jeNEAi8t2oMu++eRK0jCzDwm0ULERQ5pX1Q/7Os6wzXq1VEhLktThWp4AeCrULQChCoFpH7Ay7CY1oyoGf7rz55ZpnnRN3a4ErW42CRu9SJDRcOreJZ0vGBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395685; c=relaxed/simple;
	bh=qpr20bFoWIAVz6Uu6SDBY1Onol/yGpj70dm5w/7HmbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdcAzxUUV30qMpm8RgIXDz3gNJDuQbzKi9m5bUc7XUQ/Qo+LE53S1xhwPcX6dOHCe2kfVGfUVZF+TiEWrLVjcO7RdPDjmivZ8tsZVd2iOwXJflTSv9bD2tXuLzIRDI2zWCFcLe4FTr3wDoP8FXgutQ13HGJCS/YogiFjn/ACGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAA0sVec; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZQtb65n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAA0sVec";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZQtb65n"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0vA9138413
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hsC/n5G/ysH1TDMPqrs15Xr5
	Fe1eAaS5X/4GfDOh5vA=; b=ZAA0sVecotuQbIutF2EPWz8avV8PBXwK/D22V4EB
	T7JIXLLQ1Pw29b6EVFSY0wTE0TlLHg8qvV6Ovch1DnuNa6WKDmsBAgDOqC5PTuHw
	CixdNiZOG/sxPSsQUkr2Jpm8dKWiAr/QMr+AD9bvsFRLx/2dX/P8Syg4vKCUUFV0
	L1N+4XVPHfeVUI6LLy/0yu5JJQapY83jolFHwcayTw30aMwBkLJUNgcQzrjDmiuy
	EtLVZFaInA13UVi4sYGXkQg5Tur2Nc3gNJ1GHg1TMmmKRltzL3ZNdMRdbhd0y4qk
	MjDsMNpT3yqlYInbKgzhkCs/Kot+rkHfPMWXQuX82Ttt7Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq902h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 14:21:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-792f917d31aso2773073137.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789395681; x=1790000481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=dZQtb65nHQWP/U+6nd8BGH73mm5a8w6wz52rIwnINgZABoGFTDTakG+dMqia/1/Dvg
         9RS5uXK5f0C324qddWAmOuCAEiGUTZvamsJReUOEgV9KWNx8GyPixE++IPNCq17wsaSm
         SXIBJZMGXuAUkpgDIQV7TLwWtBAmrK9Iwv1cpciZXhUX9kbixtZf6JQ4cIIqiEtTHHan
         wjRONlkdE6Fnd3odKhr1/ZqBG/alF9p/1EQOXWWJ65iZ7Y84RUjijBfHQkCAAXtSiiGz
         c9J0VTg9bY9xZ+OJ+2DvswPTRocLXSH+vN4LhIa37qX/Oz06LUQZeQRaReogwlSzrTbz
         zyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395681; x=1790000481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsC/n5G/ysH1TDMPqrs15Xr5Fe1eAaS5X/4GfDOh5vA=;
        b=cqVZeYmvEzNN6s5l55fe5ZF86F9rRnUAx3HjcBPjbgt2LeB692v26n/9N4CSQ5NTWo
         QjPMdRGGpLTeni3205g1E6MwTGBY/sYOU36VeIBMb5zjkjb+9gI85zQf7JijqX2HeBz9
         t4Y6/x900OcdLOjdPJQjqT8PJqFW8fWYKt/reBlCOvpZ4UR9MngOCNfcpNAx7qEMYMZi
         5Ugi51y3Jco/dKM91yQW4SqfLvP7hTZzCCEZTrmCqHjm/GLRSoW/TRi/FQgqWZV8GscZ
         cfw4nY8lBX2c3WeJVeWDi7BmvgI61XiQsQsIF7hP/ssYwxYHQ9057r1JKA2YFAx60XML
         3bNA==
X-Forwarded-Encrypted: i=1; AKwUvByfJDUThRcR+Pou44AqDIAygXlgtCXgM/rk/UhXUfXfKTWmRAbALuiDpFU0M41R7Y/YkCyDoAaAl3j2Hw==@vger.kernel.org
X-Gm-Message-State: AFuF++mzFLBl0HT1xhL0OYWJuaTxq793sAu0HseGMLshPCbVFeK7o3Fw
	Q3r+mmBRVTDfiD1twaPqGAraQ4Vh/CSYYCJbNvKW+cMDWFye0VZcxQjkluiaf0vxIEVpwSf9slI
	/a3JJ1X30N7+afUbkuYzrPl45lGaHxMMcwtUQhTt4evLz0gavRtjs9sDddwFy/WGa3w==
X-Gm-Gg: AYBFou17UkbM4DS/uu60/gomi2NWh+++wI/uYZ8/aWOoC4g8RQxbS44mBnzlax/5MnU
	7THJrb1XFQkHnw1matxDpFsjeMWFQW+KWcVrO3EzW9DShi6auLIfQ1kbU2Jb38KvYfrMEYM9NGo
	kKjyCTHFNkkycmKF/1Ba5nMGYCS9XXrWTvp4pd6+RpJgfbeFG1Cv29iX35aceCtAleyNXGGmWWZ
	wKjVRxQojBPWZvSM0aBA/zcgHEw+FfPhWQDvr0xl+fB7MbY8Rk0y6vZjWY/kmYXER99M1PoAbnZ
	eWvUrnbAI7/sT5kTCD8X1SjGqEc2wSIljNnejkvbIleQGc5ZguqvaGn5X5t+HYXsTHRubgFurQn
	W+N38CTvfyxcV2Zk=
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1731007137.0.1789395679763;
        Mon, 14 Sep 2026 07:21:19 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr1730677137.0.1789395677612;
        Mon, 14 Sep 2026 07:21:17 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6499d57bsm477423505e9.3.2026.09.14.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:21:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:21:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <z7rjt5237gdtytb35chtyjposyvqpgqfsxhov2all4g2527aix@dabjw24dluwa>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX0rQdBXv1zCeM
 xypVjxI4S4Q9DdBs6SSv8bjOSTdjJzqFPFKbNxnGDOdsiAhUtiiuTfigdokG4Lix5eA5tOKkY3P
 RKZjErO4XS3XSrM5zwSmGNoxUXsm0asQBV3C59U11Ib5JkCbifxc6GDMdgdDJjrmMnYRTfqLLzE
 d7pbt8FrSthB+3RGvBkZBX3IgYPThnAefqsYsuCSUMNTtUjhgC7c44b+9XnvGYtgpXlFWKjCUSc
 kaQ6fLskDz2FrIzxzFpp2gJhZca8FYg2GN5U08FnZhmu6excAGettsXDgl42xhelUmXf5QRWXhy
 7jSmrXs/OWRnW+ecnciOtMPdjoPczUPuxiNS0nXf9lNGjIMgwCko4ekl9hw79xdNzemTJkj9Kmk
 3xwz8rKJ1PHi9v2ruuKIYPH7zyjE+cWj01cMIM2whvmjiIjpN/2YXfe0hvGxX7kQm1ITkj/MmoT
 0rBs827sNkglVYgKR8g==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa802e2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=CjuIK1q_8ugA:10
 a=TpgoBOgV9RAA:10 a=gYDTvv6II1OnSo0itH1n:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: N176WwwOn8G_1WTGCAnc8N9l95IyFvBV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNSBTYWx0ZWRfX6ea4APXRVQ1L
 RtAT4KOIi+jTBVr7huXuUJlihHDhdx49lo5GsjmNZWK7t+HVzmlVEHDHj7wGBFYRvmwdIuFzIIq
 K+otEjhrJPYfshOeqmxV8+rj23nCEuA=
X-Proofpoint-GUID: N176WwwOn8G_1WTGCAnc8N9l95IyFvBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140205

On 26-09-12 11:39:24, Muzaffer Kadir wrote:
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
