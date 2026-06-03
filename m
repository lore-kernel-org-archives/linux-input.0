Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D533E63B5
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456313; cv=none; b=NMFi+TedscWX9aQj8s8w72/zctJuiD+RJRXlTk1MfwEKdFFGtELEXWyH07Gj2OejOGP6uoLMBcsSaTvVKGgOsdLYxoddK3WrsMxFNaDoz68BbL6xiaOdxkWxrZ+74sPfkawSaawHGgX4xk4fq85Q/NVAHCREiqZIzBdSkqDOUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456313; c=relaxed/simple;
	bh=AneU59lXyef9SIW/HnDmRQ2mhtnL2MPLR7a7poCmZEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j60lVZyg2sEowNmyp+ptXF8eqshR9LfHvWi5pC9OCkz2Rz5zwlPrWzPeg5KmwoK2biqS6M4uDi60/+jSfxrS9m5KXNnuSt2SbN+u3NrD3RopMw/vk9TBS8smL26PqglXHQNXSSeuEXLAL6SDdlEavliM9z9SYr2vkcEg4v43K3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzrXU+or; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZDvPRSW8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzrXU+or";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDvPRSW8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652JlgCo2767770
	for <linux-input@vger.kernel.org>; Wed, 3 Jun 2026 03:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EeKOX0X7IWJ16loZJh3c0OuX75DD1qqhyVbH1dmsUeg=; b=MzrXU+orfWJlGind
	4zY9gqmd0gn1gxCYLNQMXhWdLr976oVl9vZxaIshyCB6cf3pNsWnDnvMxJ4jLN18
	Wseb9yXQNPzcAsLQpGYQnf9a10mIhdcjNu4GvxjoGozX7HBMED4kiMxRXC2PCBY5
	MHFJBn9sCJdxpLx3eiTSzeZlpBs5FoXrNaSGrbffeii6JMaOmevPjMIOtuWX+H+P
	sfK0HUPP2Ox6Recqf2Xzhw7JzPRzdQGP5lE6PmbGM7dVMFS2j+b6Was6iHqOODDG
	JhidQp1EheyPZE+6wZX/nfmw+bC1CGwbdV52Zu8brbwOHd/yHbaYvFqHUZyRRwUC
	bKGRTA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus4v1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 03:11:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bbdcf36f0so252616a91.0
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780456311; x=1781061111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeKOX0X7IWJ16loZJh3c0OuX75DD1qqhyVbH1dmsUeg=;
        b=ZDvPRSW8nV0Nd4y3Rfn5Dpot1kuCFLtmdatM4eg150e7JvE/Eu+fTEEir4vPdgidrI
         niwVrWRGj6yncthxNAFqG6k3ypbr71i5PGkgovLGPYQPL+wCRrigb+IMv1GR6VaUSHiL
         HJdweBu5N2gnXiPtdHqet62unxnFj4gAwK/MCY4ELKUorJW6hDpW1/hZ+xAVpFsQpAVA
         mU5ibcRNqiZVT7wgWu/2o4422HrIymLgnHwpWjwsbhhU6z0haPjGWNyTpv0M8vPujk/3
         eQ9wmpkIeSqNqCHZmjrw9NgbXAgLNexVy6cwORA9Q8TYUxEJB0UKM7AjJGPxFp7HjS32
         Q5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456311; x=1781061111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EeKOX0X7IWJ16loZJh3c0OuX75DD1qqhyVbH1dmsUeg=;
        b=bigst8AaJPPhwCPj3HIFRxGlYY0uKpVgBbYzOAhloLnzpl9rnOmIX86xrTZmW4Bpk/
         JUODYxRN6sL99qWjopy619khmFUy+svR07EMohQtCBwZzZ46HF7XUY7XvfgA+VGipa58
         YKXjxYMssWiWJSD2uSD5uRSYB8huXAaU3PZWdj4HtlzYMslCEwucHM1PtwfZIBdEanym
         u/5e0xgnNuWO2ITPUAzqxpQQ58gukck+h1nXuohKKvbqlpR5yPvzf9e4NaMQyJjhPdFo
         jlVbw3XuyqUVaJeGz42cjG++DiGAVKyteXN4N0Yikj4fvOUClNjOEOPVExrhxcOaqVOJ
         LnSA==
X-Forwarded-Encrypted: i=1; AFNElJ+jzB4S/FwfjU+AV/CBS2X4kX6KV8xxwBQDjcwA6MtvlmwpF3fVjnBgLZkiWfgc7mxhbPH+1iMSjbbVsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2plMGlNwZ0L5RtFBTNX6rokb1q41Bf34idxHAdB8vduiiK6G
	Zh5kVMfRKV/Rt5HT+5MYbrPxSkEb56er+F242jsnAb64N9Va2m+dybi/wtbx/AaNVk99t2OgBeE
	DXQPMR8CcphvXyGD8o/i30KFdX5E2gvucB/IB9ClN2M6HvcLCVfpK69cyawv9Ji4IrQ==
X-Gm-Gg: Acq92OHc3H7D+b38STRFVnHa189E8dZkdU1v8JKwBGU5kFsloMWF+vr0FVmHxC93FA9
	/P+zreXaQ1Whl2kc42WlEGsH18Mi2t1zXrWUb9aNAa9xryiJ96RFqybWkO3GBoKIUBCuUyTie51
	aJqBD0NmuLdDoteDTQreXUnCNp17C4iyewh6D4kChOtWVyNiebQYDVrlcA1bO4gAZjphrPpaBsy
	BoGkhuMcx6TYkZhq24KDNbYWGCIxs6/8T6hgQMjbtXlx9rn8+EaYuwZ8ytW+3rA7P+2HU/I6UNh
	QsObTADdwbCWp5iD0YbF4YzugTe22roeCBI4ZoZIZ/CiyXQp6yGECvLE2xbF1/su5yX4zWy1J0b
	DgfGk2ce8BQGBrwu/eIxb7nDwdrQWXM5evjYVaTykpnGy2ucK
X-Received: by 2002:a17:90b:584c:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-36e3895f04bmr1113210a91.5.1780456310669;
        Tue, 02 Jun 2026 20:11:50 -0700 (PDT)
X-Received: by 2002:a17:90b:584c:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-36e3895f04bmr1113159a91.5.1780456309824;
        Tue, 02 Jun 2026 20:11:49 -0700 (PDT)
Received: from [10.213.96.151] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a276892sm1269420a91.12.2026.06.02.20.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:11:49 -0700 (PDT)
From: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 08:41:20 +0530
Subject: [PATCH v3 2/2] arm64: dts: qcom: glymur-crd: Add FocalTech ft3d81
 touchscreen support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-2-3453ef577bcf@oss.qualcomm.com>
References: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
In-Reply-To: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780456295; l=1732;
 i=pradyot.nayak@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=AneU59lXyef9SIW/HnDmRQ2mhtnL2MPLR7a7poCmZEI=;
 b=j/yISeycRh6g5Z5PkZnpcYebHJW1524NW5rnDvUchkPoN3KGC2uRsSiLOlxscRrE8R/3gtxR7
 SPxgfcch8+LAcRC1+8UttHYVA1UUFRDgkx90z3t83RqKOwUNpD38oFc
X-Developer-Key: i=pradyot.nayak@oss.qualcomm.com; a=ed25519;
 pk=ZAwwH8thDSb6bq4dCgFHWr80BqB7MmUAKogkd9BsiXM=
X-Proofpoint-ORIG-GUID: saRqztinLeoSOxrF2okzOxyLvTA6hx81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAyNiBTYWx0ZWRfXxXdVRGk95VJO
 y3fWmdxolOalJKXIF703IBq1ADCYVtzzhxmI/CDIBRhBpdwDNG9II5X6tIEiDjLd0Sqy+gNUBFk
 uZZ4VQSlpdswqXqFAhJF6oJgYJwEaCysYozIJyBukgCBVmExAYdTNkzLvdsDUBxKJgDJtC8pXZS
 gi2RDLIoPMK18eXImktZSjaayGcksFT1fIr0BwiGRnpytyz3jjabuEJuaRPC5ImogrGBN8vnamZ
 1O8BuZGgIWz9r9MyV0eJ0IFULLksZgcD3bmXVapM+3YT5z07z3rrZPlHrvyvU9JujeS/F6V7w2I
 efPNYaBp4S5oiQ/fKGmB15NKLvhvForzIlVCa+pKC7U9X+gbgDpkrmVnfZcT4PhN4PV06zn4D0Z
 SrGwdDBeN4I7Chjet1nzUMH4bZ+CLMFgJ53eI2LQfamDjISKCtud1/jNLcIpPgKc/9zpSHb8QlZ
 I6bllk7KcmjfBj2H7/g==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1f9b77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Y23twNOXuKrVrwrtvMkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: saRqztinLeoSOxrF2okzOxyLvTA6hx81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030026

The touchscreen module on Glymur/Mahua CRDs is different from
the one used on Hamoa CRDs and requires the reset-gpios to be wired to
the device. Without this in place the reset line will remain
permanently asserted during resume leaving the device offline and causing
all I2C transactions to fail with -ENXIO.

i2c_hid_of 3-0038: failed to change power setting.
i2c_hid_of 3-0038: PM: dpm_run_callback():
i2c_hid_core_pm_resume [i2c_hid] returns -6
i2c_hid_of 3-0038: PM: failed to resume async: error -6

The touchscreen on Glymur/Mahua-CRD is a focaltech ft3d81,
which is hardware-compatible with the ft8112.
we have added the required change in DT.

Fixes: e6bf559f7eb9 ("arm64: dts: qcom: glymur-crd: Enable keyboard, trackpad and touchscreen")
Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index c98dfb3941fa..5cda08bb48bc 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -154,14 +154,15 @@ &i2c8 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "hid-over-i2c";
+		compatible = "focaltech,ft3d81", "focaltech,ft8112";
 		reg = <0x38>;
 
-		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
 
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_l15b_e0_1p8>;
+		vcc33-supply = <&vreg_misc_3p3>;
+		vccio-supply = <&vreg_l15b_e0_1p8>;
+
+		reset-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
 
 		pinctrl-0 = <&ts0_default>;
 		pinctrl-names = "default";

-- 
2.43.0

