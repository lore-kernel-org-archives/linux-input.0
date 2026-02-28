Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740643D51C
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290383; cv=none; b=f6ENYH78mpHjQPfFJoholejEx/nVp2HLaBevlLRP7ejypSs4QbSH29+ugRhJytwONqFUKmxgbrKKaiDgJcPLMcCyD2VlAMgu3ZZo0KS9f+KG8IZJTSGaA6ilzD2OJ2LPfBmjRGvKL0EfPHdbMykxrgPjc6OHqThBvf1g6phFmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290383; c=relaxed/simple;
	bh=wbeIB3pdgo6b2hpUgQ/mtXe5nBmAGyugtp16gz1s5c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYY+zPCHT03BX1VY+2qwv9CE7K97y1eoR6udNpV4T71YzkCUxn3E6T84Ks69J2h5pUjB8gTfsLTW7mG0cYUaV3gBsJehGenHAbbRbtjfW+Zhy7Ij/eyeiyQ8+p9X4CmZtgaA/NM2SIZuqhdJuhlgml6Tjjt4BzWKQYvF4Vi+7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTdo3BnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DVnF5rKe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTdo3BnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DVnF5rKe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SEO5C22733073
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sQoIGifsm7dUD98qeNz+ggbZLsrODU/8H5X
	eiRtpxrI=; b=NTdo3BnQ49gR0z2ke+diJb/+LQTdKNG1c7XYwnTUDl+PwKsNa+E
	AWPYrG+DwPsCiL71JI38mWltieFwVA9SsPikSFNeUbjR5Q8+9qXbAC+//tc+icO+
	ehlrwusKlz0DTiuZPMFhP4GcIkRlSbId1aSB572e5LkILiver2EEo8Jz4Pzhgzd7
	q78zwA9GZUaqp4gWWLpM4Jq8HirBtVRnrgK6baBHH4WCkd7H7aY3uEMTduxIxI3D
	CUvCmX5s8FGGMd7vSJ2Fq2j9C55rbrcGJfhslbuTwzJmoQCA8cBMlTKPrTSaIAeW
	+EsCnepg5jmBDkINUWWQUjcVXuv6lxd+i2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgrs3pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4a241582so2141978985a.0
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772290381; x=1772895181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQoIGifsm7dUD98qeNz+ggbZLsrODU/8H5XeiRtpxrI=;
        b=DVnF5rKe2tqivXuSg5W/R6F2zd0nHa7XPhu30glSJp5jf5g+VBkufgOInyZbCNd/hb
         8NgOZgb3jv/SDFaPEq0+tXzkkti5DE3T/+x4ZPxGEcXmi8nIKbBV+nGnFerl+8Y7pySv
         MvmFJOFNewk41AOusq3x6ApjRF0HPXZL6OKc4PO9iD4ta6vNM8yrT+aXNW/E1IZDG8aj
         40ETUHKymCW14sbL6YztJexYqasbiHuCFhgZs+qgwi/h8ny+no/XnZ1QuGRA8yKEHFfi
         2duBaqb7skwR0whmFLtBVbq5C9Fa+JUsfYKckO9kFoYDHUfAn3MG7ORWbZrWyozpur9e
         FoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290381; x=1772895181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQoIGifsm7dUD98qeNz+ggbZLsrODU/8H5XeiRtpxrI=;
        b=kA5cLfbEEEisFjGQHDCvVWObw6VBqKO6pkB0aClwqzQecuBiR8/uIxwsWiEZlx0i2h
         u0w+d77HD3m53tRIPf0tUIMjZQeCLXM9Bx+eTAccq3ZTDGp+DXFrF1NN9xV1OcjtL6g3
         oM1+yczBDxdXoeIRKIEkIHMYqrXO57uq9t44eI3SAlKViFl3qR/8lo7CQkwLIeHzpZdC
         5/3NKb/CzcPS8XMFsGdogbCv2Hl4E+sulDmyr8Csdk0k8q2uo344JIk39mvRDsaNV90J
         kGyI35Lmpzwbgjn/9kDZ4N7X2L99aZ2jTxnKwL17i0LQGRmyjCIScNr2JiDNHs2HdruW
         GCLw==
X-Forwarded-Encrypted: i=1; AJvYcCWsSMCXYcvbnmJpTKeHCGdP7MtCGFfpWJ0F6D2qfPeYPYjB6p7v5Xrjm+pEERIiXOi2zim1EFsBXHtK/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtBYeP4HcXN0LjXVYe8YiRtLcrNTel8Vp2od6REOypTTqoNw6
	YfRrVpRIQ2XNWX0PXYGszaMWMPmxmOQcY3UiWuL7lMKK1GtZ8jfeW13VXp/D2TV6iYiVzkwjQUT
	EumaP0DtMB+0zc26S6QH7WrN8ldIFIxpEjV761YlHdxRQVmnoroPgh/ufyKiVZSxThA==
X-Gm-Gg: ATEYQzz7D1hvEvdD223l//TxFJfkXf92GQfi4oroGgeVSkYMlfU/m+qNyQbtjkExUI3
	A4pS++Z8MC5OemA8oy1XlUSY73IYD+H8FgFwJayXkWuJoaQh1r6RlwXHRCHY8MJKoDGVlibhEfI
	QYEfL5uyKe99SqE5xIIgE8zCjQ/ettOiaf2yZQ/wIGKa08NWb7gy1zR8Duenyss9aeR9h6urb4i
	lMbSjJg75BVv8lyn7Hm2mbByGZJqdQjI1ibJD4AeyV/GboJZSJAfNN+iQUaHWQxB2yqCq/d2oBY
	JN5kOy2cQDjEouBYoSYu/MGC/NcFO11vfW7YJCt6gtpE3V2Fqpvb59Zx8zbjIMlEkoHZSXTFqLN
	HkDqTZo2H8NSDCwpVbCtmq8cCpQSpnLKIVurj72b5yZejJMUGsg4tvyCU3g7WV0lrSabDnffkUy
	P4ghLzc7nwz0pPhxrrIpFh9pbs7RGhQpqKuMmB
X-Received: by 2002:a05:620a:d8d:b0:8cb:2b04:85fa with SMTP id af79cd13be357-8cbc8d70f11mr814276485a.13.1772290380593;
        Sat, 28 Feb 2026 06:53:00 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8cb:2b04:85fa with SMTP id af79cd13be357-8cbc8d70f11mr814274385a.13.1772290380107;
        Sat, 28 Feb 2026 06:53:00 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac546ddsm251565266b.20.2026.02.28.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 06:52:59 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 1/2] HID: input: Drop Asus UX550* touchscreen ignore battery quirks
Date: Sat, 28 Feb 2026 15:52:57 +0100
Message-ID: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDEzNiBTYWx0ZWRfX9rxV5J0ReSLT
 i9tG5JVOftmvpfzAHXq+j7tF04308NbTzaYAi0vfqTycayL7CLvOxe8FT1bUEtKxSqj+85yrq7P
 XfETkml5PqodrfCqB2FwurybLkiG0PgYyxd2uz64PFMNJwHqNaxMs99quumrIl/zm+YTrgjnLOG
 0mIekJdBQzovYvWCZGaHLkI/H8Bt7GxBHx7W8Ln0/HQ3DBY/132NW718b9rOXE62BwzXGGTLO5N
 vp5g90Cno2+YKMO7FSG0/HFbc9stxgrsA62cfA1BILrV5yhQDJZkycVsuI4JxdN6zDfgoeJMJMZ
 yOM8ienu3y462/z+j/Xz1oTS1I/oM36Q66DFCRgL6eP9hwmgy9J2CGHg3cMgg/9V0EHRWmknUBb
 lK4pD5fXRGjKXz1I2w1VOswjHlr7XGvJboxBVaE37o4WVv471+wBoTSLkwsH9wRfKYsZzJEKE/2
 p+zThPS4odnNynnUXZQ==
X-Proofpoint-GUID: 0MJATEMQIL3dBTJaebhX7yKA--yVpejz
X-Proofpoint-ORIG-GUID: 0MJATEMQIL3dBTJaebhX7yKA--yVpejz
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=69a3014d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=ckRe6vLlIY_Jwn_eP0UA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280136

Drop the Asus UX550* touchscreen ignore battery quirks, there is a blanket
HID_BATTERY_QUIRK_IGNORE for all USB_VENDOR_ID_ELAN USB touchscreens now,
so these are just a duplicate of those.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/hid/hid-ids.h   | 2 --
 drivers/hid/hid-input.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9c2bf584d9f6..fa728b4153fb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -446,8 +446,6 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
-#define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
-#define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
 
 #define USB_VENDOR_ID_ELECOM		0x056e
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2633fcd8f910..67ca1e88ce13 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -386,10 +386,6 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
 	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
-- 
2.52.0

