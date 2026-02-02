Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0235771F
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027583; cv=none; b=Wk7C7BnxOiHrHlvyH34IKpDvpqQg3IMRdHiUKGf3qyLSlJWQ1BOhdUYjuSv/tcDSSuTuH0Epr15OZfLo3uD55qSlnbFRhQADUC0FrovpGFdKI4Wy07Jd2KfBoj4QsZjT3Blvv9w6ZV0FvORJbdXJDl6b6HlJGnAan2Z227TFmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027583; c=relaxed/simple;
	bh=Q5S+eZyNIdwCwug/VWZTnTNBY6H5mYjm23B+aZSiTjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTBBa1u3MyJ02PUQr6mBzj4XDGGv737FegAK6woubnj1yb+xbzLIvgFUYyyEraa8nUz5ekS2s+uk+fFJbWOrBpt884bV4KUnRYv2KFcrk+Xr1la1iBh+ZGyn09I1tk6icsncGzNED6a/otjjsvdyygoMALoTAnmu5SEyOh46D50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ju9C52UE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=adybnmcX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ju9C52UE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adybnmcX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6127pGth1237320
	for <linux-input@vger.kernel.org>; Mon, 2 Feb 2026 10:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7K8yMMMnoWnA+M65AIQlB2vZJmr3ueYjTb6rPsykpro=; b=Ju9C52UEDu4Z1GA6
	Wqpbdrg4K3F9uEIjjLtEV/JECNNTLGII5DiI/Lys1b4ZMl7I/GHPu96VKbeoQVS1
	2OaWGvx4dxu7E3NpVgcq0fT+fPHBhM/YYlGUF81Zl5EwT6balJj124ouPCnU1tKJ
	i/ZpMAwSu9b3VWyeTGlc656SwayBBdxCD1bfQMffJl3okQxaAX68iTp0P6Pxf6Jq
	OV6Zd+5SMNtku6fvIa8DeMdHWR3N6IFRDUPrM9i4mA+8xYRMo9Rf2dGy1paOXLBF
	TBEYZmm4ue91YUe4SP48y+cKqqP/UCCmbn34Hqnt0IQOlG0aqAI0m1HFrvNFOGqM
	GUhguQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrw08m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 10:19:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6de73fab8so119717485a.3
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770027580; x=1770632380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7K8yMMMnoWnA+M65AIQlB2vZJmr3ueYjTb6rPsykpro=;
        b=adybnmcX960dzUtuUl7N90q1Q6vRnkb68c9n5PaHyFwicS55ROdW0ZfiRFetZkUse5
         mdyBOHa6C7+G+04LPeOcjCJCNYKSJQV1VLUc2nuRdSXRcwqoaOKX7AoGJqpus3GS/m8+
         ho22CzJX2fIEj7SagBSa4/MM6TGjs0y2w6Y6q02BBXP2RziYQqtV67Ilim8saG0R3VM5
         gJLk9jgbGUq/Z7OxzCeTUyRy8IaTHWp7yZ/nAlmfUHvEinpgc/KAl88lB7apO4WvEL0v
         09Do/xGR6/g32LO5Ds4YJVUyHJt4SSSXwpDkB9gLajKlQJrLK/UNZqx3AfJQEfHF4ijb
         1nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027580; x=1770632380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K8yMMMnoWnA+M65AIQlB2vZJmr3ueYjTb6rPsykpro=;
        b=FyYljdIH9SuNI3flp7w9TAtzQZgrSqkoCWmN5PUXGsPFp1FdmjsV158aFbrwMIXOJ+
         lTudSJ5GHfu9PWl0Yh2pk1s7uONUnt8XV9waU+9MK/gYxjABVokkKuvrcZWdYWDZFuhS
         Kpheps6EgvOhyLdrpUtisftINhGQU+vj8kdr/1a7aXlGXO6r4kTGIQVx6pv4hIW7j6TC
         qbQqcFgkj/YmiCfwdFF/zVBwnat1liRkWHCR5kuBJY7mwiczX46YeOLmHgAmvsMDANYt
         DMHLdxYMLKa5UTYfyUPRGlVuJix2Ucn8crJ8yV9BQhh2DpiS1GYEi4gu7BV3qiVqRjbq
         U9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyeuGC+llgHZ99sWG27T+ksWXX+1Ps8hW9gsK4Vnc3mA8l1eORCuH0OJnSrGpnbac1O0lAIpDpHzDWxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSOCeYQ/88Vknz4QFmeGW3BiTWuycAYBL7gb37aK/fQblcgvN
	cUQx4Vo02jokNoJBn9EMEVPoMHwBsPCyAHG4mqoKdqc+7Al6fTuM/IThcxDa4UNXwSK/adGQZxP
	sGcHjfsFQjlep6YNfW8Q0cHgFANsuPS5meZIto3EXGfzsPhksUv1iyXaTqAR/HNR/Xw==
X-Gm-Gg: AZuq6aKuqs67C0jAvQTuy0AclmQVetH9RgHiT8qet/HRU080etybo73eYc/pQ/2etLt
	VrYlaGtemHNDMZMDdpuGDsOTxOlL5t02ZHmGFvhISQyMF3pI7RVMA6pdbrgQNTCnir4xIcrBE1e
	j3HsSs0fJMxoPhSBEYHz2jSwusVVlzVHpHK0sJU4+nrfoRHmeAytlzenEydsKeqFI7HwLw7Lsp1
	Q9Bn3A24lWzK/Did7kfKBmQpknVP9iVDj6YOPiOxiCu8S/4M7iZn+As/9gzE+9oLxIfiMsV7hzC
	N+J7PuSs7iR4uURaxT24V7zVqyEDK+8DIOykNmIg1l7FWt7VeyIXTRaTmpHJVW8by3Pdspe6mBn
	TLTxCwIxV+1ZmYTbBtzMv+cUQ3wXHN1/HlgUG83o6D8ZafAOch8CwSKKe1ceKMXNOoZY=
X-Received: by 2002:a05:620a:40c8:b0:8c6:f997:d6d1 with SMTP id af79cd13be357-8c9eb325aaemr1163988785a.8.1770027580045;
        Mon, 02 Feb 2026 02:19:40 -0800 (PST)
X-Received: by 2002:a05:620a:40c8:b0:8c6:f997:d6d1 with SMTP id af79cd13be357-8c9eb325aaemr1163985385a.8.1770027579526;
        Mon, 02 Feb 2026 02:19:39 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dd99188adsm715942266b.50.2026.02.02.02.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:19:38 -0800 (PST)
Message-ID: <34fa533c-b9ab-4025-b9ad-4041837e790c@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:19:36 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
 <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
 <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JxkDmc0bRK_ore1T9kVI5ga0J8FxwcVj
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=69807a3c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hnEZpkAE9kI51XuuN3kA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX0P5ZRCoTG9SW
 WF8E+IIioR+PgWdLUB+4IJe92NzZkyUFV6BcnUPfKl7rRd5Nvt58EBXZNk1weS78ZjoqhINi9Th
 QiWeiXY3Q7nY7VPyMEGyjvgHKJVxGfej2ln7GBEp+cDUOCCSVK6DLnCz8mMZQiGV0SmNStLVFkx
 wqvGzzf46NXkHKW+8HmcOZlQFHV1/6QURP+KBZi6rcBf5Vp/1cS5o7XtZTwHrJa3I1ylsSr5BHO
 39BNax1wOBqtimWw6oD4X3mQjnV1nkY7nAhRCOeFpZdCtEMnI6nG3fSsBXffXyCt+ISCuHVD7ME
 a+wRkFo0Kof+LFfvnbDMwzM4/+GEWzIMvlg92S6qlHOTb3aMk+pAnlVkqcJMY3pyJ3uK84C/P9w
 V8IYFrdyzBeLejp4MaTZV+4uD8xswLP7jd9KC+WF+AsTl9qsvAzp604DMhfYVxzyKR34Y3myLQd
 /fXfoyv0IC0lCOKiUrg==
X-Proofpoint-GUID: JxkDmc0bRK_ore1T9kVI5ga0J8FxwcVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020085

On 2/2/26 11:14 AM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Mon Feb 2, 2026 at 11:12 AM CET, Konrad Dybcio wrote:
>> On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
>>> Hi Griffin,
>>>
>>> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
>>>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
>>>>  
>>>>  	chip_id = be16_to_cpu(read_buf);
>>>>  
>>>> -	if (chip_id != AW86927_CHIPID) {
>>>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>>> -		return -ENODEV;
>>>> +	switch (haptics->model) {
>>>> +	case AW86927:
>>>> +		if (chip_id != AW86927_CHIPID) {
>>>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>>> +			return -ENODEV;
>>>> +		}
>>>
>>> If we are able to query chip ID why do we need to have separate
>>> compatibles? I would define chip data structure with differences between
>>> variants and assign and use it instead of having separate compatible.
>>
>> dt-bindings guidelines explicitly call for this, a chipid comparison
>> then works as a safety net
> 
> Are you saying, that
> 
> 1. we should enforce dt-bindings == CHIP_ID (what's currently done)

This

> 
> or
> 
> 2. we should have both compatibles with no handling based on compatible,
>    but only use CHIP_ID at runtime to change behavior

This is spaghetti

Konrad
