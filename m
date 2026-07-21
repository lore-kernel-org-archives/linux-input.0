Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D803CDBDD
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625570; cv=none; b=t5Nt3spJQZtkGmOBJcyvqrc2PDr8NLrLSy/S9txiI+YF6vP8gXfhIiuQPkdI07eiV/lO2ubix50Abet7Rq0pNYrAddIh2eyQxuaazf1RlaBYfO0S2trKxmc3BHBsz3i86GDOlp0bf6fOQkXvt3nTT90CU0qygc1msPFK3505nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625570; c=relaxed/simple;
	bh=h7OkXjIcyiqraWDTg6dQ7Qjakwh2M5Bf8larYlTJdyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUuX3voZPV8rI+jUZl4UlTksutXnWOXeyy/6A2k/vIBIIoUqdOQLfqioQGzjWgdc8sba03zQeg+Uce9lriXNlLfsR3cRj9ygIIi/SMFs/gPIwlke+6v+ynYaTSfzuNAkslTvyFirU6xgZ0j9WvpKnayRXsMDOJtyVluEMTzyLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3rpe5lH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ALS21L7K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3rpe5lH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ALS21L7K"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8rr4J527891
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gRKUDofMEo2Sg8xUURikMPta4qvKN0rtK1tI/8N9jl4=; b=n3rpe5lHpm/ByWlU
	PYnYAz2B/9gwjsB6xsQ6SzhHH0nBlLEleqSu7SYzfNuHis/R4ni3mlT70fFcXuMf
	VFfo0Wz8Hg+cZED7v1jT8rVKK+DL7KF8obkR1UI6aDzVeH337NovCsN+vyHqb7+9
	qBNnPsCkqVXeuIlzAHcn30yxSGxo/i7fkkOwHO02Qlq88KyS/nArKQ0tCvf1LOZy
	5/uU11N3Ui7wppDvMdCBPgX3qzJYwGDqeTRoAqYdduj45piu1oLqHv8v4xFgxzDY
	es08YKcccRy0Wd5eoalgY+IHYXeYSLmR0/a4O/TsQQb7AfMkbuZjtfHVCPQpWZ7z
	xEQpag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se1ard-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:19:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so177512515ad.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784625565; x=1785230365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRKUDofMEo2Sg8xUURikMPta4qvKN0rtK1tI/8N9jl4=;
        b=ALS21L7KZ32pLbHN4v5Y5Lj2EQPKrAKHf5/F8WQ60LrbSbaB6J6CDjRXawIX866Not
         aeL8me6bhGe3cHo2MKjEVr46ZWuQ5UU+kA6VSg5Ryzvv98y5lLbUpWsMUI1ToxjPQdcr
         8u7FKIU3vol/2+zs20OXhoFi9uEQta+ekouO4F+J0XoBAx5BquEaav2emyZx7dtMy2HJ
         XxCML/DFHePVa0YM9LV/3Ykr6OW3ZUhXCX2QjZf7NY4X8yfAes/q+Wpqa7Cjk0eCLfbU
         h3SmX9tqs7Z244XvrthbAMU1gQFC5omnPnTrw67ve14EKh+6vQMLrAVqoE2yQB2NoNbj
         IXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784625565; x=1785230365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRKUDofMEo2Sg8xUURikMPta4qvKN0rtK1tI/8N9jl4=;
        b=ShhiiFof9vPHKSLFqrjY6omW1t2RDCOiigbabiN2fCoZ7pyvhpM0H6dJ249212liUn
         3HH/NOeNVwriKpk42t4vWbAC0Sl4YzBYHn/ssJnp7ou+JnA0e6bLz9YIofVI6Q1i/Bv6
         KqkKywhKjAX1zgf8Qvu21ikki8qlEj/E8Jpc378x5I06MrkhzXjsCNwdTcJe7TqjELeP
         4agVi1JE29NaeUEp4cIpnYR+5mro9oEUa2XsWXXe59ipgonYaxbHzzUmJa2vc2IZuFEi
         iIovuABPDUzs+ku4bW13qDMReZiLJ49KAHDhikzBzYpheitGlWdnBxhfEZ4Myq5a0Er8
         /8qg==
X-Forwarded-Encrypted: i=1; AHgh+Roh90ddFerA/XhbuPgzHy2Q46uvEvCMAyJzl7J/TciVcuYwN8U+88MVnDrwjC0KBmOsuZoa2yOyzuxOog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TQMxl3IjWDa9u9s3an/eyWKWdBS9SevVuPPRGXIsTdPOitGm
	BzNjp7/7Lou0VVu2JUhiEty5YUoNy2DHKAELuaNFghJTepAYT2CeIHl0Q9gnhR+3nc+A0snwAs7
	FYJbJDS8nr7xF31ZdkI2U8hKj3TPGmOrN/lDMS7/GiXjg59WfoJGjRIxccuw+l9bjSg==
X-Gm-Gg: AR+sD1107XHONa7Lb3rDe5Vqyrq7bGl77cs8oQ7BShB2PThfs1Qq5e14ni4NgmlVxcY
	BHAcciyh1lliK5XlRrVxtmJoRW8zjjl9vos0NREYZyphRdNnHpX2b4TI+EThaGi32cE7iG9utwa
	9l3zxwP5snpuGZgu7qQgmRta3do1ssJTx9e4F0gbH6AeXQ7Bju+f3ycVq/GSCRWixo6rrj1O8FA
	hQmdDFQvncGrdkR613ux73UxQqaAR+Z4NvUZBHe2vTohZTWWY2eL9dE5hXBygPkvJ6dv1SsaSnO
	gYXtfnOATJb59DghnZe9w4IE0b1l/NyKn64igxRY12q/L9KnOdqgBss9ND2rw2vF/RyGTABjprU
	5G8qMXMk8dBgrwkRFD0SMHc2JzA==
X-Received: by 2002:a17:902:d4cc:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2cf348193f5mr192353045ad.7.1784625565346;
        Tue, 21 Jul 2026 02:19:25 -0700 (PDT)
X-Received: by 2002:a17:902:d4cc:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2cf348193f5mr192352615ad.7.1784625564881;
        Tue, 21 Jul 2026 02:19:24 -0700 (PDT)
Received: from [10.239.155.28] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da095sm71796115ad.49.2026.07.21.02.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:19:24 -0700 (PDT)
Message-ID: <4ca82b5e-f570-47d7-b08f-df9ab6393059@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
 <20260717-qcom-spmi-haptics-v4-3-b0fe0ed30849@oss.qualcomm.com>
 <alpWEL1hJgQ18I7d@google.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <alpWEL1hJgQ18I7d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jR8kV2oz0Ozk0JKOg6q8jomQ4e_aZEQA
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f399e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=0P3381qDqkNb-38gs_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NyBTYWx0ZWRfX1l3lu0gQuemm
 +q/zyeCY0aK1c2/uG85FUR2yGFuJ41Hy/XDKxThaxMgze1rgtY+u4uSeU5oZ5UctuuzlWLYpY4z
 41E+s2jQ//gvTZQ7N0O67rXjV3/fMHs=
X-Proofpoint-GUID: jR8kV2oz0Ozk0JKOg6q8jomQ4e_aZEQA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NyBTYWx0ZWRfXzJi7GxJvM6nc
 rWGpPfBpvkr3HuQgMsTt+9/vKQ4bu106PXHJKEiWXwW73AKUft8+EdTSicYAoic4DI13mquMKGk
 SItUJgN4g3qm90Smwh+zroejhuwCpkB7S2I04rCgkzmZxLH8lDj1BYv5bXXTPHerRyyVy9bqn26
 td3WhtaZQpAVMocb9d31xCVXr6GHn/TdJlhlupgOXIsAj5PL/KUFNYt/Hugo5pckpeSyCUdvwUI
 LYLemcXhGTSTU3MEg2znUhUS0qZ88WBcUBdE8eO1YWIH9p25HAAq9CtYdNvo03H8xraa6tXwxgl
 47tD6buJhU26OIhotz6ragJ0nQ2dhAnQ9KS2VpwC7/WV7N36TvgAL0oPoIHSm+vWPDJ7zssqylH
 FWAN6xBb6/o7yqsxr1Nn8RmdbdTEbPt/yQm0/pkoz3k4OSvUurCtcY7b8OSDHnBYnihFow1c6I9
 FAogY0W81cFTzE7gfEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210097



On 7/18/2026 12:51 AM, Dmitry Torokhov wrote:
>> +
>> +static void qcom_haptics_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_haptics *h = platform_get_drvdata(pdev);
>> +
>> +	/*
>> +	 * Unregister the input device explicitly at the beginning
>> +	 * to avoid the input device being used after the resources
>> +	 * are freed.
>> +	 */
>> +	input_unregister_device(h->input);
>> +	disable_delayed_work_sync(&h->play_work);
>> +	scoped_guard(mutex, &h->play_lock) {
>> +		haptics_queue_flush(h);
>> +		haptics_stop_locked(h, true);
>> +	}
>> +
>> +	haptics_enable_module(h, false);
>> +
>> +	scoped_guard(mutex, &h->fifo_lock) {
>> +		for (int i = 0; i < HAPTICS_MAX_EFFECTS; i++) {
>> +			kvfree(h->effects[i].fifo_data);
>> +			h->effects[i].fifo_data = NULL;
>> +		}
>> +	}
> 
> Most of this is better suited to close() method of input device.

Hi Dmitry,

I tried moving this into the close() function of the input device, but
I’m running into an issue: 'disable_delayed_work_sync(&h->play_work)'
may be called multiple times when the input device is opened and closed,
and the delayed work can sometimes end up being disabled unexpectedly.
That would mean I need another flag to track whether the delayed work is
enabled. Do you see any concerns with that, or should I still keep it in
remove()?

Thanks
Fenglin
> 
>> +}

> 

