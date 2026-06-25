Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDD3815D9
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373209; cv=none; b=jxp90PkiLuFC4Ww0Uw+ubiqca9NoQNT9Wsap8qnib3tvgXUME2FRWXmK48f1NmYmg7JaRHVZC/MOyiGnneKFxKaN5+fnHXobCm9vLS/wDZsAeL0xzX4mDUhahf/W3Oe+qpUOso4jtfS6dMHzmQq7L/wUoAhspvELR2QKapVOAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373209; c=relaxed/simple;
	bh=6LMaV7tSjo2C/B0aYBV81KfWE/PDaGlSWTVSu4v8Rvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFiELkK2fItV0LSD5o+0dq/3w4VgtpxapwcI33/8QprTzSPap5FUdY29//WhO9FRgB4Jo+9YekXqymz42X/JFzn/eC10fJEdb+MoRUuNyzj28RG6pX/ctRqTnMygBK0+4vOvV5jlm2W9MRRdtFlUwCeVG8GQVo9wjxyavmyeVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPdJC32n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dajSjBKG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPdJC32n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dajSjBKG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P45onq994106
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2/4C4/vcdt4WFOXcl6HzVU9MdIEVo3PNCuawT5cNjq0=; b=hPdJC32ndoS62Ptk
	XP3uYf6bJlQ1DcpVu7pkym7pIrqBmddGJeKrexZYoWb9/WP/oLyM9mGveO9DeHOQ
	MevYXdSZoajVQBHKdWhtc1x//mW4sHgElllJ2JDSyO+x7ltm7scsuxKSaWIHRh6s
	9hvMwFT1oUMbOUTH8++0U0aRKBPzABYA+V7gXQQ7S1ebjGPF/Uyxt25JwjGdCGmx
	8LJsL9l38hAuyuohvnryfAZQyRoufVoYAa8NMj1vsmlmWst6LBpCVTinCQQQ34zK
	BJcVGthoRwHN4kYCKBO5vQzrTFdk1RZl62JhHeaa92Qi1eJtvvVJ4HjewU4nUaGx
	WdTgjA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q0pgs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 07:40:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7645ac9b1so17490835ad.3
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782373206; x=1782978006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/4C4/vcdt4WFOXcl6HzVU9MdIEVo3PNCuawT5cNjq0=;
        b=dajSjBKGT1C8qSe/nH+fDGfaiYfC6lgZ1gVRqu59IRzKuOXxeVQyIGrcVitOPwXqSQ
         FD3VahvOgtswuP1Q93IAQDBAIhAbtOJItwX3C+m1Qp3Yt/Tph9kfa3DMeQAOLGxIsQB1
         GdM7fuTjYE16USpjeTjRaOyc47RccGjbs8cHxLE5CvRWs5+F/xDlAVBCKYPTtLhogGVu
         rJ1PeraUPLifpOwfU4nilDH2+lqJL7J/L50X4Lzkz6GT3zhnN18VsS7lovUSXf4OODDu
         nsom63RF0tNuL4oRKSadTMQAucmJJTNfPawXZbYZizlGS5GSCZ8gOU3yLgtiEHyBr6Tq
         o1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373206; x=1782978006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/4C4/vcdt4WFOXcl6HzVU9MdIEVo3PNCuawT5cNjq0=;
        b=rv5BAf+izfTQmhnXYoTl9YXUJelQ/EU7OZ59S16P7a8vC6aZBb05eLaiR5+c2RZWb7
         3e/sDI2KLjVrz5jf3CCAux8tl6NBd6QlJ5CCzF9iapSLJkor4yKicaN06bTugLQEbdQd
         1H2GKDyTjirmQpN3Zi8cLidBMc/5dnDPE6nI61/aImmudxbsJT66ogBanv5nMlM+I8KE
         G2T9etONTKiE10pLK38Uyatyw0/I7cKmavAiR/jFpN4j2jxaMQw4E5rDiwb6o9H5ZJd4
         njYh5KWyc5WiuylPv02+LD/2y5VlahrlcaLA4k9RiZkbooEKoutXCbqVe6m5/NmzrvCg
         udjw==
X-Forwarded-Encrypted: i=1; AHgh+Rqu2K4AZz4p5C6ZrZke0l4/pgFeuHoeOwkGw0P1Iz411hqNeCFoQKbAjSBzEwg90CiobGEiVERplN/bbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyMhgZkeZ3INRKQirz2VbK7kes/IMLjtgBoQma03FtLjG0v9t
	hqqHU85xB9LfwyOdYqS5YlnfqQ0BkMgXKZidKLdCDiaLVE7BLkOqnQCkkIuBh/C2Pz5JVBLsoGj
	hIIK2lsqMfapFlxafMgVly+zd9X7s40gp6Y4a5tLmXT7QSbBHWWyLh2GhbQCkkhDV6A==
X-Gm-Gg: AfdE7cl0deFecyHNbKaIqvrqSncfBWSO0cE8NCn6F3RbsclS2YSkV68HZ2HpxkIZ7B/
	haGEH0kmxYQQpl4N8druRfKqGprAV/isMonFDgVFmTx/46f7y358TeBe/3dhYJHDhz4283FyCIF
	ozs4F9+xRkjE+E3KbKxw8quanlXPXB4v4F5NLeCTIOIxDqyYE3qB6W1l7m/itBEpuWSLi9WD96r
	5rkFdrjwS4+oCE3mqafkzpSPzNOskSSoFTZ7QyCO35kDEInl8JvmDxHVS5RupqyDGj+QpZwQ44J
	H5aYPP0qoL1+rTEG+W4dSe/dUyHfnIckh5Dj3fuigb9UWwMahpYBFczPbI7oWPENDOkNIWcbqDG
	p9AcKpwKjbzEzkVDX/F7E51r/U3y82Ln4lnhM62qg9jq9/717bn2HZRlKs0SrtxZY0H43Hm8r9o
	ga0Vxs
X-Received: by 2002:a17:902:cec1:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c7fc696019mr14046645ad.10.1782373205820;
        Thu, 25 Jun 2026 00:40:05 -0700 (PDT)
X-Received: by 2002:a17:902:cec1:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c7fc696019mr14046365ad.10.1782373205343;
        Thu, 25 Jun 2026 00:40:05 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f6518bb1sm13912915ad.84.2026.06.25.00.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:40:04 -0700 (PDT)
Message-ID: <32ba0f9c-7f01-431e-8cb0-8eba9f546adf@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 15:39:59 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
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
References: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
 <20260624-qcom-spmi-haptics-v2-1-b9118e60f3e3@oss.qualcomm.com>
 <5a5fc753-977a-4e21-984c-9b4a09d002b5@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <5a5fc753-977a-4e21-984c-9b4a09d002b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tXkcpCbP6u2Ht2Sj9RltalFch8AYQng8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfX2rlvvgBhxGjl
 RHeARzWeqgNCkGLUrw+KDvuIDGoiwBwGHFahW6RL/uixdriT9qx+cuA6hcvXETDxkH5iN4Rejij
 msOSXwOJTItz1Q90hgAoZvaeUDIL1ZA=
X-Proofpoint-GUID: tXkcpCbP6u2Ht2Sj9RltalFch8AYQng8
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3cdb57 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=epH8AEZvAp_WDEgYvPwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfX5dhjAhB+Q79n
 1FaK8OCLiGyYBom61EzhALdkeXOeKZkYTmbq7rdNjVMRnllZR4QX64/Gj7oJ+FHzfd1e6oCHqAm
 1LrnhwvyomDIi0M9bpCsf86j2J3FghZFgJhRTy6pCzf2HFujYzvlfXSXfjYpwrFtXzWT8vDBv5I
 QCEgQFUI178Yo0d0VoY5l1/guQoa/cuLWdrL+68r1/sWaL3fHS2ggnDNTwmoPf9eIv/qJ/2A/oa
 /rHoQxtKY3aDAYS1892gMqsKiUKjHpjtHt+nlX6Yz/GhotOtBUT9bnuBSD5SgTlu4uOsjClxhbQ
 8Sfbe7iQukUX9GwyniJM01i64k1fZBAAnhJm+kX06kJ0nZN7AscQnoHRe8VuLCvZ/wz++e/vu67
 9P71ReAt6VjJyBPS1gV///tezAEbvmAP7g/XmfK3JocqCMLdm7YhwDmRxOJyQzVsnN5xerbE0gC
 7iB/BL4d/PMNbsKsxjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250065


On 6/25/2026 2:23 PM, Krzysztof Kozlowski wrote:
> On 25/06/2026 04:00, Fenglin Wu wrote:
>> Add binding document for the haptics module inside Qualcomm PMIC
>> PMIH0108.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   .../bindings/input/qcom,spmi-haptics.yaml          | 132 +++++++++++++++++++++
>>   1 file changed, 132 insertions(+)
>
> You did not test this before sending, therefore this fits in to AI slop
> category. I do not accept AI slop to be sent to mailing list.
>
> Best regards,
> Krzysztof
Hmm, I used AI in the very early version but I didn't use it after 
realized it was not good. I don't know how I missed the issue when 
running dt_binding_check. I will pay more attention next time.
