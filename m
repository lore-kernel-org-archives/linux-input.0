Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F519005E
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629176; cv=none; b=TyG0KwbZQnMCips6/I97SN9DTyfjUrFq0mS0P68Wl+oEnGwzWkWxXkEuiTCqCVK3rFxTenoitX9TjlTHpvESDKpYlRtEyneRdqfpsE/+8ge9qCjNmLDi88Zz33HpfAApflMDb8NJT6qQ9lC2f+Vhkez+/7RDtUu5bG6Jecr1GuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629176; c=relaxed/simple;
	bh=b5JACez2nK38fxDSCnVCINWrSOrr4lZXyjQAUn2KU1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPFEC7RW/V7b1UXmcKBv+7ENg0c+RmPOOhLI1lKZBtP1rsumnTEWOKb9NgI93Tz+giLA5lw9ki4VIi0Gv4mb7xgVZCD4WGKFH6j8063HUvMCFsiWDRybeTdP2p5tDGyZLMSafYps5S12+/+huhog9RiGr1uMDguEcJKQEMcPNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rh/ABkoE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Whe7MsnM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rh/ABkoE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Whe7MsnM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R5OR3741460
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	84HwQDQ0U0qytZHjgh7YElDDyTGY9iMA6qEWfxiQS7I=; b=Rh/ABkoEOabv9s+i
	vosYXnrH2fDLAlBacNZ2SpgUMInDQP8D2OAymZQDMvQHbylwKJvI/5a6Q6kf517J
	3VkCc0imrBG/U70b0ZfHJ2brAgybv42s9+vIsDBOPAJFwMyVjAm3stEVkojXLBUN
	/ImbNS6y9lBWSXSkYrZvwMH54nzLwKR0jePDny6EMnHRc9/yZ1jbDxID2AN8LCfg
	4m/cEFfJLzgQkOromV5P3eY20MVlxWUcQqCR7uKIq3+UdiBTJf8k/aTiR/tKsKUG
	ZKCwmHl5KQCGdPC5VjMb1EjsmNhkGLyNwVKzePyyN9d/55CJV0IgMTuev2OPjqjc
	u9Kg9Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv7bssv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:39:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so446123a91.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 20:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787629174; x=1788233974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84HwQDQ0U0qytZHjgh7YElDDyTGY9iMA6qEWfxiQS7I=;
        b=Whe7MsnM8zqqRYwL7nPmPASPe3IcGa2adwjCnCiFSFGodWTj2pkYeHSWZe8OF0i8mK
         aQmmjRxivddLGclrVe9KfRpTSiQ97+uI0sZl8DbE1+l14KbWSWnDSw4FupdJR0b1//Mo
         orVtgiUcGfa+b84wdRWjZEl0g5Vh+LjuAQx+3G/aH9J74EBV8gwMGjoin9A2YfHTjtyD
         xWKYcO+2YuYlC9isGl7VsZWuB3FZFh64Dzl5MCYMu3K9lfZX3PeRxMYthwfuGbThJreQ
         7CdykMFKvDBNu2VfaAGVTRtVcY+4ZLy1tGlZ2AqXIejQQQ+A31Wgw+LfRtYcWk3w1ARi
         B6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787629174; x=1788233974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=84HwQDQ0U0qytZHjgh7YElDDyTGY9iMA6qEWfxiQS7I=;
        b=pNkSwwJFFN9lQ8BfsUNatKHsW2M9YY/vWKkdIiAGzwOGvA9cjshA1mIxJ1WbXNdPVp
         mmhvFGW0HwlBqSx89W9tHohrCeKoR2x41Qjb4tq5NNHoNfsu7kgG2mR5zwFGg6lqyBkr
         zeBLOBYZjfAc0yauMH7gr2MYInKsW73VI3abf3i4bjZNvcs7nnhTB0wmy0FWuftspvn4
         uPCJwfabyfNVnZUhUkRqu6tS29ZxXvEVtP0nCCrC8UrtwsbEyUWEVHbmpyhKt1CqIj67
         EYJPenK+1kqBcL8rNw/6DPQlum3RiPdn5QUzk4c70PbdbhhYrqvCPNH8cjpyfjaqlEXA
         LCdA==
X-Forwarded-Encrypted: i=1; AHgh+RoYicsTAiZCfql0UIK7KCrzxzQb/RjqUyweQgXAGwncA7iQPNXylt1GpkDoA4Yp9dXlZaQ+VALDDyj2fg==@vger.kernel.org
X-Gm-Message-State: AFuF++nLynNFQFJToq9eeK17rtwpG+BU0FcAcMTYx+73+N7TBT02W5c2
	XAwXZiKxgXX0vrBtLeE7EK4VvC7dY6n17lLTBZeDLXkgEj8Ym7yzXnJbBAtg6RmAUpOaOgEKAJY
	NKMAAQTT2SPpCnMDVoFKITjO0QDjz/V2wJl1Scz+ElsMXRMsmj9kufyUS1RghpH62dg==
X-Gm-Gg: AR+sD10eWtwIhLdM+DoGSt3m6KrMxu3oC1Y+fbEovDnKXHfMAxRr+c5fW8VD9RLDBn6
	oNmt+Ws0tFIchWieGlmmSumbeqvDSXZKXQl98z/++MG+qSl88QaKl3zhAx+t2GBQRS/Zw5AOa7H
	03i6tbdD36p6icBtYGwefyXLRnT7+lAeoBuUjULvQM4TQmV7oCJu04fJIUbZOgei9DmyI8JNEsI
	VT4fVZms4HkkcjSk719hqHpfdQWloTyPiQr9k03m7P7auh4nJv19BeYjCNzlYLEBr6YzJiV0edK
	tLTHoHdqEvx4C9u5WfaC63smpIzGtNHMS2VRjUwdsftIXPdiazBKlb3lW3Zc3qNdIz1AMa1jM0l
	38LPJe8arVsK8p6UYmrKeEB4ts+gYW7JPT3qP1WYZFO67YWxb1i5h5CcDyib5NLwnUCbz
X-Received: by 2002:a17:90b:3e50:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-396459f432bmr4215573a91.2.1787629174238;
        Mon, 24 Aug 2026 20:39:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3e50:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-396459f432bmr4215543a91.2.1787629173814;
        Mon, 24 Aug 2026 20:39:33 -0700 (PDT)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm1916325a91.9.2026.08.24.20.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 20:39:33 -0700 (PDT)
Message-ID: <ee493f8b-aeed-4481-91e3-1a17297a2bec@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 11:39:28 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
 <214bbcf7-38ba-458b-81ba-d7f3a42cb73d@ixit.cz>
 <7df4c69d-9d7b-418f-b7dc-a03a710dfb13@ixit.cz>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <7df4c69d-9d7b-418f-b7dc-a03a710dfb13@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8d0e76 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5_8ev1SDl5wn8iQIMj0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfXwNln+Hk2dmLK
 79RunyCzLjm54N7TBkc6F2lUqTOcMQGF4fabydsnrDyTYT6ZDWD54/e/SqtX30EdwQuhE+sh/tF
 0H8LpGEyiRmygtTEzbmiPYeV8vCT0aw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfXzt9s6MAkp3Z+
 GLytP5mOd9h0eyYNm+fpnXFyF3CdCzPkiByChtVdMU4bXlHRfEOPvlzvz/gKoyCkACKQb2WtESu
 c/WF5cio6nz4WYIqTxNWuDpKXn9kEvHpfa8kweg/FNUGTsD5oAJeDrDEltwXEds5sSN+BI3K+05
 z9Ph2a3xlYkuDdWqi3Qlm/5Cyz3LE/I5ID06BBXOkxSY5TrMVGfpBjV2xPNy+xedIWN8CV7TmOM
 4q+nRIbE1bg7GiwUVwEMuz9iapJfB/FJaxqkvmvgoIGEXzQd+Yy83DVROIHtHQLZ/nIiEau/Dxl
 MdUfiyij1Jnv07utgRw1jH9QJk3SZh4JNKuu0V2jSKALOZVZbtfIzUlr+DznqCGtKvac5et6gpf
 ah+O8h7WJT6PKtf9VsPG+bOzOHPXJGt8EQwV1+Hjbgghvn/riuELjWXn3hjoKA6rwiCDJ3oxKDm
 Mlb4I/2ZwZFOIQL7PBA==
X-Proofpoint-ORIG-GUID: I0QCKJMe-wRZHgrDMG--7wS6RKm6i1o5
X-Proofpoint-GUID: I0QCKJMe-wRZHgrDMG--7wS6RKm6i1o5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250028



On 8/23/2026 7:36 PM, David Heidelberg wrote:
> P.S. Could you post together with the PMIH0108 device-tree part and ideally the 
> device integration you testing with? (or at least share the WIP DT, if it's not 
> finished yet)

I left them out when I sent patch v2 because there were several
board-specific changes, and it was easier for me to revise the driver
change without them. I’ll resend them once the binding and driver
changes are accepted. You can use the example that I replied here if you
want to test them out:

https://lore.kernel.org/linux-input/02269d67-41e3-48eb-9ce1-e3775a4c2eaa@oss.qualcomm.com/

Please remember to update "qcom,vmax-microvolt" and "qcom,lra-period-us"
parameters to match with the LRA actuator that's mounted on your board.

Thanks
Fenglin
