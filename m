Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A6375F9E
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375938; cv=none; b=Sst5gAX3oKThOdAHPp6iOvnQHXFjSBtl1EsgSPo+rfjOHiRWAwERZBr4iq8mAPbZRVDwcMqOxLNj4/5JnxV9xTZwnUe7T+3mR3URoFS7numjpIy/dIjRc3AQHDQM6120XalXei9ZwQkwFE4cOxyoYR9lmGMcrPL2a5y93jlAlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375938; c=relaxed/simple;
	bh=OPhLm1rJuIi/m2Pvh96og04FAYQ1yIsttDFmqZKVvPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAcDP1YzYiKiBUXHG1Ln4YzJIG97zV+7FfAA/5AXuawsAWA7whA00aZqWsGIttgGqb6ArlklBuZdTaigzxYjugaQs/8lYTfoEtu8K7T0zG7mGNG3g7VIn3LMTMNrH9RemvKHzIOE3dJPAYboFgo1pk05+ofDBY/hbY4q+vzhs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y0/nxr4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxhUfiU0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0/nxr4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxhUfiU0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eaKv1192394
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1hkulWBVykslW4PgXVL5UYKLv2kiiaA3D+8uNzq2FGA=; b=Y0/nxr4g48zscEjE
	vs3fahqZWVg8cCh39meTKghe/FBOXlbW7HUTVWXKunt4w/wL0UOd8ZMidqvASI04
	sC15nSXITDL7PGM5nTEILjsYMLYKQBHcq/1Wg5zXdhTCVBloh42PALwhh2F+abXY
	laXylebvd9N6wH1DwSlbk1FQ/USqMcSq7P3d7/nDHEveotJfXTvuQNoKkn6bAkrH
	HXgjcZCXOkLjrAGTd7eLrTqFqDCegd9Ugf2N1fYKaL6PsB9rmOT/Pox0DzvrGO2h
	TlzDD/4BLTbFVekbFuZu8O0TOHkhcXKunu8ip069dbAdLAaXxZkD+Z110qEtIsaf
	vXxB3A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmh8wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:25:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8d37bc61dc2so5368066d6.2
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782375936; x=1782980736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hkulWBVykslW4PgXVL5UYKLv2kiiaA3D+8uNzq2FGA=;
        b=kxhUfiU0OqiNPEsmj/mRElOYvadwdxdjY5+wyaEmyTxApmWMl7AbohsNPLpy4gEQXN
         /wPRcD832yOuMJVTPQAaKwJQ+fj3YbSOrTeENbsuGCgBfmHLquJg7XfG4w8Wwlij4JSA
         0ZnoegLV/duNVG4wBurPiYN700EOlE8xUmBqWH4/joEK09LIVaifVPEs+9oONNEUPPAX
         QIXdh91+wc1zptubz+0vjYxL4vNRUMGUHQWIVXC2XOf8HefPMnGnm3nnErzPNYIwZxZq
         9PBCf/hPd/8oQk2Thl8QdoIsbrHwt7emz/Cje56l+xBVo+G0GKQMJOgR/iA70poxesr6
         NkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375936; x=1782980736;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hkulWBVykslW4PgXVL5UYKLv2kiiaA3D+8uNzq2FGA=;
        b=fVEON7cGPk8ghSqze6BxUtv5Jq8XkY7MYa+oKT52uKkKvzNB3fltqKXtsAPi7uRr3f
         2LSmcVtpQfCOxM/K6nE3yG9O/tL+RQvb9uRUPxMONCnYl9m+QIUXmCbcuF/qmkP7IREG
         Zj4vbgCjWmvCNBZ5416sDnV+Nnqtk0OEguaANkSnhAOFqNzMVabDko39btfbISq7Ex59
         YBzD+iNyRb6vvUwtpDwYCA40nQ/ed/oJGkep/bOXVGEhymOCq1tdIha1qtnBl+kUkAlb
         yes8IF82VUtQot3DHpnNcZeXtf1CKTlLVxkny8rjwPqRCYrfO9TYPtIh6W9sctSHFtLP
         j1zg==
X-Forwarded-Encrypted: i=1; AFNElJ+vimchf/k+FQTYaOLc9hqbqR2AEPthj86ybBSs0XqXKF1tc+5MXS8s5Kp3qcGBkaeLzpL+zuDMrFw4PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgPXAIBXKO1o2mIrkwGLECaiM/qauq8d2dMu1dmIgUHc/hzsc
	DHP6v/RKJKoPtDTm8+ln9IQrPR5bt3+0Lvx1ja/ypANgw8kvvsffyiy3X7DRelbWLrDlU1P0WTI
	ZKRmvFsv4r6ay1YBdNIZ9ZbqTV9Svf1chU/jRMMBQA40180Aq1ZZTTMLAdZC6mipBgg==
X-Gm-Gg: AfdE7cl/k4vTheFrk/zp17+acBw/nnZ0869z493PIJeMT3kIClrfgVRSc/UBvTgDHbz
	xOVH57UL6DMqsU/bJeiawsRe0NQIaMIjy/QxgrNPXmfdB1ryIwavQOJ4YDlpRXgzHk25teOxRoi
	rOOTF7sMlIlo9g6XLUp6+3WPnhdHqzit4Ol6RMDofiF/VXidJQb0Ty4DraHEfB1JCx1LJLPJT0J
	WblTocKLwtU09z+hJ8UqMV6Dy1/foKpmCBRhF/3wc3mnvnT/Zc6/iWweEHPfKK6mVe4Vm3RPn7C
	05njU23lnfSmZJfjdudB/BbfJ8DVbH6gmtm8gUo+T+fvl+uGxUSj7EcxC3kdm0spwEjLgZxwEkd
	Np5gGeY/1l110lcfFvYXtlUpY32euHoD3nCU=
X-Received: by 2002:a05:620a:258a:b0:915:2b2b:fbdc with SMTP id af79cd13be357-9293b572b56mr121494985a.2.1782375935572;
        Thu, 25 Jun 2026 01:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:258a:b0:915:2b2b:fbdc with SMTP id af79cd13be357-9293b572b56mr121492785a.2.1782375935031;
        Thu, 25 Jun 2026 01:25:35 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbaa5desm128737766b.2.2026.06.25.01.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:25:34 -0700 (PDT)
Message-ID: <7d8064bc-4dfa-4990-ae36-d68cbc9cdc9a@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 10:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
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
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
 <eb693705-c0c3-427b-a924-5aa907fd65bb@oss.qualcomm.com>
 <1bcf00ae-2558-4c3a-970d-aee1da0c06f9@oss.qualcomm.com>
 <29806448-0588-4590-8540-a689ccf1e7b0@oss.qualcomm.com>
 <82253653-bd85-45b8-8520-e2bb213ca48f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <82253653-bd85-45b8-8520-e2bb213ca48f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3ce600 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NcuwlND7g3vlKZA_ufgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfXyP8u6/CG6Lvy
 7Bup+RfH2DaYNeogqdKL2hqqrZylBreftebZvt0Z6nz2RRtbbd57e2Q4BagjuSSrBJruie5FT0Q
 kNiiok58RPcCCUVX2xMzlBYxuVgdiSMLxmqEv+vzBJFsBLNknRaEn7rXGil9oAWKpvQ67g8orbe
 gHQWIxfjZe46r6Qh43jhaKYdAHnbU0ZaB4vSoaFtLGMocMEpU6ZaxPFdoGF5wSmxXfoKJsSV3n2
 mXUc/VR0Qoyj9TQChq2AG5PpoDnI0cKAqPElA321euXO5iJwCTNxBuIb59UE6fNd1hEURWD+ZyD
 VY89YQubV3bcwrbsfQUyB8sme6KySDtFZ9U60or1v76epmARQPMU19Mo8E8lWqMCjkZErTMDEMU
 scr9hRVnaSw5DY3qviBbFZB5mSTgS/OXOHAHDhNzknsQIVonC366VYdrtFVwRjbhf5dfqnBDn/7
 eeL8L1dBTnjD5iqxfhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfX6OlTGoe43heI
 WakvYvFeeUFVrWytqbasD9MeEyVQKL9RudjeiPcahVnVqPHkhZJU5b1j8+8vWT9ZkfBQy21G7h5
 Ep4wrWgYA4ogoxcQQWXosxvStTkTmRg=
X-Proofpoint-GUID: HpoYmEJiPJv6WoOHowKhgM-UVTYy8KtI
X-Proofpoint-ORIG-GUID: HpoYmEJiPJv6WoOHowKhgM-UVTYy8KtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250071

On 6/17/26 12:12 PM, Fenglin Wu wrote:
>=20
> On 6/17/2026 5:30 PM, Konrad Dybcio wrote:
>> On 6/17/26 4:31 AM, Fenglin Wu wrote:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ptn_bulk_write(=
h, HAP_PTN_FIFO_DIN_0_REG, &data[i], 4);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return ret;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 for (; i < len; i++) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ptn_write(h, HA=
P_PTN_FIFO_DIN_1B_REG, (u8)data[i]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return ret;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> So if i'm reading this right, the first loop will always write
>>>> 4*(len//4) bytes and the second one will be entered at most once,
>>>> to write len rem 4 bytes.. should this be an if instead?
>>> I should put a comment for clarification. Here=E2=80=99s some backgro=
und: FIFO data writing supports both 4-byte bulk writes using registers [=
HAP_PTN_FIFO_DIN_0_REG ... HAP_PTN_FIFO_DIN_3_REG], and 1-byte writes usi=
ng the HAP_PTN_FIFO_DIN_1B_REG register. The 4-byte bulk write is more ef=
ficient, especially for waveform which has several Kb data, and it helps =
to reduce software latency when loading effects and reduce the delay in t=
riggering vibration. It also helps prevent the FIFO from running dry duri=
ng data refill in FIFO-empty interrupts. Typically, we use 4-byte writes =
for the initial 4-byte aligned data, and 1-byte writes for any trailing r=
emainder.
>>>
>>> So it still needs a 'for' loop here since the remainder could be more=
 than 1 byte.
>> Right, I mentioned len rem 4 but failed to notice it's a
>> single-byte write.. anyway, a comment here would be good
>>
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Configure the hardware FIFO memory boundary.
>>>>> + * FIFO occupies addresses [0, fifo_len).
>>>>> + */
>>>>> +static int haptics_configure_fifo_mmap(struct qcom_haptics *h)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 u32 fifo_len, fifo_units;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Config all memory space for FIFO usage for n=
ow */
>>>> What's the not-"for now" endgame for this?
>>> The hardware supports more modes than the two currently supported in =
the driver. One of these, called 'PAT_MEM' mode, also shares memory space=
 with FIFO mode. However, 'PAT_MEM' requires memory to be pre-reserved an=
d waveform data to be pre-loaded. The entire 8K bytes of memory can be di=
vided into partitions, and it is configurable, with FIFO mode always usin=
g the first partition [0, fifo_len], where 'fifo_len' is set via the 'MMA=
P_FIFO_REG' register. 'PAT_MEM' mode plays waveform using data preloaded =
in a memory bank defined by the registers 'PATX_MEM_START_ADDR_REG' and '=
PATTERN_SPMI_PATX_LEN_REG' (they are not defined in the driver). Since PA=
T_MEM is mainly intended for hardware-triggered vibrations, such as a sig=
nal from a dedicated GPIO triggering a short vibration with a preloaded w=
aveform, and although it also supports software triggers, I haven't found=
 a suitable way to support it well into the driver under input FF framewo=
rk yet. So, I am currently allocating the
>>> entire 8K FIFO memory for FIFO mode only. We can adjust this later if=
 we find a better way to incorporate 'PAT_MEM' mode into the driver.
>> Sounds like a plan.
>>
>> For the other mode, would that GPIO trigger need any OS intervention?
>> Could you speak a bit more about how that works?
>>
>> Konrad
>=20
> I'll try to clarify the 'PAT_MEM' mode further. 'PAT_MEM' is useful for=
 latency-sensitive vibrations because it preloads the waveform into a fix=
ed memory bank, then it doesn't need to load the data of the effect in th=
e HW before triggering the play. When playback is triggered, it plays the=
 waveform from the specified memory address and length. This memory shoul=
d be preserved, and the data is preloaded during boot. Unlike FIFO mode, =
it doesn't allow data refilling. The trigger can come from hardware via d=
edicated GPIOs=E2=80=94currently, three are supported, each mapping to a =
memory bank set through specific registers. Software configuration can be=
 done in the bootloader or in the driver probe, but the 'fifo_len' should=
 be adjusted accordingly. After setup, software doesn't need to manage it=
 further, relying on the GPIO signal to activate the playback (for exampl=
e, a pressure sensor triggering vibration to simulate a physical key pres=
s). The trigger can also come from software using
> SPMI commands by setting the play mode, start address, and data length.=
 I previously tried using the 'FF_HAPTIC' effect by mapping 'hid_usage' t=
o a predefined effect in the devicetree, but later I found it unsuitable =
since 'FF_HAPTIC' is mainly for USB HID touch devices and not general vib=
ration usage. If you have any suggestions for supporting 'PAT_MEM' mode t=
hrough the input FF framework, please let me know.

I don't really know much about this part of the kernel, but at a glance
FF_HAPTIC seems to be roughly what we're after - quoting the cover letter=

of the series that introduced it:

<quote>
Haptic control
=2E.............

The HID protocol described in HUTRR63[3] must be used.

The following waveforms should be supported:

| WAVEFORMNONE             | Implicit waveforms required by protocol     =
      |
| WAVEFORMSTOP             |                                             =
      |
| ------------------------ | --------------------------------------------=
----- |
| WAVEFORMPRESS            | To be used to simulate button press. In devi=
ce-   |
|                          | controlled mode, it will also be used to sim=
ulate |
|                          | button release.                             =
      |
| ------------------------ | --------------------------------------------=
----- |
| WAVEFORMRELEASE          | To be used to simulate button release.      =
      |

All waveforms will have an associated duration; continuous waveforms will=
 be
ignored by the kernel.
</quote>

(i.e. reword 'press' to 'trigger' and we're mostly there?)

I'd start prototyping in that area (maybe taking it out of drivers/hid/)
and see where it goes. However as I mentioned, this may as well be my
wishful thinking.

Konrad
