Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F445A290
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849753; cv=none; b=bAKUztVrw4l+2SxBxtwB98cZve8Sf/+EKnvo6SwXO+pqWPiLAyKX9bS1gTR2G8PpkaXVQv/1Nq7DK0AGON6P8nelkSz2tdKIIIUEEdbayFzwt+hoiL/P1Ktyh+IYt2j63AA5BkDAW/9Z2uYDfNebwdxDdZmssvL6fbgydQLCXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849753; c=relaxed/simple;
	bh=b8cAENdW5UBfeKXGM00Njn9NJat57NtDZ3mXZlH95q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRgQoHJZ2iwnB37Wb4oTRVSfs963OecK//W6r1GnTA6Adg++Fl2lAnnQ+dOAKft4QoQaKuK/eAxm2UNWmzCJX+XIl1yBSmG+Wa1kJ0cVgKhMAEvUmY4v4ArKJaMYj0hsD4FmKPwTDoDMG/bXoRjvWxNWN0lebfh9xQCPnt/iYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pB8dDdrl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cGRPTpkz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pB8dDdrl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cGRPTpkz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXVT84144185
	for <linux-input@vger.kernel.org>; Tue, 4 Aug 2026 13:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6cKta+lz1loaE7DVGHn/1G5j
	fGz45qD/ucV6NNVBOng=; b=pB8dDdrlDMcXRAk6hesoh9rlsGWYY34gISGdrdbf
	XbdhVLwKRBzU88GCzfJBw0cD+Vn2rKAy3kIhIkb3FZMgYZHX105XXIhNETvL0SuZ
	E/NQchlt/I/itf/5IQU8igTQ/1fJxK+6h3Y4oE6NKUPXJ9GAQILYWbbUhYsXy89I
	8IS+Nr8qGROBQWenmemWjOZnahGHpCtzWg47vmjRoCH5THqPJv2siQQy6rwRp6Do
	yCAeirE9IYXQxX0kvbDOf2YTa0JiI4wWdpy7iJIcFkICRJvHHuyKdkUC8BXGEE/y
	dlWU7i2tGiRcDfBFwuO0WOc73t74PJVJewAapYnVVaPIVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu3vs358r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 13:22:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so48497261cf.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785849744; x=1786454544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cKta+lz1loaE7DVGHn/1G5jfGz45qD/ucV6NNVBOng=;
        b=cGRPTpkzJskeybKCadKWCwt55YWtxe4tJKuCDBAL7StKWrB0VGGc2Axy8fy4gyeraJ
         euVd7ISKFANRdNICune3Br4jkLL02yFa9WUYQMpyvXqRSpg/mA5urFHQSxvkpguUiNfx
         YjU/gx2VRRYVO/jEtCfeILt4Fe45bhKaq1hf6C+71ENBsiaJPYY6k6Le3d2MBkq2M54T
         vGeAP/jiJYIAzZMi2YypzTOhI1Y9OWaYoKalR4teu9o5zWQ3Jh3X+pWJKU9bA1lJXZ1i
         xO7wVmwW5AME3hgGy9w6qO6Dkp5NJu9kqY0f96zakcDMNfoOEfcg0lOk3gfuSHgMp41h
         ppCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849744; x=1786454544;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cKta+lz1loaE7DVGHn/1G5jfGz45qD/ucV6NNVBOng=;
        b=C0pnjS+XU9FRVIdFJ93k0vWA+LFQiW+hbTiriV6vIfP7QzwCBBiVoTw6XFSQb/aTmJ
         ldjll6KJB5id4i5+zCPR57MHyjA9tcD/HUpq52VgfqGF7LyDV+IZV/fBl6EKZhug6n2r
         P1Nn/r+9ZIrqz3owWJHbu6FEoHkyBWXZ1OUbYJf7Dm0SONTJ/g3g+jrjj97msE+gi85i
         tQ2GaH+CZFXIlXiNNY3BgwHZ1USbcei35fUlwas2JiklCc3V2PPRiI9u4r4ota13H8WG
         Wx8n2lWP8jZuMqPKdNaX8e8OwcR5iKN0owQdZEQFQ2z5/Y6OcGhNywOV+CdsCKPKjI8s
         VZZg==
X-Forwarded-Encrypted: i=1; AHgh+RrmalBPepeHEgh5SVbAYmKO/vDOiXHNVhKhwwl6V0vdkA7TI9+I+gN0Z1KeA/NhY1z0qysxSF5wro1cJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGGKRa7+77dLfV5wai/rdBeE3iqzfBjvkyUvGjePTiSKUJcMU
	r/sf+qD7Y2WRpnsU/hTQI0iMgGTrfsVRZI7gMqYxFBL2LGOx7cSl7ICFH+1gYf6X1yoP5urbRpI
	jprvkRHn7sj4DVxc/PzwzOQpcAv/dL+OBI3rhDfbH4z6Tx1YB4n8s124sExT/6QscE46ZPPZ9gt
	u9
X-Gm-Gg: AR+sD12Nz8kbvDf/uDiXF6PUFy1fzIok1ph2xC+FiAJ/N2cm/1Rzh99jj2F/6AOe0Gk
	I4KKvE652uAWIJ41JTLYzJlKJXXSbovxDt4bWdvwoefAX4z6PEM/pqjAotBjEnwZnTJ9uPonLtb
	hF+Gfd8tZskvwlMrtoLFfSoWW7A+/9Eh66CAap4nr+rj3EDBsPU2woDUAlqXacAFh2eE+oxA5JT
	0WWoHKlEB0Z1+ngIZKZphZvPqAzLxn7qXXUayGy6bYeYeV+2xwMIU3ObWG9N8MEEIPetery8Eld
	T+yqk7HhWe8UuNN45fRt3UEBgnZ7IdnwJfP2Wwwzh4OcdBcQFTnxDiPNk/Awr6bbsQ58bOGEAX9
	hf7uLJOTd7BuVFg==
X-Received: by 2002:ac8:5d93:0:b0:528:15e:d1d4 with SMTP id d75a77b69052e-52b56671733mr224087621cf.4.1785849743968;
        Tue, 04 Aug 2026 06:22:23 -0700 (PDT)
X-Received: by 2002:ac8:5d93:0:b0:528:15e:d1d4 with SMTP id d75a77b69052e-52b56671733mr224086691cf.4.1785849743183;
        Tue, 04 Aug 2026 06:22:23 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.37.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm88266385e9.13.2026.08.04.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:22:22 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:22:20 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: glymur-crd: Add FocalTech
 ft3d81 touchscreen support
Message-ID: <wj5vpe7lhcvvj42wndplekctfjegqpwzupwyqmaw6wf6rhgi6b@maii6v7rz6l3>
References: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-0-5dd091e25801@oss.qualcomm.com>
 <20260717-add_focaltech_ft3d81_touchscreen_support-v4-2-5dd091e25801@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-2-5dd091e25801@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfXwKYUFh31wTmK
 UYgt/y+dhCvUZIQ1p1L//lrH+4VQr6aZ5ufB71DtdWH4qnU29mMprajIc3c6EeARF5asK9FWYFJ
 TY20dxKakhR5OOipog4MGbvtHxViiJhe6k2O3uCqCtGEtOzSrtjtGKiqPvgDEA5QHiR51eryj59
 pBQN9kF8s7rXhqPzEMKQDA9aQV6Kg2uwiOjRzdRhiifopRjurF7G50ueBUGCLAIM0nkmWHihRM1
 xlaVlu+0LcKN9UNmPD8Q1PwwSMrnPnvow87XlWceAMdlrUxmIp1gphNmcJH4jdG/NmTBALhksdk
 turDA24QOsAob3/Y9fuIIlmSGngmH/Wv2bAMAiDjfJaNWpdkL8/UpBRk96ULYDYOLn4gWeHD82E
 ZJrB9X9ylFdmRuljVWpFP5vEMGpv06ql9Qrwd9i9JqKc5FFJp1Z28vOV/J2jbCtMpHSA5bI++vG
 0NfkoNOU33Ggh2l9M9g==
X-Proofpoint-ORIG-GUID: 0T89y1CH3jBzTboYq0FbyNOHB1W2yGvt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfXxDRArLO2fRGI
 dqn3u+IzSBIYxZ3FIuF0WYQ99WyJBXAqWdiXLx6C2jwvAKKQkQoYW3N6GtWgpQP2OFhHWlJIUge
 aAWMhz9DyGLG4FC7jYlU1HBaBmvrs+8=
X-Authority-Analysis: v=2.4 cv=EK82FVZC c=1 sm=1 tr=0 ts=6a71e790 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Afnz6uBANMlDQL2PJxecKw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CtdSQDPJOJc9UmKi9akA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 0T89y1CH3jBzTboYq0FbyNOHB1W2yGvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040107

On 26-07-17 17:28:35, Pradyot Kumar Nayak wrote:
> The touchscreen module on Glymur/Mahua CRDs is different from
> the one used on Hamoa CRDs and requires the reset-gpios to be wired to
> the device. Without this in place the reset line will remain
> permanently asserted during resume leaving the device offline and causing
> all I2C transactions to fail with -ENXIO.
> 
> i2c_hid_of 3-0038: failed to change power setting.
> i2c_hid_of 3-0038: PM: dpm_run_callback():
> i2c_hid_core_pm_resume [i2c_hid] returns -6
> i2c_hid_of 3-0038: PM: failed to resume async: error -6
> 
> The touchscreen on Glymur/Mahua-CRD is a focaltech ft3d81,
> which is hardware-compatible with the ft8112.
> we have added the required change in DT.
> 
> Fixes: e6bf559f7eb9 ("arm64: dts: qcom: glymur-crd: Enable keyboard, trackpad and touchscreen")
> Fixes: f64ef325f1d9 ("arm64: dts: glymur-crd: Add reset GPIO to touchscreen node")
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
