Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E0486640
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329819; cv=none; b=mNH4oFZR2TlTwpXpwp2c/THUCwkfxUANGLTx0gh++b04CCdCXHG2Pfvj4AqVqpmxooUVq2tNm4RUziJYYRqpX5jER0EwRk7Hcb24LKcjaWYKYwUnyw9v2mvoc6L6xz4+ntP9baXC5s8mythTalnzv1EhqHZL/o705RYoBBO5SxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329819; c=relaxed/simple;
	bh=fVJK/ODa4zbxOESRyzBgT/5Apdh+pjZlARY0HosiZe4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CNpT56RyQUt7Y83rTM0UVNf8CHXxh0tcPxLV6kD5KEZ2j7NjRkEI+EEdiQYRrA0/HC3OCUV+ojzhSl8GIhrVnI81uQbfnMdRZgaX2B227d3pK+Gqr3SO3CEdd9u0gjNDk+JrDaz3OaYKHgcdo6FOUeC4x3CTXTjNQZe4TRbmeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E81RnA5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIUwzoy5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E81RnA5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIUwzoy5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5J3XL756774
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0REfjD0UJGpjCK0Vq2fllUzL5RxgtLYWUerZOCwfaP8=; b=E81RnA5yZSkXnTk9
	CJohkSx2n1JQfJPCAsqAm3jn2vW/zYa7IOzXx800q8CqgGR3mvJuxUvSkndBTkwa
	kgZQs9vRSFPUGTpn4JZyJhxeIRLaHLFx8LvlO/vKaG4BIgjUaMOu3voKtZERfOrc
	pRsOXJMC61l+cY+Jxs2DSnTerDqe5N9SwC7OYp4ovGe0cGgTbHMYx4r+v4MrV+m/
	Vw/ZRVG8d9SIFGfSyvBFB9qyhS6k98Me8FF814NFJjDPP6rQJ0VnSyuIRLgPbUxN
	kDcLtyaTL82INl3qL5rzLq7sP0YZsuJqYoGx1uvFG18U885arlsYu8Cwg5ZHcWOy
	nFM8Zw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq08tha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:50:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91049eac948so11897196d6.1
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790329816; x=1790934616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0REfjD0UJGpjCK0Vq2fllUzL5RxgtLYWUerZOCwfaP8=;
        b=dIUwzoy5o3UaKFPpwaQ9kgrSwijLW1+ink6NQWAJ9L21CCUhRwy9X9ht0TrREdS3Za
         Cz3rm79UebgKvi8wgmB5QV6/6YxkY8n6ABXn88ixfcI1nICbUGC84zTlvPf1XRFs+NUw
         7yD/4MMIWi7PzGjOeafF+fwHRhiidSFSHnH0xwIFL7noLhov1BwVosMb22etWU9+pm1J
         HU3zRDwZSR/eTTNB3UuEOfu/PFeSjv4LvYwDo0aA7klkOhRvGqeY60u/67WNAjhwjnn2
         KTFOnRXUTwS0iEG91z7ur+oNEvJrVpyGql/QD2ujwGo0BqeUwwpSHYCeXpXydNyCieMJ
         X1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790329816; x=1790934616;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0REfjD0UJGpjCK0Vq2fllUzL5RxgtLYWUerZOCwfaP8=;
        b=hsxIBbLnCBM1LRjSdlUxBchzYBYLfEFxvX1mErfRGjDXN7J5IQu7GtkZkhBn2Lsguv
         NTs/oqXD9H5MI2otwM617puVYX0uSYT8LMpxZAzkR054y5D1NwokwNKvvtBIybRWULnh
         qf6/USG4Jkz4O5GA8NZrozG2dDpJQ94OEeElm/vRd5hy3M2jFJ47cty18lsB8eZopgfG
         3PVCxkGYKSgKLmc0NzU1igRDba+EY90hipb5f9QPrZcvBQQK1vitaL86qvYFoDvBA3yC
         +GOLjm7vk7X64aYEUXfbrIFS36v5akc2JsBvlr+3ZB5NenJNkEDlCzVRzlZNjBA8BCDs
         EpMg==
X-Forwarded-Encrypted: i=1; AKwUvBzx5I/6qSke/4ar3Wx9NNSscgWcHMhrdrUl5aB1v6TOKRU4ymEc4vFiFVMCLjW7W9k8GNnGGtfDFP2wDA==@vger.kernel.org
X-Gm-Message-State: AFuF++nlxjN3ENoo4gfiD4MUujdDfZyzHFcXaOOdxnF7IH/5HRyin+2K
	UGYeZEFQ7rZedBgIoeuUt0tLls6WBdR0ACGB45VWHfJ0IUSezEFH3+x6fjC6nzivwSma15CgfLz
	YnyiZOtKNE4R/OfzRqF/v1cfefxtgSkfXWbnxqLuVxoxTa6qQP12n+AgTv/GOyaIBRA==
X-Gm-Gg: AYBFou3d8SDYTSfvbybN0JFTQXobxtX9rZNXRVMsQLZDGSw9txQ9jecPdfpKkswuWy5
	9IAftiE0SUsYBzmYFFWD5p5nnc7X7QZnaT2IyHCSApNFXHbZGPRWrbU0WIy+yPLdQzlbJJU0NfS
	rBavgH3zY2D4qSQWTe5544CI3WbV7MJ4SCxxn2dAA1l/iTxm5nl0dReKZMiPth+O9JddHeqo6rr
	pCSbfTSPNIdWGH5ztnEt4ceFN6smWrRxc9nwBctLBnOAmVB/keZXtQk5GWjdZgsWo0+a0HRbNGn
	IxZLdwsKQruE2N94NQ+zWswAS6f5T0+qCRl7kx1otQmHgmkP8SzBgkMboS1S34gZDcBBP3rdDyU
	EV7zkClsDYJ0xyoFSNbzdMUN6/X7VJy9GIAOofNIPc2OT+2bkh4t/wKrHuQxn0IVDNj7Mf26hWj
	wRe0WRHtwLhKOV8NbGW8P8IHglB2TpTdiEYIZPIbWXpUI80HxtNl/EDUadO4QMoB1+2vE=
X-Received: by 2002:a05:620a:618d:b0:936:cae5:8b38 with SMTP id af79cd13be357-93c43b80a0fmr321749985a.10.1790329816398;
        Fri, 25 Sep 2026 02:50:16 -0700 (PDT)
X-Received: by 2002:a05:620a:618d:b0:936:cae5:8b38 with SMTP id af79cd13be357-93c43b80a0fmr321747185a.10.1790329815917;
        Fri, 25 Sep 2026 02:50:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm89637766b.33.2026.09.25.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:50:15 -0700 (PDT)
Message-ID: <7be922e5-4d48-4285-8552-9a0281591f8a@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:50:13 +0200
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX4hCjlHqa3yrv
 QdpXvxfLcu6Ym5UiMdjtNiDOyUQzQwuykT7YKzcGyese6dFI2o4vvAc16+qWULBBezs4HNZCH72
 XRQSR0sqYtw6JRSsHbunMEsPT4CKswU=
X-Proofpoint-GUID: _0RP9NK5XpJZxoT8f5io54s3A8bQL-04
X-Proofpoint-ORIG-GUID: _0RP9NK5XpJZxoT8f5io54s3A8bQL-04
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab643d9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=m2H-BLnp-5XiiflOyWcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX5n2mlobxeYFi
 PsL/fwEdq/oLbyIQl7NkFbEswzrtRxS4BRagTNgeZdX3TJm9aMQmDZm7P/pDp9IsQ3T8G9f8YLn
 W9iXAXPy6STWtIv9psHJJw7YupXdDb6tWph+jBTRBCNcHwxWVpWz11aUxpmEiYgl5jgRTCifKm1
 hccFZNJ+PYqSFcTiOvABE36qQ4GdBXxIY8EWIJscYPY6yV5m5IbmrsY/r6FuK1zv3g3qvdc73yX
 chyf60XX1FUCO19gUjHenIpJx+B5v+DOSEvQHY/guolP1MK2l0PuuL2eoPo1eTyii3Nlxq7r4by
 1TSjzGjlC9Tfnqv+VfLn+KEj8yM6NII/9IkLqVNqN/dY4hhfQPjxtfD/wq1d6hUC5Re3+6g3SuI
 r121ZqGf8m9Xw2gVTb2DkbpNIkPmcu7Mcubh1znCBcUhrEOYd7dZbITacPfSe2lOcziub47GkTo
 tkIZ4+ulzw4re3FQFaw==
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

Also I wonder if there is not a non-persistent equivalent of
setWheelMode? That would be ideal.

Do we know what Windows (with Logitech drivers) does here?

I cannot believe that Windows will not use hi-res wheel mode
when the Logitech drivers are installed.

Regards,

Hans



