Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D7455603
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387297; cv=none; b=V3RI7qfVi+gCdClh4GvuFJJwHrsHppQOE5A1OPXD+AmzkyPJSjAtU9ch7bpVtbtX24jV+fYe7lWvjcN9oYqA6lQZBvulLwQYkWf3rOvkp4m5aqtZwcfd9i8Ot6IVgk1uiXEq/WtHy8zLKeYQksoOT3kYbXdjollgRGZU49UMvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387297; c=relaxed/simple;
	bh=86eYR0i6ZVOAL+yOW9gV5s1lTtVfbPgehRLwOGUh8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0S9lMRaM7r6Q9Wu3hwYt13MaOe5hOxJW8k2DHC3zeLErnbch7/N6B9W48+QhcGI7Kpv3wk0FSdN2zZDROgQuUrrCtYKxyvvcEhJUfnZ5pBRm6e+kyWleCvossKx6nsWQkTYN3a2+DlsAYIvnPK570sdyPAFqinpHpC2RNl/jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnamtNDQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/cUyenc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnamtNDQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/cUyenc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAm6W93291509
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=; b=nnamtNDQQ9gHj/1u
	8u+wb1s8mTP6JWRKxKfdX3d8ABVXd5kMHmfW4wQ9nsSyRrjYa8WkAnjy0dXdtaEo
	h2enOSMboZOQCYy8H/CFLdd9f7u0SAjuYTs6HsjKsSMJyk6o6xUB+uwhBjPWBiyu
	sicjPLoGajNYaGVa0l8fMYcMn32TORMoX1I0eqFvp30N4DUbJntsg9O1Mb2f8SY4
	vyxc953Q5FSjtqXmzyZ3M9e1jVgMce4t+MrG76KRNx7HpcRB8WhzKnbYVSsGWoj7
	x1ZSWv1V0N9dsqSCWcPL2ykRO9F2MIYBz8r5t+u5rEJnunkGwCFUwiCOgKAy+DCQ
	w4ofBw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg8gc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:01:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97cc5388db1so36514241.2
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789387279; x=1789992079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=Z/cUyencPcBCvGHjHB5IKY53arIs3r21sdUZTIMBq8b/WcRZC1K5QRiGrLTEKYAm+/
         o+m19HyH6Zc27DLsaiS9CvlYpH+4jImYysOJYaGzuqMXtHWHS9JRPHpxLT+wmi1Mb1Li
         ExeqJfg0/YVZjC05Igdjqht6wJqZYPRn1IEuWz1HdnYXGEMvOO9vB+uu/MhMhj8GBjRn
         RQjsarsg0lJlCgwe9iICBwuPGXyPxspLtKt+IFmXc8+txPgvBAp99GHxj84VnTZr7XM8
         m6ciE9MJfLyAqwRXxgIW2SloFBeX0StP1EW/TJB5XJXBc/8SlvGKF+rwbtoCC8YBlMu8
         tkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387279; x=1789992079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qo6JOC6UhdyNUkaB81UiRgfAcuvaacMeC1vvdHJZFec=;
        b=Jx6/ReTMN5lw3H61IYuGzADlf77YnTNxxFR6u+aKKRZwANBmCZlWLrCIjtcFPzLEz8
         e8xQuE6S0MJrH59HYtTKz6nVnhuT52XnO5kppqbUssMCBVCCgQbUm1U+IULBv+2ngQPk
         kVmIqe3luvgE6swlXXJWie5nLS5mBgf85MLUSWGorSpS6oMad7QBO/ot6/oAORyaXab4
         RdqWtB1zmiM9SpMvQ86FK9uw1BPRyupVV9owevUtr1r6rKMRM3YdA6U4W5ctlAUCY5Vo
         r9GY2hOMwBgvVyuFd46lfT9v4DuHo432HoUFum5wZPUXvwWfFzAy2UnbcPC1SPOmFNnC
         vECg==
X-Forwarded-Encrypted: i=1; AKwUvBxF8qeDHAyvDMnltu6b60Af+8zH1Wl24KjDeiH2Kl2hdbDuI0BU4phzeAFbkznpn2H1NPkPDgmTPO2WjQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kcKP+3uaB04FPX64GgR4knCYuxVX7oKM+D3WHWJ8r/rV1g7ufI
	9BjNItJDXmaahdBxNAVBcBii4o88hduw5dSJGCGmAZjcqq0n83x/PFr/WaTWA0JDsHAqMBNEbFP
	23R18EEMcMXCCjckqA1rxUVgbUioCbXteSjSfCcjuDRjjP/X7VJT2iVq1RxdLoFKo/g==
X-Gm-Gg: AYBFou2XLwLbEf6I/ULMK+qhgYnEM+rA7p8PIGBXjXuLRLbmgL+zcN5GPrIGgv9AkfI
	0hQsVCvu/qI0/NKIYrx8mTboQGWB42U+ZK1JB6JlZtAmpdHZhNv4Qgb0sYgFEeruzMPDwxL2mVV
	okWi+NUfZGBJFh5wFxdq0Y/AYI4kylbzzeehIzXbycpkvRdkvlk6DvNxgWeDob2+nEeMpdLID81
	zJX7V7rKkFTgftzqT2gUzn1k6ci/cMdMCuu7vOCxDazWxj67MZDWmuCSGvH01DFqMkVG/GweIeX
	cF4D8zqCKRHCrX2ygduqziktYSZdedYukRtO3TvOyTwZaaxy1XsZKqBnYEi7xJRh/idkBYqdXrw
	rJetJn3jMG/ZIVLhveJg73A==
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321820137.2.1789387278940;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
X-Received: by 2002:a05:6102:149a:b0:797:576b:a9f with SMTP id ada2fe7eead31-79b5be3a274mr321754137.2.1789387278364;
        Mon, 14 Sep 2026 05:01:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4dfc7sm417817966b.4.2026.09.14.05.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:01:17 -0700 (PDT)
Message-ID: <7f3aed88-fd53-4cd4-a316-630208e7c08a@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
 <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
 <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42ef03e8-112a-4689-aedd-eeb7ec9b4f58@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa7e210 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OuZLqq7tAAAA:8 a=NPzieGulNsBdfkreKLwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: A7TUXl3SWhxxpwPhgTx3w5xBOe1YlcqY
X-Proofpoint-ORIG-GUID: A7TUXl3SWhxxpwPhgTx3w5xBOe1YlcqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX8WrLRQKS7/SC
 2g/YvNhFAptqnhobPhfdgdEbH/2BAZ2Hleca/As3pcNKqbKtjYCp6lN0J1EiP04vdwQDwIsRkJz
 8XxTDWMJyUehfwwc0ShNootFLuywVqE8hqj7X43/Foo5gpRK0a338urn0fVygGJGzehKp0/p+Tp
 uUnLuvnyIoSyjrJ7amngDXUJv93FX1xlVrcagfN//BFn2wBTsZiaVw4zOkNhuJJ8115EFLSIV5C
 0LiwT0cFeklFXrAox1MZYpaVL0Gif0PzUJql/0m0rKqQggj8wPsiHlAQUVMuf47lJS7uJSc85vU
 hJ5MJeiMMqNBrpv5n6vu5jLwBWw1x9fjlXsCu79ueS7oPDxSrGpRlwsKZhHws6H4dQUEO7IfuGl
 q/wlUQaDTX4FWR2BGktq5AId0ht38AAZrzpLXW2duK2QwUPLc+mMS+Y5yEKyy1SyK6W4ZBnq0EU
 J8KZO85ckYm5iG6KRRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX4Xhiod9V3zzx
 Bg8IjsjaJ/PiS/xhIDzNpDIawvU1P8Y2SXGImsO1tbchwDFseh8E4GdhTsbF1GMhREjSQmyCgfq
 4PGroKG7R2DjRHsORFs0mL16hmOz1r4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140171

On 9/14/26 1:58 PM, Muzaffer Kadir wrote:
> Hi Konrad,
> 
> On Mon, 14 Sep 2026 13:22:52 +0200, Konrad Dybcio wrote:
>> On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
>>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>>
>>> Add General Mobile Shamrock (GM 5 Plus).
>>> Shamrock is designed similar to L9300.
>>> Downstream reference is [1].
>>
>> Please feel free to
>> wrap your messages at 72
>> characters, otherwise they are
>> a bit hard to read! :D
> 
> I am sorry to hear that. vim shows
> it less than 72 and I can't see which
> line is bigger than 72.
> Only one I can see is url itself.
> Should I move url to Link trailer?

What I'm saying is that you wrap your messages at something
closer to 40-50 characters, resulting in excessive newlines. My
previous reply was an exaggeration, pointing to that

Konrad
