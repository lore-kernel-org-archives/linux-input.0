Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7E37DE85
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479766; cv=none; b=mJd8UqpclQ41++MXcjK8o/mbPumhDhsVmnk3sAV2N2u8TRu92TkmXZqFwh3q3Y7NMxKQG51SXBR+nN6CynDTQhBjTNzlHnuBXJynf9cxz5tDNn3gV+ygSKYGMQWTb5Pyq0Xfayb3c/6ZkxYVbwjWOrLf935s1p11fu/fF014L2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479766; c=relaxed/simple;
	bh=xohVw7WqqrOOFSZP7YKJSgmiB3NaZ1IirzBIZ89DlB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHIOhKXrI/i3JroH2xAVhUE3h/wE2cYGADY5iSuTHITgOC67DRoFpiWOK8UKIP2l79nxP8NHCH+ypYR87EO8FYyONr//gQtsqGjct6DKjrNOYhEVxtT92psBSgC7jnioe7v7aoZolxOXUCsQl7UweF6m6YaNG5dXos8dKXJMjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MiUUr/OA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W3kQk+ko; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MiUUr/OA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W3kQk+ko"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MDpVJF2125149
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 19:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+C+Bsa59xkFVu9xkLSE2hBWtbA2batft1uO2tNDaWbs=; b=MiUUr/OALWs4OXuO
	hjI6P+X3H9h/PFFEl1TA++mdfKDEewgX2Ni5d7YOLOhYwtgAa1EqaKgXrEPFCWOq
	wQilzonc4cuq1J7SH0ldXAkijnaN8nP8WppjulimEz9Mend0+7K7Lv576oP0hDCr
	LDv359dxstzvTj0y/+X6YVSbRhntQhdICLzO9hfSf+3xEHbG3c41WYkhLYmoUYX4
	9HQudYnlLxc+USsLYlR1vXCZfnqIsEHo4XT6sl3GST6SfzyneplUQxa7SLqdAM2+
	DMatdIVZdFFIuMzz1mK8f8CI38HzuM3e13d9IaB207h4r258XMGVqVHYLHvzqQVk
	e4St1A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eard89fjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 19:56:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso75666215ad.3
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779479763; x=1780084563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+C+Bsa59xkFVu9xkLSE2hBWtbA2batft1uO2tNDaWbs=;
        b=W3kQk+ko1G1KH1IJQfybSgHsidgBQNA8nI0gh3u7vup6+JkHw9jKbKYozbeQfkFfe5
         FNqe4i1ldm+ysx3RH1cy8R/+Mm7oaeFtk22Nex0y+ifYMJ0AFTdgiFnCCrD2pG7i1C84
         MGAytM5YaJ9d9IGzPmvdzo9mUMf0taOBmTKdXYeGdlPl5wkeffuZ3/7GV4qS3N7n0zd+
         YUz8CCtZME2X7Lr+AQsfIU1gWuxC/UnqSCWQDIupKwWjh9dH9etfxLRH+sGI/jLZlrk8
         Bm1AOTrlHnX4I+stmI1n182ME8GfEgYbqTWmeZhj1iS2f90dkxjYqNjal7KLfRaDLwwC
         r5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779479763; x=1780084563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+C+Bsa59xkFVu9xkLSE2hBWtbA2batft1uO2tNDaWbs=;
        b=ThUTkxPnNSvRYPqQzVn47DgUrJmcEBMOG28VPD/GzZn7T/ZsVKZO+JulHfNNPVNmJS
         PeAGaS1MPju+sGzPtNLrwwDSWw9RtKDvvs8Hb8YSE9PD5YmrhemJN0oux/fZDWPJwvDe
         ZXkM/xzx//dvkL4rwzEYGhS9ItUjNSikK3XudB7sJlCE5WIgThai8zJ8YytE62kSMBFe
         6hJlN1cDVIE2Y6vGX4ZAS//SWdtlOqoSZhysAttZ5fC6OkZGa0hvpBFOnTju0U5/BH2D
         vgPSDdDkOPLgp60MjRjT1PUMDS0EqgT2nD3mNF/zUgTq8se0BwXHnaIMN5CrgT3dQIDW
         TGAQ==
X-Forwarded-Encrypted: i=1; AFNElJ++YEVQbDGhxvAOV787ZkE56RHLIVZlkSSQiWa1RMq28rInJW2XUaZsGGH3KC7cyRdm75cSLK6N12SmHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7AAAw/3gS6FnVE1Ia4YLcjTpItZpoD94Dz/W450bEthNP00P
	o0MohFBRYrQZbElye84g/kWYybiwGL3cRPt86TEn5+QEsAZjNzqlqIdCYI5n3NZqCsJp1DhWiE8
	ljXB9i5WSvohRVdLCEYm8v2YrusXWZktDhE+rkPePz+GUrXywS0ihsO/pIXjcKcYyAA==
X-Gm-Gg: Acq92OEsM+jLNAwHIHBREJDg6FY/N18LjQKVoCX0wMDEVSjvfGXHWlPNiD8HW2MLSmA
	3CFoEsGdAySiRXU91pnJv0seB2pVJQTb1OnA3HYjdOhmPn7esFxZby8qLR7UII9UwsFVgWcH0FZ
	OGnCYNYXTah2ZpDBw0JBm4dqcQV0btO7DQx5W6vNrxD0IloI0djI4yELMXYT81y16BmpyIFBx+D
	/jq6dyP4mKC/ghMJzMJX5mYSNNbTKjOPZUo0rUEDDOkCN2N97OkeQjVCZjWCp7BH7gmo4OjQi/s
	qzF1coZg/u7aEWYdjDKOteUwWnLxOoexpd1H1IqVZemx5rKQWSNjfFzbrorWHIDMkhQApJx+6e2
	+RC5+HnXd7jrBBvXTkhdG8I9LtYqfXTvzQRr2mQ==
X-Received: by 2002:a17:903:8c8:b0:2bd:8395:feca with SMTP id d9443c01a7336-2beb067455cmr53984465ad.23.1779479763520;
        Fri, 22 May 2026 12:56:03 -0700 (PDT)
X-Received: by 2002:a17:903:8c8:b0:2bd:8395:feca with SMTP id d9443c01a7336-2beb067455cmr53984165ad.23.1779479763007;
        Fri, 22 May 2026 12:56:03 -0700 (PDT)
Received: from [10.213.96.151] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5914287sm33389355ad.79.2026.05.22.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 12:56:02 -0700 (PDT)
From: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Date: Sat, 23 May 2026 01:25:37 +0530
Subject: [PATCH v2 1/2] dt-bindings: input: hid-over-i2c: Add reset-gpios
 property
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-1-5c333051e5bb@oss.qualcomm.com>
References: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-0-5c333051e5bb@oss.qualcomm.com>
In-Reply-To: <20260523-arm64-dts-glymur-crd-add-reset-gpio-to-touchscreen-v2-0-5c333051e5bb@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        20260519-glymur-mahua-common-nodes-v2-1-9f1b89a3f398@oss.qualcomm.com,
        Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779479752; l=956;
 i=pradyot.nayak@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=xohVw7WqqrOOFSZP7YKJSgmiB3NaZ1IirzBIZ89DlB0=;
 b=y/GGlI0SWnPsoGz7xcS5FgDUZtghMO0rS3iCgRwi9o4ZbxViOwnjuEu8Y6EuSZsqs//lRr2+u
 xnSIUax5iwTCuPgmDuVxvPUGEMGC45tMkXFiTRLId0fWTGA3rxkuu2D
X-Developer-Key: i=pradyot.nayak@oss.qualcomm.com; a=ed25519;
 pk=ZAwwH8thDSb6bq4dCgFHWr80BqB7MmUAKogkd9BsiXM=
X-Authority-Analysis: v=2.4 cv=Fus1OWrq c=1 sm=1 tr=0 ts=6a10b4d4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=V4nsfvEclF_xFOw8guMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: mr6GEm7lcquao6CCR-4D4BChzHW1pwPM
X-Proofpoint-GUID: mr6GEm7lcquao6CCR-4D4BChzHW1pwPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE5OCBTYWx0ZWRfX7y51e2uSZRqm
 A0AmOQBNWGkC+LVwWLUBw8ZtmFsZqwdoBb/qLRHuiPAPa3mintgqaA/gNwukNQzxbhpDHku7mVm
 Beh/vGPqyCwQdWK4+AfCD5DksuuoWz9XrKmUD3ApuuxwDg2v7dSBhAIT+GRFdxH9FJiWHmL2qU6
 dlmLyqyxFZSrJjvNzMzQkMQdZlMy0me5q+9ld8+T4bvnZ3Kvn5Ha0nrTlFUKyAtGogd0ervD6dY
 sTVTZt8emLIjsVxsYG315ng8k3C6m9lYMyBLQy7JzlH1fSIs1V4tFk3BB88xPTSCkM1SpUQCRMP
 O3T31f86aKuYuA5IntNMjQ6f3viKV9zBUk7ozfRMQoktwehrR8hRgjdpQcvI79paUuVxkqULNTj
 BSDIqTLy5FU1/dn2gqZFx9gKJ4f1FUxIeZ911DBadm4nMLW9go9NSnqTTrgr10YkPWwSsWt8LTC
 q8r9fkACpoGJKVWDHcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220198

Document reset-gpios property for devices that explicitly require
the reset line to be de-asserted during power up.

Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
index 138caad96a29..fe0ec4fce673 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
@@ -50,6 +50,10 @@ properties:
     description: Time required by the device after enabling its regulators
       or powering it on, before it is ready for communication.
 
+  reset-gpios:
+    maxItems: 1
+    description: GPIO line used to reset the device.
+
   touchscreen-inverted-x: true
 
   touchscreen-inverted-y: true

-- 
2.43.0

