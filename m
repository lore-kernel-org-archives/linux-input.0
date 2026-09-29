Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4552BE55
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688871; cv=pass; b=LxXVk+uvMjAYdiC0NQHkeiVtOdch2W2qvapdm+a22CU7XUUNk2Vu8x3N97g9vREORKjN+ux4wwrlV4u3sJAmT+W4EGXBeDhmx/1NvV2FZmHi1n751fvAuEnA5h3ZGcKbAK69yLBP4UZAel31UBoymJu4U2qlLhViqxhMkGIOUWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688871; c=relaxed/simple;
	bh=aatIQCpb5b6E18tOT607YiK+lREgF4JTQbKPFrO+iVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBQB6ubOErzCiNPnC+yXzxVCFmZA6/lf0BGsVMITOY5hoKfv3Xc35rhvTlKSfNuwTG70HguQ0gbin/NvJSLf90m2ffS3aLPFFREbMsTBaOW5hjN24cMMXPoOajwS2A+V9LCbrXnGWAvWaZSiNsN02e7n2MMSmjmUYwT4jWmptwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hk6mvLlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MnW5UteW; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk6mvLlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnW5UteW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqeGC349948
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=; b=hk6mvLlVWv66MepN
	iXjqUBQgGPOer5qnBJte12x4wjPvxOCEYL7J06CYjn0EHwKp/mQIZhzGf/7PTCrr
	JPVMRa5P31yNjd0syZbjgMb1SqSQl0EhM88wLqYun1EFTHMdFhjcUQaYctLQJvLB
	m8rrLNP8N82Uo9R+rz0dot2NO2Ag+BRrRZy3QHNaATzsOSBlDlmyQoF67xxVYAwr
	6AvhbgJpiztMCqAaEVjfmc1yrAp8Qnex8FnEzTZH2Oi00Q9D6r5JmaAxiFebRClG
	r3l0ApPic+NoNoV0+qGAVh5h3Rn6Nx3BILxnO83SaAFd/J++STdI9TWC1odBWbQy
	41skTw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkk2ef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 13:34:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so9309237a91.1
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688867; cv=none;
        d=google.com; s=arc-20260327;
        b=cv9N6Cqv+Q6mW/gH6Z9NtnEYgu+4Yo9MEsmETOl8T10xovO54k7mdigt4iUX4Dr8Vz
         lWO1BRBlNOhrEdrKbn4giOM73/IfNErLux94PJtt/V9DSmCAWYt9ckec8X7hfC18gedV
         YbgEhf7UT6gSM0dvCffxBTjAMpbD8YFFFTgAe4baBWbMtJPqmJ+YuQWuQY9h9qAsLyeo
         /+6R5VeeIW1wrj9jo95SOsSdKkshA3AJ/iwxEJS2hjb40f0x9xun+BIzimqMANo3k0XJ
         NA97WfSRw9xbWdZp7Pz+O8HFdSKDcVTMmjYwgMmqm5CLhX1yvyoM240y3VlgYwM9LgUS
         nEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        fh=QNRGKC35vrLunyDduHe6G2miN3B9c3Tqck3QvlcG6zU=;
        b=GfRE9ekFvGtVy9+xN4ZMwKSv/5+A5Oa9WvgjE9uNmQgV9HbxoHP6Jiq4gASfZXmjL9
         JaA8tLIDCmcdQMR90Kk5qfqeSdeBQjhImVSof18b1hgwss9ADSV4woPX9iTiPh4AcNfR
         1PZqxGh9tMK1Lby3KYosHMcOmFOGcUNpOFqISL17Q+wK+uqz6RTh3Op4zv+43Jy7Pvni
         i+g1CDAKF7wK7lEQEQLU8P20aOI+HE71kTjp1Ym6weDBH8bMZW0whnwpR8RYfX9b3/8w
         vpxQCJ+zEJZrVTkzVP92pAyqh8B9c6zP3KaBEafbSlsXWwfqxD/YDJBZmmOrZv3EQHPU
         71qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688867; x=1791293667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=MnW5UteW5tCkE0domqFe0WMEddVoAo24BrHbfCGicKqHJ7zswfoA07vSpvD8NfqOnE
         fF8ELmym2xBwXyl8/OfGKwGsoqqQxQokZj3gd+Dq32ZPO3DRhsUh73z2LfN2tdHpGy/H
         EPBeds6ekZJPCl8GDtF9YdK/apasEgcCZd5m+U8eKxUnzX94w6I8HytVWl5AvvjGs3zR
         DpK+qksSdODDf/RHW+WZU/BkBWAdIHCAI/QR4tzPiMQzi530jEw/yRRLhlCn3CDzzxlv
         lqWsAjIxiU5+U2yWw0xsJgp1V2E0KCF+z32vgJSxHnU3S1tTCcTS6PAXS2gHKiJQLrhb
         2M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688867; x=1791293667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ApZtp9mCDzFhUghEqNRHfpNQRpHQIPz3H5GND00+/Q8=;
        b=scrH6sOshO2XxtPFKlwdQ2QLp5Q5nYNn5twrLqzSn1qwSK/4p7V3eQ6VyJgOoK9CX5
         /BGcjXvoLwaCBnRymoFjCPBIrhWAYmjry99QMzR8B9Fx669OZ4Rz/rrqb3eRJ+qQCVlm
         aPK4LAHKUaqIoZgkPeA8khXUcPMY79LGFPevLX9WZHKYjARsmvyMUNnfDC/kmmI9BR6e
         NlqH+F9MmiCWZ5YaioBwz3ldz2V2oBsjz+PcgLNWgWtHxEjOGy9ulCM/2jXBCriiqIoU
         pMUq8sYj19QHX5j7byOfHJkswrSdTq6N1dCju4yO671ES1+7mB91UT3UrEiF97N1Y7UK
         5mSg==
X-Forwarded-Encrypted: i=1; AKwUvBxHuDrazzPcq4EHsR98ItmdpAHySM0CJpJ/gl5+QlhnwBTzF96aQ8VlyhW/+mGQZCzvVGwfu83pt7/50A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIVWklyOl58KJYgX7ArZ5UtKSpFaaqBG0+cgm/ZQyA+Jpp4VGLe
	71oUq5z2BeJvXkkQkUqlR/pF9LE4DSp4wQ5ZGU0MIP1GoIJGtmusxs81mDxQjkzOpVvMqrpJAKQ
	pTeTzMa5eDXmygF7Z6PIFsuR7aXzzJlbl9VT6ruzolPTPuJYPMHrmDQ+yPlx61Qx9fz2IO9DtGA
	5KM9211+92zcEcTBDxXQbQAzpjUQrCf+pSINVOi2fz
X-Gm-Gg: AYBFou2/mGv/KPiEyDRqPTwTUq4OH/EAM5ul4MsY0KyK/mi6P26WOB6bJ++tcbJh/+T
	BlIx7TuKp02ahi9CcB+0lQMkFRvW77OfL/V6umYQ/1/VBpN+uwT8nzOGcnMtxS3WxIQOyQ/l7br
	6vB3CV6rCLIS1k/EVkHSaCGnG8HRcbF/Rlbl/ui5mFXYszO9mliyrD/SHVmg==
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0bb60e74cmr11071558a91.39.1790688867369;
        Tue, 29 Sep 2026 06:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8c:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a0bb60e74cmr11071507a91.39.1790688866886; Tue, 29 Sep 2026
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:16 +0200
X-Gm-Features: AclHuK_IsoMVZ8jA--KFIskLK5LDOvw3Q0lyiLyhAEn2l6B1awM5w3Hl8Ax8gbg
Message-ID: <CAPx+jO9qPRgae_VqWrGQ8bhDOHBf+zDzw3A-BxCMa25XfPaa7Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
To: muzafferkadir@mainlining.org
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
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX2VCwme0cbEzm
 xEGSJWXEauSsFi4zOMc6zZjZkDPQuEAEztZpsKn1ZpN8UhkT2Pbc0/VGoP5lOIVZW0ITdfnQYCz
 DShnd5pTl+4tUFfYHCyDFGUHie/AKL/jhfzUDUsSaEXfZPx22HBjltaHsiMs3vR9wX9gTbDzN6Q
 KnNUN9DKEWnbRpoWyqcQXA8KF3fVY+Wh94wVTDgFXmONTnCPCjDEKhDC2e8bnuXiZf0ARxhJ1MY
 V7bac1YWeonpmAeMFK5I9za/N4wthPOUnlG7gBhcVW86iLYSRNkId0G5JUyb6oonx6aFGUVEnwh
 1+PS9uyFLEOCWLk54XKMMLZ++4YlsdqcCjjbeFoJr1xLPfs8y3Q2xGX6D/MaP7N137mbI3OLBnS
 uIdJyp2L8iMNmJdZ3ytjKg9/4pP+VGu55zh0awtRQDLP/+JLo3VJNEecZRy7oK1gEWRlzzDgyYn
 cPxF7sIqt9Py6l1QaNQ==
X-Proofpoint-GUID: 4_1rE9EEIfQnMFRszeuSPAqVCwR_Q66K
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbbe64 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=wO7LUizMVtHDz2nkp9wA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 4_1rE9EEIfQnMFRszeuSPAqVCwR_Q66K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX5pFdKMZgToLl
 cMiHb5EECneV9QwwxRKzKuxoWitkDjIaaJZYbpQ5GqVp4pmHZwhWXPe1aPcEXOH+etMdNKyDkMj
 0PzOB4f2myvdk4fvjnd8Kg+QlZP+New=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible string for the SDHCI controller on the
> MSM8952 platform.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 69bd44e65ad7..9d4409c958fa 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,ipq4019-sdhci
>                - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
> +              - qcom,msm8952-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
>                - qcom,msm8976-sdhci
>
> --
> 2.55.0
>
>
