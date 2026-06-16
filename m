Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEB31F98D
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605561; cv=none; b=EcwXcVjIM5htgcfRbCmuC4lv34wTnnOwkfywaSB6btWJYTsZxa9BoN4bSBVQjouk0utxSXYJkB3vbemhKFw+RusD4euObgvdIVDTGdWpec0heYUk3pPeMkxZ55u/TlQCaB96+ytB4IsmbVgZhPLKVKbmlFK/WbEwQhfqTnnChWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605561; c=relaxed/simple;
	bh=rBQrkdlLxu+sHScrpiOHOcI8isRa+CD1qTLn1K7LBaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvfcfDdhW4YNK1hBKMmR7NJcA4Mq9SGGW8G3F/0ovt0MIEmvd8LLc6rI5XmKbHLnyUikje6fZ0ReyqCJ8qxY6NI6wZ7kHdl7SNKcNcGWoMRUX0QMV1BiDzUbCyiSLSpqe4/4qk112rOK582E6S+04uOAolk50T3EgXMMZ4CWOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O69xuHOT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGVd0rK0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O69xuHOT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGVd0rK0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GABGEf3223760
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7V7D596VKMgblFH1E6kjqVU3QLyINlDY8eH+KpidKYc=; b=O69xuHOTQ5mv4r2n
	LNZYoiBf88oVrj0g6nTrb330YMVO0hLNDsYgSW1DeDRixLjVs5tHFqb69pSBUO5P
	oFF+4ENAr7avI8h7CvI/UFQbFKxewyfhJKfhGLbvKfkqLvg0K87+PNNtArnkeMX9
	067u71zi6x8bBnqWNEfs4skrJuBJF1kwI1653P2UPMu5IzBF9xUcC+PBwRHFg41W
	6p64WwGDCieofF61hZ/P7RePwF0dazOELPt/3IX3uwnzE4RUPODUF5123+c73Id9
	Na5i3MEUHmG4otKAAVz95WrPgTGD4LtRnWWq+10ZHDG3MPQvVlVT+Ta2L3QAbOp5
	HNPdug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ysrqtn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:25:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5175bf22b2bso6038011cf.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781605559; x=1782210359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7V7D596VKMgblFH1E6kjqVU3QLyINlDY8eH+KpidKYc=;
        b=fGVd0rK0D+Liyww9SF3LNti9iaslXkdL0M0DyCwPjSmhr2qHZ3Z0V/lxFiOv7jq4W3
         FRU+zn6UF9krOrMb8KqgWTJKjn6PZQEyNRKt8dfhZT+7twRylXwgxQpt2LdZ3t9+ltwG
         +mxYBJXo98VA1iLAgT4Z255QTemfKQBKimxXjJtmT2KCjV1zX7hkBgS4IBpn/+wi/lef
         9AvIWFH0EmcPoS0Wrh9+ZlOp0X+BknqPfT421ydOvGmaWcW2JEYysLnOkaPimlQi2dfp
         e61qqAlbKLRO0SasDxPAxed7fbvkWEmVhMtIXyzVdlaGWyQaMf1IHVG8wnpfGghkI5os
         e+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605559; x=1782210359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V7D596VKMgblFH1E6kjqVU3QLyINlDY8eH+KpidKYc=;
        b=MKgBBRhZ0zzh1usAPO8NudVxeQ+HaMLOFFkDbuVwJ7yZc/K/8AIIDZDdzqafhEIGoP
         ezZt1koNT4k26sw0hAwXT70eCa7GrhVYim1YJhF87hLUJ0j7VmdCvYgpN/yFHbbZP/ej
         TZdgOuixIQLjcZ0/cJB9EYqtZOr1/2SPd0SECdle2U1CtQ3++wvbC2ZKi/2bDUtg4ezY
         vuenD7pqUjhmGW3+vj0b7UJ2SMfsyavv0oLQdp9wQn/fcD7bnb17ECPnJxbFVyjbLb9z
         TgK9U4pq+l9610klSWZSW93Yybl9I0cx4sKjKZudxIz997YsrfthB7Mn4DHlwubhcbzL
         YBrg==
X-Forwarded-Encrypted: i=1; AFNElJ8AtEJfdmbhujpgawIEZspAgMzIO341fFo0i33NchpPMOkXcx1jioPxLo256WIC4KhIR1xlVFOkyfQDRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rvj8MpjECdTkCb1mwxZBDpakNNn0ILVKKl3ntCiPb7Saojv5
	LTobJxTo+8YNs/a9cfd1imHssqv48DAiRJX72NWnQIOySokHs8whKGrUnhz6I3YuWqBRJfFxHvP
	cb5zalad5AWdmyf0B5+7+kpagC/dh1u8M98cZZhQpHvrry46cffvU7Yu2bIjEQ93KGA==
X-Gm-Gg: Acq92OE9mkLTUItdPuXxY+UbrfBPZ4yN+AGYWRBCKCHV1yqft6Lvu7pg2pUAn9i5rGt
	Ma3OuiDRkmJ/4xcsjNiM6AkvwAxCPWLr28Xp+6j7Bhec1FBYtA9swIF+wWMSC2chKxJnqEtdXtU
	LvdV1R1Qo7Scp/NFoSDivWZ9uC1+9+g83YABbwMWcWLl4iDFB1NutkJVCx/66rjwAu9eFhwo8Dc
	MM1NwDMYoKTsV89w65Fi+sLEzT12ddRlVbOxmUTeuvAzF65Z7LtXOj/iz443rM2MIXOCFDF4qqk
	EJwMjFCIE92y2UBnb+nnAJClK7gWU8BF0nyaRIsOIuUWqHKWldVnWlZwbNSzcFUMiQcpggGRV7u
	oaiVkTa2rO/ZwRZgghWV71e768ejVS9aS3xkgbw+xxK0tWw==
X-Received: by 2002:ac8:5f06:0:b0:50e:487a:bfef with SMTP id d75a77b69052e-517fe242998mr177624001cf.2.1781605558872;
        Tue, 16 Jun 2026 03:25:58 -0700 (PDT)
X-Received: by 2002:ac8:5f06:0:b0:50e:487a:bfef with SMTP id d75a77b69052e-517fe242998mr177623691cf.2.1781605558432;
        Tue, 16 Jun 2026 03:25:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949fb19sm4637499a12.27.2026.06.16.03.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 03:25:57 -0700 (PDT)
Message-ID: <eb693705-c0c3-427b-a924-5aa907fd65bb@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 12:25:55 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
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
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Z4PuPUVQBv9b9TkOlfVPzYSS4iiJuy7n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwNSBTYWx0ZWRfX4e/Dnf+VoGYf
 DftveeA6m+BwZU+ve4V7AtkySsSD1a/gRUw5bSiumCYBcjsNqAgJzbB+I1X7cOWhOfCTo4FM31x
 vJN/paNzrL7phePpHtiWOaabXXTjQgc=
X-Proofpoint-ORIG-GUID: Z4PuPUVQBv9b9TkOlfVPzYSS4iiJuy7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwNSBTYWx0ZWRfX8cAPFXCO4Qar
 cdTNR3l3ORxVuDEdarjA6QDmv/mwm4v4bBQmnL0cVCWWRQJQ8aMr070BweYFswgwiHpCYnzgkww
 C0AXuJxUOQ+lH/bfxgPwhn15sUkQAmKqwtH2wkN/RLplTFFQn/cBsdrMR8drN36+lwvN7QbLRwa
 m+AoxYdAJd+j8caawvAiClkDvNj7oKGRYOyGzuUG/Eo6hPZKe5EBqlO+q28IHq16VrN69/RWhGz
 pfk92L94iCK8KXdEnDea1WT+4R09K3rMUEpJ7gHuIjcjarNoMY2/BRUOArfVQ7WEnCfHUNVLPgO
 7tU98JdmnEROSn8oAAATkzce2gKicEjyj04Kxdh4j5WIBRmcBEWlEPNcusX6yWiuxWGjTvBxRIG
 OiyOXNDLTmD8yVR4MjTht0+jPGNse5dezGClRN1Je8svfc/yGZ96HhIRbBVNWpZmHUMaBGh92g2
 E+/mt3xrKMypBaYwXEQ==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a3124b7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ana-416hF8iW2EXVXAIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160105

On 6/16/26 12:08 PM, Fenglin Wu wrote:
> Add an initial driver for the Qualcomm PMIH010x PMIC haptics module,
> named as HAP530_HV. This module supports several play modes, including
> DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
> and hardware data handling logic. Currently, the driver provides support
> for two play modes using the input force-feedback framework: FF_CONSTANT
> effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
> waveform for FIFO mode.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

[...]

> +static int cfg_write(struct qcom_haptics *h, u32 off, u32 val)

static inline

although I have mixed feelings about having so many accessors

[...]

> +static int haptics_write_fifo_chunk(struct qcom_haptics *h,
> +				    const s8 *data, u32 len)
> +{
> +	u32 i, bulk_len = ALIGN_DOWN(len, 4);

Please avoid mixing multiple declarations and assignments

> +	int ret;
> +
> +	for (i = 0; i < bulk_len; i += 4) {

You can do 'int i' in loops nowadays

> +		ret = ptn_bulk_write(h, HAP_PTN_FIFO_DIN_0_REG, &data[i], 4);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (; i < len; i++) {
> +		ret = ptn_write(h, HAP_PTN_FIFO_DIN_1B_REG, (u8)data[i]);
> +		if (ret)
> +			return ret;
> +	}

So if i'm reading this right, the first loop will always write
4*(len//4) bytes and the second one will be entered at most once,
to write len rem 4 bytes.. should this be an if instead?

> +
> +	return 0;
> +}
> +
> +/*
> + * Configure the hardware FIFO memory boundary.
> + * FIFO occupies addresses [0, fifo_len).
> + */
> +static int haptics_configure_fifo_mmap(struct qcom_haptics *h)
> +{
> +	u32 fifo_len, fifo_units;
> +
> +	/* Config all memory space for FIFO usage for now */

What's the not-"for now" endgame for this?

> +	fifo_len = HAP530_MEM_TOTAL_BYTES;
> +	fifo_len = ALIGN_DOWN(fifo_len, 64);
> +	fifo_units = fifo_len / 64;
> +	h->fifo_len = fifo_len;
> +
> +	return ptn_write(h, HAP_PTN_MMAP_FIFO_REG,
> +			 MMAP_FIFO_EXIST_BIT |
> +			 FIELD_PREP(MMAP_FIFO_LEN_MASK, fifo_units - 1));
> +}
> +
> +static u32 haptics_gain_scaled_vmax(struct qcom_haptics *h, u32 vmax_mv)
> +{
> +	u32 v = (u32)((u64)vmax_mv * h->gain / 0xFFFF);

mult_frac()

> +
> +	return max_t(u32, v, VMAX_STEP_MV);
> +}
> +
> +static void haptics_fifo_irq_enable(struct qcom_haptics *h, bool enable)
> +{
> +	if (h->irq_enabled == enable)
> +		return;
> +
> +	if (enable)
> +		enable_irq(h->fifo_empty_irq);
> +	else
> +		disable_irq_nosync(h->fifo_empty_irq);

This is called in the .remove() path, I think you may need the
sync variant as the underlying device may be destroyed before the
ISR completes if there's a late interrupt


[...]

> +static int haptics_playback(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(dev);
> +
> +	h->cur_effect_id = effect_id;
> +	h->play_request  = (val > 0);
> +	schedule_work(&h->play_work);
> +	return 0;

nit: \n before return is 'nice'

[...]

> +	ret = device_property_read_u32_array(&pdev->dev, "reg", regs,
> +					     ARRAY_SIZE(regs));

Here you use device_property_

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to read 'reg' property\n");
> +
> +	h->cfg_base = regs[0];
> +	h->ptn_base = regs[1];
> +
> +	ret = of_property_read_u32(h->dev->of_node, "qcom,lra-period-us",
> +				   &h->t_lra_us);

And here you use of_property_ (please use device_)

[...]

> +	input->name     = "qcom-spmi-haptics";

Odd whitespace

Konrad
