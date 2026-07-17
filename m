Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA83BCD3E
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273363; cv=none; b=jiV9QncNznhJeSqx7xVid5ow8wph4DCfrAb5+iJCmj32FVe8fOv4bLdingVwL8Ky+Xi4/qpZxTM5SmOU2B8EaA+GftSaArSBuD+GIp1b6GO60b1scgBNjGyXbnLd6iEp9uj/niRuPq8JLLhr49KqWh5isruo71e2CLW40txhiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273363; c=relaxed/simple;
	bh=Ys197YC3XOD9CnVoetaGWg4eqH96ao9lELwA5QMf5CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTpVpEUWCd3wnb6ov8ER3Eia4S0Rrn0YEBtQfD6vedH5vs4Lg6ndUZwUvJdIvsN+2CrUDFKX3OcBR3DN3ytYmoIcCA1YM0iDSZSgXFjp/lNP2VMP1/a74Z7UUHe/XzVciQjYgJwzxk1cnk761J/H6psvtw+DRIhLvkQEuXU5tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrQurFQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KBuptXT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrQurFQ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KBuptXT6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cguK1078372
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jPg7wDJPn0dLENWw36JR9/8Qv11GyQ72iD0SDfmmmZ0=; b=BrQurFQ/gy+V65UN
	97cpB6n77PboqFX79tDf2BNfB5U64o442NoHkiZbI0g6uiQnPGeP13RE32WM7lQJ
	nJICXmp2YPLxQJZa7/XbMeQ0+uM+yFYdhrJeZdfooL+n8mn5v7n3CCTlDy+zDLh/
	/P4FukMMeLZvD4YW+QrKBLfBKCQfZPzlMeFR3SZl3qgmsksG4dTJC7pqISzX+pp5
	z9l9UwwO8r/vIsV3eu5Cm/4FKJ4+zEPUAMeWcRpgZcPB9J4c/IuAAo4loqwJ8vbQ
	qD4erNjJH8xARh6wGOj5jIyryTneBlZdm45wIQD0oGJCKzbOGvcvypHH7GEuCLnw
	rvI8hQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1by74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 07:29:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e095fd889so8415966a91.2
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784273347; x=1784878147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPg7wDJPn0dLENWw36JR9/8Qv11GyQ72iD0SDfmmmZ0=;
        b=KBuptXT6EygyIqVs3Z8Ql3qPLJYsvfEpHcMsBiPHDfESTW1WtkV9Ea6U1huaMVfoFg
         ZyZVeStbyY55msxNW/Ti4KerUS0eXP0ha9x8G6s2hQTcrQz+hd1RRiVYB53iVRFIvFpP
         n40ziscs/EUd1MHuQHI7MUJcQAmqQ2HVeg1d3/KpoZ297ks+Gxc8pcAJBoEpx8mqQcDv
         8K0D3uiJicDSb1FnStkNLG3w7JZgYMSxPDtBwTFi09otXy67ntxZt+qKiFhroq+bUIOV
         5C9comW5zTojoV8ymkMBgDkwPqHzj5Z2Tf2sFujZ+0sWvVKV3uN+lCb+D6hxgldRXCld
         59uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273347; x=1784878147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPg7wDJPn0dLENWw36JR9/8Qv11GyQ72iD0SDfmmmZ0=;
        b=iTyAgVmZZRIGd8YWEdoy9piAE4dw99Zcapbt1bKlJ2g2yyksNujh3ukBrfTr2b8VHP
         JNE1v3I7XWQryLJdHoVlRrZPfc0uijhdN7QD3oNy2H8pT5DaYolesc2NZ/00ocv8BKmP
         ZGxEeg1HqfBHKad/MBJT/Rw9nZyO2RonHnIqDp2tB5CR9wX/cSzcCPNzfrMH1tKXSYC5
         vM21z/h0L3w6ufpccq/MxoXyRKIztHZ0TYCOLa5psn9n8Ks5lXjVUl1fwACncxK1ABqR
         +uo4a/BAj9b1tKZSYgkTSg5FY6sJCpQVZyfwaJzYuH9EuuZRBFL7GAF+kk3Y03CK1qeU
         YB4A==
X-Forwarded-Encrypted: i=1; AHgh+Rpxh8STv/9fsVhWeMNL7z96wkEYICDFvQPtmVAFb1FVQSheE0Xv/8fwQUZtkyBme7JvCvPaUdJUwz2UBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFQ/wVpRLK+bvRcAUPfsBNSUN/+Oxf6j82mRLmrl/E90BNLiL
	iLIRAQN6C8lz9u3sHS5aEuBHEXEAR9rPf4amJz50vXH+Lr0lbkIW4+hVCzOyUCzcMsCAH2lRtPY
	m03/xMSP/+StobR6t++IJL11Q//9sBlHJvMacVsTgkAwuY8laRM3VGShvLP+w56jOuw==
X-Gm-Gg: AfdE7cm1jvOj/TMmX3Fu3tLg6jnvSnM1UVBDZ9AQts6kj+hyxSmK4ndgs3bByiRTAy5
	OJHrxgZCj+BT4wLgrTujyDaVlgom7esO13zJLjFwxGJEXGGYtYLzHIM6KK6sHrYUHQnON1vzfgJ
	5ShK99TZFrn1uMVFGUJB8u0ck3bnAytnDyQIiUS/LLgxOZKSropiM0WGpz5TtQPw313pPfZIJG1
	PGybO0uHQN98oxKXyj9FyUC8e66/K4Md79FBmDUohQxRhPS24esV6TK7LBSvmvhLiQGTzZycOY4
	NjzIDBBROl1jI16nzl0JACxan4iqiny348U0xO6A6cYf0zkhEOPMfgxY1LnorJrtbQyg6yOCZTR
	DFIjlehcCOk53jegmHygOdJ0ha1J5TqwJq6q7D4b4W61oTfEIHDbL
X-Received: by 2002:a17:90b:582f:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-38e4b5f9bbbmr1434707a91.42.1784273346859;
        Fri, 17 Jul 2026 00:29:06 -0700 (PDT)
X-Received: by 2002:a17:90b:582f:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-38e4b5f9bbbmr1434679a91.42.1784273346457;
        Fri, 17 Jul 2026 00:29:06 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da071sm5724065ad.47.2026.07.17.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:29:06 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 00:29:00 -0700
Subject: [PATCH v4 2/3] dt-bindings: mfd: qcom,spmi-pmic: Document haptics
 device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-qcom-spmi-haptics-v4-2-b0fe0ed30849@oss.qualcomm.com>
References: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
In-Reply-To: <20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com>
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
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784273341; l=964;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=Ys197YC3XOD9CnVoetaGWg4eqH96ao9lELwA5QMf5CA=;
 b=cXBU3K268G67pLiiWZQEM99iACL5l9Dw3dfn/rTlzktErJv1I8FMLcmb/LJlyILzIKL5PN0h3
 8GbwJnxAEemCYpJeNcHrFrXQFn5pf1CHT/Dy5qjpddVr8j8tEz5MWXz
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a59d9c3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GfP_bOASi7LDpkAm3wIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3MyBTYWx0ZWRfX8l/HSC/PXGuP
 wYOa8FcLsN3uwSHxHD9532YxhbXhrB1k8Bn5KMUbGrfHHQH7l0eCe/ld7IRO76w64slyj4u+tZ9
 x6ZBPe6aqamj/cgnoo9VQRw6qNpaA7D9I60LdNUQBCuAHzIuCrQGL9QgqQOk2rbYHQGU12QUj+Z
 bHWdCdzvdlkXDCFNyCJ2USVG+bKErhwXwEnrGJQBtwnEWQyVPcfpoZbQEc81YeUbOYI5S8bFAzy
 x2mPulEcN9gwCmC0p+EoVBNT9tJNiDi3QqwPX8eZvnqfmI0uN6/rJToKcz8A4b/ORGE5zRC7vdz
 GiKGEtUZPK80/F2JKuPonVz3kMysMp/YUUs039kfoVe2lSt7FoRaOZNSPf4zy6x3INBobFIuCm+
 nU3+luZTc6Sw/SDLVlmeYy4Wvg80kkZdg0f2XJ1zUxaODA4E5D82kX0i73SQ3HV0jg5RtQcd0vV
 XtLoOK+qoPmkcAtuiuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3MyBTYWx0ZWRfXzTr016efLdcq
 GpITZwLV3Fbzy/a1KyDhXWY+3X8+Weo07mHps0Rs4HNM09XPxsMPfgPgwJ8FiRgcawzfawmgqGl
 fhc9zf9+J8S7dpXpmZC69q3sDP3g5hw=
X-Proofpoint-GUID: jfJqmTJ6xTLEx5-3BAVnlR7P0cfzG7LK
X-Proofpoint-ORIG-GUID: jfJqmTJ6xTLEx5-3BAVnlR7P0cfzG7LK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170073

Some of the Qualcomm SPMI PMIC has haptics device in it, add it in the
device list.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 644c42b5e2e5..773f4cba5935 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -165,6 +165,10 @@ patternProperties:
     type: object
     $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
 
+  "^haptics@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/qcom,spmi-haptics.yaml#
+
   "^led-controller@[0-9a-f]+$":
     type: object
     $ref: /schemas/leds/qcom,spmi-flash-led.yaml#

-- 
2.43.0

