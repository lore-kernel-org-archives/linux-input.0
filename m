Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447203;
	b=BanfRjhxFrrCKyndLAPHIPRm3L1bsiQhXlX2GlesyUmKGdGtnGVjrVYrl/wMnmw6f8u1
	 xAUJiNXwi3yvQ1YztRkuS94PEj7NAcxyatPLSAZfmXjez6tjZA/eCvQDQ2pNoCyHNjUVp
	 g62rWsSkalQmGGDIvzFbVAtdZqi6s/gP/D51rJFdlIPg9cdXlXaRkjjquzCaOM516E6AS
	 QUABOsz6CDcFUwRe0UbRow6R/AXx8kuzF/+1e+PHrgc+p9SkyqK6YtiS947NQNExZzKb0
	 QbfMLHyI+ZEcTtlncxSR0DjerUWxdilPdWBCYCJB0DbcxIoUWvRzXN2Bb71VOg57FBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TD7NnETHvRqTIKcFjw7RViMYq2RFxLOt/Tq/0tVAYoU=;
	b=vOJ9Z3Rj9TUm5nhrU26Sti1tlNamrkH3xB+Ze6IFiWSuNi1AIITCelGkao7F22NSHIQV
	 aR2u2tIYsiKho/Y2xsRTXseQ8Y6G9mfKwONNLMcDNjl5P1oVMDRbCA0FSbzSy4lZqadk8
	 T+HKzHRFDfnD6SLUkkUDRSs9exAVuuOECJpwMvI5ImXX91BuNckOnpvIgyGdYauxet1wI
	 Vkv6OYs/8WSU9heAAP+phNRrVzAi8vQeb6PH41AKppVFytMc+eDcj2eTnoIMSoHbmHk1I
	 BiycUtFONsuExlB47yCjTyMSl9d6CVdxphDuProvvdHSkHvLTggXLz2TxZ+YLvfuv1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gEPJcTQx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fg23ibzu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA474606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA474606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gEPJcTQx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fg23ibzu
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL1DY1937831
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TD7NnETHvRqTIKcFjw7RViMYq2RFxLOt/Tq/0tVAYoU=; b=gEPJcTQxbMM2ttVl
	Jn/AleS1ZSeO5Q716XFm976lbjSqpA/bCQRTSzLvQbNH3q7j8odJkAvHdyotRZ3O
	NXN/NSp2tnYj4oXtVEcmPYYsPq8MAUS3RsHrer1mXvvewYqhfwHW6rKfIGTBo0SK
	+9J1jgAPUJypn5dTywm1nqCYr5lGDJxQVhe68qWZuqpvJu9ZBeDc7iT4rSU77YMN
	yr9wNWmPMXB4PSZJvaQnBrmC4p+3tbk0SoNs2mMc5NE6Zm27X0kUv+gwMHOOVN4c
	oJ3Os9UbOsdUsu3yQjGI8xIwWQZtNaNXxEiC8rfb1NZzjCpnk+aAPs3UT/dVqe8G
	0DILWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx2857-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:20:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9496156f74fso32149385a.2
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 07:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795447201; x=1796052001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TD7NnETHvRqTIKcFjw7RViMYq2RFxLOt/Tq/0tVAYoU=;
        b=fg23ibzupk7viDUqik5UeFCfKRXZOfTF0r9rZdBSJtmMBCLUfSiSk26MR52tlWgFzL
         N1GZMPLWO5tIyXfPriWpP00V+AXK1QIJ8Onz00oYejDB1yyyPLxT4BoJVP074UcFN2dk
         wJrqu8+4X6CmGyvX12B+PRZeHyKb4fpQDggZH8TE/X2TYTkBx53NuU5S7m8TCjyLxfuT
         dC1zh5wuEAyoQyMJmr6K4Ayo+8HjCo64LuN0+qnYPyFjbo1KRSzGuOzoRvZkQKtZsZc1
         jqoW6d7qz7u5s9KWqUj3Rw11sz/U6aUZTW3rxVcWAJlSbwGCmH9+6hGJyl0M5nZ6xeih
         YmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447201; x=1796052001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TD7NnETHvRqTIKcFjw7RViMYq2RFxLOt/Tq/0tVAYoU=;
        b=ErGj0fj9BcJEwhJ3Z4o+PcCMbywN2HDlnhybcbUVoPf4Ov8VBurQfxwkdpqCg1NGLV
         uVal6G+xXuDQTtupV6RzJsHSjVpet/DHgImyW1453zfImqIjEo2QpJC7hD7fspjFm5k5
         KFSVgTRg/zNhai3qSPk+j2V2KshBti149UXX8P8MvsllZPes7VipahhnIebDjWOJlu6y
         0iskUPwtBS4FGpHjr+CZWR5S3eN93khahKDXKeFw+2d+xsrAMna35gLBxVcHPw1B3WVY
         GFu8tK+41US3oaJUgfKIwn7CMPyqX9rXqOh2OTcAufJJI5GIg6RmwRTmDwBlE2RP2bKX
         POyA==
X-Gm-Message-State: APuU4Z+fiOHDeU0wDvUljGje82hkAEdhr/gt4A9ybasONX3dkSZlsRjR
	ONsjMOsgmHNIWrrIsKLWcmJTfTXarhB7lsri8IhJsIaXKFFLt9xOvxr1ume1E17NO5wC0uyVtHX
	ZP1HcJ4x7tsXn3d53LBVVuYo/jUo7Z6DNd2i6CgKxBKF7BCCcY2AhKzTFKG7XxhrG2w==
X-Gm-Gg: AZFdTZfDt9pX7Jh/dXzZG0Y09idbUX3XLv/vyDtW5fr5NuuLiBkkv4V3vi/W452xFj4
	/Jz9K5GDwlTe9zA8YH74GTjBYZ8HUOAQjxGculiV5ScB/EwId8km4KDU3zhgf+/12O/YlU36qCF
	F4z9Nt4ZMCf4VVsCUNdfSjUujOjhvCy3uC7ZmR6LSyZW5mSQaci25YBTKk0YJfodK+5VU8TNf9g
	ugcCvnnvJ7Y5KzNAJeBOW/Dk4ftIsDdOuoreNMHCePlBXlrgCVxwfRLySAToP7DECHziRKaDXnD
	vKJzTwQVIWHgYCQ359Ba8WKPNc6HEdZo1W7AEIcZM8VllRsGJXEBXJYjTLajR8Vd8ORvumExGpq
	9RPc004tNa7cIDe0Yp3RKRVw/HchmMvm/ab7iLrKubE+7thzKXn0NVA3SFIzVA5mgGgqf41U=
X-Received: by 2002:a05:620a:5636:b0:949:436e:45f1 with SMTP id af79cd13be357-949ba6c7b41mr2244317485a.0.1795447200711;
        Mon, 23 Nov 2026 07:20:00 -0800 (PST)
X-Received: by 2002:a05:620a:5636:b0:949:436e:45f1 with SMTP id af79cd13be357-949ba6c7b41mr2244312685a.0.1795447200081;
        Mon, 23 Nov 2026 07:20:00 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afec08asm423197066b.73.2026.11.23.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:19:59 -0800 (PST)
Message-ID: <c7d5292a-86eb-4be4-b5bf-974a54fac51c@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:19:57 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: pm8941-pwrkey - report wakeup events
To: Michael Auer <mick@yoxcu.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261123130336.1316006-1-mick@yoxcu.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261123130336.1316006-1-mick@yoxcu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b0459a1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MRTsC1I0QnlaK75AdyYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Xj39AhnKXqnfXW6o0F-sLYrba_UxjQnT
X-Proofpoint-GUID: Xj39AhnKXqnfXW6o0F-sLYrba_UxjQnT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MCBTYWx0ZWRfX3tYRNrX4TzXp
 mOZ+kDAWqe9IHUI/ujiIkybiLI8Mu2pY0ZcRvjOdVdu6llsWlhypZ19ILFmTfHOHgENtvxcGa+F
 6NE5yHsIQxVgdWdYclUiukaoUPF/tps=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MCBTYWx0ZWRfXw+ukNe1iOJ9/
 JDozsl1BQx4XBb+3PkY0c4R38io9WacaSRRdBs8YEYA3WfY5hi7v10PnMbnhwXgE+25krV6uOMu
 NOwxBcgWdcu7bV6bfPpu5vpDRubwK1Pygi3UXdqdg/v7SE300IsnreAM9g24npnUOJJGYg2XozZ
 uoFisqotmXqwEQw1uRAaG+ZTdZNzkAHgA5VfvnKTO2HTeR7nWBcV9EcTJpim3uTaXha2Yz3XGR4
 pY1sOCumGra892rGcEX5QehsuqBRn5sGq4zXCRq//pFB8u0n7YHZXshRV8az3EBKyTRJ4oGyYGl
 rZaJ6k2ihZOR0jG0sGvo+prlk925wvOEytcbtP2X3FD/pKc7hjC4rlhxW6k/txEKyIj2tvf6IDG
 wRvoCtsx8IMxyUPebeJ1FRTlzq41eAAOTkgZg/hiPB5PEQI7n5ZgzyC7qe2xg4RCGE8XW4K0NiU
 QKoDTvxQ5aJisBfJ8KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230060

On 11/23/26 2:03 PM, Michael Auer wrote:
> The power key (and resin, with "wakeup-source") is a wakeup source, but
> the driver never reports a wakeup event. Its wakeup_count in
> /sys/class/wakeup stays 0 even after it woke the system, so user space
> cannot tell a key press from other wakeups. PowerDevil, for example,
> uses the wakeup counts to decide whether to turn the display on after
> resume.
> 
> Report a wakeup event from the interrupt handler, as other power key
> drivers do.
> 
> Signed-off-by: Michael Auer <mick@yoxcu.de>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
