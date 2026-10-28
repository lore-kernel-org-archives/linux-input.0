Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189061;
	b=iV89+j6gwJrFkqdXPecLIOBbCej7tLg0CmxDhXMDRzuai57hkhht6NbJIdCt6NHa76Rl
	 n0Rf84GFBh7qyUoe8VYi9U7/wcooaMkuJ8fc3KXXNVuvE0uv+JP7NAUscnAhAYD8l29B4
	 8CGnLZwJ+fEbjs9x89/x31pW4vLi2e/nV4NXjR32GHZkLAQqHRSHbGqY6MIQcv1hasEDa
	 LFak3Y6x2WSOxl/BXSFh/gfWOs8aU0zqYRrtEQvs3tLUMdLybJoaP+aype4catste8y7H
	 RjKy/4CRQ4UzaRlzp2Mk3Ujk/v8Tj6t6jmUq73lUyubSVyxuK5MIKW/2WrSZRMxrGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ghp50T07BN+pBS1mt66586n1LUvrkgrvsClQgUfUovE=;
	b=rhLiTD7ZqOCQi/r1eeM3JGj9YHdjCzJf/YduWboK33PhrpbTArjpi2d+8DwDEq1G6TE8
	 FAAduY6zTAqp8ZYV8Cx0i7fNsYP306Ct7N0BkzlDgcwH9ckg8AcprnxGeO4SsJVbR8ID8
	 VCDxt0zf5VhP/fSCu5qHhamm10KidAFzC7Tgr+bc2/6SLeKzMlhoswOcjyENq9gFF1XQ8
	 0lOeNDYW0Kt7G2EiD3t+J+/VrTiqSNjQe3trMt7+THbyMnU4xVyYSXM1FkaxZ2MdQIHj7
	 mWQzhfAzkJc/VDcyuTyYp+ajGZbE4dSbkWLRnK3ivjdwO2dek77WKeChZk4nJx94Fpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A6snvN9m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H5mJLCG7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920C606A31E
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 12:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B920C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A6snvN9m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H5mJLCG7
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBe2AB994523
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 12:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghp50T07BN+pBS1mt66586n1LUvrkgrvsClQgUfUovE=; b=A6snvN9mZVyi5Hr3
	iK+WpdiaTKaqYIz/umvVihpeIn6IgxYYRXTNYoKJT2BttvtFDgx8ecfaZyaa6Zue
	BFx1aULCEFAebWHWU5MWzEdhgyEEAax/fldQaIPi6dSEzwAbWfA0h8argoJf1Ywu
	47PsPHFnaiICKAjyrXrFhaggHHfvTL6eRUloYxZ1d2HjBG2XisYZ7QyvzjmRDdfV
	49+hDLPcoLHvqH0bjAbrXEY1+pNrIC9rMHUtVPXL82+SoYI6KDfHwUTLncUsZMy3
	SKe8jms6Rhvipxw5RTYHwkKd8I5t2wekF1V+QxPZsSY38hFxfK+B0ZCMZYfdA3Oi
	0hEzXQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82tsxac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 12:04:19 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eacebedc9bso41641e0c.3
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793189059; x=1793793859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghp50T07BN+pBS1mt66586n1LUvrkgrvsClQgUfUovE=;
        b=H5mJLCG7NgK9TgtT2xYPSGhmEEu6TtQWhXoTXS0hHL6lGk13A07MStjbUB3OQzRJgS
         SPcKp1VYBg0rc4Zud4a7HGoBgzJSVoOf3FNc1V/ftd7WRaEUXSbt6TvbjFwq6iBGEApW
         +P+mS3knShJRamEt3DHDPh9c2n7VVA5q6sskO/pEvjztEepyJtF2+uiEY5stWsMi9J3E
         PgcQ/7uFg9elf3As2bURA6Vs3mEy93ljMJydYfOXmXbcw4yNx4mmeiIdcHR6CadsVL/z
         xhKze9ofZLYuuSt7nm6LHJsBEHDEBQijgXtZGn7TZDxrCS/3d8IpfYB4SOgvJE5c+B2D
         b9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793189059; x=1793793859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghp50T07BN+pBS1mt66586n1LUvrkgrvsClQgUfUovE=;
        b=q09GU2syGYSFI1uqyDqp8Dil8ywFzH0UmBhG+PNjD22EuKUSsox7cWZV/glKu2VJYT
         zfrB5kGpZkH7Gn9p0mJJHnDVvQLkw4u+Ey1TndzzhB2jre/REBVNYh++60qfzOueJrrS
         9e0Dgxv/YKlfPBsq5kMiRJA2MhGY5Qy7ETwtm4J6yKOIergvkduXJqk1+c7h5xAHPy06
         tsZnlS6c4aqz8AWrg4rRjlP248fA8GgWoXYydVqnGUzzdVNs1GGZIxvpO3kUyNNIQwQ/
         WfH4jalIUV3+Sw7hiy3CuAvlJ/gK4yEvAKiAZEuGEFc3t/XuRuypBM585sMNrUeh3ya+
         q64A==
X-Forwarded-Encrypted: i=1; AKwUvByQraVwU8eZYnjMrSxywGo6me+YGlp7s1qO7aOkwAE9UrUcW6My/eYZFBjqDJOFIyfEy8OdJ2kLeewv2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCj3QqlCP1eB/FRQ4bvXUpp1fzaSqShQQ0UN6wKI3REOaDvDpa
	WBPJ0zXikzq4Cte8i7+4aIbrXVazj9v42nxrKI0aCPbuRT7QHMWFOw400BW4msnSGh5au5F2aAe
	6jzeCuaElfefS6kZctu4kZwc4MkwuPI6hFwGmKEy8npR25zAhJq4FxM403dx5R1B8tA==
X-Gm-Gg: AYBFou1TpIU+SHINzKexgdEsRXjBEEzoZeonvTBu+2hy99MpVTleIKLM6PC6BrQDu8w
	FUlfGdPVmgYN2HzNh4pSgYwD1P5gqUrpeVudyMuRA8jYEptK9DISs96Cy+LHqFh1grJxthoUStH
	epFXoQ1WrXeZDD3qRyMrW2aNHvvcwNmrmoYLaJD8v1FPYtwW3ILVaJa572Re1knGvuP8NIcoycT
	+3fpclgYHE4AI4r7N5H1CQTcV0OtqkQz/1kNX/uHuWX9okhMXly+r7JEbqXzKDua1wxuSZUBS5g
	GbLwXxsqVOA0vtr6VeSJdb9lwiGvwuSs98+/Ib+vn+E3v2O0oiuqcLLAbrX3WD9ZxfB/W50Bq/h
	i4AOfqO3IfoALegFwZe47emoXHT5uInRd7iDDTn9EcLUb1I5AZaddKyiA97jZRZ+FsWZ+ipQ=
X-Received: by 2002:a05:6102:8482:10b0:7cc:22a0:de89 with SMTP id ada2fe7eead31-7d03a556ca3mr577568137.3.1793189058786;
        Wed, 28 Oct 2026 05:04:18 -0700 (PDT)
X-Received: by 2002:a05:6102:8482:10b0:7cc:22a0:de89 with SMTP id ada2fe7eead31-7d03a556ca3mr577514137.3.1793189058217;
        Wed, 28 Oct 2026 05:04:18 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49640f1b9sm1348803a12.19.2026.10.28.05.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:04:17 -0700 (PDT)
Message-ID: <96405224-72e6-4786-b13e-d73134b58ca2@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 13:04:14 +0100
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator
 support
To: Krzysztof Kozlowski <krzk@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Enrico Cic <enrico@privacyrequired.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1793135056.git.soyer@irl.hu>
 <8717c3739be282747cbef611d242acfc5a40656b.1793135056.git.soyer@irl.hu>
 <20261028-thick-gainful-pegasus-e1b430@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261028-thick-gainful-pegasus-e1b430@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HdqS170D-uzhD_qan1ynk5oT9iDuc_4L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NyBTYWx0ZWRfXx4GOUE6xW5mQ
 8x8CXF7LEufRsfoeQz+x8weNtEpvdWGqyis91JSTlGlLn9FWJkg6CAL6lgrBIayTqsTtxV8k6xF
 hyFMPle+snbQGIgqorrGGoGstn3zdis=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae1e4c3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SrNx-AKsgThqvEfA3AIA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: HdqS170D-uzhD_qan1ynk5oT9iDuc_4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NyBTYWx0ZWRfX6RQ7RLMDGb2+
 E9IjY0dJGjmSC21Vq1bvjRpXbZC4HazBM/EErFST5IJdg7ZLZTcDzpymPeWc4HIkaOPGoOJ4qH3
 ZIpGoCAJsXn98rV6723QYF2s9fGH1tiGoJ5a2UPubS091njygXoBWRrQpiLgmc1e9lZi2f1EdqR
 BroE7ras01QvuTjjKvCiz/Nny2D3/1Y0/GyiOLIAh/KBW2C02kFGcNcRaHSewHktiEQ5S9xl6zQ
 ebaRYfS+qH9pufmZVv+YTL23wxCL/nHQYEblvDJR0iHfjLIH7kLREThPea0R5xu2iO7JovnK/Tk
 n03N25baMVsZoSk5nfbIV3AYATRSrqvJKph9hC2/3hu7pQKgQwHxFduPuVYNGqMFeq93OZ4DhBM
 4RrSodHstODF3QnSx2gAZrw3jOqegYAx5MM4NzmNWAIhZrR5nUuX2XlU5UTtF68f7Sd4ZnwaedE
 JGkMSrRAFBHhHTErdEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280047

On 10/28/26 12:08 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 11:01:25PM +0100, Gergo Koteles wrote:
>> Add the required node for haptic playback (Awinic AW86224).
>>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>>  .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
>> index ef91986a1fb9..434846be51d9 100644
>> --- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
>> @@ -924,6 +924,17 @@ &i2c4 {
>>  
>>  	status = "okay";
>>  
>> +	vibrator@58 {
>> +		compatible = "awinic,aw86224";
>> +		reg = <0x58>;
>> +
>> +		interrupts-extended = <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
>> +		reset-gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
>> +
>> +		pinctrl-0 = <&aw86224_int_default>;
>> +		pinctrl-names = "default";
>> +	};
>> +
>>  	wl2864c@29 {
> 
> There is no such code.
> 
> Please work on mainline, not some fork.

+ please keep the entries sorted

Konrad
