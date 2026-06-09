Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A403FBEB8
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006808; cv=none; b=NaJxU+duF6DfYQgfDiQcLZnwmHSh+nPXqNSzqNartk2vF1/xEWKJWEIid4H8Sf8UTi2gRB9TISRHtZTdeYVbQGOqlbE9zrMg1Ky16ypRLQvkaKsX0WTaaXFvXs2/NlHJachFse7c2JLje9JxR0/dr851C5LdGxgCCryuzjrxXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006808; c=relaxed/simple;
	bh=GYrQglqCkvMh/7QCT6j/Feex+tG7+uGK/6NcYppoReM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGMQFtGeK9drwJNwYH2J3SrFxXBiEHEyFzWYBpnD115B/gDm54z8+q7mpY8MA6NQrXIEA3pd46G90NjvhhBZojuZlkRTWnr7ATZ6uViayIyfwB4xRrOciOphxXJxMXYSiZcWVS0B0KbRwoN5kbdO91ASwmx5lp8yN9GcWqv1sUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mjl1JUb7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWK2iyj+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjl1JUb7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWK2iyj+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BnD5M2454311
	for <linux-input@vger.kernel.org>; Tue, 9 Jun 2026 12:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NrgTSnQ5pusr28eTiK6slUtsOUdsXM14expuobM4yjs=; b=mjl1JUb77yJ80ihb
	BQPs4y2lKxB92Xdk+TMsz2n/b/sg5e1NpR30pmuxTTpibb2+HpPOOhOJ4hYwRJDL
	C3U+2j7cvj01gzFg8wunnN6yaZrNU4gQhHBUyiMjPr+e367wueafSIk1LjeqUp4r
	bNHv8VBnfPcBKvlcBcbR3XvHyO6idmkGmvRakDBd5p0MnivJJ1IlgHWt8T1xVeAU
	nwznePQH03Ea1+/ao3zoe5uPxwoMwtDovl9y0DfKoOPA9rdJRtJ7Ri3l3jAz5xDO
	wOu5U5FagqXSUXPhXshLecyLHPftQEjIoT0WMqVM3lQlp8i/FFVMbDbhGnwDvtja
	h/SNgw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4h49j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 12:06:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6c7bdde6912so301667137.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781006805; x=1781611605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrgTSnQ5pusr28eTiK6slUtsOUdsXM14expuobM4yjs=;
        b=SWK2iyj+yb4HBkEg8kbPlxK63KrJsWoNyfm7oHZPtE2NBa/YYttQCRm2Og1Skt/JVQ
         lpjAldCA2ClquZSBwG985FoZLrm5C7p9AD/akncuoQ8VUoyQ9ypXjzxqw/+i1/UHPITN
         FUPKKdFSDIniJtm1ydJRc9SQIq84m+fCp17gEUsijjSFeidt8s6QjcMPXtQckV/U2R9e
         8it/Qgip2+h08JzrFeo4HopD+66xfmRW2DTyyT85+0FNNULxGHBfdbmFOGAcPmfKaIK8
         TmwVNSv+ZqxFhPGDi+Z3zERYGPwH/SGmQuaxc+ZMozdbmmdqv5u+qLX7lpqDf9X/eyTT
         6G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006805; x=1781611605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrgTSnQ5pusr28eTiK6slUtsOUdsXM14expuobM4yjs=;
        b=Duqa749IknQo2UagTwB6a2Oe8hKdaIPkdjOdWtNN3nuquwUojLIyP8B5uTZoTYCzhM
         iOqWO6V/z6L2c20rMgOGuRYbPk/dv+LXj2/jQtmQjNoznSv3HqCtOUbtzi6qtxKl7Jfd
         rHNZRWDIVdYay1+rgJynZzKEpRogbure1t8+7K/zk+MfMUxHwRft6iuIBO3WwmRbcpFF
         5WyyIwR3gl1McUWJjzxFWsHn/Infw6eCcltObn4mbNfYaOVC5pjCBlKlbpR4c2WgyfIg
         SmA0ofRmTneFTvyx7b1gMXo3zQxd/lZ4obNgp65fiGxmTw0ZxCptReBAyGMYhSkWczaC
         4DxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RRKIWhjiY1pdhAwC68zPUNC0+7L8qAxEznsE8AteIKjU2+ULJ8NZtwKGvtbK2lCYsst8fwCiZ3EzUMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAv+eRbgw1Gi2fiTbRadCA2jPoQlW9+Cw+rlTDUNIrjb4QqxpJ
	kjg+asUXuk3x52XMw8trZLJopPjbYX1Hme41IrA9PycupTW67inokGW6COH5+eyDyEGFYq7nzrq
	FIZn8XfIFC9EikTQpXoUq6SHSGJhaoohw+dEwtkMOuRZlr0VPsy/1mysGb1O9oxHlPw==
X-Gm-Gg: Acq92OFBVSu+nuh8VU21ERIzdAalwblnRqkDcZtU19tGZ2df4EJCvXeYg63Hnagnht5
	nZMH0JfN+hdhg1GL+3+32iUAuIsdMfnFKLBovz0wToKvFpTNJ4iWA8uGgNqJmtgeuntVjAwoODw
	jF1q4EHWzaZy65sVdcTsDIH6FCXxaE2FLQxV8m2g4zH01mmVtWahbPaNU5gawfbJ/fm8mg0I1wr
	0ZeG6QwbdScPjrSc47Er3zZXlWHoo4dfcdAmfBvnvI2CnMFNRVrodfbUAiDCYR/+PeJMRPncOv1
	KCYGFcA3bxGB5yzp/BAhvf7pNh0nkinEInR6j5ZbcI3RQs4Ht4A2g+qzbFCHzbH58cAgbVRofeM
	6KMb1em1+0dA6uQXY8XZ9LJJJoqK54ZxPRdPQcOhY7aTZmj3DfJXrQGoO
X-Received: by 2002:a05:6102:1487:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-6fef3c04af3mr3115210137.1.1781006804625;
        Tue, 09 Jun 2026 05:06:44 -0700 (PDT)
X-Received: by 2002:a05:6102:1487:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-6fef3c04af3mr3115195137.1.1781006804175;
        Tue, 09 Jun 2026 05:06:44 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f34asm8822920a12.4.2026.06.09.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:06:40 -0700 (PDT)
Message-ID: <081443d0-5194-4d4a-ba8d-a720d7f2e706@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Microsoft Surface Pro 12in
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, bentiss@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        jikos@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <4ced3207-a132-4ec5-a0eb-79f75f5cb4bb@oss.qualcomm.com>
 <20260609110429.11427-1-harrison.vanderbyl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609110429.11427-1-harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a2801d5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=yMhMjlubAAAA:8 a=lniaELAF3QKj_k3u044A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ZOl2JGgyGDqroijJcM-5qzdLm4S2cYa8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNCBTYWx0ZWRfX4a3WlztG4CAg
 5x16cdcSeeA/iisXIfERSjDWefRFAuwF2vuti1pS5qn6i4rrSkqqu4dcwf+iaZNxtB5WR44qwer
 lriUTq1+foBDN9zOXZu26FVA/Rd1xOIa3Nl0NIJ+ocNyPxYlQUlR8fhiL94JlO8rzsv5Mot9B1D
 dV5QRdfsC+UpuRPrkv4AGRbPQddHWF37oaJgaPG96uHHrTIBtzce4Cs8pjXO/zQzvg2es9kTAik
 ky8/9VYUXuzXupXTGIdUxyBUkb/68OB9E1+guV0OMN8S7TFOUeMrvqK81psro+KVENMNli7NUsP
 RAuZ102mi5Y0G3ZREFS+kzX97IvVz5NkCt07bzf1BrVgP1hUMULUl16x1DVjo9IznpJwF7R903O
 DDxFmULehBKYw4UNFt6dBmrmpbK3opSQyZkXfu8iXObtm4V0pUr0a/6JNd6wCjjyFaqLzgvYHR0
 l+qGvcHqPd4tm1UBnlw==
X-Proofpoint-ORIG-GUID: ZOl2JGgyGDqroijJcM-5qzdLm4S2cYa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090114

On 6/9/26 1:04 PM, Harrison Vanderbyl wrote:
> On 6/9/26 11:30 AM, Konrad Dybcio wrote:
>> Because we'd put the subnodes for devices under the 'status' line (DTC
>> enforces that), please move the comment below as well
> 
> Will do,
> 
>> Or since it's @28, perhaps it's just nxp,nxp-nci-i2c and it could work
>> for you ootb?
> 
> Unfortunately for me, the device/antenna is not present on the consumer version,
> I was able to confirm this during a speaker replacement.

So perhaps "commercial devices only" refers to ""Surface Pro for Business
12-inch"" [1] which is presumably an actual separate SKU? 

I initially interpreted "commercial devices" as "not prototypes"


[1] https://cdn-dynmedia-1.microsoft.com/is/content/microsoftcorp/microsoft/mlsd/documents/presentations/en-us/surface/MSFT-echo-surface-pro-12-inch-snapdragon-techspecs-factsheet.pdf
> 
>> Please align the <s (or is it my mail client playing tricks on me?)
> 
> The alignment changes depending on what text editor I copy paste this section into.

This shouldn't be the case, so long as you set the kernel-standard tab
width to 8.

Konrad
