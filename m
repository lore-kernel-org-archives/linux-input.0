Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75D30FC23
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857332; cv=none; b=nFQxzPxC9BI6tUOCxdsayxehjDx0PH4PfIGNeap2Gc42amz4GbUd5r6zYisY7TqHkpz44jkuCp55RpUnqyt4is4bbm2nhpf4H6mNM+9ss78J3TGtFuJgT0ctcYKynKKw6SYUzpZIXRGGvMPV3pzH/0JbB3gYb6xdRHk1x9KSLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857332; c=relaxed/simple;
	bh=eyMPhz4D72N34DaHLBk8TtAHe/1rzGfpY/U34NdyrfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwuqsUbgR6dgrp0nYYYIrnqP741M/fgzS6YkLUpfNfSvKVmZVT3mRuDT4HxvjzSaSbekzruNwwgmFFfF/hd6spzsBvn5ZAeZhLSjUbY6WLqOaS/e/v67cVYCFfQNVWmJNBsuPPVViiOCyZw952083qOutMs+QQMws6Ktes9EnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjdrKYpV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EaDRdcoP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjdrKYpV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaDRdcoP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDkNf2942727
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=; b=YjdrKYpVqZ8H9XAX
	ibF7vH/kUADBSYjVGZClU63lnyKF8JVv5GZII67PEhUmScSfLZEtlySCd/8RXj6x
	o+rkx6Eto9cTsN3V7OIW3H3NJVDGsBpAi4uBgzMTXdfS8EGc3015nJ1/UL2kEZ4+
	BA9iwT1xYJSu51qvtJlUaI7KWY9mpv+Zf/4q7MA6Zp7fhxha5a52zn6FeCol17DP
	00t0lcWini3dby7PAFSuxWS4FE74H/bGbkax08nYfIc7ANpPU3ABvUKZKfwTZ7uA
	3ZIoFEoYf5v4XPixYIG36bcjUj9HG8lp6iaVzz8ebgdDiRlDt/46JVeyX2EfpF/f
	aeUJpA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h4s9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8dae6572676so323996d6.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857328; x=1783462128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=;
        b=EaDRdcoPceYoAWWUwIABiowKA4xewzdMc0gWkmN5YI4B5fvUgR0r97ljpcBh7pYPum
         Iu9t6cIR/v6ZyzFFS+67GAP99hO3p9A8cR5pDpNEx/BaqSEtfVfaLGdXSaGKYNiN/YR9
         7JtpB/Rw3BQinIvKbYVHwtjr7VMPL3pYrzc+BlzcGrbjuD45LolyizX/ssLCjCOfdCFO
         21fDXXr1D8DW5xVOBg3DGONiiZxODGhEBgGmB9ZZKoj7DFKhN0Y8W9nwQhEWAXhyUWca
         pPphpA+1fknebnZUlAdDkznvkTfjuXH6gej05AM++BuzPNFZ8dUStE0eu88NiOVHJosH
         3g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857328; x=1783462128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=;
        b=p9bM8CyWRNWB5aOPzXo8SRSkyWiP+7VyMCxUEAHqOeWOWUF9feBRyfR78TlzE2wwaV
         840BMNvaIE9RWV5N1hfX+noYjGhLfUBhBuvg8JMcGnDOEyQaE6urNNhZD9VEm7ve5Lre
         tC1U5QT9hp4NmYQC6rsjSBWfB3Ks65/cPLpLNQboGnXHWTl9DwVIocllJd2Luw1RqPZL
         Ed/u8V+mYojqaAD8lq28A3zAameo36lMYMCXpekz1vPz9i/iqsLiifX1INBWUthRrl1m
         OIpICi2wprqQ5NYspGwmGLlpJ7f+e6xstYZrw6VFZWnHJikjxDg2wTAkJNuZT98RQBn5
         oofg==
X-Forwarded-Encrypted: i=1; AFNElJ8li0HwVLkiGxVPj0KdYuN7Jvl0gHMAT+vLnHb80YQjqc5hDqL0yDm6O3xdLBKB7fd5Fer0bWYc3ElUfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4odmFUSSAIO3iMU0p6hwmhuD6v1vOgROMsGMiX9fm1TUdu+Gg
	Toaqc1Inaa466lb1Cb4dF+Xd3T/ABSBR3bTKtK2UYFsfmufHuhZBUs/F/TexBGxPbQZ/GQODdVM
	fiR6+VTBSBvgqYRmkYCQ68TkQuRZl9QOjJLwxmJf6IJSGJZq6Rit+HCqt2RVsi+jUqQ==
X-Gm-Gg: AfdE7ck554wflw4hJYYwX5Xm+C1oxBqE5dEyt9Jwn6PztdKwRB/G9aww22mHh9tNZhP
	4S7pvxiPnPLg0RpT101hBWZjzU5HWQXpvVL+8YtYqgdGucdtrIe8pn63c1jEEsGH72yEuMsxvlR
	G4Pf2AQKOuqpUuAFGbtf119SW67JGztVY2bPfbW1bsf5f2AmQ0ox5SsZJIOKF/yosmzCvLAEj+I
	eo7V2c6mjGHP6ooOP+7w9oWEgi/6PtVchZDIn/cfwJT7tcsaSlxq2a5Em6V+PBpvyokEK7p5QcR
	gpO7PR6ffBAnLX/f38qBynrjyfmqN7gFgBxO110N4+jNH7D8eOH/XMqzVC9WeEN9Mmub96ZW1v1
	bZpCCzKrp/b2TnIOHOXzSHz+gIpfITQQHlD1ADC0sXnXgwVAiOPXpfa+s6Bk/ow==
X-Received: by 2002:a05:620a:4511:b0:915:8502:f7fe with SMTP id af79cd13be357-92e6d7dc6cemr404387885a.15.1782857328365;
        Tue, 30 Jun 2026 15:08:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:915:8502:f7fe with SMTP id af79cd13be357-92e6d7dc6cemr404382285a.15.1782857327863;
        Tue, 30 Jun 2026 15:08:47 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d9daasm28380565e9.9.2026.06.30.15.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:08:47 -0700 (PDT)
Message-ID: <6bcfcfca-aee3-42cf-baba-9a926ef26471@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] sh: replace linux/gpio.h inclusions
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
 <20260629132633.1300009-5-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX8SBIe3xc9S/Z
 hnSSaWqgjE8EAJsd+8CwXc7FT80wBh0viN9c8dfvk1HbrQ7+6VyEEoQmDtFHm7QrPsbwJcHHPyo
 rhaYc3fx6sJBbhj1z3C1vdA4rHeS99c=
X-Proofpoint-ORIG-GUID: G_-XVLHvtJlQaGgJXvB5QZLdrjCguW9X
X-Proofpoint-GUID: G_-XVLHvtJlQaGgJXvB5QZLdrjCguW9X
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a443e71 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX+Rn/FNa6FGmr
 zSNp57Ieadj9TfhzUPcx5V07SvuOID3GDELZWIhEJasrnWjtKg3xU1Zn9RZRysGWSgoOgapP8+d
 CIaq8Fn76UdHT0RPp9Njzth1J5VBWciszNdWRKkKy+ixvP5++DXj+dQTiHMRbe87SZfHYNy8TBS
 XfL2Z/LqKN65SosmiCPIB4rXzB5oiflZVhm+QSIrrXgZXHB8RH5cRGhHgKZX+5zg0ImEGYDSbby
 09NCVBr9dgkm56nlpTqVXGDqIcFoSvOIgNrsMhxPMNWeQ6IHHEaj0JbpnzmL3v687dYeoXL4cYo
 uOu0nnB4nPCS5gC9yqRm7LKMNtDMITyO9Unj/tKsLYlXW5hPxKwgiwzcB/N6qbgT39pYddmgCyG
 1Je2NfPZweeKzyKT/7pWHoChB6xMzOcngvytKOWf4gYovtOv7A6czypMSF9w24d/a862hRSRlpF
 5feQRO1l9MXhJDSlcNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h should no longer be used, convert these instead to
> linux/gpio/legacy.h for the sh boards using the legacy interfaces,
> or remove it where it is not needed at all.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/sh/boards/board-magicpanelr2.c             | 2 +-
>   arch/sh/boards/board-sh7757lcr.c                | 2 +-
>   arch/sh/boards/board-urquell.c                  | 2 +-
>   arch/sh/boards/mach-ap325rxa/setup.c            | 2 +-
>   arch/sh/boards/mach-ecovec24/setup.c            | 2 +-
>   arch/sh/boards/mach-highlander/pinmux-r7785rp.c | 2 +-
>   arch/sh/boards/mach-kfr2r09/lcd_wqvga.c         | 2 +-
>   arch/sh/boards/mach-kfr2r09/setup.c             | 2 +-
>   arch/sh/boards/mach-migor/lcd_qvga.c            | 2 +-
>   arch/sh/boards/mach-migor/setup.c               | 2 +-
>   arch/sh/boards/mach-rsk/devices-rsk7203.c       | 2 +-
>   arch/sh/boards/mach-rsk/devices-rsk7269.c       | 1 -
>   arch/sh/boards/mach-se/7724/setup.c             | 2 +-
>   arch/sh/include/mach-common/mach/magicpanelr2.h | 2 --
>   arch/sh/kernel/cpu/sh4a/setup-shx3.c            | 2 +-
>   15 files changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
