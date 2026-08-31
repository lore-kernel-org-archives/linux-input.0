Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACA345EB1
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138706; cv=none; b=YAFOyGf0PBhkypiALh+gmBOYzAWYqksAxHs1YLqGy4hcbpnsZrPiDp1s4PFGqXtTPGqkNL1ctVDeNVJzOyJFYIaKN+fndqQOeEe0wSyi3z6dWnrm6BfPJWuyuvuAtF+PqVLxZwNlxLv+3C/AxW+RzHS4DSD12e6zDEzssYx/WlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138706; c=relaxed/simple;
	bh=7UmMN1K0B3ovALPeaoztcWuz5nL6IxnpQy7fd0Gu6kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPM2EBqIQrt3VagRked6fXwd+KZVE6LkAHngKspJ/xWrsyJwYnM7n9TEsF6I1fKrq3ynfPadIko+KY5qG5WqqB2Uc2hsV1U9M/Jd2pL231fQWDy9NfVn6u0Ww56V7FuU0sCWzNPiLQ0rdKFhgjIFDw+DBqe/E5djFLdjI/RVzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DM5JVk7L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ALjIs4cC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DM5JVk7L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ALjIs4cC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UMgOLq1880918
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h1D1TQvrH8BzeCG32FmB1x7kyZWd14bC0HSgfQg4E1s=; b=DM5JVk7LnyHq9p2W
	Tm5JJ+hSCdSA3qaSqp8rgLOsaJBlVer55JY7zCvwSekbHRE1grZcYy0v9B5KTAPT
	GUrVGS+SRKjVAmhbWDOj3JmxJl3YWI1YuV07Lt2DQY6SMBXplN65xnLIZ8hlGsWp
	tfYNn9Cw+RBIx9mmQfK7VGWQnm28IGMo1Rn8BInb94JVu6NFwEG4dOxKCSaEQnaR
	/wqQRZv8v77sb3Lxw+wlFcRK3/yjeRk6MNusuJ3l78kRqcYi0P66jsaAPzpa6Rd8
	UqjFsPkJKHGVfcjfLYNu5mNCtAmNAZd/v+qWfxh3Vv56X4UtOURF0MtXeff3/MP8
	ciCk1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhwc2eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:11:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3750264a91.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788138703; x=1788743503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1D1TQvrH8BzeCG32FmB1x7kyZWd14bC0HSgfQg4E1s=;
        b=ALjIs4cCyp2ZvkoOIv/5bRGRWRvRe6ZbRobWLL5LMGyKIXplboR66NqxAWtR23puVU
         SBYHSOTGm6hFxqTYd9YZ/BqAdAGe3xr38Oa2wR1TvaIsfvfa6U0qUCD+T9NHta/pynfp
         arrVMBXKs2TWKV7TejQcdry2SAuIEFT64YWWa4qlbs3e1zav+3hRx2yL0Nh3FNmVebtu
         31bSQScdszbDYkEFhVOKN8fCTQOfx5q5hbbPDk5nyIhTC4V4cCEoeZY0H4Qv6Qf7swCO
         gB4Px6qcg0NE/FNZ1zCPDBSqvu5k1xYKjno8B1eCRjxvB4pGTL6y41LtfwWTub8Zfi2v
         09bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788138703; x=1788743503;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1D1TQvrH8BzeCG32FmB1x7kyZWd14bC0HSgfQg4E1s=;
        b=MuRX9/6Xt0cQuKc96aLtZTK6E0uOEJmmpxty8Fi7Y9ofkvnwpW+vZOt0zt3YbaP1DL
         ySjSnjGNs1Bt9kSdEs4jaWRRx6xJier9f5NgFhaCkhQXJdL+JNwXBADGkludy/o1012I
         6Gnnz1OabxmYb8EBGZqTcswZO+cAq9bQPaIO+IID+Sn9RId9aqMi8GUMHJHkYeL1CNHd
         REhVpzNpTLXADzdX+wyoe2WrxaE4j9Qsk5niMpxWD0pys651XsrGDbWyZoZ8cZ3+mgyS
         tqyIKfTGOmDfZNxgV9JfnpPFwza2p+ZKMl1k54NEnzC7+QmBzLjkh2AVDX5zu9EOoifc
         covg==
X-Forwarded-Encrypted: i=1; AKwUvBwlsX/2AOtlzCxQVx8fmIVO+6EBztmc8qzhuuXfMyFny9inqwGr367FFfuwLW8LIoU+XMHhHnsGOyhlzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mEheu7qiOi0QNJEqAjJJ2q6dBgIzVpkrJYIx4QaMflbJ2SusXd
	erWqT5+WBbgJcO4Gjyq6NUV3kklKX4fWdXU0BSwUEz3136/n306EYolt14O2fT3DxnhiFztP/sm
	1/IsTmh6R34tZIu2RW+o9bnNjHR1hVzGIFxoIm/WRkKMiXTqIepST2w/g8tx/AcOJ6fyAADK97v
	1w
X-Gm-Gg: AYBFou2oP9tEX5TFXMnUWx6MLsxtDag/hBrkCWigWgLSbeTMzd+Tv6f69Um+qm/yULb
	h/lZ6GHSHcr1SO/ln7s/y/Ko4xzKcn8+v4GTiwY1gwTw+wYLd65RPICwL5Ti0XFEy+TEtp0J6D8
	UgTGWXV1IZchlkOqEK/lh/p9pfz8Yv3nRQvziskA4moEjd/Kez54GpYQkJUZiL1N8BUSlVPwPpR
	cT4XktfhRxBMpyvuKIiY5ndj/S8D/nyFmMXZ7UkMD4fh3aXhTbV2CkJmEhVwOuMxAcKnBwFIF67
	TfmbFZJl1bCbPiuowYh0ZN5eOXgO8sRy6C+Oar5FsRAZaer8r8Wq6vT8RvZZ1QYdzvVc9BKtxBl
	JfidkY4n9c0/vA8DtfnKA7FPK/obtXSeK+IMyFGPGlboXRj4qgUTjgVdNmIHG7p9FgxpaHQ==
X-Received: by 2002:a17:90b:17c7:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-396d0fc1b2fmr34041147a91.16.1788138703176;
        Sun, 30 Aug 2026 18:11:43 -0700 (PDT)
X-Received: by 2002:a17:90b:17c7:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-396d0fc1b2fmr34041100a91.16.1788138702705;
        Sun, 30 Aug 2026 18:11:42 -0700 (PDT)
Received: from [10.133.33.138] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda7eb6bsm14314442a91.8.2026.08.30.18.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 18:11:42 -0700 (PDT)
Message-ID: <e714caa4-26d5-4c41-9f43-9e9f71e63612@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:11:40 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-input@vger.kernel.org, robh@kernel.org
References: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
 <20260828-qcom-spmi-haptics-v7-1-0367b3ac2e1e@oss.qualcomm.com>
 <20260828095932.EF7541F000E9@smtp.kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260828095932.EF7541F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZZ-CMLAYafv9v37zvBRF78g_7UpoTGh9
X-Proofpoint-ORIG-GUID: ZZ-CMLAYafv9v37zvBRF78g_7UpoTGh9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAwOCBTYWx0ZWRfX0Aj5eH5ULPQm
 JiuWQQAai2Hc+MVRUF5ZMnDzOjDO82VTNxsxvH/70FKfiBtLdE7K/Ql9GrgyXwkoP+vgiML5ecV
 gvOqGmRASkobOl6fctyqiGP6acAqkNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAwOCBTYWx0ZWRfX/Jmvg2ZVflSm
 162pCJndKdCh8qUrGZkqemVWE4uUsaJ3c5qsAUbaIXqI2+ZsV0YNM8VxZEqsKr+HZpRhVDQL3VK
 udaSdeeFecCAt9YrsNe+Km7iEFIo4yIHuIxlkJh436UcH6X0I801I+c+zUc416wv2Hev5fHXypB
 XMayFVmBu68uEeyddI9dJv2VCn6pfzisElX52AH8mzNLWpWVFuKdu89jN+PNUitS82hQXkrZXyg
 JFUGxOcUAbsYyqGaOZ5x7IJccLonrJ5la5iGRCCQJ3OPkOT70aJlma7p3oMp0NSXp664jYDM26x
 o8RjPeDXkGw9F6e+ShQEt2bZilXOrSzYKaGCvtaxjICilCu9ZlUnugHnk9fLyAfYOp1AXz3t6eX
 nxQs3iaHOOlGE/LVJZS7hBMJqz/XKM7iquvEXqmdpMZlmpPTnXGV1mwXptAMdYBXtxpKc1fTRih
 HOeuwS9KXnMpeavwg/w==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a94d4d0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=skNwuv_u4mlSdyqJbrIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310008



On 8/28/2026 5:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The new `haptics` device tree node will cause validation failures because it is not permitted by its parent MFD schema.
> --
> 
> commit 69b46ca6dd857a336fadfc81c3a26d260c9c10ea
> Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> dt-bindings: input: Add Qualcomm SPMI PMIC haptics
> 
> Add binding document for the haptics module inside Qualcomm PMIC PMIH0108.
> 
>> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
>> new file mode 100644
>> index 0000000000000..ce2c9e893a0d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> 
> [ ... ]
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/spmi/spmi.h>
>> +
>> +    pmic@7 {
>> +        compatible = "qcom,pmih0108", "qcom,spmi-pmic";
>> +        reg = <0x7 SPMI_USID>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        haptics@f000 {
>> +            compatible = "qcom,pmih0108-haptics", "qcom,spmi-haptics";
> 
> [Severity: Low]
> Will the haptics child node cause device tree validation failures against the
> parent MFD schema?
> 
> The parent schema for qcom,spmi-pmic enforces additionalProperties: false,
> but it does not define a patternProperties regular expression that permits
> a haptics node. Running dt_binding_check or dtbs_check on this example, or
> any actual device tree using this node under the SPMI PMIC, will fail
> validation.

The change which adds haptics child node in MFD qcom,spmi-pmic schema
has been applied here:

https://lore.kernel.org/linux-input/178602255123.2917765.7426706813083510078.b4-ty@b4/

> 

