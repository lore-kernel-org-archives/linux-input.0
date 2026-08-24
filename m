Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305273E92B9
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554172; cv=none; b=b55RObxoS/EshrXKTtA3I7/GzhkAVNEFmsywbwmJkk5mbIRBnGL/uUlB1efyS9N35Hh6avlBzFTEe7b9oCPPsAPW3owZqLBURN2TG+qlg9/Ys0s60OGoYNwXugkVzgbrEPojVMDxe9sWsbIJOzqwrVejtoANseF4i/dvR2mFXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554172; c=relaxed/simple;
	bh=MdgVsqytscDNoBcQq1T2DXmnKAy+0t/SSD8HWEOcbPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP9RSSbwh32nVOkxQ/E0SkXWsTppWkpoKrLKRE7yglJkYQVX7zvZZDwGQDcgt8COkM5gFjiuRPOfNfs3YF/BRv9vFewTAa85IfCP2xaeyV7MQPu6v3jYom2yyyahkh5NSMJPlU2syVEvmVNvgo+ca4yB15l+9wNX0Viq/qx34r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfM1E5Xp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eugu3q0n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfM1E5Xp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eugu3q0n"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RAu31477777
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2dD9MZSrO17sYCLJOzYAgvl/pfHfIeh6MHwlSpI4G/Q=; b=LfM1E5XpVDizC3qf
	MiFOZ6aQG9jGY5rDjbBb47nNlA9fwTP0/9ACGkODDLrS7TPkxuB+AgJGQCqYwgG+
	59f9d0r2EdbmirMkM4lrOgBJZP3+7lze13R1GO9xQGOCBZQrTg9YzEU68PsnedD6
	cUsEAsAp1MQCoomk6XrDy0W36xkdK/5U6YvDkdMn0azHMa8Hidktk2qOEH+sh0iw
	EaX8Ems5hYEsvpONXx1qSgla6LsYQDCJEpukDOaE1uJhpNTZaXaAauRdh4uCrj1u
	2LPlNBQuvI/xCd5MbblaiSRFgZeGWyN/GtkfmQdqh2zxNWRCV7BfXUQiElIyVqiB
	HAM/ng==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7528nh9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:49:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-744c091ec4fso65958137.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787554167; x=1788158967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dD9MZSrO17sYCLJOzYAgvl/pfHfIeh6MHwlSpI4G/Q=;
        b=eugu3q0nZ6mMGBxahYfrijB+PRc9fKbCDUyte86OYQJqaYygXugh+xgoO2qvGxnRtJ
         GiIHu/ThrMXnz1olTkak6TtrYJ02O3LaND2zYhqHZewqAUYNR8mMlkLFVDd9SwshcASZ
         qPaHnCS0UJUUeqkCovAh5jI+DG5jHvtzhjXNWi6TICAn/qQXgvFPQJinkhr1D9B/Af8w
         0Z+ufA+GI2B5ChvNfcROhGRrs9TqQtJ14IBHaT27mF3D1jeEqxuw51FttVxt49/KzlC4
         M/JmRH4RC389rmKssWp//Gx+e+fpHFZabTyWu5kfy9F07rzwagC7WHtafNfxS3N9VoSk
         e5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787554167; x=1788158967;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2dD9MZSrO17sYCLJOzYAgvl/pfHfIeh6MHwlSpI4G/Q=;
        b=bWU15LmSAWrG2I08MPWqYlkDP1IRn9YZ7Y8cNh6+HtodR7NiIooKX7p0KuTEYjJvFg
         IfbL+lCywrd5xV+iElFd1yUy1nvngZs24O9HcqwweOPFz7EYheqlzvGr3sEtS/l3HaA5
         XcvkRIoTBSN6YmOWwCE60w73YOIdbzKT/wGUkOEzUPrMD0QWaEs2het+pN9i4VTLu++T
         /P1CqU7S9DpqXH9YXuEnEeA0PZe08CcW0+cluqDKMsR3J2xLd7e2FGEKcU82qr8nsGRk
         eaOFPCa2pT7/LeqgnXD8vXjfqlA1hh5szWygzG1d+HojDIP9+jvc0xXdroJfTbAo0yEc
         8p2A==
X-Forwarded-Encrypted: i=1; AHgh+RrEEb4vJNhZr62wUO1jRp25ElNM3jq5JVue7d7/nEy1QO9aPYKJD95GCDbheXPT+sZpOkitmY828kf5Dw==@vger.kernel.org
X-Gm-Message-State: AFuF++mU9UjW+JNsywcD1XjdjsM4rXAsMBL4KXAZ9CH3tEH2coU2SXBw
	prY29tUNTYXOx0SzpwMjnJx1XfK+8h/DMt96oiOCRp3P5SzLzRi6cd0IV/7Fx49HWxiIgPhXZ93
	o2YQy7UyN+MBVzzbYXzaTrOQXnMohptZ51r3x41Qc4tc4RKo51f1C42rA9qINy1mpVg==
X-Gm-Gg: AR+sD13NSLw/8G+d3aIhkIXH/BLHt6Z32L3joj4+SAQhz+9iSnCTs/LuIiSCSFiJ6eb
	wthO8wlYJjX3eg0Q9DMH/5OyhpwAtBo27WbgMJfMhf9AtSWgfaUDF9MKXwAhhG3/DHjpyiuLnHF
	B+aB1Sy0K5LQmrpl0nidak/HfRz153gElR73ixcN+pZw/JCyUVPFJvyXSBcQsy+tBKTrtZXpBkC
	v7Nanxfd0wQRecXanZ9ajkel3Ssnfhk/3W9qYCGE1CnY+W77FHLsNOzYxllAPfRv1Nu2kP9xhyq
	GuclqCb8pHK8qNgDvqjaL+DQKqo/hhlo8TOucO2ccREWNteYrAqB+Ek2K49JGA0XyFW9NOxABCY
	DTOJIHekeBiPZG/OlUMedCbqQ
X-Received: by 2002:a05:6102:b03:b0:778:5579:c65e with SMTP id ada2fe7eead31-77a6434994amr2998275137.2.1787554166908;
        Sun, 23 Aug 2026 23:49:26 -0700 (PDT)
X-Received: by 2002:a05:6102:b03:b0:778:5579:c65e with SMTP id ada2fe7eead31-77a6434994amr2998268137.2.1787554166519;
        Sun, 23 Aug 2026 23:49:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0126edsm7306458a12.7.2026.08.23.23.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 23:49:25 -0700 (PDT)
Message-ID: <f2ab67d9-e1e7-4ee2-8bdc-abf2e6b4baf3@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:49:23 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 touchscreen
To: Luca Weiss <luca.weiss@fairphone.com>, Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
 <20260821-fp4-hx83112a-v1-3-474941bd8860@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821-fp4-hx83112a-v1-3-474941bd8860@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DsJmPm/+ c=1 sm=1 tr=0 ts=6a8be977 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=2kaJ5Qa3FYFKpuAPAowA:9 a=QEXdDO2ut3YA:10
 a=AYr37p2UDEkA:10 a=crWF4MFLhNY0qMRaF8an:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: BY2EIP_Oubm1hzYhdmLff1FcibQ16IN6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1OCBTYWx0ZWRfX0DGz7Biji9RL
 oeLHYQharXOCmmhnq+MBbKvZ4CGUqpYkDTrqRCzwzaK6hM8wRomFWlRyqikA4fanYTTppxw2xqQ
 LVaE/l2XZBziyvQpO85ELlAr3dvqYPXFNh2IlsnABiEmz3O4qA/VpUrZ+tWub1F1Gxn93Id42X4
 kpLNUkgqOyQKbFz09yLrucmZbPfAktroO8em38gfUsg1HZ2/B/hmj7mLBpcG4JOSJYiVjRBipJZ
 ObiVpDiVCJTX/S2w+Pcy93bnA6sJ38x+54Qpvaja0r/Lbl2VP8LXzQDwTersUH+z11IpvhtJNnB
 tEKJFZEOzUcsCB3rh8YpjoOezzQWmp5XI6jCACqGn+6rEFRTZtWwjKIEB3zRLPv8Xlc62/cKfkH
 aD9kluW6VdaErfvrl53Y06mDfpmIosTfHr8GLd7T3UKAAtgRxWghjgVrENRDJG6PIWMLQePbQId
 TjGF8hbtBmlzCai6Zbg==
X-Proofpoint-ORIG-GUID: BY2EIP_Oubm1hzYhdmLff1FcibQ16IN6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1OCBTYWx0ZWRfXw7U+v4iysOdB
 +aXsgOGayRbl3qQOUeBZ4byp28gzf0fJC5ts0V9zHykC+G1yBoSGfK2801+aU+l3Z5yTtaCz55S
 SQy7s8/x/OoDSG/Mz8D5IVS6nMTWHvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240058

On 8/21/26 9:12 AM, Luca Weiss wrote:
> Add a node and pinctrl for the Himax HX83112A touchscreen found on this
> phone.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
