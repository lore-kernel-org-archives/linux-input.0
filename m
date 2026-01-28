Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF61E3DE5
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616409; cv=none; b=NaNci3SVwmN1SJtYc+oGR54bDyoQ9BDnSZBQPw+moBcxnK0xRgOAqlThrcHa1i+/+c2XmUAI5wwJtNGUxJcCmB7E8X7X9k+W8b2JRBlWbtDrSZqP9Z/aQgo2D+N2SRGjPB5qWEvKpEEVm2TXWkTpgz1L0E0rUHj08d3QnFvqhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616409; c=relaxed/simple;
	bh=VW/qc4m7QYnWq8rGr+uR7X5ZxtSgkDmixXSRRjkvsXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnyzrR8rDTTKHDfu7pD8i8jqjGyodDIkOiGwcUCgtMhqtX+vO3GdPNCvGZZoOt3cmGnkYfcj8COppqFwQGCvipX9bHCHvUXtKP6jjR3Kv017+B1VTu3c+/Ze5zKOLONg1BS/M4BjabValcrPSX/45UsQMIMtlkvcwmzSwYT3QHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nID9qwAg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4gtpb0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nID9qwAg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4gtpb0W"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFc9eU3442358
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 16:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XHLifZ9wwYI+BPtJUCR9DVIO
	9WGqye4RlpIupw/JkLA=; b=nID9qwAglbIqC48REmyIsR5BGQea+I7x+m84TSH+
	bH/L/m654Lj4V0/Xyp/5QMa/G8WfZUw0pTjOTK4E3rVFRTnDOXW6U1P8dl29W5rH
	Yj7MHAnrV9MrcBDc6QUGZLtCLqUHDJFax8v0CmdPSjEYkCvQQG7e5G1CO02ktqV4
	hbxK7Fp6MWJJL3F1CvoCosHwKXfZsCCgIG6XH3tzyD/JtuxiO9UQ5d2KSXPQzx6K
	HfWMCEumtHBcKI/YQZFDLJODITOHF+acpXVhZrPPHPBCAB13LkYTNEsjQaKVgQ6q
	uQbDhdy1ns5zwTvOCOfbhYkwyGxQVTMototqE7Cv6B3zHw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byanajey1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 16:06:46 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56626b89e83so7236814e0c.3
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769616405; x=1770221205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHLifZ9wwYI+BPtJUCR9DVIO9WGqye4RlpIupw/JkLA=;
        b=G4gtpb0WpVoZy4gvVWWHo6Ex1JTbajju6N0WeCrhZL4mla9BcnAWsyiuvwaAJPptuU
         UqWLmY6gdjjFro5T9PrWqgCzcL1VhxYuzZ4IKM8ypgbPUsV09bEx3eRyDz4OnhpUGwN0
         clYcRh2WaDfzV9KAV8jPlv2pNlMalhsRbF5JjH1vbAJGF3Xe/5RX+Nb8Z8DnsEnIr3Mm
         yZBWWHO3QiehU6qM/T5Q2e3s6VuME0ZjiplOU5j+gvt2eHtry71ZKtkatA/rw7U1CEHx
         V914fWMI8LfmLi9Ef74yH9zQ51o/z0zqJb1ct6RTwJMeMei8NGQ+hPcmAYNi6RQi18hU
         aidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616405; x=1770221205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHLifZ9wwYI+BPtJUCR9DVIO9WGqye4RlpIupw/JkLA=;
        b=p7G2aLXwDD1NynkrEr4oatIgEfDlIJBhmrrEuwqt3sk73adOZXg+2BLbo+/2O7AFrb
         iZ5UTNLwAS2AH5e6TnUpvZoL3FkbT17bghHlXADpvRM4JpOkx772JUsMzFWmTH1LrKbe
         jnIxrosYxJ9RPoQrY0vB85kOYqEB2pv8qKYF/KWZFz2oK8VK6Vpmrdtth9wHi7Ei9hxM
         mswTLwE42FJnUo0qONobq1b4oLnDxVA41mlRJmqJE3q6LdW8/1lLiPSS16FQG7Iuf5oP
         fRxueQIvOG3SMzQaRA19n2E3+smZ4+HoBVV3TQvOiLG9mGC3DSiYCOktXqUv/0LQT+1X
         jykQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmKGz+u+W5I+Mdn8qIwS2XhKYiZHkzsE1d9bP1wqbpzcSGy1Tl6xzOkoh31PkTLH9lpQC1MD/qoIY8BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4P9Rh0ziwDUnlP71hJNW+ODhxA83uu6vyFEotlCnelIkkVsp
	BibnKOXuyo3C6x5g/EeF9ubgU/Q/Z4DbX9NiEEhfrEMxuh9JHxBS8UQ+l/QLnBwGDv1OEL6L9Q9
	F/tBfahRNBDk3jzEJK2lQrZZgbmvlzSO/ecnNwbcsqLf4i+PPQ2mgGbSoL8LhbvTS3g==
X-Gm-Gg: AZuq6aKkY2+Vic+ripGV7VDPkECUzsvNlVbGlr2YaFe4NfvQQPBIkO5HQ4gX3aFuafg
	Vs1u8nClZXOH8AJskDaoUgyxJuTPjCLPGyjA/aTWdovQ00xXiOHTQaSBNcZI2U19YsTPUEtmO7/
	RNKiVErLSF35rqgS+JAADVuNGMRCJZ5Yo7o5hkFC3E6PGJuaHgiM7ctG8hXCoWH3NHJduwkxq9k
	dDXPE8q841X1OfO0QuksA9cYDpT10KU6yCu2v14zfKPFe7Sk8/n7tlqEaHWCCa08WuzgMP0jNh0
	65FxnkkYbkJ8I36RdFjt6UTJkX2XZAE13VjG3Wsx5hxKs60V4Z8UwIF7mF52wM4SSfr/LDYX96V
	32a1XsbF2JQsyrohLpMcNl3EjYq7JQxe4nUvi/KV+vQ4s1iI1/K5IOjS0Q6PpMj/SHlP153c+E4
	iJybywMTIyFLFNTBpw56Sq7+Y=
X-Received: by 2002:a05:6122:210f:b0:566:24c0:716b with SMTP id 71dfb90a1353d-566794a81b7mr1704499e0c.3.1769616403852;
        Wed, 28 Jan 2026 08:06:43 -0800 (PST)
X-Received: by 2002:a05:6122:210f:b0:566:24c0:716b with SMTP id 71dfb90a1353d-566794a81b7mr1704396e0c.3.1769616401913;
        Wed, 28 Jan 2026 08:06:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625f6c670sm4378361fa.32.2026.01.28.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:06:41 -0800 (PST)
Date: Wed, 28 Jan 2026 18:06:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: milos-fairphone-fp6: Add
 vibrator support
Message-ID: <w3e3weyxdp3bi6mlxa3hvtmvbtuyddaj3hfn3urhixtliejhsx@h3wqvscon6n4>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-3-b51ee086aaf5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-aw86938-driver-v2-3-b51ee086aaf5@fairphone.com>
X-Proofpoint-GUID: Wq6eRS-QUrf8FpEmBzEg_P80YPQ0mRnv
X-Proofpoint-ORIG-GUID: Wq6eRS-QUrf8FpEmBzEg_P80YPQ0mRnv
X-Authority-Analysis: v=2.4 cv=N58k1m9B c=1 sm=1 tr=0 ts=697a3416 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=7WDzbpTNP48-5iC3XZUA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzMiBTYWx0ZWRfXzJBFz7wEEVzL
 wKaMgH6CAeNV6MA0x2obYJA+EMmsoIFADORM0k2QJ8TN9pIWMloo6x0AZaIbScsM3KR3S4e85qC
 1jWoLz+sv5Fa+IkK4CvVmcExu8WLP3GdL6+lvma5Am4LClg8XdHfsGwJpjPuWO1ypP80s/JZHoM
 zDWGso/GMDnZbZEHoCJPWHFQ1buPG4rkPYC3bXFJh66uOBZjsXbntyh+Tnp0K8TuokT7v2agUVz
 HTAohU5fn+o1WEU1ULagMbd/1VKoBIAmH6DGBe29T3lOEmZOryyXj9aoO5UFBzAUMcC0Ue+d5Ln
 bNK2JMexyLXABsnzwVSCfuG54PCajw6v6FZETh+BGOcbEmEypfvCBYxhjZHgW4ZDk9C0OxKAZ39
 YpP4dggp5K6IxqartabtIgx9+0e6cMhd7pKycbsPvVoPXBtf/I/rtLMestFQDyMZZjtDCyklJns
 wfO1/Do7z29e6KMkowQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280132

On Wed, Jan 28, 2026 at 04:51:15PM +0100, Griffin Kroah-Hartman wrote:
> Add the required node for haptic playback (Awinic AW86938)
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
