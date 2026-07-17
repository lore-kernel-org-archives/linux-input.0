Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFDE3B6379
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280361; cv=none; b=XcM6/NAbJnItatq0sQWudFURJb+LE7t9y14u/pWWGzzKlyP+DZVJWmSw8E3RHboio4HSvUfRFXrXHmdxUQWxRkob6Y+wW0d0ZDPd2Dg41hsvwK7X34QiAKFInjQKAokJmL/Q8C87p0S5FIJq2nAFsWGgMdVoD+nxG1nIJVZpFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280361; c=relaxed/simple;
	bh=UUu0yhwA6E69V9YantX0L2H5+v2Hw2KIgH6t8T3r2jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrjt3EdkDCmzXVg9v9BL/CVEp2b5DCdJV4souIjTzQrdlLTMiUIpgzyoFVfFM9S9OIYmMgHhEVnxyatpj6cARE1bSM+Bt0IxJKHXNg63uuC/jt9dqHlpcDrUEfzJqKkWCLdag3l71wfuHx3/IJhaMf3fNB9gVfdKgB894Q+/G0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQmtDInR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aeWLYXIH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQmtDInR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aeWLYXIH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cnJi1093309
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 09:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZtH+sYSpZT+y6pPmChaU9tOu+tanPYeojGGHeDm89p8=; b=TQmtDInRRYSNWJut
	JqnBphO45X22XNBtCJjHCdoHFq+iG+LsjqbCy12tnaIZL89hlHNVJK1AiV4Aj77a
	7qVVI3BWfSQ4YK/p1l0dtZFz2kzf2efnyE8uPxffnNZ2ZQiVeveGMeAMXYhSt/ZV
	WNQvhqr7muz7sG1CFP79qnlnr1XJ13aE8y7Nqhcuc9iXq/2NsmRTP9MmOEXL3T5M
	OofL6zPZVveu5EBRMMiWL2l/SEyrcfRgTLe2FNqdRtrsuOF5+a9myLiZhGuroksj
	Fj4+pQjT8c7n3NLiLEhVqgdKsF/jKjaX1e/hUp2rx9r1A88l6DdijzXr0bamH1L6
	S+WYLw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0ury7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 09:25:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so63110341cf.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784280357; x=1784885157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtH+sYSpZT+y6pPmChaU9tOu+tanPYeojGGHeDm89p8=;
        b=aeWLYXIH+kscYkXDI6jgJSt7MyLJI6KNu6rsEIj6vG2VKX045MDX5B/XqBCEsn/+DS
         7XMaW0ciivAISoOCKgmVs0r6iJwpABxt0pdYaoCK7sdmf9JOL7YB0XZl+bn+4AJDmtK3
         8JuJiwHfve00wYm36//m1DIO1yLoYUfQsauz1n6YH3SF89iEv9dVRRaYEmnoHjQ8RtTX
         JIo+/UaZ9ddByru6eG0jOHyRuO6MCXu9CyKUX1gaZUI+adpn2Ou1ez/P9h5oIEJeHSeW
         5+vhSI8GFGEsNpvf/c21ZGQbt9abZ4e1w/dkcYpXqodB22y0uMtkTZ7u8z8NrU9tFExc
         PioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280357; x=1784885157;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtH+sYSpZT+y6pPmChaU9tOu+tanPYeojGGHeDm89p8=;
        b=N969bAPhg4o4jj2hunbZjeYJn7HVTwYS60F08ceuSw139PZKZKyM9fu5c+9TN4zcvM
         q7glZDgRFyfeSIS4ymwU+ahPUQ2elrHXaO4pKQPSxceqwtbwAu7yzQg7wGrKW794MBkm
         QGGiCg0Iemg7N8iyqnNpM1sjBe1byigbMRIv5GrWsFmMUfjBkgQVBUT+8L3bv1UTQeG2
         rti2zC9EOuqGX+okoghWoBtKtcX9i2JrDtXg017z1dLvIgl0NunCbUjzsWLHp/YYb+wu
         URodTHZOA7Lw8uSvnQd80REK4fPVud2UQKMMDl5gxgtOfssQ1BsZ3b6WvcFjRAMSI+Od
         n3UA==
X-Forwarded-Encrypted: i=1; AHgh+RqrotGzcJ95zwexdsp+15S6jc35ik7YGoEExNdIZ1tUIodF+VWYxFIIJMVxn2S5/bQ2iu7R0zweKKYPKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CZnwuZs3uGQlXbPFNviPbjazSHscJiL2UDqbKncBqqHCk3Rp
	7e49P8+0qKrn5y6VZUSWLv9s/N5Lt8+08nZJvqH03yyYYQuzfLOgrg3xpVFzLBnDMTmMvkJrPst
	RDGcvDcOYUZuxBwU7QolpSg0tNuB3FJxhCIiSTbi4E4b2jjptv3Y0LPUgcniCR4lgMg==
X-Gm-Gg: AfdE7cnS2LoMC+yme4s6fh+zvY0SZ/FhjypplC5mUbCTgzQrWZC2oOQ2jd3N2KXIgiW
	t9OxTJ4fzwOPC56N1NiRNgpcAwZx7/sjnB6TAJeL64MCcn+HPAfb+va7QJ5Bi2/oYcfCwLRikHJ
	PNHzhm92DmvMi6A8MXLvjxdoR6b4E/0An1PxoUKCQboO+fEEboYSe4/91/G3Z8xUvZccCwSDPfp
	7HEYAQ0Q6d0EJ4bNGZJVdrFJbgxrTqwHr8DdPTRslk9xDXBXkdjHHbCxH2TELJll6K7FFY2Q45J
	ivHZNqTgj0U3x+6+vncy7zRazFXuBFQ2aMtX+DPhX6Tc2DqyGwoTdPpTHOqWpAl+am+qEbvBuGI
	xGf1GrEHWlnIXvxdC6anyJeNlpNjtgA==
X-Received: by 2002:a05:622a:2992:b0:51a:8945:3136 with SMTP id d75a77b69052e-5213e48ad0emr12623541cf.56.1784280357530;
        Fri, 17 Jul 2026 02:25:57 -0700 (PDT)
X-Received: by 2002:a05:622a:2992:b0:51a:8945:3136 with SMTP id d75a77b69052e-5213e48ad0emr12623301cf.56.1784280357135;
        Fri, 17 Jul 2026 02:25:57 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b074csm34097465e9.6.2026.07.17.02.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 02:25:56 -0700 (PDT)
Message-ID: <0da6b426-a9eb-42c5-9476-9227a61f0794@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
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
References: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a59f526 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CtGaIe7eZSrXIIjUQnIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MyBTYWx0ZWRfX9Pxv9ouL3wRs
 B8L40vmJEgIMvEwygb8tNX5ym+y8tZauBYtepEudoMKFeZoTxZrxeN4vhGy9w7+zhAp7KNuYSYw
 YH21S23qOLqak1S7daSndoRDBfF7i8D28+XxiiV0K8FBHfYxvlHinM4/Fclnv2VUphe1NX5DQsA
 At7c7Uuo+Nfcm2LV1C52qxOXfRhcZcyHMXeX9/OwUEUWp0+vJyBnXmycrLMXA5jFP3rkCURlg2L
 ip+mHmvXzRDbOf/QJDedICTPpTXhDhPNA6UM+6HHIUNtCkkkhTvk6JvD5AQ3UqdX1jcfeob1wNn
 J/llEzY4uZiWU4x38wm7SVvvQ1enh1PLmXuizmzvGkAX32haVhajg93EwfyvTfYYnzrqh+V10b4
 lAAEUl9p581iAYMdV80doe3XOzhFAO4r34k3Wp4W8uM+aA0cxgzF207egatLZ9AI0MZgltDciN+
 YjLiddSsu0pleG/At+g==
X-Proofpoint-ORIG-GUID: -GRjqL2557NPiV7Wvl0mVDcGmkUd7oAB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MyBTYWx0ZWRfX4hYxICbQileY
 ErVEZvVOMyutI4SW3FOuFwPWhBjDb4O4I4G0HsG3fxl3w6tZAF0AciERM2fCeedUkeHdjf/vuCN
 EN6rtzes0wHQr5snmDyOMNopa/64Zxc=
X-Proofpoint-GUID: -GRjqL2557NPiV7Wvl0mVDcGmkUd7oAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170093

On 17/07/2026 09:28, Fenglin Wu wrote:
> Dependencies:
>  - [patch 2/3] depends on [patch 1/3] and they should be applied together
> 

Why are you cc-ing internal kernel@oss.qualcomm.com?

I already asked you TWICE. Both times you ignored that, so that's it.

Best regards,
Krzysztof
