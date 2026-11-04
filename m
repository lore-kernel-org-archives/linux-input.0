Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781900;
	b=SyqoXgtF3vmnORsvCbC3uN6Z6MKfcsrbtpmXe/xY+ViwoFgH0jT38ZPRbBPgr/McXtPL
	 xJM834Ty8OdVP6K24twyomd9lJD92PfpzFuyGr+1e3PmiTuQA3zM8wbd+4fH+p1cCOhz4
	 i2utqE2/BwRL1QbpqDwqNvM0gumwJIaRmOnevxrrK8zJcajQB3d54y1Wa7gZyzKVaQM/w
	 zM9nvaqxpq487NaU4Dn8ADXG9KzNCLrLaOf8QOdXaABHfLQ1UNxY6cOSMY+Xwwqq2XJEO
	 gMl3wMvc33p+RgbNxVR463hqPy6b1Gq56xBkLk36fpRP5bovJTarykOmmqvZ5/cSclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n+TEDrUElWg9uttZzwotv6ehhRQDadzLBsmWXWQ4tek=;
	b=o+Vdqq+JmVz/JqtPu5fLaKw/ih0gPEIbQaFZ4EFdLSnhLLky5H19Hakn6f2qahQKQjAk
	 0iumdnKv5oWuiZivxL4fTJenINWxRAzga0nXBfuby37MIrVmxn9PrasMcON4N26oCjepO
	 Bo2giK2+Mxc5FIPJHkbiBpCut4NKtMCf6+ZALPwpewQWytK20q+17BCTeqdkP3JB8Y2z1
	 4qiiWGyI6hVisLcQEgUYjJ+O4HSgeabuHd2ndEMleioRpu5AEVZEOhUnwbHKeoaj5dDgB
	 7UUdEq+wm10U2r0fW9il8X8BF7gP7TsqHVu+TnWUDnMZ3cT94ovy67DuOzxLzzZdRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L8tpp8El;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=An8CfSCW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403F606A330
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 08:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9403F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L8tpp8El;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=An8CfSCW
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48OmCH309833
	for <linux-input@vger.kernel.org>; Wed, 4 Nov 2026 08:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+TEDrUElWg9uttZzwotv6ehhRQDadzLBsmWXWQ4tek=; b=L8tpp8ElNIR+2SCL
	7ABPfhPua3esRfL1aCbBvR9OMxlgtGpIn0i/qMU2pEcNo5Eqx3J0rn2c+0kkfR+I
	U7/8vrjIpKlksjXwfdREkhZVExiSm+DC1oId2M7zdyVNVkECDPnxUmevJscvZvGl
	InIg2N7mSUFHqnfg0xSNZQqINbtu7s5o79YgzZ8+hKj8dbnah7ACvSe04DRsmRiM
	Xwdm5i74GRLViDKzpPTEx32acz5ROpfe3JHkOsB3MsyKe0irSgrfQc347pSSDkhj
	wAnTUQBTyaevg2kGbnx8oyv1WV8X6mwi0e3m+SKJCpji9MroqND5HXNR5fjCX7r5
	MwXiew==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163g2hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 08:44:58 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bfa915da7cso343145137.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793781898; x=1794386698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n+TEDrUElWg9uttZzwotv6ehhRQDadzLBsmWXWQ4tek=;
        b=An8CfSCWQwW0diZJlUulskvDtINwQDb2uX3sBnyH4H+oUBkqWKth48+Tokq9/nGKv9
         aX5zX9LRrG68zdr6uPkjvh4W9NScqizMgLHETeYmOU9SS8glbvDeZPVZPlVtLgMw6o9Y
         jfoURFC5Frz8t2D/AZONsYOudkN622j/5ll7ItvEjhL7wuEzXuuzXLAu93izx4PaRxM1
         4GOmO3Czlm00iEJDYwNTVDpWf9QhXGOZ5F/OFeR6U7HCuaTh+frAJOv4UYJk0Czq6jkf
         le8kTXegA/o9/hcNVjEgxnDUkrMiQL9Ah9c9R9z76oXLV+GfXr3tc8vFLjyXHvfdFpQW
         V9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781898; x=1794386698;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n+TEDrUElWg9uttZzwotv6ehhRQDadzLBsmWXWQ4tek=;
        b=dZumoznye1/WOx7VHdP0CTW1/dmuQGecNbnwOVNc860sPUoUtsptsi4XzDPnsjoGfx
         AjN7eyQQswjA2J+oNxKTCAGxJYlHW0RsdImB5VyaBTUJWG5bTjyoXWkjVcrPJPCiMBwU
         AEWJcep7ynvuetahMSCzPkr9WG64f0M21nCHPMS8z8b1BBXPi53/kRdUeAvh5vRBbRaG
         DpRAzDTa+RhuRaT5Xjhsot+v1vZLC15sqNY0h4X6n7J+Hf+JnTwkA8Zb6c4+spQKSmvQ
         +n2o+wOfqiQvoEwYItMRt0hs5GFcai+JvqcW1b28Toh2kETV8ep3s1287lXWXyq2oCzT
         O1xA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ7mrqRlJwLZfiIJf+aA40Lrblq5F6msRvmumzMpTu8D4enlF1nF0t1Xkrp49+pQU45BQyS0YGPC3GQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NJ8nGHoxyt8njAVLCTJ4JBN1D9sTktUZZcZTFuSp9CurGBTis
	YrxqyIB+wVOIzXgMKEhsXkh5OvZGoIbuzvmJGZV/OrnU17OloZGOrlT7kTfk6wLxL6sQ/Yy/h7M
	GmzJIDVRtvVy82NpJmf9dbx0gu71WlmKrTECb59ZZaYqt4JsqrqnVMnT5CUKgfXWhFQ==
X-Gm-Gg: AYBFou0+z/eArIootXGqZYRmcVZIsSDLTOfKQkGeb4r4sO5jAR15l3yReTfbDXHawES
	PIE9XOpuYcefaUyh858rrOk10yW1+pUs7V1jCIGIgBaSSYZ2n73iQnx9QzKZLS1DwDB6cFNCxfM
	1/mUgepPARqzuVCq8YYUfrpdsmEuZ+RZirg1qKF7NLyuWU4djv9DmkKkH5NQsgv04QgeJe1WfyX
	86eTmr55C3L8R9MWI1J2GY/mYTld2oeBDQagwyOBsnFe+JwrYz5jvJTfHJN964V/aoJz6VUPUYx
	zelCmon53V01qF1Nx/CFKvqupHaOmgXDZ3Qs9VjUjQGX+pa3OKPdFIEcymQXcNQO4Q26MeEHP75
	dEYVRpdA1CBzb71wDVLoqwp8eyHiAr1z5TxP19+fJ4+StPXn6UathG097wfKfLOBvquVUpammmw
	==
X-Received: by 2002:a05:6102:3f9f:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7d054182fa2mr5047771137.8.1793781897701;
        Wed, 04 Nov 2026 00:44:57 -0800 (PST)
X-Received: by 2002:a05:6102:3f9f:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7d054182fa2mr5047765137.8.1793781897282;
        Wed, 04 Nov 2026 00:44:57 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d7f7sm2658699f8f.38.2026.11.04.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:44:56 -0800 (PST)
Message-ID: <6964d550-2ddd-463a-a142-9e8f72588803@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 09:44:54 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>
 <20261104-myrtle-kelpie-of-chemistry-de43cf@quoll>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104-myrtle-kelpie-of-chemistry-de43cf@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 01NL1dfEc7y_HGjjHJ5GrJXhzdv8BYLh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfXz8Ip6+211sjb
 KMi/24NtjOwd59WkdWIpo63gvXeiQF2iZt8h/Pfx5T7Lv0t2rT5sJKcah8kZ0gzeStauif7FOr1
 lBpoBMn9Mi7qF/4IRgi6hkeq67Apf28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX8nDAWadEjvOO
 vjLmeSN9/HwUBo1xL6pWN6CRDqPO0hqZLePQ/8xq6ell3wS6FBKhc+XujzmhAgRD6o9RlvuCxyb
 EHNvE5y0wS+RwPPimrsmgGj+/yLJcuvw/uHDu53ytrVuTd3uYq9x7+GehfsKfyoRNv3cXSIrY27
 l4+eMoKOm5Bs04jeYqFul7eK8Hj3bfPqrXzq7hvhN/HvRK482H9q6+YJzKtPa1JZaGvQqnHm4Fp
 u5VD18da6yewLBYrQE9jFVV76bN2FPEwcFDPMpc2zvsDn70XmZ1foc/hnihx7gvX4tEPr6oQZvP
 6EutkkqiK0kfyza64G3CaT0oeV9UcJl9yLeERcitdds/75nrwyR01nOHEdQkg13EpQdWpUG0lsn
 /+iiDaGlH+HaYQWEYdf/ADZbncj/ArqgyyTi6PTn2WGyYco68WM3RQtk1CirPL5+9KY2yHnYfvI
 Tq4phMnCbGqNfUpxE8w==
X-Proofpoint-GUID: 01NL1dfEc7y_HGjjHJ5GrJXhzdv8BYLh
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeaf08a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=kU8dVnbwxP-e-aHbJ4YA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

On 04/11/2026 09:29, Krzysztof Kozlowski wrote:
> On Tue, Nov 03, 2026 at 08:51:17PM -0800, Fenglin Wu wrote:
>> Add binding document for the haptics module inside Qualcomm PMIC
>> PMIH0108.
>>
> 
> Why are you ending this? On what sort of ancient, downstream fork are

s/ending/sending/

> you working?
> 
> 
> NAK
Best regards,
Krzysztof
