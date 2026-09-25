Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61348A8AC
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329868; cv=none; b=avmTLz+Vl8/D1Plnv89UEg3yjHS1gtj7U5r1+HEfhvQZ6lPj5B8oajHbRqtfOi5CxxIu2FXuSVuKtsYG0KjdKdBdYqMxEecxC2HpTi8DogtNIT+03O+HtH75dlVebGaHLo3k/qBZIRy3jdgs1IU6ybTCkIVXpEYGudg8PPQjKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329868; c=relaxed/simple;
	bh=MnksAUFrnZoQ453I02yXVhjqgK5PCtlmo3eJI7f8BhE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ba2N1kk5hMs2niHo6uzbH4XUif2UnIOI74U+CZ4xK71KlzRmbzkpy78ClOizeEq0U4Lsk/Zw57APTAzoquS0IpDrF/CJ+kMOCj+qizBofR/M3BHtOsMFq1G7v78xi/39ykq3RVXhmobzQ450NCZXnb302331pp74zrw3k1nJpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJpZSQnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rfev45nd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJpZSQnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rfev45nd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5J4Fi756781
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dy2cVZV2brJV0iG/A9GNVh8lIWJOu8EaAs3R96TiPCA=; b=nJpZSQnVNi0hEPhw
	6j2LaXbhj3nOebH+M45W9Aqf4MNtRlbFHkhlkUmKUSY9qPlaqg/ykbN2Gt5CiWuQ
	mRvODl98id6WkCUdsC+jVRXk3Q08EhvVpfYVOFhGcmwDgvsmdyzIiABNKZ21xqA2
	jJFKHeUdozDf/uqPJH0si8Aqd6BD9QzzPHQKlxe2ON0RnMB3+rciB93PLthR7MhJ
	hIZYnC4PZuuCfi/sXFZwlak76CIYSsoOdFZo0QzG7Kt4VagTfKgfJfAhLMxqhbeL
	+D7FmEtOrkpSA24WjttEibUvg3jy5eI2YbL/1bn3P1gz1ltmsxhxOnvGJhQivwcD
	1AuJug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq08tm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:51:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93be1861d2dso108654085a.3
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790329862; x=1790934662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dy2cVZV2brJV0iG/A9GNVh8lIWJOu8EaAs3R96TiPCA=;
        b=Rfev45ndOtKMAHuNEhO/j39BQfh7PPjS6sJIMXOiY1GJ5ZU13LkDwVlirrlZVNhtfV
         +gX9g6ipFFHHSl/kUMdw7gyL/DJf2I/MCEkgY0Xpf4BQ6WAnAZ/ve5vtYA4vdyvbsomU
         2fRVLVAVNl6ZR4IJHja7AzezuWavep37+FF6gAvRREkbnEdgk0LHV3iIz72hHvrI0TbY
         G+zv2hfeQxzeM83PnNGrK5iD0thF15t9jzveGvUVxUoLez26ueDmorZZvvzw+3D31pfo
         hj2p7HBRHuTvGYJlne1O85LMNH3lkXZRmbaOb3vD8C1h/AxbAMgctLTMkcGJh0zWN7Ie
         1R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790329862; x=1790934662;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dy2cVZV2brJV0iG/A9GNVh8lIWJOu8EaAs3R96TiPCA=;
        b=R/xdnSAQe9VhkxZDsY8+kyptom3NNzQqPa0vlvT/EfAXdUYZPFUmdlQ2W84NpBKQX3
         R4iq8JwuQjo4lBwY2U6XaIs87eeF4IEbfSHTUS2dSL/09sEmPdIvrXFA971KnfxmfzeP
         c+iSDwuCuLgZswjIbVvyuVUESrmTSxV+qJPsMsc62bLtNx4siuybeRnO6TbZJPML+/wM
         53WnDIAXLqrnOzcr8vK2G141s4mssWSMTE6GlgU3CtGytxs8yce/W5hOPawEIA/oym7R
         LRGN7vAlzAQowIp/t+UHo4oA9K01Qknh+l2EElYg7emHHuoJvJYUitl8jHrMTRGGT4MP
         qLbw==
X-Forwarded-Encrypted: i=1; AKwUvBzH1wzIje0wfdzkCS+PmtzfbLLk4SBjq834CdwhEkr184A/wv5N9C59d/xR37Zf4wepiqcD62vy59FicA==@vger.kernel.org
X-Gm-Message-State: AFuF++kDobhyUl5xbrPh8uDkgM7iCUuhtSmQ0s1zGB9I3+6siSkdwgUu
	igsrO9pt/LqXhZAb9I0Xp5Y6ePh4bqbUbGqcH+qekKFVTs6eAoa0waaEzaS7LU2ab24BvHiahlc
	R05E2+0IfWStLypNsXR5uEIeQgKwTB1/ro8UZZN3LviUc8eSHOQBT6QBKXzBJea2UsA==
X-Gm-Gg: AYBFou12U+FDZBQkn+r0EOPnH0K74BVsEBF0744pGYC56Uq+t+Jl0id2B+mCxySquBM
	HL/yUBDkFe5y9BY9Ov3UAllR7KDl729FSxpzQ4U2xJKnV5FuEsdwha0AhpIE1xkqrDkY5ooK3rw
	hgW2tH5gRHK1fCpjsiPQ3ugF6w5xGIWfrsfMAEsRHZ1UabtgirU+NZJIs+CB/xuh6Vh42hX7xDX
	DuU3fQYZvAy3e7mtsel4rwKRVcDYmNrFIezR6MEB73Tn+tFIrprHxRnzGn+bm6byyKmF8UoSIhM
	PIYtuT8952EpV3Gq0uBi+NZB9gqnddBnxAP/XSUYfTDNuq5XdIQhMSlOLgmCO3w84oAmkmoBkuX
	FgiTBJFt9Bv0Y3pgET72JtxRa6309In0+LVgem3zGoywJsHmRHxuscnWG2iJQ/BYjROBVW7POXi
	W7PLAXm/eVYwCt4YhCkObB5IPCuq1q/XifD50sk3BCRukbkiKAXpxEI6pdm+GLlBQqfg==
X-Received: by 2002:a05:620a:1b99:b0:939:35e5:94ba with SMTP id af79cd13be357-93c43b82bebmr319157885a.6.1790329861786;
        Fri, 25 Sep 2026 02:51:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1b99:b0:939:35e5:94ba with SMTP id af79cd13be357-93c43b82bebmr319154385a.6.1790329861314;
        Fri, 25 Sep 2026 02:51:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae782a4b0sm89001266b.60.2026.09.25.02.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:51:00 -0700 (PDT)
Message-ID: <9acaeb9e-551d-474a-9c3e-9be5f667297f@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:50:59 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] HID: logitech-hidpp: do not overwrite the device's hi-res
 wheel mode
To: Roman Stingler <roman.stingler@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
        Erik Hakansson <erikhakan@gmail.com>, Filipe Lains <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <20260923181203.422097-1-roman.stingler@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260923181203.422097-1-roman.stingler@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX1iZ4Zww19W1B
 hQMwX812oxu4cSItMLo29Me+VN2/fi/26CMKqZcoJRpO2czFYfCLnU2AENky/RHLurr4q+q/mtE
 1FnoeaG1ELhj0jwteWry0Lvru5mzmiA=
X-Proofpoint-GUID: Z0L5M04x-f0-tdzL0IUvetnOdzMIeSDC
X-Proofpoint-ORIG-GUID: Z0L5M04x-f0-tdzL0IUvetnOdzMIeSDC
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab64406 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Dp_lu2mDYKKqGQaK_HcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX/UcrwfCi7G7Q
 3XCsZmAQj3mpSprsy4TkrR1TAjEDRJuYCqOyKzvjeKTxF+qNCTr5icqUo622j0WyKEPIpKQZDSd
 EIuipoQnyD1JJE3uU5+v58DLcrjXgLpAnNZA2B3OVajsb6dhZ4sGV8rQDTrRSwr83UdvROBkW4D
 nOyAfOdKh3p5NGP5ZKX60qqpTdaQmjzIBZz6xxlGfsSoq1gLMVbM8gJfNTJ/QypYs4Rzzf5YQh5
 MnaoSUGk/CeYz2CHqyDCGYpo8ur+twBewQhWzYI0RqSf53TeYwQfAKP1+Mwj7pVnrFfT0Aw/HDR
 LcwNjGIhcJJzkMrdnUCQng6bkyGY03Pdyap9QjsqQ2/J4IzY5ZduHT4mpiZz0TbrRPMhgH+VdtM
 JJt1tRwQnKhhk0Icn5Jt5p1F47wj6pu+2aDOfp+F++Cwqk+4TreVlOBYfXHH+NS1WcVniCV2st/
 cJuVwzwC/jn3v3ODEXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250039

Hi,

On 23-Sep-26 20:11, Roman Stingler wrote:
> hi_res_scroll_enable() unconditionally puts HID++ 2.0 devices supporting
> the HiRes Wheel feature (0x2121) into high-resolution mode on every
> connect event.
> 
> On at least the MX Master 4 that mode is persistent state in the device.
> With hid-logitech-hidpp unloaded, a mode set from userspace survives
> switching the mouse off and on again. Writing it at connect therefore
> destroys a setting the user configured, and does so on every probe --
> cold boot, receiver replug or module reload -- so userspace cannot
> reliably keep it either: it gets no indication that the mode it set has
> been changed underneath it.
> 
> This became visible when Bolt receivers gained support in 7.3. Before
> that these devices were driven by hid-generic, hid-logitech-hidpp never
> bound to them, and nothing in the kernel wrote the setting.
> 
> 0x2121 exposes getWheelMode alongside setWheelMode. Read the current
> mode and scale vertical_wheel_counter.wheel_multiplier to match rather
> than forcing high resolution: a device left in high-resolution mode
> still gets its multiplier, and one the user configured for low
> resolution is left alone.
> 
> Note this changes behaviour for devices sitting at a low-resolution
> factory default -- the kernel will no longer switch those to
> high-resolution scrolling.
> 
> Link: https://lore.kernel.org/all/20260920094508.39682-1-roman.stingler@gmail.com/
> Signed-off-by: Roman Stingler <roman.stingler@gmail.com>

I assume the low-res mode factory default is because not all OS-es
can handle hires mode (I guess mostly much older Os-es cannot).

This regresses (new factory default mice) to no longer support
hi-res wheel mode at all under Linux, even the non Bolt ones even
though this is only a Bolt issue.

So in so far as this is a solution at all, it really should be
limited to Bolt devices only. Although I wonder what switching
Bolt devices to the hidpp driver wins us after this patch?
Do they still gain any meaningful functionality from the switch
to the hidpp driver?

AlsoI wonder if there is not a non-persistent equivalent of
setWheelMode, that would be ideal.

Do we know what Windows (with Logitech drivers) does here?

I cannot believe that Windows will not use hi-res wheel mode
in that case...

Regards,

Hans


