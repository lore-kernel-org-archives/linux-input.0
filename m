Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE09375AAD
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499982; cv=none; b=Ih6EMVHan2G0/2TeR3T6zOOQoAmp4PeS4Zt5/1espBNIBOKhJjf6HFUOXhg5ke7ke+BrQ8RYcPlYCsDM4i3ONXRZ/Et+zoXZPHKyUQA6twlVG43qavMfh4yE0eQsbqTL1ExtSKJGLMn9IP3UC/M67Y14/TOGGlS5RIOzRhVTiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499982; c=relaxed/simple;
	bh=noclX/RymRW2NkxukjcocB9/8FFYFplVWyQzzJOzt1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/O4Qy/jZIsRJvMUSpNpZbaeWB+thdd7Zj4AGZfP5iV1CJDTfrX6DRiC4TpcKbyF3R1z7AYqg14OpeL5zzawkUCTM+dHm1NbFShZoKLTmQ88QN5OG1uVSCUgzki6F3yzmGZVVRNrDCcmmFP+gxY3fyygAY/e13KDM1i6BKUUXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjGecIuj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZ6LplzX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjGecIuj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZ6LplzX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7nvcY949464
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 11:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XQLblkDWAWxW/czf9my+DUwdl3Nm8gQabtsWaYe3ZA=; b=QjGecIujEqxvh13V
	7uYpTKxcWv5Okyh65JE3wnjewqEaWohzf6zq+8aZcHlwnvjuiOyJsd84cNBYd20/
	iBIQ4Sg+rlj3Unmvl1bP0fJ6HencNR+aRlW8N2BsbHsMXuPDFOSt43NgQRKT3DBt
	kTv17shPaGoPR7mShiC6bRJRGNeJDuIUv02LNAm1CxPkHwMfFbq0ApcjTf/w8Eoe
	lNKM43QVOIGHYsDi8LBwJ5Jyy8RvMBoaLnfeMTNMMXhbCN1G2BaWJ9Ay0pyj5G94
	T8cajFjMqFinu7M/joWDqXIlK2AqZTHCBX9ehBh5mg/d73QNt/7+b0dMbyY1PKIQ
	GvqHJA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dksm25s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 11:46:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-575b631c698so33279e0c.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778499978; x=1779104778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XQLblkDWAWxW/czf9my+DUwdl3Nm8gQabtsWaYe3ZA=;
        b=UZ6LplzX9mRVZNemrQ/9ZguqrjQ3sRGYW+DYQpecUC+SCoAiRbZK2GLHTTqBKGc03P
         RCTLZ/i5YzwB/VsXsIrDNMWlFff5fWdSwD2eMLFCC4Mgv6ngIXfNMSnmId/Ceu7YvSMz
         zTkl232irHfhq3Ft9yyXXo7jPZ85wm4Hk3jLsoLRJ8P680mlDJDpVLOrsrRaNFbuxKb5
         CEnw4jaFlAqwoYIqKJNgRPL+svQi4B3SWga1jLpsQt1PvMZG1MDm6RIozzWfn8zZFl2/
         KBDfa+b+qTgo/JEtbH+hxdhAXVjaxZomGhYZsH7Y9fJEASqJzKOcT5xUz9CB6/01nZbf
         /GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499978; x=1779104778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XQLblkDWAWxW/czf9my+DUwdl3Nm8gQabtsWaYe3ZA=;
        b=P/qMfDJRmix6W/hk+kmvFPyKJODany6HpXttwLAw+3qHQivUztpb6Lka4AMdR6iEgy
         i0DoksmLzJwUA19T5iXw+qmyBvt1p3yLCRk1Q0F93sG1VQTpHuymcSmN8LdpYjLCi2TL
         Bv45sVWyVXBAcYFb+MWDd/7Q4v1vZxkJm3aGOnUMrwcPiM+rjBPt+T2E8iJ9MbHFrTuI
         6TYXw2SASPC4xgTWbIBOxu3UfFZ7GOeY8zxSJPKz6Ezq9bbrUFJhIw8yKG+thUCuLKTW
         QnYPYPPDPIrGt2+lwNyxI94xN8f69hZ8R4s1F8lPvHAj+1ZCyKd+INV1FudjJ9P01OzL
         ihMw==
X-Gm-Message-State: AOJu0Yw0X9CisWDuYvE/BpKaneUUPWZpok/DCYVl2e60TDrtZedkyHut
	FSNKmXFWNSxOJu4GohrmZxVPD6enRuTrnsIo04MaojwIeuXb9OWdBI/e6WRz8CNiYW8Rjnr58My
	OY4KiFzFvEUvfxy+vJzvPUr+14a17Mllw8R5RGVXCJrgXpYxkbbmBxZUh7uakNERuqw==
X-Gm-Gg: Acq92OFlITkfWs0fDmDWfrkjxeDGZlLbfP99bjXseqveSMZEzq8C2sU2HV+GJ+hz/8n
	jcLM3Wl3FhLJ1l022KJVr+ZI2NPO0337ixnQHAOQsv9AVPhTada1g+/m264HFz23WvklcEVi15F
	P0wy99pZiX/0AjNoju6MPwLZga8MZId3d3M0LZEc6bqtHogA7JqGerCblJXzW8NMW4Nu8RIUVMl
	r/Bz9+aeBF5egzi8Wo3YnCT8fQ96lUyyKeTWT+9M75yDTMfKPF1sdI/A829RYAsgGfP4dgWhzAV
	DKYt48jfWsZ0zA4c87nvWzRrZPnY9xqX0t5IKEcTyAOxGq9wTVtVTPjwen/vW8CRLI6tYkVJhi+
	IMmGri08yB+O5SWJR3h2Wgx5GKCV+G7E1Dl5kEjTDF7OMLPMAziynHMiwYkGfukOZLmjKQ3vQAN
	BqLd0=
X-Received: by 2002:ac5:cd48:0:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-5755b4af80emr3913498e0c.3.1778499978118;
        Mon, 11 May 2026 04:46:18 -0700 (PDT)
X-Received: by 2002:ac5:cd48:0:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-5755b4af80emr3913486e0c.3.1778499977719;
        Mon, 11 May 2026 04:46:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd026b13c3esm125481566b.27.2026.05.11.04.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 04:46:17 -0700 (PDT)
Message-ID: <80632a9e-1d78-4805-bc36-19616ec1e185@oss.qualcomm.com>
Date: Mon, 11 May 2026 13:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: milos-fairphone-fp6: add supply
 for Hall Effect sensor
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
 <20260508-gpiokeys-vdd-supply-v1-4-0bb32e8e6428@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-4-0bb32e8e6428@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzMCBTYWx0ZWRfXxnZw5LfCWgZw
 THTivQQzKeTeOEvif1/proWv5yqk+wkJHXH+f/6Y5SFDcDRZpaIH4qtGgxjonXz2DOTJqKKGh38
 rJOnf9U6ZLt7aeXy2/jYxGUyBTDlZ8J/J3rgSPt7q71cj3ivwKHMw/mz3nTuIQDvOrz3xkkRgGG
 vYZNdRQ0kmisav3U3+NIoWEgF9/Pkz5ErM55M4Pwp5MIG1RI1rMK0sIjRN0zlLirklqmGJ8uMsE
 BwsL5MHz2Wvug5JMTgbRX9OzT57IPX4zposAA5XqYAyUXkSDzPsZdGUHcOs5P3PjkQlg0YtYDfh
 Hre2k90OvKGX8385eGhRxnkYA8pnD+LAwgt+uMEU2EfCw+NWDmG5rxn7gxXlDHqcIyyXF8amM19
 /SQLZZyH/VFySEO+LBTOomNU9Kl/ltUTWC8cXXNzvTckZMRGoW6501sESjjvyEKEh/Fhgog8z8Y
 85IPjU9L9h7zOa76Teg==
X-Proofpoint-ORIG-GUID: uTQlBG8oSfxvbmJg84o14LEEPja5k3lf
X-Proofpoint-GUID: uTQlBG8oSfxvbmJg84o14LEEPja5k3lf
X-Authority-Analysis: v=2.4 cv=cKjQdFeN c=1 sm=1 tr=0 ts=6a01c18b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=OHetYUf0uXX_Db3cnu4A:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110130

On 5/8/26 2:53 PM, Griffin Kroah-Hartman wrote:
> Add vdd-supply for the Hall Effect sensor in gpio-keys so that power for
> the sensor will be enabled when it's in use.
> 
> With this, we can drop the regulator-always-on for vreg_l10b.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

Modulo whatever the supply name ends up being:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Thanks for shaving this yak!

Konrad
