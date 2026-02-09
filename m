Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49689274B48
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643439; cv=none; b=gUa6rnbQllsnjpSLx2G46Bu7icFztH8967ZB26CYNrEU5aC0hjB8QLgKP/UDOPq3N0t2upNHPdD60bqmkiB/XGpqznD0J88RuHESNerPfGQc3l4qfM0/PL7NAAvjKpy/PRJhU/hV9U4KlpJJt9RCTdZoFQSEV2Oy4f/pPEQ1U1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643439; c=relaxed/simple;
	bh=UiU+149jnrVM1SWUnO6BecZTr+G9PKFBnhbQil6C7dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPhCu5QAu3GFTbvDtI4WPrfYFH/IiAEijGsilVe6Y4RC6DpbtburEsGA1yVEoOlPANL/V5INXu8g6qdN274tajPT1B8IYIqsF6fU+hdX007LHrHPmbDQHK+UJAhxbuqxue5XXtxfGxdemUFn2iHLDPhkRSoLYojuxdfB9nUW4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9LJCamS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLu6k1yC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9LJCamS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLu6k1yC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619DFKMg857257
	for <linux-input@vger.kernel.org>; Mon, 9 Feb 2026 13:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HKCdAZuuGxNAXDtN64uIxZbwDy+4WF8n1CgeQagiJA=; b=j9LJCamS2nPoB/b3
	w9ofSOa/FHjj/uhSY5FS6gHTbYRzjmRpvtKUaMCG6NxAFVryi2dzTUb7S+FDFg5z
	vTi5+YFkk/LJXMm0fCyRP9nhZDt1waVNOtdr1BpVnqO3hsysatagM8d69VcrqZWs
	gSXwU2cGjS0VlWrbCNDarJog/deIqLSt/lN5XbBqHfXwNoNkXrLAR2bsGtu2meBT
	rLPyVOY3Q5yokm0/L6EkebVzakKPWsF4qvUPEEElYmdPLQIoHmd2QICZu6ep3Nvn
	rk1aRDK13dTqHcD2VCueabivCOmPh6J85L3YDpZRnfJHrjrFSUKJkqVzT3qAkbaz
	BTSHhg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga600y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 13:23:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fec175so33834845ad.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643438; x=1771248238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HKCdAZuuGxNAXDtN64uIxZbwDy+4WF8n1CgeQagiJA=;
        b=VLu6k1yCQsdxneKAlGdLFMczJsodMKTUlTdUtFwexnYtbc8n2k1GSEkOdmxyvYXIf+
         qe4G2KCgHnWU3UleD7ZRKJ5zcv2ox4+D/dSHm8GSfnM/9NFNOCE8gF4mbz8edW1lSCKA
         qY2cpFZwpUudHNJmx0uHdySNkkoPF0Iwln6SwL5bHM+QhvMqYivEye+PIhtB7OHCdieN
         tHzIiPaz5JWcMEcDV1nks5njMeAVilqmi+pyMb3OJDqIPR9fRhRxjsXHE8iAqHY1WhMC
         TvCsNX0gt5MeNA+24aAsO3TERhDpx7YQ6qmMOiqrbzSPsFNHmwc2o5g6WmeL8Hlwl/Bb
         rJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643438; x=1771248238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HKCdAZuuGxNAXDtN64uIxZbwDy+4WF8n1CgeQagiJA=;
        b=YqXC3aa/1VGzHC0ftX08MRrZxPheTlXQZsWkv+UYKNFZlcLLv9uG+05vYr+D2Sc5Vj
         TCdwdaWjwosNgN4Bc/XUc/tz3vC78OLiYYmHQMxMKS00/2K65d8+y91FwK9+FkIuAKem
         2VifMkqy6+N9LatQEjl4uNdJQUCYuFj26GGBNFRuCHKlSavl5HRpgnTgpe/ELd0Ov438
         2M1lAOmf+d9n3ydd/2pegy6jtjS1EEfML6rWiTbkrAJMjrMD1ZwazPLFZA44MRCi/TgH
         9Y6XtZAMu2FJqkauWcOaj70aT1LVN5Fv49yHhsWKMNfF/9w0WU8f775aMKCUkMxFsP3X
         SkwA==
X-Forwarded-Encrypted: i=1; AJvYcCVBL08TRwE0nKsOAOT/xi+kft2WAYIbeqKoaBg9Uocv6ZCLq4Ezq3SyH9xzMTRDXAUac2ZgR02FLnklGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGws5a+Ya853oWqK1+cXtcEmUNcugxZJ/6fNsAPNnKeiQAjXHy
	9bLi3Aa4epwgfR7XLwF6D7YyBkGNVvcbGonBmWmCAYfWJYESnMkjb9kSnAHML5Is3s/bEk4kwfk
	TI8v/DDKX5rl6wq4UVc6z26+2oP5zAzndWKn6KNOc3s90pSx61sDnLnfird6G5xYv
X-Gm-Gg: AZuq6aL0dEHhgIg8kP8gUOwFDTn2PJhgxuumCwKiuOSq/o8p0t81koGt9PWWQYOd5se
	65cLJ4BdQ2+gLIlzwk88bUGiAX/Qc4ukNyPSsTKRRNzY0LYuznEWrusuMEoLffVLhn6d9uqWRh0
	NPSmzhLoxPjlgc3DX7a0KCN0GakLdG1i5IzG0E6sFnFvZxySQKMAEU3cosza9QzC+N63Cr3vdyv
	1me7u7UrXqvV2bv5rBmwyU8HZyT9LYPyCA+HprG+thxbKErz7L8zqsAnUry3DNkUcfTeqjFmxGq
	BRid13dvOvcjCXfVTvOszjhK7Yj3/Rhd+0AoNZeV1TIYU5DZHjedEHO/11KGkl43Ih9hMQOpvhT
	URlDfAH5f54becos0FzY2brb7bKPPDZcm7/zVRuY=
X-Received: by 2002:a17:902:e744:b0:2a1:3cd9:a737 with SMTP id d9443c01a7336-2a95194698fmr144678965ad.36.1770643438087;
        Mon, 09 Feb 2026 05:23:58 -0800 (PST)
X-Received: by 2002:a17:902:e744:b0:2a1:3cd9:a737 with SMTP id d9443c01a7336-2a95194698fmr144678525ad.36.1770643437573;
        Mon, 09 Feb 2026 05:23:57 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:57 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 18:53:38 +0530
Subject: [PATCH v2 3/3] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1461;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=UiU+149jnrVM1SWUnO6BecZTr+G9PKFBnhbQil6C7dU=;
 b=rG94SyNpfvcGbjoBjrVWjDplNxVX6azl7klWt0E/bxlDq72lOpcETrbZpYe88qy3c9m+Ivrk4
 /I4EbjXtMxEDV3NlnfEqd6AiZMFfuuBjvuDymgtoP3a47/SSj/wxjDe
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: YMFsGlNvggBjf1M-2EyztjxLuqeyFnZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMSBTYWx0ZWRfX0Mi8RZCavxxX
 BC1N9AKJKIj38bRmocB335W2zVQ23n2fQXSxkRVk/rPuUNngWjU1t/ugagNggXB6Wbv2sDuwm0j
 6Hv+FHbrv66IpLzgRGD9GrnpOzyFAzkkWIVE+y1N7LlmqPq3I5juzr7SnVsM5BBDr9eWoV89FMa
 Ra+ePzHDoRq4/bJ4fOVszqZ838qKyqk/EfduLPLlPtEEVuxcUXpRq8wuat91xKx2aW5aOXgGzwN
 auDStPGgpL3QogUBMFzkRUxexfmSkjLYFJyGUHPm6Rk+RkjjOKdaQjEx09jA62hxsHp7Dtfwp7S
 2ZBgxfUcD7LVFFK08zgiJa8U3I6MTQDt5O4N/09HmyHN5OS/Ep9XMzyH93xdDmkeXJJVkyRilyU
 3llUFijvqthFnEC6HBsHWOc6czocyMW1tBS7bp+owEIwvkSbb8jJdWrwK6x5JMxY3umm5lIDVCL
 6BoLD04jOo41wq5Yx9w==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=6989dfee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=waYKtz62x7MdsOGo3IQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: YMFsGlNvggBjf1M-2EyztjxLuqeyFnZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090111

Add the Power On (PON) peripheral with power key and reset input
support for the PMM8654AU PMIC on Monaco platforms.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
index e990d7367719beaa9e0cea87d9c183ae18c3ebc8..182c2339bb11af40275050a36c4688227e89497a 100644
--- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
@@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_0_pon: pon@1200 {
+			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
+			reg = <0x1200>, <0x800>;
+			reg-names = "hlos", "pbs";
+
+			pmm8654au_0_pon_pwrkey: pwrkey {
+				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				debounce = <15625>;
+			};
+
+			pmm8654au_0_pon_resin: resin {
+				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_VOLUMEDOWN>;
+				debounce = <15625>;
+			};
+		};
+
 		pmm8620au_0_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;

-- 
2.34.1

