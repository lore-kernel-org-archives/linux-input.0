Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD46331A68
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702555; cv=none; b=ISXStDyuV6HTTrHax5QhgO0gVTMjFZ/Lcwy8E/uBAlxlbmIltnAmvRz3W7H5oxPDxG2lX1qTgEXTeMUnW38zADzZXYiGR6XSPVm3SaY8sM8s+4JKxLFF2dbUq2jbK1+nu9FuaJVCdMand9l4cIuWkZiqOEoS2kNy90eICle4iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702555; c=relaxed/simple;
	bh=08QOlsqCxUff6qhLn0jxifoWLp0ueQPzXmuxRrlcNZo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MlTrnywy+1ZbgNxmtGkhwfDDbVNzYVG/4wCguaZdB/CXgzHnAoui/4+YQulpALoGkA8P+XJ/9QFDT/gOUQa57spx3rNk56cWiKXX/SqIirae897usRRmIeRaJh0i+J8Yh/UClMaxdI6EKn9aPoE8JP8/9IpYt1nsXAAakhbmYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JRDQB4sX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1TTuka8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JRDQB4sX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1TTuka8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAPxej3642973
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 16:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifaldSceYXKqfedw+8k2x6L1CWZ3ZSA5wfqYD2Rqqs0=; b=JRDQB4sXr1W07rLA
	aj1QTOe612Q47r2cLU2LLh4yQCWULk3MjzbLP+BzHbTFjvsQmUyR641VpWGTFu8J
	WL3jG+7kiiot51any4FMBmn26WbRu4u3/8m0NPfQ3buTz/gni8oJX+ZEYq/QOnH3
	99ZZnp8PmLjFAPZXxZV0V8KSix9NB43oEPNY1ukhNA9lx4qP3+Wfl2xXrVERM3gx
	yeVKWMsJxWk1ixMjp5IIQZnPv++fftRKippEyPBZzBSTo+UeopFKDlqVa6/cCslq
	hK5uZ+6YphWrq84ZmD8SDi4NuhQRyhrScT3/34m/KmJXDzMoefBoykrlErxmWKCP
	vSkb2w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05sr12nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 16:02:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56637daaae5so3288012e0c.1
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769702545; x=1770307345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ifaldSceYXKqfedw+8k2x6L1CWZ3ZSA5wfqYD2Rqqs0=;
        b=I1TTuka8P8JqeZ/0WJo8zmzcMAoMf8byNLy+15NMVTjfW8mGRcJqwhTVDvds13nxp6
         Q+WfFuN3slT1DdJdNj4V3vOlkai6kb2G1pGzfnGsRZo/xwllHBX+yYmrArU0rs1Tfum8
         atKaQZPeIA1qOLR9ICEytlN3AovpgyrZDo1zumHoM42gX+nrS1AsxKfVtghKqnNKkDfJ
         N9ixgwKF0BUnLCTWD0xxytpJcJHQXHLjTSXfCWrijTHX8XJoG9smFNOWNBMNF0UD7tjh
         zB3KfaImyxDkvPcmgcdAqp+ypjRKTm1llolClfxOOy+whuYHLE1a781B15akIC+J0Aie
         G61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702545; x=1770307345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifaldSceYXKqfedw+8k2x6L1CWZ3ZSA5wfqYD2Rqqs0=;
        b=pQPbS2kgnVxAGVW9rp33+syWHlm439+D3H4YVJYrvXYysvwkMSUcBdRPbmlFlYk7jv
         zgnI0jb2KG7CrYaoFsRl+wmfwcy65UA/Z2W4Z4U7gfx84C7p/u3zSKghFtYGII0l8B+k
         tgYgyezd1VDdtLkM6S8EYSBGDusZnFqYBZ1TXuyT4xNx/W1CMGFGTWHoDcARh/B6BKOu
         yG8+0YjFSyRAClQQRK1wZS+K2Hkn3EZuA3CbkRR0Y4YX6Tk2/ZY4EMuK+4M+7TIKQZgq
         b4tTjR7ctu9E/7fOktZ5261oerLehxm+B764kT1qwseoWSSBaRkgtzAJ1pgwe13+IguU
         5ssw==
X-Gm-Message-State: AOJu0YzYOqOd2uBzK1/obU47qUcnfHEuGXMcMwym+ilp/t/Bhx1+qxv6
	IQP4JVkRKxB9G87nwYWz7oKSxJQxjRbqGJr51xMKGaSmX+XeThpv5S7Z2ZgE7+waaliw2N4uIPP
	lgMygfoHoXyxO4PfnsAZ2AMBULTAxaKZLKqxYasv9O7TRmpCHdL9UBNK2SU1tZYSwCg==
X-Gm-Gg: AZuq6aLq1nxvr6KEteVC+dXINueY0hsDLvzlhmBlY16gTcLiYK2qKD3PzEaraITVwYv
	aLMUKBt9k/Lo29cGrBS4MyZnhS/Je5j4VtNL9eXkxbgHie4jkFB2Lr22wLdkzk9OYi3nw2lQlV5
	YNmG3lzscoRDd4/Nb2hTfs7kseH8hRnGpYEbRwApRMNY68ua5yQANi/7uyGdLRF+q+uZOtzu6vG
	Q/nQU5DCxoTAVKt54IoqeTkT7Dr2ocbEF68LFQ4lZwdcynnUnsG7Rs0dD7HftdmKkigbtKcBhDy
	RYM3BD8dNm8GEYsnY5/wwIf1r6p6Ft3GRpElX7CaKTJi4QRZ6O/k3jfDImFaj4oKrKvCgLbtb39
	WawYdVv+LA9O6yQfJcN8US8fPl8N9uW+6B1Q0v8F+R39Bi0KLZQ2N0hciSAHB6obnFXXl3ofb2F
	mjKoU0bKtjHCn3fsSK5mK3ZsTV0GCg6jn7EJfqE39VNdXJVjnDoKtQppVKl5lstcNPcgYm36whh
	XPX
X-Received: by 2002:a05:6122:ca5:b0:54a:992c:815e with SMTP id 71dfb90a1353d-56679502f80mr2719329e0c.8.1769702544271;
        Thu, 29 Jan 2026 08:02:24 -0800 (PST)
X-Received: by 2002:a05:6122:ca5:b0:54a:992c:815e with SMTP id 71dfb90a1353d-56679502f80mr2719240e0c.8.1769702543451;
        Thu, 29 Jan 2026 08:02:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d15sm2978663a12.19.2026.01.29.08.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:02:22 -0800 (PST)
Message-ID: <62f3302a-a78e-4f31-bba5-fd289f3e27f6@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 17:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: add DMI match for ARC 11.6
 128GB HD
To: =?UTF-8?B?UmFmYcWCIMW7dWNobmlr?= <rafal.zuchnik@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org
References: <CAJ10sVKe+kV3erD-cYREV0g=r6biKm+OatPJFHncnyrYDp8wiQ@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJ10sVKe+kV3erD-cYREV0g=r6biKm+OatPJFHncnyrYDp8wiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExMSBTYWx0ZWRfX5Z4P9Tt/dJqo
 cVDypf0pCb/cf0Hbg/8/NReNRtJc0ytsxEFfZ0NoX1IOmYlfIpwn7hg+durKtdgaO3HqFBFTEjh
 L+nkDFdzmwc8h9DdluCufRiDEN9BlwESToQFEQopAJ8G4nS11l1ELO0lIWUXYDUEn5P3jzf0ECO
 5l5z/gUuUZ72ofJ/Zz0lrQ65B0E2E7jCrttXz6Pyme72HaaqSb2FZTCFOYbAtIumDfjXV4g9ZlM
 6QT2QhnBcroe9KsHF2EsYTZkOos9FcyyBsgJ+h9kZZ/izmavOhg7SFuPSmjuSy0WodTP+69X6/1
 EE1kaap7DQBZSptx8h8dhcr3AWeY1ymHARkmm2x6NbsVADUj13uLn34XwDMnXuYc7X8FsNRR1Uc
 lV1gmFOS23jJt9KuwAyuxyfkShc8Sx28jemZrgGMuVwlOCAbnLmuObnUwlaqMCWaJkeneIX3JYi
 hhlg8DQ5uOHhvzP+gWQ==
X-Proofpoint-ORIG-GUID: umL8weoC_wb5luJbufQMZy_n7R57MJoq
X-Authority-Analysis: v=2.4 cv=UsJu9uwB c=1 sm=1 tr=0 ts=697b8497 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-8iU96UmxKHG3qEprpsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: umL8weoC_wb5luJbufQMZy_n7R57MJoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290111

Hi,

On 28-Jan-26 00:52, Rafał Żuchnik wrote:
> This device is identical to Techbite Arc 11.6, but ships with a different
> DMI_PRODUCT_NAME ("ARC 11.6 128GB HD").
> 
> Without this DMI match, the Silead touchscreen reports an incorrect coordinate
> range, resulting in partial and wrapped touch input under Wayland.
> 
> Reuse the existing techbite_arc_11_6_data for this model.
> 
> Signed-off-by: Rafal Zuchnik <rafal.zuchnik@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> 
> ---
> diff --git a/drivers/platform/x86/touchscreen_dmi.c
> b/drivers/platform/x86/touchscreen_dmi.c
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@
>      {
>          .matches = {
>              DMI_MATCH(DMI_SYS_VENDOR, "mPTech"),
>              DMI_MATCH(DMI_PRODUCT_NAME, "techBite Arc 11.6"),
>              DMI_MATCH(DMI_BOARD_NAME, "G8316_272B"),
>          },
>          .driver_data = (void *)&techbite_arc_11_6_data,
>      },
> +    {
> +        .matches = {
> +            DMI_MATCH(DMI_SYS_VENDOR, "mPTech"),
> +            DMI_MATCH(DMI_PRODUCT_NAME, "ARC 11.6 128GB HD"),
> +        },
> +        .driver_data = (void *)&techbite_arc_11_6_data,
> +    },
>  };
> 

