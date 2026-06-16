Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA5427A19
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604524; cv=none; b=CahWaz2AbB+3VBp5WJ6F4r2+Wyzy0Jgpd8FOMFIOV7AVtVYm0l4WaUEtX/+Z9gEi7OWa9JMO/HuvQ/1C1xebvg8gM+HFDSyh/U34l8Fsc+6DD403ipLEhXLOhs4tYxjMX8XQvH1Ci4WhoF4crQSKK2y217k6xD5oKo0CjXZhCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604524; c=relaxed/simple;
	bh=Cam+lRe8QqkoGafgoRm2B2QogdzzLxofKNZhDKv8ZdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fs6sTOrjY0jGxVB5L5fOvnj8yGjFH8DHtCP4wS46NbExAQiAILtGc9HcCufllh6TSyyRr36AUmVkKHF3xjJyT7ycvb1trS3oJ3jNCtr12FHbJw6LINpNAhD6WUB6rEOuG2kqGgLhQguuHYGSRxjcPBgWLcHItxDNDlJS5ZLfh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SeJ0tgmh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/Owo2HL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SeJ0tgmh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/Owo2HL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G8ALI42978629
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MCuohMbpxCw7pt//XjSJR0I5DVLs6HUVuEwQ0utUTZU=; b=SeJ0tgmhrLAwjXjE
	U05MqmE1gNlQz6t1nMuwJdQevQeIIJNH67GZ3oz/hvjpZtgQUsWKCq4P3vAb8avv
	PFdKsDiXQvKY6HxKdR6idNeg8gCKvIVw8wqTf9MjPWRUD8ICwBCP+ZmcfIR+O5IH
	MB/Hi3b9YM7NUMkSq7Fl59R4MjqHXOyPPm6bC89G0vgoHqcckIFlPiJyQBlhrL6A
	qHM3cqLmjvyIhlLPuhWDXX/XDkLNY7DXjz/i/wwtEFFNpmcCuP2PRnpOVM+etc99
	h4UXyoCWTwXgtxoJnbLEQOJqQ7xch0l16zLvfmFgbw0VTm4cDpTzAGdR4Dw8GcBx
	Y1qZwA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09k964d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:08:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-307fe856724so1536464eec.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781604521; x=1782209321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCuohMbpxCw7pt//XjSJR0I5DVLs6HUVuEwQ0utUTZU=;
        b=c/Owo2HL7pm28+eHPwkyn43VJdAjINMEIRJKEmjwxgn6ZBloKE5dBp4fgCTzp4wygd
         mcJeWZAGW5wqWz2iCx6Vmn+ndH4j3ENo50PHln6RoaVPOB+QkS5590lc3/OGVvs3O5cL
         MUeiZwtvgnsxyQQg0XtozfXExdr5tkJDKogQLcjaLwrHW9J3EknoHOs/55JTAVly9zup
         h+kiADMVITGWp6wGW8+ct/G0ebbB0AGXmwTnE2zU5vYa0LEENi67H9cFNNfWAn34M1LB
         3hwy8/KZ/m5zPsxg4d1L9jM37kunaDjE2Sl8O31TxFhWzd/OOuJHK0ORcvkQy/oDmKx4
         1e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604521; x=1782209321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCuohMbpxCw7pt//XjSJR0I5DVLs6HUVuEwQ0utUTZU=;
        b=gC8qrS6ieS6rUYryLGAJBArlNk5Wi/9eQoxBsXVJYDb/LNAQe9QyUyszfY6F8iPSQE
         Wn6UEdGRfKRSI8usSHBbzUx9E0uwe/kxI/uHt+T8aoAXnVrbqK/qlM/cUbeIdozlkSqR
         TEcuFDl04aLvkRJ6Iwvd1GkGCPwSZAcbr3sMIPlKOY4UuW9/yoyw0ofLBZ5Fn+hPei6M
         Tnnaz7DAi9pokFS02bj/xRiiVSf02gYVIYcF42gHRdIOTwi9ZA6N7wmA/w5B054ZJV7W
         l1zhmGuw5VsKKS+eOltc5x1QSrVQGfKgFrSlwN/9k8KfjRhmOmM0lY9QCpIrfpSGSHtj
         7A0A==
X-Forwarded-Encrypted: i=1; AFNElJ8520qOf90dH0yh/vg9F6+E2/xyuRnM96qz3tZ0MFHhZXv1eqbLhI5GM3f75Qbd7uug4OxRhqJe0cjhTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmnRV48nQ8mak+/URZ17Gnw+so8ylS7sp/D1fi02Ic601P87n
	NkcX9GKIM1TQ9K+TTXkVJAkZ4ecEgNxyhpBaA1SsayDRVqoQkYGNx5JQYvGTf9fqgoUImoH4c9e
	9df3MrQPN0xpOhcM3hF3GFprDt0rMLg7kqbY85WjQXR+RA1SlQG3wlICL/u2c3woO9VHDF4a3ng
	==
X-Gm-Gg: Acq92OGoxMOe3Kk92OwZYob3CxzAFwyHFw+rwh4sY9wi0WA4HXcrAKK4/0Psx8rr7ik
	cxNsWu1tVxgTGucQFdLsySwHV5T4g68coEMEcs+fDz0hwNfHgBbqc8LKZnTqdVurSjEI+AQqP3n
	GflDF4GcMxVIl4EtkS6r9+G+T1NpMwfhMxFGQVkxoKoHSv0apkKQ+87rTTFTv2it9ycM1Y0SQKW
	DsayfPO4pJIVbuHvhWpCewGl6lT5ZudxJIuljKBe5omkdA50jpsE88jF6TsGI+J/D2Iq793Hegk
	Je5bLg2OxG2LT1btUxmXgCa8uNZxyMkdHDFKEimBJTQ8xgIXVZwur4B6ekp6ZEc16VFANmz+c8B
	NDflg406uHPvuNbXsQztoCKuZLQ5plECfaUdAaZKLD8Gd4+I9g3I87p3WqigdReDkF+ud8IE7oQ
	==
X-Received: by 2002:a05:7300:1482:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30ba5985551mr1760330eec.11.1781604520786;
        Tue, 16 Jun 2026 03:08:40 -0700 (PDT)
X-Received: by 2002:a05:7300:1482:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30ba5985551mr1760292eec.11.1781604520331;
        Tue, 16 Jun 2026 03:08:40 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm18401484eec.5.2026.06.16.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:08:39 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:08:27 -0700
Subject: [PATCH 4/4] arm64: dts: qcom: Add PMIH0108 haptics device node
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-qcom-spmi-haptics-v1-4-d24e422de6b4@oss.qualcomm.com>
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
In-Reply-To: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
To: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781604514; l=3992;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Cam+lRe8QqkoGafgoRm2B2QogdzzLxofKNZhDKv8ZdI=;
 b=OWdm/RwW9Oxof8vpRTnu6O17HJDW2pOobkwXGQbS45ugN+h8l3vLtxd3wRMLs3sg3jBDkThVx
 7uOpgspJQSRBFY+z1Pz+V6Auy4s5xJrKbGJN6a5sZwsJTeLOuJ+Nq6v
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfX+7BanXmk30Bg
 kZIB+GjbJZn9ae+H7MHUtJKDOfMHxZYhEwBncfepl9/BOCkkI0KlvC9p/D8apS8XXGglFlmn5zl
 QSRYaEltElKLwtfMCwLZMVuHk1iPZaI=
X-Proofpoint-GUID: KDagJEEeQi78v2ffXQpziO1r_4XUKL0u
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a3120a9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jWoQrppvmuiTGUauvUUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: KDagJEEeQi78v2ffXQpziO1r_4XUKL0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwMSBTYWx0ZWRfX8+j38omHBzlB
 LrJJeCehyIuQNMpeVF6npv+LG5Rr7dkinjrq0TXWoW5l0od/m9nWtbt3MpYhIP3EzitReNL862R
 1OWGKfXNrRKU5o4O5NyxBBFO+Xvv/NPkumvp+fMdegSd6bDg9mDYWT2s09CcAFuzGXtVC565EHt
 2OSgrmHYodeElf832jK7IAJnn7NG2Z5b6CqjjNV9gL/vAkfSQLRMWBjb45sPI68yUGS0N0+Qe4G
 EH9UhxskwDIHyAcNvjJX4U+RXU3IdN5/QV41D/In8kvM0tsje8mrV3Nyut4Mb1EgIQS6iGjv1mX
 clYz5G7EjsSyuh020yecuXHY5+5NI69WNdny49RAy9iTVKukV061Hyk3JIoRI3gYkZc92NirgGV
 8mAoqILP/tEIdJMx0VnSVoBLb3aSU6TjLRU5qK4XHcoZDXZQsaoNtrsGaZtZWpSE6Qu9z91ZwMd
 K0AuUVxL4iWwjrMwZoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160101

Add haptics device node in the PMIH0108 PMIC base dtsi files, and enable
it on several boards according to the LRA (Linear Resonant Actuator)
component mounted on each of them.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts       | 7 +++++++
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts       | 7 +++++++
 arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi | 9 +++++++++
 arch/arm64/boot/dts/qcom/pmih0108.dtsi           | 9 +++++++++
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts          | 7 +++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts          | 7 +++++++
 6 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 07247dc98b70..7e3f59fc008e 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -952,6 +952,13 @@ wifi@0 {
 	};
 };
 
+&pmih0108_e1_haptics {
+	status = "okay";
+
+	qcom,lra-period-us = <6667>;
+	qcom,vmax-mv = <3600>;
+};
+
 &pmh0101_flash {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index da0e8f9091c3..0865afec47ac 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -744,6 +744,13 @@ led@3 {
 	};
 };
 
+&pmih0108_e1_haptics {
+	status = "okay";
+
+	qcom,lra-period-us = <7692>;
+	qcom,vmax-mv = <1850>;
+};
+
 &pon_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 
diff --git a/arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi b/arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi
index b73b0e82c3d3..22c83c549ce9 100644
--- a/arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmih0108-kaanapali.dtsi
@@ -59,6 +59,15 @@ pmih0108_e1_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
+		pmih0108_e1_haptics: haptics@f000 {
+			compatible = "qcom,pmih010x-haptics";
+			reg = <0xf000>, <0xf100>;
+			reg-names = "hap-cfg", "hap-ptn";
+			interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "fifo-empty";
+			status = "disabled";
+		};
+
 		pmih0108_e1_eusb2_repeater: phy@fd00 {
 			compatible = "qcom,pm8550b-eusb2-repeater";
 			reg = <0xfd00>;
diff --git a/arch/arm64/boot/dts/qcom/pmih0108.dtsi b/arch/arm64/boot/dts/qcom/pmih0108.dtsi
index 1c875995d881..d942d6c2fd03 100644
--- a/arch/arm64/boot/dts/qcom/pmih0108.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmih0108.dtsi
@@ -59,6 +59,15 @@ pmih0108_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
+		pmih0108_haptics: haptics@f000 {
+			compatible = "qcom,pmih010x-haptics";
+			reg = <0xf000>, <0xf100>;
+			reg-names = "hap-cfg", "hap-ptn";
+			interrupts = <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "fifo-empty";
+			status = "disabled";
+		};
+
 		pmih0108_eusb2_repeater: phy@fd00 {
 			compatible = "qcom,pm8550b-eusb2-repeater";
 			reg = <0xfd00>;
diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3837f6785320..7a3b8c440d00 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1138,6 +1138,13 @@ wifi@0 {
 	};
 };
 
+&pmih0108_haptics {
+	status = "okay";
+
+	qcom,lra-period-us = <6667>;
+	qcom,vmax-mv = <3600>;
+};
+
 &pmih0108_eusb2_repeater {
 	qcom,tune-usb2-preem = /bits/ 8 <0x3>;
 	qcom,tune-usb2-amplitude = /bits/ 8 <0xa>;
diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 801c46d55602..4a1079984307 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -933,6 +933,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&pmih0108_haptics {
+	status = "okay";
+
+	qcom,lra-period-us = <5880>;
+	qcom,vmax-mv = <1700>;
+};
+
 &pmih0108_eusb2_repeater {
 	status = "okay";
 

-- 
2.43.0

