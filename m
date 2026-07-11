Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29292309EF2
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783814354; cv=none; b=GQtaMPWT+uYtg5UX4yI3i8Ge8tmMzzggTcL+7qic7pNL3lBkcjUWXcsaKLRatLuTebqYDTL2psszRStC1i3uzXJP0cbAyIKN7GlHFKf8W0ef4OtSRM0BZ9id4aTQKkkRdzTVLVym7EJ/MM2fD58lttvzoCfLFdjWjUcXdrFm6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783814354; c=relaxed/simple;
	bh=3Bo1jP3FSrJ/y4Wz866thIsc0EA6jjA4gqz8ci/KdJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvblfT/Y0HCfn7DbdfjBg6hnFlwM84B69MqCCTatPjgBr+zqCJPQZY0RgtNrnMf0q61ZA25di1vql/jRFV4WbCVpFjK0yqrWIgzk6wfZzg3p9fltU42hUOzOpOyfRdB+qqtnyP545liGUTBvU1iSqZDoYoqZFvrGhiDFdpMkf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HUu6Urt4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ei3/OhLM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUu6Urt4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ei3/OhLM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BNM28G1068926
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 23:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=; b=HUu6Urt4UkB3suc4
	8C+HjX878a7MfVHOrKzdH4xZwbiH+OLt3kQbQs12Of+qJYw4R0gwGA+8QU6zwTZM
	EPr6+RQSt6qqjgDmXbqF7l78XIUmClPHm6VC27N6ITdQBZ/1iYZVtyvvMl32cij+
	e6igHBj3gwmCbzKvrXxsqD/SgBlEWBMmKH3eePgWbg8yvAafZ8LjQR3RBslmA2j/
	nBXuEb4ktaiyfqx0oDrfX/9SP7EEekWHLdJDPzs4UF3cMgFYAnQdjIU7B1VTDmrK
	QmByR/bovjAR64mVlLD41Uvq0E7VnnUQOd28hKhigwGEvFOhdodDvvqjPifemqBF
	Bch3wg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeaf9sn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 23:59:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacd6d37edso28527515ad.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783814352; x=1784419152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=;
        b=Ei3/OhLM3JGBjjwZBKK+ecaQ72UsY7bVI0E7rTspTPWKubA1NJa3NTbEs6L0GQNSfK
         bSrFcClKY+QFAgn2fCJHXDKBLBF+uJTEcTOfqaWJOYwgU/AUDut5XtYb5rlDDNQBmAFk
         EnjIeR7V0W95SrvmETh1TnXGXnyXJq7fkvNUu5TV7hKRYscgKorLh4wnh8IJrZIXSxPd
         O92ymTWBrzH/qOdpRaihDEy0TvxXtyhYcBPeYC4lT3WsNEtnX34/NZ9kPPtb6pnP7lrY
         9c/u7S4pJX5TYKrMdayrKvgK/5qLfCtrQ0OdCDbwV8QDQqPiGSMiK2RwUXfCwg3pL3EK
         0RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783814352; x=1784419152;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=;
        b=Vjkd+0Sip3kMvrWBN2Q49vp1vpE570sXcABHBKGTh1W5tIsB9Jra4VMQFB4GV1+hp3
         D2egq9ZqJ2nODyB673IDpMIUeOCJqGTxkjvJS+skOq4u2y6m1kWvoA+nKHU6TTzAU9nN
         t/k32eFex7A/zICaaxdr8jaht6NC+DXHDJhBX84QZ5CKvQYFRSCtd48aENRH3FZHtSEr
         U4igKGfrEupEzb+LQAIQpDW6NkFHe06hTUK6iN2ISzRL/NUUnUo4VukKeo3kyXYCdTzc
         EUGUpiNcJ9cWbo2jyPO5IooY6peUbqBqeRjXARWqb3COEzuU5dFhOw2BWmn6rMTm4Sqs
         lhtA==
X-Forwarded-Encrypted: i=1; AHgh+RqwtJlZJL8MXl9K1tzYKYg9hBoqWoetjdM3l/zUbYBkI1Zlk3xCBPQIgiS3V1GXL8OPBuITSZasWFbSOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9DzMC5ThU0TqD35QUNDnRucILsWTULkoUMWqeRW6t+8HEYKg
	6eowC6wW9uoheOurD17JLJrOnrgeIF0QoKHyaDjduFet+6aclt+o6oSmcyh3/baw3BRkdywyQIT
	YDuVji8AjakSEV+6ur3tssDoHDpH3qvXSDeSwsXp6CLUWWF2ACOmvBLtRMzlpsV2d6g==
X-Gm-Gg: AfdE7cmysA38E1rsTSg2KgCDZcRMDu/jmnX7Np6+k2G06glQaG3nwp90VNhV9WPPupH
	yRYbLq+gCEug4ay20qtXQ+Wi63wF3REtrHmdHoh9RKnrDXA1e3xUONOai7tC3f0W0mAQSw0kG78
	SKvlKPEBjtPjdDdiiIlu4Al/tnum95/ga4YQ5TC6UxqDroLvK+oWWGTGNstlSbx7k/D81VDhNn4
	XLTQj2VYQzD/XOdOsef6azJRK7aA4e8m16tnG2RtZuPticy4+q0F0Ld+t/2TEORNiKm6TI0MWke
	5afv5KfQbl9oa5fzFxhgyqfY/eufzbOwfYI5dmY1nXw37Q/165pd3rRVEEBMhDJPLIVptbaCy1B
	vGCCGeK349taqDrCNvOFF4sMEijA=
X-Received: by 2002:a17:903:3204:b0:2cc:7759:ffac with SMTP id d9443c01a7336-2ce9f052d4emr49349135ad.30.1783814351808;
        Sat, 11 Jul 2026 16:59:11 -0700 (PDT)
X-Received: by 2002:a17:903:3204:b0:2cc:7759:ffac with SMTP id d9443c01a7336-2ce9f052d4emr49348915ad.30.1783814351363;
        Sat, 11 Jul 2026 16:59:11 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce9dc64037sm16641265ad.78.2026.07.11.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 16:59:10 -0700 (PDT)
Date: Sun, 12 Jul 2026 00:59:06 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] HID: sensor: custom: Fix fields lifetime issues
Message-ID: <20260712005906.4f196ff9@jic23-huawei>
In-Reply-To: <20260707071545.3087073-1-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DR6GJsbtR3dZYh2wo3ObC1k-yU9m_fD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDI0NSBTYWx0ZWRfXyCHqkU431CCV
 2PSRwSxtNi+4hu5fdFSSa+zuhFXCE1eOpafD1yaiIQXsuHxCKCMUJY3+MW6BKuv67erGFMlHC5C
 O4wxOPuiCFD4o+fIDTpTtd9q9VERMQN+rGI4nCUdTowVnAzGDUpJZmqOpC7rj1eTnwDosZGlNoM
 FD2QTwa8Btlkqd8PlyB2CBusHtP0nwfvQQn8YK63i9iafNpm5zau21sZ7GocaLk0UrM4HDWYtp4
 4ops12H7eCm6eM2LelyDHwK/XkmfYEKawRm+O4kudEfo7vAB9c4+SzwGgQVGWK4SJ7f6aFzcoDl
 PokWEBJb4qmjxZF6e68js/iyckG2p7b6t0BdeGCBBSTXNBMadaww3hPieBjcfZFwNa98Ve9RrqZ
 zjIHSBXSMqs7QYwOFynYXZ3MTiAVSwWKELlGg7y5V8oVNu+8Zmob72XZB0KLfSi19G2hXPikpkL
 qffrMOB0oPhsauhmsMA==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a52d8d0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Byx-y9mGAAAA:8 a=4bbN0DY6XaUK8setVPYA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: DR6GJsbtR3dZYh2wo3ObC1k-yU9m_fD3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDI0NSBTYWx0ZWRfX80SacGll1cae
 amJ9esNeSik2PeBgTOKqWyH50ghaS1QuLNHb65v+DveMCdDtRqiLm/tDsNYW1RNrl47pio/j2XR
 N+MV0GJc4rAfQEo/bbXMzx8IBmCipnY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110245

On Tue,  7 Jul 2026 15:15:43 +0800
Haoxiang Li <haoxiang_li2024@163.com> wrote:

> Hi,
> 
> This series fixes lifetime issues around sensor_inst->fields and the
> sysfs attributes that can access it.
> 
> The first patch creates the field attributes before exposing enable_sensor
> and removes enable_sensor before freeing the field attributes. This keeps
> enable_sensor from accessing power_state and report_state pointers after
> the fields array has been freed.
> 
> The second patch fixes the original field sysfs group leak on probe
> failure by unwinding any field groups that were created before a later
> sysfs_create_group() failure.
Series applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> Changes in v3:
>  - Move the enable_sensor registration reorder from patch 2 to patch 1.
>  - Add a comment explaining why enable_sensor is removed before fields.
>  - Add Reported-by and Link tags for the Sashiko review.
>  - Keep patch 2 focused on the field sysfs group cleanup. Tanks, Jonathan!
> 
> Changes in v2:
>  - Split the fix into two patches.
>  - Unwind already-created field sysfs groups on failure. Thanks, Jiri!
> 
> Haoxiang Li (2):
>   HID: sensor: custom: Fix use-after-free in enable_sensor
>   HID: sensor: custom: Fix field sysfs group cleanup on failure
> 
>  drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

