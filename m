Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABE30DEBA
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626302; cv=none; b=PqcCfqtD4aRAxF3JTb/Ezuvnt1vnokHy07bJZ7BZIZQDXd/ztERJW2CRKShVDgSDTDZmtPmMKiK9iZSB2B05H20R39ritVNL7IJRD3eW2mQ20TJh+pFg5tdknoSurCiii7v0iQ10GH2+liU3W1p8wCEcuVZpC1/40Y0XcPLZFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626302; c=relaxed/simple;
	bh=bhE4RuI9V+MVZ2WHKjpClmsRXUuzg8N3aIWaYUU2wA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPoN2pusHvMMaP8/GTaqSI6HBtQDO/Lmac6tFMO8e16l7oBs0CXpVHAlVqAJAmkferzSkpT5tuqg9zBtIrAeXyIA7tb928Xv3Uaqo/0DUlh2yrXOFenQDOqt7xhejUFxT6lvv8CSZgQDgFUSW6il/Nw3BHixePm0aM/m58R+9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feqQQeXJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q1usSyLw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feqQQeXJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q1usSyLw"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2RrZF023981
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UoErnvSWXkC4s7oreViW8HAdb+aeLpfKk8vSmTkAGRw=; b=feqQQeXJqunMp8tn
	28O5T0KIdAH6Ee0GMHEZj0h6QOF9q5+St8ZBtDvv4+dii9xnX0Mqx+QCjvL/oEWK
	OKZpd+y5CnbB3IxbG7yKZdyeZ64zDwR3auTDB+FaWxeMN/Y5nt53scfkiCoibUjO
	OFSbeKnTbLJYPNALXv+wKbCNVvGvAcu2C1GGYo2Ovqje2RsTRksaXlEhib9ch68A
	mD7xhoyakqrV8MTDOnd732qMopbV9ej4iBF1UoCJQYUt8h/Z4IfYBoWfWsuHEQoj
	eSGrmdjTqvnBruVjLcd4Q9PIy5vUudZMupKL3OP3iEuJeucm8AEosaQeu0nCMbLD
	iU4maw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdskrjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:51:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so3324545ad.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 19:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787626300; x=1788231100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoErnvSWXkC4s7oreViW8HAdb+aeLpfKk8vSmTkAGRw=;
        b=Q1usSyLwJq0t07N/cdRTfGAqQCZsNL669P0RogM1q691XWeavYOukQfk+iLcoPwnHk
         tFkinIijBbIDpxaJZk1LdeWZzsb5Dj2CyNxZz1ktI+pmePfBxkEo99l7zYbsIOVrUBVD
         IaeR6fBnHFWeA2iTnsJuZV4LuoP9y2OmR7yItTe3+D3Eh0YN2v1FbGhkY8yk7fhugNRa
         hmBJT3KCbx0ChWb9wwYnVTw4KpJNU16pIyPy2VwkzitdYU6fuRw9+wrkEzE88gaOslXP
         BoGZND0bouL2uvPBI6ICDzK5/veSsZGeUovY6w1hJdsyq8bkjmAtEy0kW3Kdppp19Lw+
         AqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787626300; x=1788231100;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoErnvSWXkC4s7oreViW8HAdb+aeLpfKk8vSmTkAGRw=;
        b=QSeRDtNhSaG+JBEVwX1nm4i4OHgN4l59Ko1OaxMkBesufGTy7F+iaHn7tSHJAjNbWj
         jVUJU8maXWR9Yuw1pjYq4lE4Caa4bBJGfNAc6ZQlLIU79BoZbQHhsV+RXPgIMMTFZqkx
         /IWlT90b1Qy2ROCSrZ3uO5DvsRiXnVQjcydZATJ4gg0KdNx72PdyF1U3+V8qYSo1BFTu
         BV3ycQA6xsuxH6rhqWo3yMVqaXEjlbLz+16qXyiNafscHe3oy1jYXYU4hKcQffN7CV/v
         S3ZhmQ2kxgaUmCD+3XJ2nCEey6XIVD4AAwpYlrdsxIyCO8yvlmKeS5WEYjOjydHHZWdU
         ApFw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi0UT9BfTfsffMWp3DPSlY/Kqd34ETrzbabXMvjucb5AzVV9WQhxf+KULHJJkve9Iif56LwhrJRAOu6g==@vger.kernel.org
X-Gm-Message-State: AFuF++mWpSjpyMFFOwsRb0QCgMx08nzkHR2l556AEdWGeeMoWL2Z1pwD
	1ppfoRo9xY/iq/eD/PsSvPCpzxbde0gVHuPsi236S7+xfk4B0ObMGoeD5RcZlJpaxaJs3ZvwXAU
	nXBcvAvfDexseX71vpwd812sO4Lg9/MnyWovWNFCdZG4TzQrbP/LDFaIHF6O9I/S6hg==
X-Gm-Gg: AR+sD11Rzfk+dKEMX+6zNYfU4sWcqy2QLTPKUFuWJX5b8H5/T1sAX5Ew2EUnwG45qEp
	y7XnRbmqBHr46vBH1WkekeUCQdcJ8sgwUJ1aQdsW4+YYgnjNpP3Qnrpd4D/m3V4Qb0QXYdY8mOe
	oL4RfL7M5vKVCRvQ3j+n79W4eFQRDGXuCVz+N5DS+5T6aP+/lXMcKAR6PT+KiTHIBGPJYi2Aln8
	Oz70/7xRfERIibIhrRJtYna4cLL+tiEizPphcb96iYD+W8JMmDdBEOqKt5Px3iwGQX2k5bzB1w1
	RT0eY6QFJ+6e0HPDCwnc4t5VzQLciFpMmnNaMAO9AHJPdqNzHK/OO112+KMmOAFwUztJufrPPy+
	XbywyNBwzEGKUe2101DERVeRm3iqY+fswInHqUtQvb/wTz+okIRHk61smSNDKB9Rn3Lee
X-Received: by 2002:a17:90b:2543:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39645aaa837mr3945717a91.6.1787626299673;
        Mon, 24 Aug 2026 19:51:39 -0700 (PDT)
X-Received: by 2002:a17:90b:2543:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39645aaa837mr3945666a91.6.1787626299087;
        Mon, 24 Aug 2026 19:51:39 -0700 (PDT)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d69f74sm1713636a91.14.2026.08.24.19.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 19:51:38 -0700 (PDT)
Message-ID: <02269d67-41e3-48eb-9ce1-e3775a4c2eaa@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:51:34 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
 <20260807155640.GA893689-robh@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260807155640.GA893689-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyMyBTYWx0ZWRfX2XI70lyrPNlg
 +tEARD9odC4Oehu2l7jo3RnFetnOCIECG2ax58aS1X7bxEAs8p44rQOY4J2R6B4Vykrkor/gvVP
 5LI7m2cV3lIU+ZZuU+HLqxXWMRGHxJE=
X-Proofpoint-ORIG-GUID: C06zasgr1uvYRyTXBn8VHPy2Wo8kxYH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyMyBTYWx0ZWRfX/XnmvGOm/5BN
 6LplK7Yn6CJlH6S+YF7+3TyRqHM5dXNxVvMQ+GoOuFmgN9t0dSQ3DGNjYePCGr3gexG2O/PriIb
 YPkDvCPlBRjlWPQW0G1BE6w42KWIj+FEv468HkXze21AGtZuYilrfayhC4dTglUua9dX3Zj8tq/
 ba1oHKF8szn7R1zIfovCLn4rxfpFfiK6FYh2UOT5QPyakZTFRVdwbib/KsX9ZV5H8nD/5x2eSwi
 pHbkjAXYJ05PMO46N6DmMFTja1jClIu5E81jSWH9+9kaKfWBbT4d3Kqh1Pn6V7/aQoDaS/93DsC
 dxkuB3md5nkDSL64OPcxRZtsXD7xtbEdWRoWEnUpoHwSDzQr9e9mQ/XVBwuwdfwnnHw420peEcY
 rfRu/UnQuFf3+geBHNwwO6KZopTDp7d7StuZpbEAVViEJz6MFGCnhMytLVCHG4vAWdWzsiVj7T4
 DNMYY0/W6d+P6qRraDw==
X-Proofpoint-GUID: C06zasgr1uvYRyTXBn8VHPy2Wo8kxYH4
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8d033c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HhSylQvuivqysCgRbxUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250023



On 8/7/2026 11:56 PM, Rob Herring wrote:
> On Thu, Aug 06, 2026 at 11:21:40PM -0700, Fenglin Wu wrote:
>> Add binding document for the haptics module inside Qualcomm PMIC
>> PMIH0108.
>>
>> Assisted-by: Claude:claude-4-8-opus
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>  .../bindings/input/qcom,spmi-haptics.yaml          | 136 +++++++++++++++++++++
>>  1 file changed, 136 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
>> new file mode 100644
>> index 000000000000..b1a69e9886ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
>> @@ -0,0 +1,136 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/qcom,spmi-haptics.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Haptics device inside Qualcomm Technologies, Inc. PMIC
>> +
>> +maintainers:
>> +  - Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> +
>> +description: |
>> +  Certain Qualcomm PMICs integrate a haptics module, such as the HAP530_HV haptics
>> +  module in the PMIH0108 PMIC, which drives an LRA (Linear Resonant Actuator) with
>> +  an output voltage up to 10 V. Several play modes are supported in HAP530_HV:
>> +
>> +    DIRECT_PLAY: The hardware outputs sinusoidal waveforms whose period is
>> +      defined by qcom,lra-period-us and whose peak voltage is defined by
>> +      qcom,vmax-microvolt. The driving amplitude can be scaled in the range
>> +      [0, 255] via a single register byte.  Hardware-based LRA auto-resonance
>> +      tracking is enabled by default in this mode, allowing the haptics engine
>> +      to follow the actual resonant frequency of the LRA and update the driving
>> +      period accordingly to achieve stronger vibration magnitude.
>> +
>> +    FIFO: The hardware can play an arbitrary waveform composed of a sequence
>> +      of 8-bit samples at a configurable play rate.  Samples are pre-filled
>> +      into the internal FIFO memory of the haptics module and continuously
>> +      replenished via the FIFO-empty IRQ until all samples have been played.
>> +      An 8K-byte FIFO memory bank is available in the HAP530_HV haptics module,
>> +      shared between the FIFO and PAT_MEM play modes. The memory partition
>> +      between the two modes is configurable via registers, and FIFO mode always
>> +      uses the 1st partition starting from offset 0.
>> +
>> +    PAT_MEM: This mode is very similar to FIFO streaming mode but without the
>> +      data refilling capability. It is designed mainly for short, latency-critical
>> +      vibrations. The memory space for PAT_MEM mode must be reserved for dedicated
>> +      usage, and the waveform data should be preloaded and remain unchanged
>> +      thereafter. The haptics module can play the waveform data from the memory
>> +      region specified by the PAT_MEM play start address and length registers.
>> +
>> +    In either FIFO mode or PAT_MEM mode, the following play rates are supported:
>> +      -- 0(T_LRA): each FIFO byte drives one full sinusoidal cycle with the
>> +        period defined in qcom,lra-period-us.
>> +      -- 1/2/3(T_LRA_DIV_2/4/8): each FIFO byte drives a half/quarter/eighth
>> +        sinusoidal cycle with the period defined in qcom,lra-period-us.
>> +      -- 4/5/6(T_LRA_X_2/4/8): each FIFO byte drives 2/4/8 sinusoidal cycles
>> +        with the period defined in qcom,lra-period-us.
>> +      -- 8/9/10/11/12/13(8KHz/16KHz/24KHz/32KHz/44.1KHz/48KHz): the FIFO
>> +        data is treated as PCM samples and drives the output with an
>> +        arbitrarily shaped waveform.  This mode is typically used to define
>> +        custom driving waveforms for specific vibration effects such as fast
>> +        attack, crisp brake, etc.
>> +
>> +    The drive voltage in FIFO or PAT_MEM mode can exceed the value defined in
>> +    qcom,vmax-microvolt to achieve a special vibration effect, but the waveform
>> +    must be short enough to prevent the LRA from being damaged by operating at
>> +    an overvoltage.
>> +
>> +    Also, hardware-based LRA auto-resonance tracking is normally disabled in
>> +    FIFO or PAT_MEM mode, as these modes are intended to drive arbitrary
>> +    waveforms that may not follow the resonant frequency; autonomous hardware
>> +    resonance correction would interfere with the intended output.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,pmih0108-haptics
>> +      - const: qcom,spmi-haptics
>> +
>> +  reg:
>> +    items:
>> +      - description: HAP_CFG module base address
>> +      - description: HAP_PTN module base address
>> +
>> +  reg-names:
>> +    items:
>> +      - const: cfg
>> +      - const: ptn
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: fifo-empty
>> +
>> +  qcom,vmax-microvolt:
>> +    description:
>> +      Maximum allowed output driving voltage in microvolts, must be a multiple
>> +      of 50,000 uV. This is the peak driving voltage in DIRECT_PLAY mode,
>> +      which outputs sinusoidal waveforms. The value should be equal to the
>> +      square root of 2 times the Vrms voltage of the LRA.
>> +    minimum: 50000
>> +    maximum: 10000000
>> +    multipleOf: 50000
>> +
>> +  qcom,lra-period-us:
>> +    description:
>> +      LRA actuator initial resonance period in microseconds
>> +      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
>> +      rates and the auto-resonance zero-crossing window. It could be also used
>> +      as the initial period if the LRA wants to be driven off resonance.
>> +    minimum: 5
>> +    maximum: 20475
>> +    multipleOf: 5
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - qcom,vmax-microvolt
>> +  - qcom,lra-period-us
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pmic {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        haptics@f000 {
> 
> No incomplete examples please. Put this in the example for the PMIC.

Thanks for the suggestion. I will change to below in next patch:

    pmic@7 {
        compatible = "qcom,pmih0108", "qcom,spmi-pmic";
        reg = <0x7 SPMI_USID>;
        #address-cells = <1>;
        #size-cells = <0>;

        haptics@f000 {
            compatible = "qcom,pmih0108-haptics", "qcom,spmi-haptics";
            reg = <0xf000>, <0xf100>;
            reg-names = "cfg", "ptn";
            interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
            interrupt-names = "fifo-empty";

            qcom,vmax-microvolt = <1300000>;
            qcom,lra-period-us = <5880>;
        };
    };
> 
> And please comment on sashiko report. Looks valid to me.

I just replied on that. I dropped the change which added the haptics
device in the spmi-pmic schema as it had been applied:

https://lore.kernel.org/linux-input/178602255123.2917765.7426706813083510078.b4-ty@b4/
> 
> Rob

