Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A673CEB84
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785735; cv=none; b=G7+Xvaz2WpjaIiognMFBUjs8PKVtlMJMk1tKdNsKQsREDrODNnIaYfO6gWHuZ1w/9nFdFfsM51195TNiL89OhbtVLlnHvN1uXBn9Dww39NahlT+F+l3C9ExAGhuUzJ93JoH6/vC1tKKzRK3U8yRYjywHN2bJ83KFh2HEP+AxQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785735; c=relaxed/simple;
	bh=f5KtYKaGJIxJIH6az8ZfzoSlLeMtkQY1lpV+rUwL+KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPxfRCkNcnqtmI1gvDfdlA/+lGGd6Sq8zBAB+YoEUm99sEPQh6osBqhFmJL5aQWcRU6dRI8pucr8dJIPAD5tWSdO46RGcqNVEvTVIx6Sq3jXUVA5XkU5ApMkmGrEE4MZ7GE3F8ZrG3122gA2hy6Xg3zGuFaByJFtkG5qt1MPnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YV7HYVYN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOy8k96w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YV7HYVYN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOy8k96w"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q5ivsg1802490
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 08:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lW+9suIyqVCiJGP9No19FKzkPfU8OlRbEUkWKfC9f+4=; b=YV7HYVYNNxtmRNDt
	fqLX21zOLn9xr6KdWdFRx7xpanAs3FfIPeMi8WBSnozd67JKodgAIPDUZ5LOqfJQ
	1qlBS5MN+esEN1hguBnApfVoxbLIG2YpuzLkr8/G6mFB3Or1lwaQw6BVXlsTwhUQ
	B7ti7z7zj+wx4heoDd+wmtr3x3dP10ozxXCmRO8WS9YGtB2zbi/MKQrFOk/bxtMs
	wmqoaOFMUFXx5PLmTUG9Fs2NZx66HM5oVHOmPl4L26QYdRMlDdR0t8RP2Bhf2Xc5
	3PEBgYohLB4ItwmG18UKouY9MOhv0IjtKxEAmHooCn2UY+Vcag//c9RXLN3tblD/
	TG5cxw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqkwtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 08:55:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516ccfa109dso85264591cf.0
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779785733; x=1780390533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW+9suIyqVCiJGP9No19FKzkPfU8OlRbEUkWKfC9f+4=;
        b=kOy8k96wAYKMw1oN78aAhVP8QRYK6ICVv/KydJcvFs2PMnxSWFN2EiLery05mqqDyu
         mV8CnkqzQFF6g928HcU2EIgRxFCHyTpXLid+bz3WEkn/1gxOfteBBmiejoRXK72lo3E4
         OrD2HDCdIpqCxNKtIhQwvjNbCiHucCuNZjHN7cv7yI4hC9bttwgs+OKQfx7yTNR91qfg
         2dp+qoK9PAJzjt/hxcTLdPNguwIw2OnUvmyV4qtTfpC53JfdQck3cP7denSeZVvmp8EG
         NWaj7b64GZZVLp9cAliSeHf/7Idb2hr4YfMsMYAhJosmCvYK6cRCSpwKKCMhZ0CkdnxN
         vBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785733; x=1780390533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW+9suIyqVCiJGP9No19FKzkPfU8OlRbEUkWKfC9f+4=;
        b=Hq+RkPHoDtc9O52GWXd8SIprxwWRWRRepMTAAOkr2WZh4CB1ebeVxI7Y7/Y/efBekc
         37MrcRXmQs+8eUifoHO3ZX5NHFMnsgNBpCsvr7IkEsS42+c80cyGsKOyoh5EsWXN4j1m
         rOzECfMLxL2UoWKTjQiUpZPzZ61nYMBPd1I+eDtqmo9h96i7i/Mvod9sx7DeKHbEfhp0
         MBofFYKeucerp8JelrHoT+MYnI4Xp5NorR8aJj4jJS+o16A6g819G1DV2Z9TbxxgYy6D
         Sncaews4X8xy2V4YVSPjiSZAjJpXnTT0DvgRt8v2G4V1qfj8p+wQh5PP+Pg9e31sFwzr
         55ag==
X-Forwarded-Encrypted: i=1; AFNElJ/L8XcxjCSgMfbE8q6Emqkfnkzf93/nvlveFnipfhuT+FUjjGxcXLP2F4Dwi1X0pH8UmctARlPBiATxNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrfCy2I+m+lCVaqGLTMO+itoAnn4loVYw9ncnGvCDoeS6M3m0
	c0b5KDWLMHAcnAObyyPHDnPdUgELmRhrZ4+jZq2GpizoJBbBbJORLBtcvUwaYb5QV4Or67ZkhVY
	G4xonPFbfjuLqMLWVqW7FsBfS0AzXZrtjqNwl3CjKSusnFICI073ngpxqWo3rzHFHtA==
X-Gm-Gg: Acq92OHrYIEiGEX3S53t18kd2KwHoYlrrOfLDNLOxBA5XYFuYAoQRtPcw4ECec4LkDs
	qVwXKfTWCqi6urRWsfvJ6HDqBHRdjG7yXTZHIFpc3mIyEBPXeynPHW7+K/RNh7k9+fsGs0PQXpH
	CTR22W7iPzck1wU8VJ9Kady/pzpn4WhCcVl3jidzc2q1EEttBNWM+5+378oZGuECXnq/0ivldjI
	cK4HJm04zEuUqwbeWkzEsmyV7qSDyQCZyekzGdYk4mm9E5uBbeMyYWngQNWxBA2OmNva41tCPuL
	LVCd0PwRt5h3b/J9a2F8As+SnZodakdH4EW/ro62vkLxEM/4dDZ59ATgxIPYOZeB0Uwxb27T872
	r5vg2x+BjdI2hjHnmm2w37QvroweRkJrkpvLiFxy7Cx2cxuV4Kd9UlYk7xCdbLtsRmwC8WcP3Mz
	h/NrhNzqSvQAygmpbqoTSuFRmAvmhfs6Y3DGQ1R6cllTUog173intJXxnKGkrRUbYk+7JkdC/+S
	Ld6GVMiTLSveYMg
X-Received: by 2002:a05:622a:4e89:b0:516:d66e:7b1d with SMTP id d75a77b69052e-516d66ec014mr228482861cf.27.1779785732764;
        Tue, 26 May 2026 01:55:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4e89:b0:516:d66e:7b1d with SMTP id d75a77b69052e-516d66ec014mr228482591cf.27.1779785732340;
        Tue, 26 May 2026 01:55:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d3f21sm478681466b.44.2026.05.26.01.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 01:55:31 -0700 (PDT)
Message-ID: <82a96d57-94fc-470a-b7eb-f0fde0c0dad6@oss.qualcomm.com>
Date: Tue, 26 May 2026 10:55:30 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: input: hid-over-i2c: Add reset-gpios
 property
To: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        20260519-glymur-mahua-common-nodes-v2-1-9f1b89a3f398@oss.qualcomm.com
References: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-0-5c333051e5bb@oss.qualcomm.com>
 <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-1-5c333051e5bb@oss.qualcomm.com>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-1-5c333051e5bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a156005 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=DlE_u-NSBxGluEoo6gkA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Bl-xbxVL_hap2e-GHpFohnSVn7cIS91t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3NyBTYWx0ZWRfX+hQnfVh/4UE8
 IiuGKXcXwFrSGBaycb3a2G47fxuDxTXZ6lbL3sMjaWgrjtQoZHx0gczSz6L8riHs2TtgUYGCjU9
 EvI1n0cSc67lmUevTw49lCsDs7PYF+8DnYVWU3nO0/W5YcxBJ4XiG9ulpb958DCAW0TAhKo9PQt
 KSJPURVX5XPqhCZC4Tuh2jPsbNQbGd5F5vYBFJ0UdjLlrgZbMA8OL14V4DKeW3A5p/ZsbWnsTN8
 6GMjRIDxkEaO6R8bqAxliErn/hH18DM9Igk4VXn9DbHOVK17RPXrzoEXgZO9DXV4kbjo0INtDJT
 I9i1IZvMdN8ZlkwSMftOZYH76q6ntWKh+CNxpHSaVJNji4vJCYdM2XTFROsvRq8cbyCgibqDDTl
 PUO6uFi1O7QdsTyRWbwqG3UoMb5UQWdPYrEyhJORaYmhxLzNj0Y8AqHKG6kQG+kgOeu4IK1uD+h
 piAu+4uWLiCQ7hhOoBA==
X-Proofpoint-GUID: Bl-xbxVL_hap2e-GHpFohnSVn7cIS91t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260077

Hi,

On 22-May-26 21:55, Pradyot Kumar Nayak wrote:
> Document reset-gpios property for devices that explicitly require
> the reset line to be de-asserted during power up.
> 
> Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> index 138caad96a29..fe0ec4fce673 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> @@ -50,6 +50,10 @@ properties:
>      description: Time required by the device after enabling its regulators
>        or powering it on, before it is ready for communication.
>  
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO line used to reset the device.
> +

For I2C HID devices which need a reset, we typically also
need reset timings, trying to do I2C transfers to the device directly
after the reset has been de-asserted typically will not work and
some touchscreen-model specific delay is necessary.

So far in the DT world this has been handled by touchscreen
vendor specific bindings:

Documentation/devicetree/bindings/input/elan,ekth6915.yaml
Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

Which are all 3 handled by:

drivers/hid/i2c-hid/i2c-hid-of-elan.c

Which has per compatible match-data with the reset timings.

You should probably extend drivers/hid/i2c-hid/i2c-hid-of-elan.c
with support for the CRD touchscreen and either add a new
compatible to one of the existing 3 bindings; or if the touchscreen
controller IC is from a vendor without a binding yet maybe add
a new bindings file?

There also is:

Documentation/devicetree/bindings/input/goodix,gt7375p.yaml

which is handled by:

drivers/hid/i2c-hid/i2c-hid-of-goodix.c

and is special in its own way.

Regards,

Hans


