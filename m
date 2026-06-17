Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DBD3D6CC1
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691188; cv=none; b=YrjGuSjk6dm/5/Sxkzxuq0+hawiMIsuiLk924xg0EA0/2jAzeGbQD6lomlMthNCtDvDuDlbqNsfBGWkUSqLgGLqLepyVRL/Ci3RjjlMQuEU2ZtqZh9QAlJ451/xNlLJI8P6tzPkJo8fCNMVPY+E2w0vCIgYHOFdG8EDM6m7n8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691188; c=relaxed/simple;
	bh=UoM7xrBB+ZCYmns2vLjYYzvl9XGVdcm9LQNtgl1qOwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLLbaomigXtOaWRRAc8ZyJ/iqipu/fhomR1S3kno5McIh5sn7a9+PxebFMfShLQeNinNRDASuA0tMn7honK+ZqcsAqtnX34/t/ZGTokbHhdQ9mCWE6BeIsjrA5VekLZQNXVsD0nV4yEXePryONbNGt9yTmuAWk2bUQ15DSYaL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gia1PQyo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QG8DBqi/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gia1PQyo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QG8DBqi/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8VeKr2191096
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 10:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GZ/8Xv192XsFQyD+0JEt9/9tPuIbHQCOMoIPHcWB8s0=; b=Gia1PQyoK8Wo4nRQ
	MCkM9D63pFLVuXGmBdXXtWmIH3/G+q1O4nPtEYiqafAKZTVh5otx8I/5fwxadXDw
	D7/1LCAa97Ve6vWnk/AX+uuVVSc0cwesnJJ9GkDSiUVrTAE84D332vGY8VWlKiMU
	DunK/6CPNdS/2ZzPPEc0pAZDctSCcWnPxgiYb8FrOagNcVrVTSmPEEIa2JWIh46m
	q7sBPWNPwopa2CoPWiIco3/N5HeMrNgFcE5ErkEFxxKuJ0xZsCj4AhOBiginqo83
	hSgrzCQpcd4D51dRHcwRbM827kk1b5Evm8UATWHcDV8+UCw+cucPPjuGaKF1SpAQ
	A7Ijfw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjmfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 10:13:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845319bb97bso130791b3a.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781691184; x=1782295984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZ/8Xv192XsFQyD+0JEt9/9tPuIbHQCOMoIPHcWB8s0=;
        b=QG8DBqi/UfQgXGLZUG456VDA1bkiMYFrK2ZA+LkKhZ8PEDwH8djOeN7aanEys21XF6
         Fgqlx5Z2P/3OHW2yWeRKH91By+FjZmn9InliMSlhMOKfE70pWBEd9n4MRQPS4mBfx5Ij
         kw5glDOe4ojCVLUTM5paqqNVkgeBKKeoiRlMEZ5ej4dEJWc5fvxaLmj+BxQ0T5w6IGvh
         4KA+pVSFPnG5nVUU8a+Vqgv6SQvhzKgTMjtfTB9SXh6WB8oroA/3sxJEYBH5E4lc2Riq
         gww76UR2RkjDt+3DS1Vg0l4mZrMvoNIWj08ORIyPApwDlhBnxCQTM2etDJVtf6gP2cXJ
         YpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691184; x=1782295984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZ/8Xv192XsFQyD+0JEt9/9tPuIbHQCOMoIPHcWB8s0=;
        b=nFvdcRXNb7qXZCty178gUI5WXt+5MyZQqMNiMqpV5OnveXwAmqeiSew5Pj1jMMR88Q
         WjOGMOzb9Rk7J1uZ3if1/gx+mdl9+1LRTkBfyiMhWefgea8Io+80EqQ3aRDk1iWLZ87P
         +/WeVpEvN9rrmVSnNbaZdSM2Bl0g6qtXtJGgIEggybfD7Iaa42fc/1Kjxcm6R08nMeDD
         ztjJaVcB5qbBOq7+obYmyTqlzl9Kk6n0B5hTRgTJpTt+ySqWoAk3pgkulkpOocjeH1Kt
         HlAtYmo0vZKiCePZT4XSB+D33Qy7pu+0PBxoaA4mZqd4mdphaYPvw0TmjwSsjfJIrBIr
         zrAA==
X-Forwarded-Encrypted: i=1; AFNElJ+AKUmdVKyCMX2Y7tFhz5a0BWgrVfiMbyPPzcJiDBvGqH802UkQuxYV5anMUtdFTTwm/3xmDzHaJ18Gsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1zL0ZECTrW+XlcpTuieiIhzk/1PfjxZ3iu0INdziL7E1M2ey
	FqCUDAFkU/RPnppofBeAhUdR982oLLR/Cw3Q6/3atp/ZcTC8Mrhyd/dOKIZ82dNUausInci2qeU
	KdnRnP4LLId2Ea5sW78fUny9qFqV3tG1DPZCut5skxS8KkJ/49xUIn96sm60G68xzmQ==
X-Gm-Gg: Acq92OGl6EZ0X8wqp8WfaLxTRdMqK9jBwzgwTga/TQ6YwrmJTuYu7qvI01z9FjeR6+Y
	YkZsfaxlpwnlc4l8eULtWJ+2rsJmXo0HxdVybaI2aHeLC69n9hY/mIVsV7PABJu0kKoFq1WJVXO
	lTdLm1n6w9KDJL0fCOKjWaAStqHy3mkhs/F8uNpqCmk0lSD/UfNzKWukhWgw0M72iF0jRL2lnfK
	e0R4OpS60WbYI3SbnSwWN4rM5wAP9/x8aAX1wm2zUt/B0ikTukwt991MAfxQAXjF1jxDLpRd4d7
	hfemBgPGSlnwlrUUTzpqGCdiTelNvduabje0OPkIwodKClFgstfksk1nrYykNNu1ILFjS4QnYc/
	V9gOMvX47XgqeZ5kd5hpqK9EhxwLZNafTXFM+plODRWWTuSALsX/FtNQ0um96actk3erPY1Jufl
	DUXCU/
X-Received: by 2002:a05:6a00:94ed:b0:842:21f0:5114 with SMTP id d2e1a72fcca58-845245659c2mr3122555b3a.30.1781691184477;
        Wed, 17 Jun 2026 03:13:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:94ed:b0:842:21f0:5114 with SMTP id d2e1a72fcca58-845245659c2mr3122518b3a.30.1781691183961;
        Wed, 17 Jun 2026 03:13:03 -0700 (PDT)
Received: from [10.133.33.101] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm16026068b3a.12.2026.06.17.03.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:13:01 -0700 (PDT)
Message-ID: <82253653-bd85-45b8-8520-e2bb213ca48f@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
 <eb693705-c0c3-427b-a924-5aa907fd65bb@oss.qualcomm.com>
 <1bcf00ae-2558-4c3a-970d-aee1da0c06f9@oss.qualcomm.com>
 <29806448-0588-4590-8540-a689ccf1e7b0@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <29806448-0588-4590-8540-a689ccf1e7b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NSBTYWx0ZWRfX/ErShyecNYPr
 rfHF7Og2ayj2NgpsmlLwvadPTP68Kzx9GxALDcSyZG1uxbbipWVgjHN9ekqyMoiORmeciwvY/lp
 ybm5p9Wfx7cL1C2UtvvfyJwgoRBOKlB/j55mtoAMwJ+w1L0kChCzCzOv3wejw8mil2767LAfkGp
 za2R3Lv6SYMoO0GIer5wnwgDJZD6BnrcUrEybw8lWu9B6Y10Xh8gfZvYeeg6Yd9YCt4C4N+P58f
 Opad8tI4sRPaydKxrscOZa7pRUaxzw1c4m10QyXhn08QsiHNqgciswEfdpwrcStx1LIpRiRBsQl
 wXAcM3Q17vNRPpf07pixzcm/L7VSvP3Pnvup2FBVoNfRw58euVYZCGbDV3c0pqzwAMkRqLXvmSm
 /hbYrY253D14od4vKgmLoxYKgtkz+zhngVFdF6EhkxjisOXrzyZWYcJYJc2JiapgeGIhArEDN88
 UAKutmhRVp9WTaCY7Cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NSBTYWx0ZWRfX8RVkZvFn2OdT
 UhOAMF7lqQA62HzISG+zfjJus9eIDnOLKZOu4vbFPPyS/etWjGN7r4aIYwGxfXX5E9kxU4KQTno
 JlArzTBHVgMPDvrmNq5C/oWexS0BmVI=
X-Proofpoint-ORIG-GUID: cb1QiT9nnT9inihHwQdaSEfUnY83yu3x
X-Proofpoint-GUID: cb1QiT9nnT9inihHwQdaSEfUnY83yu3x
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a327331 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=3bJTXa-xiIkwHRLKEFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170095


On 6/17/2026 5:30 PM, Konrad Dybcio wrote:
> On 6/17/26 4:31 AM, Fenglin Wu wrote:
>>>> +        ret = ptn_bulk_write(h, HAP_PTN_FIFO_DIN_0_REG, &data[i], 4);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    for (; i < len; i++) {
>>>> +        ret = ptn_write(h, HAP_PTN_FIFO_DIN_1B_REG, (u8)data[i]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>> So if i'm reading this right, the first loop will always write
>>> 4*(len//4) bytes and the second one will be entered at most once,
>>> to write len rem 4 bytes.. should this be an if instead?
>> I should put a comment for clarification. Here’s some background: FIFO data writing supports both 4-byte bulk writes using registers [HAP_PTN_FIFO_DIN_0_REG ... HAP_PTN_FIFO_DIN_3_REG], and 1-byte writes using the HAP_PTN_FIFO_DIN_1B_REG register. The 4-byte bulk write is more efficient, especially for waveform which has several Kb data, and it helps to reduce software latency when loading effects and reduce the delay in triggering vibration. It also helps prevent the FIFO from running dry during data refill in FIFO-empty interrupts. Typically, we use 4-byte writes for the initial 4-byte aligned data, and 1-byte writes for any trailing remainder.
>>
>> So it still needs a 'for' loop here since the remainder could be more than 1 byte.
> Right, I mentioned len rem 4 but failed to notice it's a
> single-byte write.. anyway, a comment here would be good
>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Configure the hardware FIFO memory boundary.
>>>> + * FIFO occupies addresses [0, fifo_len).
>>>> + */
>>>> +static int haptics_configure_fifo_mmap(struct qcom_haptics *h)
>>>> +{
>>>> +    u32 fifo_len, fifo_units;
>>>> +
>>>> +    /* Config all memory space for FIFO usage for now */
>>> What's the not-"for now" endgame for this?
>> The hardware supports more modes than the two currently supported in the driver. One of these, called 'PAT_MEM' mode, also shares memory space with FIFO mode. However, 'PAT_MEM' requires memory to be pre-reserved and waveform data to be pre-loaded. The entire 8K bytes of memory can be divided into partitions, and it is configurable, with FIFO mode always using the first partition [0, fifo_len], where 'fifo_len' is set via the 'MMAP_FIFO_REG' register. 'PAT_MEM' mode plays waveform using data preloaded in a memory bank defined by the registers 'PATX_MEM_START_ADDR_REG' and 'PATTERN_SPMI_PATX_LEN_REG' (they are not defined in the driver). Since PAT_MEM is mainly intended for hardware-triggered vibrations, such as a signal from a dedicated GPIO triggering a short vibration with a preloaded waveform, and although it also supports software triggers, I haven't found a suitable way to support it well into the driver under input FF framework yet. So, I am currently allocating the
>> entire 8K FIFO memory for FIFO mode only. We can adjust this later if we find a better way to incorporate 'PAT_MEM' mode into the driver.
> Sounds like a plan.
>
> For the other mode, would that GPIO trigger need any OS intervention?
> Could you speak a bit more about how that works?
>
> Konrad

I'll try to clarify the 'PAT_MEM' mode further. 'PAT_MEM' is useful for 
latency-sensitive vibrations because it preloads the waveform into a 
fixed memory bank, then it doesn't need to load the data of the effect 
in the HW before triggering the play. When playback is triggered, it 
plays the waveform from the specified memory address and length. This 
memory should be preserved, and the data is preloaded during boot. 
Unlike FIFO mode, it doesn't allow data refilling. The trigger can come 
from hardware via dedicated GPIOs—currently, three are supported, each 
mapping to a memory bank set through specific registers. Software 
configuration can be done in the bootloader or in the driver probe, but 
the 'fifo_len' should be adjusted accordingly. After setup, software 
doesn't need to manage it further, relying on the GPIO signal to 
activate the playback (for example, a pressure sensor triggering 
vibration to simulate a physical key press). The trigger can also come 
from software using SPMI commands by setting the play mode, start 
address, and data length. I previously tried using the 'FF_HAPTIC' 
effect by mapping 'hid_usage' to a predefined effect in the devicetree, 
but later I found it unsuitable since 'FF_HAPTIC' is mainly for USB HID 
touch devices and not general vibration usage. If you have any 
suggestions for supporting 'PAT_MEM' mode through the input FF 
framework, please let me know.


