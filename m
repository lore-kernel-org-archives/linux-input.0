Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B4330B2D
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070735; cv=none; b=o9ZBGgXEazqUN4bLRtH3J1YP8G4TyUP/NbTn26ks1kwkuAo50Bv5c/sEynB00+hDW/YBTubvQA4fEW6OEPiMJe2rxm7JxzbX3WMtKhFumKorc8HxrYc6ryTXwiGTRhl6ih/jStxF8nRBPFXoN+x3b5WMw4NVEqFZg66QWHm2g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070735; c=relaxed/simple;
	bh=uATaKfecwuZpQlE1wgafrpigCMzAtsS4/43cAsKSuyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSIkhhVMNlSplDT/KoyKoDRtUrYYJW2iRYeM27DwLnUPJIg1P5gVElKzc4fq2d0Ar7e9jXHeRxwB8G8w9/aPn8fVapmLtBJB+IyTYEnzMZ0ZtE4O0aWupmDvCRJT1p9A4c99wavAw1d5/zzJy8xoXGaetgerg+r8zRuOVvbB158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/JPliBO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JcCtAV4c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/JPliBO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JcCtAV4c"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M5nO7g3902145
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LB7h5TBBAjWDecbOflZxYmaW8tipfD/xijV1P46UIYA=; b=I/JPliBO7FAYLWCD
	18cZR9dv1dhXIdnILDga7Fm6EGD9281nA+oAtHNWSbogUQFNePibusYGzYU4xKUZ
	lC1NtxgAi80zP5BlUEPoNeKQ4Z+AJJKA3sGjLYkb574D780Ljn+H7fMkpMfX81h5
	ZtxBfBfY5FSJxlm4kPXfqS72VmrKd18Nxk3zFxHAFwfH9L3U+WKSjgSlTR3px6hK
	Sn9WTyjZtMSUKF59vdO+aFSLAugzBu8fGCs//CieBQwL/RF5aDIqG7bGqMpMUCEy
	D+2dO9Xn/86D1Df13Lw9BwBD1PqhVS+Q1J1pkaPreQDGsInMxXYyxaJ8K4eUcTvf
	N0V71w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu4khj2jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 08:32:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c532029e50so23026385a.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 00:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769070731; x=1769675531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LB7h5TBBAjWDecbOflZxYmaW8tipfD/xijV1P46UIYA=;
        b=JcCtAV4cTE7Vn/U1Uzvduyu7qRaAy8gy3t08SPM17Im4h9kXrFUKOq3JT0O+0+Sp5y
         bMRxpUfuyNifSTrTolFI8ydoumBsGMgm/zLx45uA4bXkiJsyWYpL1kOllr1iu78JotG2
         LltwWO4QMAqh7G0A/1Vr+ZKBEi43vPo7Jukd0jo/xNG9wV8CZmoEmPfbNZKmAr6JM9yZ
         4F4H38ToIdPbhI7Iqymj8BpaOhLNVvAWZBERw6dBQcSqSZz+1TOh84AEaXh98QC71GYu
         SHRZeUmQT3q/5oZ374RSgogwRwdfQwpzw3lSO/GrVciIdjs+9xpuEoM/F771yNWGMfrN
         fPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070731; x=1769675531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB7h5TBBAjWDecbOflZxYmaW8tipfD/xijV1P46UIYA=;
        b=qBfVAPeeDBeHkVe+g2DmQbl/OqmJro/FStx5JIUbpRJr4OoCptNeKXysbdIa5Ayg+4
         RaDG58F6QqTymX6dAQNIIqScP0pF6ljK+qj8cuGiWPLfi/is0MFweESr0SCUGzbijKpu
         S3jx3SetCw3WZEFGEnxGO0lqATiFUHfCVuXfGDDCZVgmB5HTHgYZDLp4NcO9mmszv7hR
         RTNhwzxhJNfmwf2C5sxjoCKhfl3nu9zXhZLfIK00mkOQzwtOCSxttw3E9QLZ+y64VxJv
         KJc7TqKJf0EVkC8PJQsBYcGRMBkQi4BqP2e0fJ1cTYayMP6NSEd0gENgR8+HQGRZ1Lzr
         T2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5Gs41W7yYU2lJqE26MaGKhAdib8A5gVrfmI3IVCGrYwOzTf+0VFd9c2+HnHhGZTH4pIagf7Cpj/hfIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qdhfLGxWvqoOe9CsRZKd8REsfle59q8x5koONuFRoULgTFzb
	oCsBdocoglooeelYCrmTi9Vq4Y0TNV/f7ofoXTqATZ4uamuFXVsu1j8aZh7cykcFWJSUN8fiola
	3lYSboev//W5zseOoLTr+4vSKjpa5c3DssEUHbS7IzXlsUy952ls7NDDXQJPvC1qsqA==
X-Gm-Gg: AZuq6aIwb0AQJVNetuSW4jq7cddPy4mT8ycsdon/1JAjSbXnrqmiUnxYg7nuLblms4f
	gR4/LQAtRon5Thj4zv9R05PlhYu0sCdYPamjm2gAPdBXU0NR2iBiEvykNcB8rg2z6v5TiNq9A2U
	K40mJ/KoMPQ0p52E/KzChalhEh2AEW3QH9Wj1Ho2MjNhB2BZD81uxk3nY7r42L41nJILBdw+fR0
	gLKIZ5IPLc0WccNnOHsO7efx/2OH2Thocn+f50v5fqY2+FgM/m4pQUN36OHOGDB6XP+HNmfWnw0
	OGiCOIutMjW7bvawTqIyLEv/s/RLr0QHjDGgbKYSIADxSg+K2kq2N5CD1/dDrukAl8M4KqVPhlI
	vCtdondAHX1m7KFSDADb/bC5Yl/1JAByIk9aSCABbGgOYkFFDH5biQaK+/H6pl8+0sIo=
X-Received: by 2002:a05:620a:1920:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c6dafed670mr207524685a.10.1769070731560;
        Thu, 22 Jan 2026 00:32:11 -0800 (PST)
X-Received: by 2002:a05:620a:1920:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c6dafed670mr207522885a.10.1769070731024;
        Thu, 22 Jan 2026 00:32:11 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9f8dsm1646666766b.36.2026.01.22.00.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 00:32:10 -0800 (PST)
Message-ID: <dfe91e99-a686-415b-9211-7cb774e5343c@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 09:32:08 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: milos-fairphone-fp6: Add Hall Effect
 sensor
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20260116-fp6-hall-sensor-v1-1-69275c6bd809@fairphone.com>
 <3a17f2e5-0724-4d70-bd22-1e612142b3e8@oss.qualcomm.com>
 <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
 <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>
 <DFU439A9HP2H.1Y9OS2OPAXGOI@fairphone.com>
 <t4yjnuty7tmvs4vqzm4vdid7oowicy7hcnmqmu6nqtit3yru55@zpo6kprnarth>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <t4yjnuty7tmvs4vqzm4vdid7oowicy7hcnmqmu6nqtit3yru55@zpo6kprnarth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1NiBTYWx0ZWRfX1i+30dSi0i3J
 4hyVUae+iWZATGVv4jEHn9pDdKVPcJenGb13B1O9iZ+PlXIFVkfAEhY77j1yc7BxLhHsU+w8BBQ
 8hn3IK0xwbjeAJBMAKLDB8TEipg1yuWygKM9qYcWHKb4E65Izlrj5VwmsGfmKJ5/xKydD7H2Iir
 7Up/wDiqwPxTXuuRbCh12lRGCf/jw5g+bJrKWaGOX/W98P+AwjKTig7Zu6UUzxc4NuferI8wT6z
 c9Myn8K2DQu7lMDoDSMMxqaATXWibFRDvGY97O0Vcwgt/SEJVlva13hY55sttJehGDhRGtDphZQ
 ldNH2MTA04806lubyg613zeMMHodEdeO2PruLq8UEuOf/AFixk3inhn6MFd8ditqa4N4gjaninz
 s24cETCAiIZPHautKZFZx5vgGpddNXkUBq2/r4eH26BMtk9H97pHjseChkjQiSWXAs4pBTpL7Yf
 V6jmX8ijUCU/pe66XCw==
X-Proofpoint-ORIG-GUID: cRXznwc-4qjWstbawfZgTLjTOQxolgeX
X-Authority-Analysis: v=2.4 cv=UOjQ3Sfy c=1 sm=1 tr=0 ts=6971e08c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=8BatEDlHAAAA:8
 a=miy9QUiAF7RNB75P6oEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Soq9LBFxuPC4vsCAQt-j:22 a=tjV2R_ox5hktXOQLSeCq:22
X-Proofpoint-GUID: cRXznwc-4qjWstbawfZgTLjTOQxolgeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220056

On 1/21/26 9:06 PM, Dmitry Torokhov wrote:
> On Wed, Jan 21, 2026 at 09:07:44AM +0100, Luca Weiss wrote:
>> On Wed Jan 21, 2026 at 12:05 AM CET, Dmitry Baryshkov wrote:
>>> On Mon, Jan 19, 2026 at 04:52:23PM +0100, Luca Weiss wrote:
>>>> On Mon Jan 19, 2026 at 3:41 PM CET, Konrad Dybcio wrote:
>>>>> On 1/16/26 3:22 PM, Luca Weiss wrote:
>>>>>> Add a node for the Hall Effect sensor, used to detect whether the Flip
>>>>>> Cover is closed or not.
>>>>>>
>>>>>> The sensor is powered through vreg_l10b, so let's put a
>>>>>> regulator-always-on on that to make sure the sensor gets power.
>>>>>
>>>>> Is there anything else on L10B? Can we turn it off if the hall sensor
>>>>> is e.g. user-disabled?
>>>>
>>>> It's the voltage source for pull-up of sensor I2C bus (so
>>>> ADSP-managed?), DVDD for amplifiers and VDD for a most sensors like
>>>> the gyro.
>>>>
>>>> So realistically, it'll probably be (nearly) always on anyways. And I
>>>> don't want to shave another yak by adding vdd support to gpio-keys...
>>>
>>> Why? If it is exactly what happens on the board: the device producing
>>> GPIO events _is_ powered via a vdd. Added Input maintainer / list to cc.
>>
>> Yes, the hall sensor which is connected to the GPIO on the SoC, has an
>> extra VDD input which needs to be on in order for the Hall-effect sensor
>> to be on.
>>
>> See page 133 "HALL" in the center of the page
>> https://www.fairphone.com/wp-content/uploads/2025/08/Fairphone-Gen.-6_-Information-on-how-to-repair-dispose-of-and-recycle-EN-NL-FR-DE.pdf
>>
>> The IC is OCH166AEV4AD where VDD is (as expected) "Power Supply Input":
>> https://www.orient-chip.com/Public/Uploads/uploadfile/files/20231014/1OCH166Adatasheet202203221.pdf
> 
> If we add regulator support to gpio-keys do we expect it to be
> per-gpio/per-key? Or we'd recommend splitting into several instances of
> gpio-keys so that there is on set of supplies per gpio-keys device?

gpio-keys {} is very broad and generic, I would imagine it would only
make sense to keep it per-entry, like Luca suggested

Konrad
