Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BE32AAC6
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857400; cv=none; b=BIsP8CL9PlPGFq1BBkitcNn309aYZIsnbBxPtF0ce3GR01A+PJQAnK2C5LE4P7K4filGSSzCHuYl8j8Ykv01nEtqEnOt4HYBRxEoz5Am5Vw2HPproqHWyGYC8ihS9noFTN5eWeK+artLmvvzN7innXJXinlttLiC8mCWmsaiyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857400; c=relaxed/simple;
	bh=lka07Gr3l2JawsdDoDkCfszFn1o8HA7+GaDRSGzKdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZoZy9oPGWW9w7Vn+N7w/codJB1cT65gKc/2Yi+DooGsqBEeWg1sYqS9TRggfAQoNwnP19ztDEpzEkuK8T9HgAFYs40mxUz/yRyuEvmnmdC2Caftej5JzeR6SXlrHSw7AS28+E7r8+wFRUTOHnCJto7NdhGIGF3mb0EPH+yXfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVVUyqEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRJsyDRg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVVUyqEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRJsyDRg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDVsF2881280
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=; b=UVVUyqEgI3aai44H
	QkYs6h4Sk/6/uPO94ctKOtJjj3n5+wTduu75T3lBINHDzCPeXdCe/LLgdz4BiIIA
	I6FCYJGuW6rbqCzG+PqGMHpMb6xjJcmfkHJt1PYgP/kntODh+X0VaaTTgDbDdP/t
	5mK6QuZEI5QJqRhPc//Uvx2PsEtojBE3Wf5jUoCGbxwxji82ZKuqfAGOBqi/CtJM
	MHsN9S66aTzRxKSc9r6r3jxLGT72P0S66dSuzw/gjfRycE/zeF8d/az8b9/+BxqX
	uSr2XsXere5zlNsaYwMjPVwz06xYAC/u+oMsdfeWvyWqnAZBEcPGno6XGT0scTZD
	4sRW/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqgxx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:09:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e61b38eddso485399085a.2
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857397; x=1783462197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=;
        b=NRJsyDRgz9XcsskDy1TCStajobjEVNxjDA4Y9JZ5YMTLcBi9FjUItPsUngOQEBg+Ve
         qCRCHUiUpd9V35DZ7oUeLzju31vveARTtZe9HrVhQDCcAJcPYuvJiG46Hv0aZK4TUEAd
         LjXYOD5BGZmYIA39/qF/kHDQRYxv4Ui7o9c1BLhA8bCMd8MCeNNEwUoVW3nW1QOL8HOE
         uRPOEvPot4OpwEeJOWmsxnHopCwAs4RQgWaTZCne0w0DuiZRruYr26BbTeTaohBkIYr2
         bvNdMnDKPbiyjlCms1hLacLCibEbq0ywkqfYCG58x374QsjTl+HiMPLbYJR9NlMCknbf
         2fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857397; x=1783462197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=;
        b=OwPVe6lwscXFoN9+xIe/sVtaM2YKmGaEVg1lu7q0Aikq8cgW/6zMGTl9z6MRWFIWHt
         WZAu2NjfasytX+NXq4wC5rXFpEiJkJMEfqfF0uXKRzXkdWw2xPvsJIUlxR1Zbay+xxxi
         tsCpHSUoGuSMOo0YEkKf+WY9X+hevnOkEbh+T1R9dCN2SIIdPyELVTh+coSZ4JLz0rcs
         l3jy+RMAiVN6Mg7e8BX+T4XM+Fs+YbdGCqHQRhorudgyhh47gMrG/b21F68PDsyk5erx
         Dz7ZvFFr7aa3NPlkh1+lFU+ErhM8q+N1W92D60JB6AFApZwv8kvr+QKS5H+9pztK8MUW
         NFUA==
X-Forwarded-Encrypted: i=1; AFNElJ8yNQW5Upw7Wt2aZ6xy+QpRpLXcZD7UYdrYD84Nyf7f2SuIaehrFbKn1V526u+mNbRie+pEOkveaRh2mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpJ8Syx4cvJ+yxWW472osZY5GGSmPgLYWh5aAUNn19z9XRTzI
	5P5cxL92Qbr+5DDtN111EcHlYIgfi1pCSxkUkWVqNsGytlzVof8grmYOhsBcJ9OrUSbGJAQEGnk
	9oFyDro5EfuKktne4TuksXqw0wXUY39LL+6E+hAVHn/h8GzLtn2/yPj46OX0swK6qtQ==
X-Gm-Gg: AfdE7clRGfRkFcrkB3ERMoCqTFExdTbT7hM0rbro3kEguRIPxXViysfqXhSi8SwtGel
	lxDAA2TA0Qmg9oofQhIOKPe0WRDVbQZiyuu1KHKeg4DxcTBqG+foeZVS3I/4DdYj+T9OdR+vQyX
	MRelteOVSWNtqkBU+qEhGyk+f70uNtF8oQQGuUCdAFCxegnBBwIW2KYUr8IOxfD3EnpeNznKC8G
	EIQZ13VLRKuypH92knQ80i3aNrI2ovZrxf6O9cAmrCQ2aH+iKhNg61yewmsqPmLBhwQybfTykcE
	ZIsvJGqHhPAYkcDHMOYkw8m4f8iUeD9cmTk4LZS7hE4HbAxVv31qYdSMDWQjO1kNS8hyCXftmGN
	OtPUSlN1BLYUNuXFTIVGRcx5AQ47NjXa9ZdnUa73B4Iur7oo7m6PZQLXRAkmNbg==
X-Received: by 2002:a05:620a:468c:b0:92b:6805:918a with SMTP id af79cd13be357-92e6d926a2cmr434242885a.66.1782857397398;
        Tue, 30 Jun 2026 15:09:57 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:92b:6805:918a with SMTP id af79cd13be357-92e6d926a2cmr434238085a.66.1782857396955;
        Tue, 30 Jun 2026 15:09:56 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm11865243f8f.8.2026.06.30.15.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:09:56 -0700 (PDT)
Message-ID: <caa30078-9dd0-4f07-a206-2dcbd2ba09a1@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] gpiolib: remove linux/gpio.h
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-14-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z6RH2b9x_neEMIX-hLeQk5AZCfcntapa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfXyhdJgIAElets
 HSLkdcy4G75HOTnRXDEL2qWvJansDkQcRcCJIDGoMAgyfH8o9G0CAR5/OS2ar5Zi/S2jTlZY3ya
 VLOmcmc2Tnz3Z4pTK+UK5S4sGSMGTWB9lIJpLQR+mfYTIMAKsMMazi3JolusIfQC14ScXmgGlwg
 mhXwk5qOPmVyqlsHpJyTZGJLNXQf7x0gy+ruKvhGUX1YZwKt8g/HOQBpOggxKrJAOljCvMZINMt
 Qub426wX2FhUuDRlzwEUsw9hIQgFmUH0EVLz11EWm0jJMQnKe5198m+dw/qn7dFwzrnep40WF4p
 iuMAeskZWp84sBwBL0uY/frXYs3FhTIzO45ScQ40q+aQEuuMk50QOc4DeiJ4LnZtp9lVPok5oT0
 zN9nBfnP7IVVEVcoQVLppYm5GwVF4Y1Yg0arFPnrAueMvFsnm8l76l/QWNUgMnJbLqx8ZzPqBoU
 +QNMU/QI2NInuZVAyzQ==
X-Proofpoint-GUID: Z6RH2b9x_neEMIX-hLeQk5AZCfcntapa
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a443eb6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX+3pa/S2B1LSY
 tZ96mPyurkyVwMVnPhIXQg7E2emBJLbNhtxH4Hhf2aTbjaoLyjEwxPXjOJcLLzcFYuIueIJn460
 Daunu2vTyVuHkAUld+yxyOkJ+2UIIpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After all other drivers have converted to linux/gpio/consumer.h
> or linux/gpio/legacy.h, remove the final leftover bits here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   MAINTAINERS                   |  1 -
>   drivers/gpio/TODO             |  4 +---
>   drivers/gpio/gpiolib-cdev.c   |  2 +-
>   drivers/gpio/gpiolib-legacy.c |  3 +--
>   drivers/gpio/gpiolib.c        |  2 +-
>   include/linux/gpio.h          | 22 ----------------------
>   6 files changed, 4 insertions(+), 30 deletions(-)
>   delete mode 100644 include/linux/gpio.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
