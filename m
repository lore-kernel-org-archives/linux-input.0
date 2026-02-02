Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D132DE711
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027152; cv=none; b=fcYkGY1llgzm32MDvVmVjHpw5T0Q1Vc3xr5Z/sdaXWW93GOQ0sJnHCLTzxw4b+/PNtx39TEH4MmXqQCd8Ln4x6SP14rcbF8+WIk7v4Rqn49owLwdcEMR9xn0V516rk6sn+N5hw3ttRe7HbJC1SJw5x2vqaaEZM0YMq/uJk/tM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027152; c=relaxed/simple;
	bh=iFMbqwctJwHkJZqPrzS51Pz2muts4JJsycPay0HzPyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHKDqZzvGohFRwzsvtTU1JUslfs6LLIfLF/QCWA8OsMisq0iwfmvd5xboNmhLMvObkvoqnrZ8Omjq9dfVmltRJ4rleT3evq21SdSOsDnMOpjyu9DnhGC5P+RSlXWm6KaxfXZHG0l/DJ2zj3l8mNT8YaYZMsvxLBa6H9leycBom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1VZ/D5e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h4iiyc87; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1VZ/D5e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h4iiyc87"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61284God290301
	for <linux-input@vger.kernel.org>; Mon, 2 Feb 2026 10:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tHS6Wu5wR7F9TxmgaA02/LdYSXLSsQ7GX/XD1ERtU48=; b=Y1VZ/D5e6wIoYfpM
	UTB2YvYYdbFnZwPc9SBGl/VicNsY1Wkoiq7JVtc1WzShEc6FTVcs3B32tysDzyGq
	Jo2yLNeVamNumrbzAbl8mWvWWG4RdI6k2S0nV7vFv0hKLhrPmHbhSJNVAd7j5Pgn
	JJMWvUeuWr+j+Gn+Dk6TU8yHN8JKURUveU//CohN/s9vOkLKNeRE60gu8plXADZf
	NlOcsupYC/VuZ7LFolJlKbJicgyqZdy2Z7+1iNl3lMtRbR7g7EioBUYAusIRuFJE
	qvTPXzeWzsQHNI07Qvch5kB8TjgHYDlm2iGRz1Ya6H0Y4qzwcrAboKSb4+yKiVuX
	nj96tA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arecy56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 10:12:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cb31bcdso91787085a.1
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770027150; x=1770631950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHS6Wu5wR7F9TxmgaA02/LdYSXLSsQ7GX/XD1ERtU48=;
        b=h4iiyc87ne70ksM2PF+DM/2LHnkVqtzI36Y5q9RsawcHw+UmzMMGTaPcNRYZHOLaPK
         uzuy4T0ehECIqRp13Z5Yo5GMPWXjAXtMClz9fkrebXC68W8dPmLjBm2It8ufl4EwMnuI
         vvwUuv27ZbwOJYvZ9HRFy/o/lPB7o0V5/FUKXR6d88XWQ/jYQGdxlFXv3mgeUXCN+eAj
         2aw1VEstWu8OBWXyKb+SgA0crKJO7J7JfJZeRCefE+c857fjZKmB45sYAo4wsOcSKdtl
         dnCpNfTyXHMxsTS8yQxNOvre9OfpbkX4aW1MdGuhJJApC3Te4ooWYia0PLFJXHIjbFZX
         hv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027150; x=1770631950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHS6Wu5wR7F9TxmgaA02/LdYSXLSsQ7GX/XD1ERtU48=;
        b=P++s0dliFlNIPdAAPd7EMNwjS5rJOFYrvziIVW/Q6yLV9DinLwiIqVTvCecInel5a8
         Khv6AVwcvUfq6mL99PQfCR9nTLFrRTHsVZysbOz2lAVsA3pWVze8W1cGTxbV3rmNkBFw
         J3Ft5rDs6zDzQ2BmkbmyxfZgLvSipL7unuLXiDFAK1VelxtWu6dyQ15PI1jSe9KXqCYe
         gr/kLI2x2RUtwszjnG3hOTWQnQsPwoeRxKWwPB/lqhWW3gwZbg3XvLjfcqNSLOrMP4sr
         gUW47bEXRZJVbmF2iCL2Px9FfQAg5EByRH+nOqRw3qTarwWfmzt/bWr+Q7DJ8kskKA+4
         k1gg==
X-Forwarded-Encrypted: i=1; AJvYcCXoMtFr+wMrhJ8tit5Y3pihZdG2fUkIepIQFYs43G22CUPDapKPoaWkTr3waF9nw8G5NcRxIO0M/Ql4gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/7EGxR7x0WCUXMXORJk/srljysOy6CnWd6NCIYXFAXATevrW
	L/fqZLdSd93rM3qyd8eROiU7hdd4KY1HAqhAZeADxBowgMfPnH+W9JWyAhFU6u50Tg1y8dx9lZ7
	I1XuBqwDs9m/8wweZ3D+S7EV+EOsPzjE5pe3/FENAi+bp4WakygKFtfi/KSWx3g11/Q==
X-Gm-Gg: AZuq6aIa+FgkX3PZLe0eTNHh4H5AItZU0HB0H0nB1HeGucPMAeWkQEFBKJHeKElP3KE
	MKXTXGl+M7IkDvY2/e0PcjLgkIJaw4ODJAvDCK4dhql/KtGI2A8acEZED7iHp4jdycY4lPVJAgj
	zHhTdJDPEHEqr9+lK29bdgZOqj8CjBBDYt8ScUu3trPDPMf7dNh/hA5yEFj21vHOoGuSteDBXDB
	DyDYn5Hsjifo07JBlo0AcBdWnE4vSWWtjJx4iQHBs2sMcNIzyEMnmxhysmw67Zqf5rcAOXASv9u
	ZLtejJgbSQdbQVSTXAgriWRK/ckcRajGN5Bg7ZQUhFh/ANoBtaJFGrH75KjInFiUIayxRktfhmF
	COWGm/Q9lU1wnKwt9tyYHq5y6DHo3f78h4AD+2JQVyzmh0S5hKuSELY5GeE5oMhC59YQ=
X-Received: by 2002:a05:620a:4086:b0:8c0:c999:df5a with SMTP id af79cd13be357-8c9eb2fa331mr1079660185a.6.1770027149614;
        Mon, 02 Feb 2026 02:12:29 -0800 (PST)
X-Received: by 2002:a05:620a:4086:b0:8c0:c999:df5a with SMTP id af79cd13be357-8c9eb2fa331mr1079657285a.6.1770027149193;
        Mon, 02 Feb 2026 02:12:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e0901c150sm528620466b.69.2026.02.02.02.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:12:28 -0800 (PST)
Message-ID: <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aX6whqw7XyaKMd9m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=6980788e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Tsre1VS37Hk-rMnNNKQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: b-BaFnYC4nlcl0SxbS7cBvrHFo1sfuNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX+aGvSA+4KLUy
 cZLS/DCLpp61Mv+4Wi/qcdmLUpUfPwYXO143KpjRjrdGMhuks101BuxJ91CQxTAMnXzlCGIy5So
 omuXiPUtE3vzX9yL0f4FHTtGoZdeRHU9FvyW0vOSnbT8mdhVrGrSu8TWxd6wR20cONivF5ao0cf
 Td8O3QuUUvfQk+Djfc45p4owfOMuYnogrvIwODz0cEots+/LyPlQAdJYIYTS1NovMU/OGfxWERn
 oA62HQz8JprD7Mmw/7iisO+sjeId5xomOYQ7jFau3gA7sVL53PqY+AVB6JElO+CGlSfCpTrrAgx
 lpXSQKJFbgZef9omp7il2z4Ab2n8ozQVLa7yBXEQogaicEJgbEV9kDjHK+BYDmm2YRfd74i+gtb
 RxK0j2lFuSBwTEInFCxmB29GG5c8GuGx0+tVHFWxLEQ1K4BFqa4h+LQyH7Xt8nObtkYpiAzqMXD
 5KXqnk1URA0HmOcn2XQ==
X-Proofpoint-ORIG-GUID: b-BaFnYC4nlcl0SxbS7cBvrHFo1sfuNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020085

On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
> Hi Griffin,
> 
> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
>>  
>>  	chip_id = be16_to_cpu(read_buf);
>>  
>> -	if (chip_id != AW86927_CHIPID) {
>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>> -		return -ENODEV;
>> +	switch (haptics->model) {
>> +	case AW86927:
>> +		if (chip_id != AW86927_CHIPID) {
>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>> +			return -ENODEV;
>> +		}
> 
> If we are able to query chip ID why do we need to have separate
> compatibles? I would define chip data structure with differences between
> variants and assign and use it instead of having separate compatible.

dt-bindings guidelines explicitly call for this, a chipid comparison
then works as a safety net

Konrad
