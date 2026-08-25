Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520C238C36
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628322; cv=none; b=upPZmPWuGXtDJHgNKzIyt5+Er0kcQ1S/GuuO3dj2O5rYsp5wYktk4kYtZNPyU8HknfbZ8CGssrjB9aAYdxzxwTQTqScPghY3UuNYsmQp75+NpeByTcMbSLrS4a2Xywiqde+deq64Ec8ObiXQY1LUtrcskRcGJA947Oe85BWeXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628322; c=relaxed/simple;
	bh=5sC65HxqHy2q6gQj1Q4zZfKf/D1v64cBmlCVI0LSeQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKRf5dt6TlnL4Jml7kB7waLba0W/6hxv9xYxlIr5BRuTB0GFmguqqDRqga7Qz/xjVewIMjtxWoBs0SX6ghfeOesRkI05hZgBsqCvKAqHiwAip3WZL0JLoTTGrD+gAZphPFKgP81qdk8huaoHWCjMTeMjYsaaxeOo1aQb98WEokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6OD9ZtO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYUd21C4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6OD9ZtO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYUd21C4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R7Nb3741555
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MYeqv+ALj6Cfd1bCbQ++2ZAswFiG0g5XGZYlJ4WVnU=; b=V6OD9ZtOhTIn3JKB
	kNq+UJQYved8AOGPa85qisU9WJIlRsXI0h9cYCGJ2yQueinunnZM29aRgbxOwRNu
	wpwFOjJsQK5Vbg43pX2t8lu+31aD3Er4XQVcxkblA65XTfzROIO7OO5GG/eJIca4
	56714EtHPU9+biAhlKVgxcV2n3k56XluKCUs09AXJr731Z7K+fJXkmOnMhJjxsvH
	KOIdnnceJyw69XXVdeTS4sa1Ml7EcrTF57ZECMMNNoxGPSgVkbcv32uG8TN+Cgg0
	khPeWrcZcYMsdBd85jBVsHH5nQAkjoEzToDNovHa0VVfk4iw8PNtsl+oT8TFccfJ
	os14Jw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv7brgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:25:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee57593baso3069552a12.3
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 20:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787628320; x=1788233120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MYeqv+ALj6Cfd1bCbQ++2ZAswFiG0g5XGZYlJ4WVnU=;
        b=YYUd21C4xv3RyMwPdeWC9pYF1yyMOlpi5JeFx/vx1b1pRTv6tXv5D5/IzR74tP1WzE
         7g6hNj9SCzrR4cmhSKEL2NqIkBwf5rng+jPK75WahRcdnLfzl7RGM0Pi2xZruRFXW1Gi
         DqmYcNddpBLlzGgCXZCjJX0CbH/N/aPMtR6NmQFolAHr7T5+QjzxBmyV9GKm/4vFa7cG
         jTqOHNMsc0vqp/oCP5Tn1lOAImq7iCPRZi4cguXG5RdNQizIE/4wYLdahf6G3NZwOz0t
         OEv1XEeu9B/RDKwaTk0ZqsaWkyndM/cv7vCbChGmCf/052SiviVKjaFJgcK0CNbnwW0D
         Hhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787628320; x=1788233120;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MYeqv+ALj6Cfd1bCbQ++2ZAswFiG0g5XGZYlJ4WVnU=;
        b=WmBInOr850/c2S+883DDssOaHK66LE9KGSFrxw48qzrOjJ1NAnX9oEu4HELvuM2OkJ
         qjsorFVmXCstJGbPniaG5Kcwb8rGnQVzqLMDmOKtgvjJOH+AKjFcYw+XwcmSbQ0FL0+e
         kKf4hsxLlSFd57Or5URCQTL6BeFt4hAhxu+bdc2GHZm56n+YthjTeNFUB3XrGctglI3j
         U/8loT2rv3remrfPSEZ2SMLKy4zWbcnaF9ZhsOnl9//n0FqpjKX6LPZDx9/7oG3MY+6Q
         voL//Lxu201seCZoE9mK+Gry64/DjsELcCkktAIGqCHqE5swAbz4+uaCk8cdCl9LjUgT
         TJXw==
X-Forwarded-Encrypted: i=1; AHgh+RqZR6TNVvH8fDCBRjEWnR6nATTSof3RVug64FM+dNqK2T1OuAYTIR8Ap52zJeyzxZIZNyDmB+mKyoAkRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mGAHiR8pdUikoLs1WUMR9Ay66ucO5x+AIL3uOshcFGw35DsKD5
	tyk395IYs05QDi2nfWrCcU5d+QjpJQf0d/C8biEUFB/9KmBXDhMQQYNdK62EQYosvy0EbIIlalt
	bjZZo9pnbjfMoDlWIrHxGNg6Gk3WVqqWVbOUxHSQA5PcIiFv67/7pfStGjJgyqWwpUA==
X-Gm-Gg: AR+sD11ybpxFIzeqv+4vUyndA0pPMnfSnAY+RiixPhzseWRsVrwdS5IalDQ/XFVt3SA
	4/pB1q5Q4fTaobJa/semst7XO8rvIjQwg0t97NIK5Q8a1TgOT1PXyXYLTymStTRbyh2uFQI6Woe
	Xg1XMt1vXW1wE5xl+LSYF/NSKmMspDzwGJ7ecM748blMM8/OfNR4MRXM53eL89nsYeZz5RdCTja
	74rERHGCAHhL7IRnngnCFVwzHEabTbdzBmpv+fCSjlYZJToN+X3fSWaV8SBxWnH/dETMFjMeMG3
	INE03CgTnA7Jd0LCGQXFhijYninNgw1uQqY6sV52OL5dcyruhh4DXoGiz+cgUolZdgSXIQE0os8
	cWMB4oGhDWbLudZvvGBIAbirGUEYCCXLvlq8ch+aLjggSkxNAIdI1Llv2+iO7lD4ApKJa
X-Received: by 2002:a17:90b:17c4:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39646519363mr6263282a91.13.1787628320002;
        Mon, 24 Aug 2026 20:25:20 -0700 (PDT)
X-Received: by 2002:a17:90b:17c4:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39646519363mr6263184a91.13.1787628319525;
        Mon, 24 Aug 2026 20:25:19 -0700 (PDT)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bbf440sm1944627a91.14.2026.08.24.20.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 20:25:19 -0700 (PDT)
Message-ID: <e4ef85f4-3f1a-435e-9bbd-86d499733a88@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 11:25:14 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
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
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
 <214bbcf7-38ba-458b-81ba-d7f3a42cb73d@ixit.cz>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <214bbcf7-38ba-458b-81ba-d7f3a42cb73d@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8d0b20 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ovy1QOkU2M_fSUD7NcMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyNSBTYWx0ZWRfX7vCXf2GMK5pT
 qQSxnEDXlauSB3wlGRPypLKXt5nY1mYW9HatsQkObgL+xsvfx8zMNd8+EAX7gQ5Cm9YBGMzlDPM
 MVqDHYfk6x3xSYm3w1pyOQuxqJRiMvk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyNSBTYWx0ZWRfX+6Ps8uahHBSA
 blRcR5o+LHEqS1kbnwobvTtJNANZ8FB0xPCMltYsnD7CWfXBRQDdquKYgdJiFlkpTDjKtSVohU+
 P2HEj6OP0zeqfE+pWxCDsenv+Nv/4hSFGyTCJtvuOoJiKWevE9lUr0X2BRAFrTpIfcbdcz+2RhV
 6Y3FD5U+wIHSN1YLGYCNmkTk14y1EzwQs+37TIVuSv+++Z3e1gI6GK4WeSimhrjyjsjNfJ8oenv
 V5G0kq3IFytm0APZrI9Z6TqkL2U4ZbvLvX+jirWx4faWIc2ea1zQXqE2znI8hPwcJz/rvos30L8
 W3Xz/xkF6Y9PJRVoqpXYOEcPRgj/WjiDh4x7O+mn4IzItNQo4ySUwY7HoRp9Rs8SPoFJx7fZ4/e
 9uaCFfMHhWuC6kE9QFhfNHmCeIKR1GspfmXMYRcSNhjfDPODff/G97btflt5PoSnDw9qE30AmGC
 swHsJCrOTWGk9ur2e0A==
X-Proofpoint-ORIG-GUID: LJaPvhEIIaEGem_1VtezS2-tOX_WT-hW
X-Proofpoint-GUID: LJaPvhEIIaEGem_1VtezS2-tOX_WT-hW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250025



On 8/17/2026 8:08 PM, David Heidelberg wrote:
>> +static const struct dev_pm_ops qcom_haptics_pm_ops = {
>> +	SYSTEM_SLEEP_PM_OPS(qcom_haptics_suspend, qcom_haptics_resume)
>> +	RUNTIME_PM_OPS(qcom_haptics_runtime_suspend, qcom_haptics_runtime_resume,
>> +		       NULL)
>> +};
>> +
>> +static const struct of_device_id qcom_haptics_of_match[] = {
>> +	{ .compatible = "qcom,spmi-haptics" },
> I assume this won't work for the Snapdragon 845 (and related arch) SPMI haptics.
> 
> Should be the assigned compatible (and relevant data) wired to the PMIH0108 
> compatible only?
> 
At the moment, this only works for haptics inside pmih0108 PMIC, which
contains the newest haptics module among Qcom PMICs. That said, with
some code changes, it should also support the older haptics modules in
pm8350b, pm8550b, and pm8750b, since those PMICs all support DIRECT_PLAY
and FIFO play modes. I expect this change to be applied first, and then
I or someone else can work on adding support for the older haptics
modules in the same driver.

It might be very difficult to support the haptics module inside pmi8998
which is used on SDM845 platform, as it has very different control logic
than the newer ones.

Thanks
Fenglin
> Thanks
> David
> 
> P.S. I'll be upstreaming SPMI haptics in approximatelly 2 months for the older 
> chips, please feel free to +Cc me on followups! 🙂
> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_haptics_of_match);
>> +
>> +static struct platform_driver qcom_haptics_driver = {

