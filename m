Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E009457E51
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980381; cv=none; b=CNJg9rQsgJ2dYNT7CmF6NCoYMnY9BhA/ihSFReHJmeXfqxhJAB4JV9X0Q+eJxvmLnOgztjMQrOjktvG+YoHrEzNtrErVoNt/88yZcSV2b28RBEA4ZtdSMzXSOb0OGSajA3C0ora72i6yqgiSNaIVzsYhxYSTHgx6drzUgNLeKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980381; c=relaxed/simple;
	bh=H/Oq7DCmmKlvAofUgjpQ4iEZ6GqCaDK/Q4LrOcGlYX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMoBkSw8NWccxsPQkmSQgZECtte1TG4KcetjwyBdjo6L0fLjsU4OAqMDKmgLRbP95Nkl3rZ3C/GUjqwRtJrbgUs71bvJWvEwYoJ6LwC4TZgmuSP6WgWmFt9VyowOKyKdWVuAtjwbPzZJG99wO11jMqScv5Zf1kzqwVWYEmFwu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHtH7cie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cS+yi1VW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHtH7cie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cS+yi1VW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79p1V1095978
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 08:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=; b=kHtH7cieHkVvlPt4
	amzlnKDl37IMwUn9NHB4e7xhpEeyJ293VQGD5i6HA24E12l+KpTEDyY8I/EFs0Dv
	xYAvDI+A6eJMp0UEmRmYdW9WxPXs98Fcg8neSwBNeD2YYVqRRbqE7RQDzo8oW8ks
	uUF0fK7SiLd0zv42+y9VlJgffgggRTzXWA8FBd2mndCIVNWbWMtNmRi1KQyEKZ8G
	cuEv/0n3gWYUnzzbxXKxIworWDeYJOsuP28Sc+HQ+X1rPCdOseKB01QlXpTNOccW
	n9o0/rjFtjf4xavMGQbrtO40u6HnMCgegUm3rde71VoOD5AsMMtLFBg+mdjFynV3
	aKMkVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw0dy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 08:46:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934a8cd3a8bso76802885a.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980377; x=1790585177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
        b=cS+yi1VWCNWAefQ4zml/gM0cc1QgOA7mf0JWtvdgtTlbmAqwQW1g0uOwNU/cFWq0uM
         2ameIwJ8RfH6+DSv100NLpgMBGlmNOx4JYRCJ2quGYi4aYKrRliq4fwYSCH2VwpqWPSO
         qtMZ7icxscUCMJL8XdCVEkC3nuxo3IbGAaqB1zxIIc7LiEOvz3m5zpn0EKFLwUdHfb0D
         0iWuyacxs+kvwbrDN0ChgDnY8YxrCyqofn5fWWusTciJWspNK7HhHIES2DgUUkZ6xeeJ
         S6HXLLdB/RTjKyLwzi6flcv3YbSQuTkGm34dDOEwcSGx7nbLy+9SdGEbFtswE4IIgAAb
         dwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980377; x=1790585177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkBaXHoqMiFvjYL8zM/mOnKS4OOJMfb5HsorDcVrhUE=;
        b=GdMaxJqsg8PKPWOdHBQVeOOSrcu7cVW6UWm9+GJ5ji77Dr+Q4llnbxtJR+OREsbAbZ
         ZpM6Hd/6Yz0uOuF3QW7WuuaO3a2RGkmLYweJ3PnRf+KhBomq0nBGo+7x39OYca6kmttu
         F1IHrT0cyOfZDxpfLskMq1nrIpl5RtcSYWJAmXyML6LIMwOwjsoybpII8zWUApS0KVWD
         /BdMZCiVTh8Fk+ikA6R7pRtgHrfja58LVzyFN39jaE3761ZnGwfV3dIfX97ddFLq6+bP
         OxuinuakDmkhXMHnrH3WWsaYB368nP0e/wU2ky37g8DxsynKZV66XpVGwl/7yxOD+9Q7
         Rtiw==
X-Forwarded-Encrypted: i=1; AKwUvBza8pW37z+McXUZL8KasJRUiIT55JHllQsVXJtvVNuXUCeIzz0Xk+7fZ9p6cRAiF4s+8RRg/jy+2bIViQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m9fHl12agNtYFk1I+66GM86nP2klnY1PzvmLPhkXOzRvWne4ln
	92PLHw2eVSHMVoisp1yHRbJRVUB6l+P3v+5B30068LCaQ/DFFdNWGr4oF2M7VToZ5Juf4CRYcYY
	b5BmsvgAOobHC7OjywQeZZzYDY3r3XKTwI9uZWXxcKtHiGX8Bz6tE6b1TxhlAOVg0iA==
X-Gm-Gg: AYBFou3lc7Pn3nQ1jWabVVxByIYIIkioE+zk50ZsWee05TcyRqL/vrl23Swgm0i63oQ
	vVNxSheH4eT7gZKWXRx4fw4aRyS+eIqItUZxd8ZnHoUrId+/jLsjxfj5wLScU/hotn8e2Iu9nh+
	gMXgs/TTSTINKJLo+weBLeHYTnM4feHvz6e6N41O4wPr5b9gJVvw67dwuWB/CbNB6pp7JEFIFgk
	954D/3sEknO9epYg5FdzgdpmamNTwTCeBSuFlLbDtPBaJRejudOq0OdzZtUuszF4fARa4Sf+xc1
	KAjjgpPWJdwvddeMZLyE4QjKdZ/KOFNkt7Ha7fDbh5Gn25fFxvhKoKgeLxhVclBUpr1Xh1VUkF6
	mUX8ts3hmCuzcBa12GQnaQQ==
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id af79cd13be357-93bf57df974mr940248285a.5.1789980377346;
        Mon, 21 Sep 2026 01:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:93b:c6ec:780d with SMTP id af79cd13be357-93bf57df974mr940246585a.5.1789980376913;
        Mon, 21 Sep 2026 01:46:16 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ade5asm270916366b.51.2026.09.21.01.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:46:15 -0700 (PDT)
Message-ID: <733a3b6c-4278-405a-be52-0bd22ad1584d@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: Muzaffer Kadir <muzafferkadir@mainlining.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
 <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
 <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfX8196jChtZcJr
 7TRw9t1GXBCRpE0Ed7th2Zxmuv7WpehyJkwGgLooiJIu49Q8REnla8kLfY7kip3ZHGl9n/S/aFY
 BDdLnlG6eSsbDSfgBrB5Xi+75JroJA7/4Yybo6GxT+nHQAEkxuLcnSHp5T0xLW/58/k8+tfM+7r
 S+xdHGopdLLyOms47DEyWkEX7ulqlhJXrEXThDaBI0cq8FmnEytgoiyX5TZPb0mhcRXU5uLoSE5
 +cM2KEtJHtED7rDcIG+q7hRRBnIcNMeiLt1Y5x2iOHQYyacujtDVw6fXK8vYj/b8AEstZw8I6A5
 v+iMhPjuezAHqR7FfA+Krjn80TfTJi1TxfCm4ByzQVEeRHN9Nsx+U5zedAJQ8iQ7jzvkO05F/VU
 7dzFK86G64UMwX125x6oNP6PdGEfM7MdzbFATzDe0l+AXxcuipfsQ4b0qA+JgigaiN+iP63wuPc
 jHuK2EU3H+BZNXdYJow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNSBTYWx0ZWRfX3RX0LmrwX/iz
 rpmupcYmY8EVN2MRVIO/kL9szwKpA985f2yUE63NSIG6YbD7q0emkj9E2RCfScIDEsT2m9AfepR
 kvp0rIfomXmN+qwUlBBODSMO0Q9iz6M=
X-Proofpoint-ORIG-GUID: j9ldyI9duXXFJqKMKRmP3poCq5qv9glJ
X-Proofpoint-GUID: j9ldyI9duXXFJqKMKRmP3poCq5qv9glJ
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab0eeda cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=IpRBMZr9S9mwpYgRR9UA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210125

On 9/17/26 2:25 PM, Muzaffer Kadir wrote:
> Hi Taniya,
> 
> On Thu, 17 Sep 2026 09:49:07 +0530, Taniya Das wrote:
>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>> index a6c676f68b79..3c3f27dcc68d 100644

[...]

>>> +#include "common.h"
>>> +#include "clk-regmap.h"
>>> +#include "clk-pll.h"
>>> +#include "clk-alpha-pll.h"
>>> +#include "clk-rcg.h"
>>> +#include "clk-branch.h"
>>> +#include "reset.h"
>>> +#include "gdsc.h"
>>> +
>>
>> Add DT_BI_TCXO enum.
> 
> Should I rename the clock name to bi_tcxo?
> Or should I use DT_XO for enum?

BI_TCXO is the Qualcomm-conventional name for the clock sourced
from the crystal oscillator. I'm not sure about the BI_ prefix,
but TCXO stands for "Temperature-Controlled Crystal Oscillator"

Konrad
