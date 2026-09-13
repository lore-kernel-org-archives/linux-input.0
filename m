Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0C37FF6D
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302799; cv=none; b=lEoawju+BBoHe5jJyq/ejCrYlwYYecjDYjm6Cb5GgPNV4lVuOAEtpUQsRzPeXZ7lhmxxMOJyZ0ynxgRf61oXX9ymQz62rN25aNAADAvCR8IuIMKirHskFqz50RYMirOU5YPwJeOlpnjJE/iL6yD1ysXbDRLqZwYYOdf7mRcPSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302799; c=relaxed/simple;
	bh=I+E/O9s5n2yESeW++6dwadVuhwOsVzwTznjrZtzXSJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2wngnsrmcGEdsxfRbdarV+Rs5kZypZWYG9NbNTmdBDV6trJaHqa2HSyycxxmaPB+rV6PTPt7WefOMAwCDPI5qisVZvIz451oFExIvwieX91nhqCipJzqfAnuOvFZ5c0sJJJqnET+jn5nWzp4Jj3TnjktAZElBcTOfP94TrhUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVVBade8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RP24g8G+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVVBade8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RP24g8G+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DAUqJt1691964
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 12:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=baoczqhIZrjz0uVdn8S3iNYTU/V5HV21e/d
	MeLayogE=; b=SVVBade8rxLppbo1Ks98mM+xoXfjAtHv5CpFFlArSqW0NjbX71P
	6aTGXyaZsEMaoQShDPYZ+xI62W7g16A84R/6Q+o5RkWQWPBZoQKyX1vrtokjU0jF
	J/Gnls/UmWrlY2CmivUqBwBWT3dcz3PXRedESOqdhkclKz4IyMwHZsOOs7zM5e86
	r8J/tA6ISg3X2PH4Pt/9QMZGU65GqPr6EII3JQYyY+XhHfyX6a/T8TFEv80sjiOu
	cDv9SzK+QMBKBOQ2lV16eJyqbFNPBUJvXwDFtu20ejiE3y1D6dHIiZ712rjE1u7k
	lhHPMXwf46jPZiK8YGK/0ZYkbzPaU7IDolg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cb7eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 12:33:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so444012785a.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789302796; x=1789907596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=baoczqhIZrjz0uVdn8S3iNYTU/V5HV21e/dMeLayogE=;
        b=RP24g8G+KNLD/jQEQOL8D2dmxtvz07Gj/Mi10M9HwOeTNK/A+SGNr39C5gonSPDvxg
         Q0fOctCCftGaKFQftpgtgGzAb/Psmtnw6M+pmD+Ze8jUuPIwuH2LtQNiodi6A+GFCOdJ
         axU4Wi5OfV8Okz+gGSVIJnnVqauxlnLDVXm3jC7Da1qlGr/HP1YUeEFdKu2e6W/lf+8t
         wnm2uKmEGOTRZjHyvQCLS0JzIlpSZbzZk53p8dBfQHf1uiIvJRfSLrIY/H3P7+xrifv4
         2s5oVYTTicbRtTq0hs+DQOYixuTq8tkppygHKAQM4MYI20wdqMI2lhrxANluyNB81ZT3
         NL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789302796; x=1789907596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=baoczqhIZrjz0uVdn8S3iNYTU/V5HV21e/dMeLayogE=;
        b=L1Bdw9Fsj615aIt2+R/xhSenwIveHPrh9zOXA8Es87qk8fp9djooUk0XWWWDvH8bXK
         nkDSeU5kSxKqyPzcvQkZFfPcPOuwZNkLstRCrXUWRfm8WpunyzMiy26kJfTgu272yKu0
         MbJbTD9aiCR+MROMw/Wk5Z+jc28+6D1g6T4pltPyNkMhwSO6UbSdKLekW/pMTYN4J9tP
         YR+1BtckGVqhuc1nR7PSVaCo7TQuAHlWpd3+Na4Jmkf7mS6ShE12b62P0q0luHxkSVAW
         10DhJIlDBuX0pSytyiZjM/AXvl43QQmZAyA8Cvmgn6UZXaCqPaK4AdIh1b8KJX2c5Swf
         0xEw==
X-Forwarded-Encrypted: i=1; AKwUvBy5I8LGnd3z9UzWT5ELZYzg/X+nubHbyBAdTTBNVAEhseUiK78qdH6ADns0GBa0e5FaLOLr7EQDFnS3kg==@vger.kernel.org
X-Gm-Message-State: AFuF++lXRwYQGvIMSSi6Ybr6LUlJVc+mKyt1djki61dIMheIQcMVkW5B
	baVWxch4rpyckXlaqRnJn9dcp59dCC/1LqWW8vkAjF42e0ftnJFmH+gxx21CKG2vPkZ2mYqSIff
	rMhs3ew6Rzyt7Y68OCNlnTrqI/wnV/GOpDELjEbLVWbu71ACK4eUPqI2U/GVuBsmo6A==
X-Gm-Gg: AYBFou21W/d68Kpi+iMxsAofZ4JDQqf0dYOyUlN/Sm6osoxZfCjp1ctcUi+wjhQsbGz
	S2c2aPtUdeg5TwbJ7GzZNsgYnm7VCTVLxnDrNQAOej2lx7+IWMsu4pQzGD9H6fwCGyefcfF0dC/
	gw8Rto3Ne0exdajn8HjLjz8udvp4kuASZ+xqsd5KpUQFCvoSj4VQsXWVyOBmxAmbkf1NrFhxsbh
	QEtFEXSqwTO0B6dnDYbakAyJ+2Orcb90RjwccLesrBLjfkpgLdhWYebkkgbOdd9CJIA3TthHPj6
	DeW2+HgTGvM82tGwbFrVVg8BYd4oKia1yXO/MuKnFmO+OI3lfAj1/I4wOGlCMVEciyUnU9WgpMy
	Z48DPaW3lDGtPlNs=
X-Received: by 2002:a05:620a:2544:b0:914:afc1:c66d with SMTP id af79cd13be357-939ea104decmr1658054985a.11.1789302796295;
        Sun, 13 Sep 2026 05:33:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2544:b0:914:afc1:c66d with SMTP id af79cd13be357-939ea104decmr1658051785a.11.1789302795835;
        Sun, 13 Sep 2026 05:33:15 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e0asm352484885e9.1.2026.09.13.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:33:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Mattijs Korpershoek <mkorpershoek@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Artur Rojek <contact@artur-rojek.eu>, Frank Li <Frank.Li@nxp.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: input: Use consistent indentation in the example
Date: Sun, 13 Sep 2026 14:33:11 +0200
Message-ID: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6934; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=I+E/O9s5n2yESeW++6dwadVuhwOsVzwTznjrZtzXSJE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqppgGbOSr/eJIqpD2Ve0Fac3V3uxuaoogWqn4Z
 8kMdHKbihCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqaYBgAKCRDBN2bmhouD
 1xg4D/9TyB0+poLY2P/4Dih94oXcs98iTr9WlRkUNjInZ+dbLhkQJtAZScBdNvwkEAqJPDoL2Rl
 TxYyWXUs02i+ebKWjyrblVAt2u4HqREQGKeMrLr5nMLRludOHJ/RoxwdTh8kQU8kAdqGvTwqg4b
 6aTSTx8ys9BGsvHW5dPJoBWpZDqTtf0Bu09QR1Z0J33BfSO0UheWlRA8Hcjpim54uHh+TwNEJsO
 6uTpCkOEo4Qh0od7P9KM/9zrYB57fwJw+j0tUvzDNtXBq217S8pimR57aRnT3R1/IKjNJMwsTE7
 xPWyWPnV18jaRmO4WeHvJVeKHwyezVh9HUIwMr9FJiLtsp/PWYXXVO+lL7GSeXF0yCOnJ2r6hyS
 yfS/VmyrG+apmE/A5bq9Ll9CqWhyZaBF5hNWd2tWOk+rXUN0ztCzPaYqiPuzybW+J6ug9j0QaHt
 UFde5c/dCp0hHtHOtxQ71+yWGybMnmrO/Oh8G1v9/2s9RtYyCeic0C9xKmsZ7kjthwQ4om3axoX
 69cTZaetMiejQbj0ogzWJoccBx0WC+CLKJeqdIqHQ3VPoF3qx+h7QNGN1uOcPQRToR3qZ3CN1SS
 BXn+ImwgsGjwNvKigUM7bMYwhSEp4stZ3Xxzs1g9EuPdYedCVQZbMUZBIOepPukB0dHr4yiX7lq 0Guw4fs1o2qYM1Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e+mT2qp/ c=1 sm=1 tr=0 ts=6aa6980c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nrvTzeEnne52kZqV4q0A:9 a=xWRXsgGyZKNAB1QD:21 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfXxMdftZzIntA0
 /P/CqwIWvVPzWXH4FQYb7QcuhrfvWZPmN4xgB1+fmr90/H39VbsODWwDqelsB1rZ6osi3nv2VNO
 Idf88M+aCtQopupay+8ZrrxUAz0q/wM=
X-Proofpoint-ORIG-GUID: 7pfg10OaYcr1VhiFSypIX5DT8lEPXFGf
X-Proofpoint-GUID: 7pfg10OaYcr1VhiFSypIX5DT8lEPXFGf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE3OCBTYWx0ZWRfX5VtvewlzEOK7
 qHlCoorN/GywyNv09nxtjuPjInghgRvgCT9hZWF8+PuaiRsIRwXBD3faVsM/rtcPFiWfAtNYQ4R
 dEwTmKfwtKz4aXXWdXPdBBG7d2J3c6d0fY7HkngOuoskrAEtYmlEM+UF28qUBSdp0GiryWAiYOD
 DBwerKmZxOjlOdQOM/yIhFbE87x59ZOKYci5b5kVCnaWAAVVx8SzdfP5lrkNKG+AbQ4dhrxpMJH
 uvSExqilYzJ1qqXIS1vrgQdbfx/g/td6eO6qdJoFlp+j9iEJ4UHEbuyK4uUpE2ATxmwvvFL7Owg
 5scQuhmMxHT+xg1sqRaLEryEL2Hh0N2DSbpqDxe7GliCEgIeeqZ/WmvcU4yoZgcP298ffh/uYhD
 I6mVmD5jbf9PZzj/n/Ag0ut0uPEiG7cbZ6mCGlwEvopE51G1NeQe0Z2r8vzvMvPuZ74sKoil1T0
 7OTlPGtJ8+j64SPZOVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130178

Correct indentation in the examples to consistent 2- or 4-spaces
indentation to fix dt-check-style warnings ("example 0
[indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
re-indenting entire example just for that is too much churn.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/input/adc-joystick.yaml          | 20 +++++++++----------
 .../devicetree/bindings/input/cypress-sf.yaml | 14 ++++++-------
 .../input/mediatek,mt6779-keypad.yaml         | 10 +++++-----
 .../bindings/input/microchip,cap11xx.yaml     | 14 ++++++-------
 .../input/touchscreen/eeti,exc3000.yaml       | 16 +++++++--------
 .../input/touchscreen/ti,tsc2007.yaml         | 12 +++++------
 6 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 6c244d66f8ce..ac0ca5aa8212 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -111,17 +111,17 @@ examples:
       #size-cells = <0>;
 
       axis@0 {
-              reg = <0>;
-              linux,code = <ABS_X>;
-              abs-range = <3300 0>;
-              abs-fuzz = <4>;
-              abs-flat = <200>;
+        reg = <0>;
+        linux,code = <ABS_X>;
+        abs-range = <3300 0>;
+        abs-fuzz = <4>;
+        abs-flat = <200>;
       };
       axis@1 {
-              reg = <1>;
-              linux,code = <ABS_Y>;
-              abs-range = <0 3300>;
-              abs-fuzz = <4>;
-              abs-flat = <200>;
+        reg = <1>;
+        linux,code = <ABS_Y>;
+        abs-range = <0 3300>;
+        abs-fuzz = <4>;
+        abs-flat = <200>;
       };
     };
diff --git a/Documentation/devicetree/bindings/input/cypress-sf.yaml b/Documentation/devicetree/bindings/input/cypress-sf.yaml
index c0b051466272..8492ffd84bfd 100644
--- a/Documentation/devicetree/bindings/input/cypress-sf.yaml
+++ b/Documentation/devicetree/bindings/input/cypress-sf.yaml
@@ -50,12 +50,12 @@ examples:
         #size-cells = <0>;
 
         touchkey@28 {
-                compatible = "cypress,sf3155";
-                reg = <0x28>;
-                interrupt-parent = <&msmgpio>;
-                interrupts = <77 IRQ_TYPE_EDGE_FALLING>;
-                avdd-supply = <&vreg_l6a_1p8>;
-                vdd-supply = <&vdd_3v2_tp>;
-                linux,keycodes = <KEY_BACK KEY_MENU>;
+            compatible = "cypress,sf3155";
+            reg = <0x28>;
+            interrupt-parent = <&msmgpio>;
+            interrupts = <77 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&vreg_l6a_1p8>;
+            vdd-supply = <&vdd_3v2_tp>;
+            linux,keycodes = <KEY_BACK KEY_MENU>;
         };
     };
diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 20fa41f691ed..f10bd0f1d948 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -79,10 +79,10 @@ examples:
         #size-cells = <2>;
 
         keyboard@10010000 {
-          compatible = "mediatek,mt6779-keypad";
-          reg = <0 0x10010000 0 0x1000>;
-          interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
-          clocks = <&clk26m>;
-          clock-names = "kpd";
+            compatible = "mediatek,mt6779-keypad";
+            reg = <0 0x10010000 0 0x1000>;
+            interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
+            clocks = <&clk26m>;
+            clock-names = "kpd";
         };
     };
diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 983f4701b51e..fa95270ac2c2 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -290,19 +290,19 @@ examples:
         #size-cells = <0>;
 
         led@0 {
-                label = "cap11xx:green:usr0";
-                reg = <0>;
+          label = "cap11xx:green:usr0";
+          reg = <0>;
         };
 
         led@1 {
-                label = "cap11xx:green:usr1";
-                reg = <1>;
+          label = "cap11xx:green:usr1";
+          reg = <1>;
         };
 
         led@2 {
-                label = "cap11xx:green:alive";
-                reg = <2>;
-                linux,default-trigger = "heartbeat";
+          label = "cap11xx:green:alive";
+          reg = <2>;
+          linux,default-trigger = "heartbeat";
         };
       };
     };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 930c70104b3f..00bd4062ebd7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -82,13 +82,13 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         touchscreen@2a {
-                compatible = "eeti,exc3000";
-                reg = <0x2a>;
-                interrupt-parent = <&gpio1>;
-                interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
-                touchscreen-size-x = <4096>;
-                touchscreen-size-y = <4096>;
-                touchscreen-inverted-x;
-                touchscreen-swapped-x-y;
+            compatible = "eeti,exc3000";
+            reg = <0x2a>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+            touchscreen-size-x = <4096>;
+            touchscreen-size-y = <4096>;
+            touchscreen-inverted-x;
+            touchscreen-swapped-x-y;
         };
     };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
index d9cb53e86512..5ef38d24d6a9 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
@@ -70,11 +70,11 @@ examples:
         #size-cells = <0>;
 
         touch@49 {
-           compatible = "ti,tsc2007";
-           reg = <0x49>;
-           interrupt-parent = <&gpio4>;
-           interrupts = <0x0 0x8>;
-           gpios = <&gpio4 0 0>;
-           ti,x-plate-ohms = <180>;
+            compatible = "ti,tsc2007";
+            reg = <0x49>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <0x0 0x8>;
+            gpios = <&gpio4 0 0>;
+            ti,x-plate-ohms = <180>;
         };
     };
-- 
2.53.0

