Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260636;
	b=19h+LYBX9tv9OP5cejixPuNRgc7gP5HBEVmruWKG1XSrYJjqMparb7oOXtFv4vk+4XE6
	 2G1G8Oa0SX7jEZK/Ko5wW5aMEWNTnA6WGo0o/hYWWxlt0h5R0bHmzbFCqZu9DaBdyvmUh
	 b1L/3/s0NRiXjld1jDuJtucVEaPd/Og+I4fF8CA777HfMxI1qvUdTvaH8YR1nderZuZYb
	 aave6X/jCXMVrnMxTm23M+iqgkLnqlVEyIHh9IvR8tK+XayJ7B+VZCXrOzmmj+6/pkkrO
	 1sO2c/mIdYJvuy8XksxJCQMztH/oqUo2NIthkAu1CYD8wpC/tM4V6vn6rrIIMPSl50A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260636;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Nc01xJh+hZtGD/0izXr4tFNrlfvugLHpJsbdxXYBeBQ=;
	b=Yz9kW+09F5tVmujf6QqyyVsQwjFlr8vRyefMDYLuAqtCXFSmiVL7MH0Zt4S8ZOy8ndeB
	 NzkJ1eXBZo74z1U3Othnsf+HoRfofOvjsWsXMBtQWVFKPlUbLyMWllydpQOsLUT/KLytR
	 Qx8rZOHf/VxdlYbk3Qfb5etTp4W5lMI3Vpg2KquG4iwjd7B7LB4JSpiV1OygePPrIht56
	 ubK9+b2m/ucZgliDWVK+YtSQpbFBu4gDqeDTVfyuyzP9jX4Axcdj77nTbLRSeCZkrrAcV
	 lWlbR4CSsTvoqNok9DxJbQGAe5DJVy1Zkz0SONpNMcmvxD/7v3o1JZMbQBem+HAgVRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GsP35Pb9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JW2PK1De;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69D606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 21:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A69D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GsP35Pb9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JW2PK1De
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LAMxw1062523
	for <linux-input@vger.kernel.org>; Mon, 9 Nov 2026 21:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Nc01xJh+hZtGD/0izXr4tFNrlfvugLHpJsb
	dxXYBeBQ=; b=GsP35Pb9rQPnjKMuQDTK1rIzniCVkkJD9lPmn52QDWiEU6x646X
	inW6HhGpFB5yRsb7GWr/NkXnKVBOieiOCF0E+tTMkG37pczIbwIvVn4NA36hhGlB
	1w0c/U4STNcMhxxJLQnZkihGWdWTBoVHzYSZmJ/fCPvKaVHv9ZOmHfQHqUMeHgvg
	iFsc8cAlkypU1NJJf2uwbY4SejN9WcqcpuDcoGLPpMSGb1kZqiqINF06RsGZufNL
	Xdv3PhXNre8FXFiLZHdGhn+cnr5IYCUpoQS85H1lnXnTTFtV1x0mNtt/Hnl6nRna
	Cc0+feMFXXj4E6uHrDacbvcLH5JF645Hfbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydja7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 21:43:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e49a1d3b1so329264685a.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794260634; x=1794865434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc01xJh+hZtGD/0izXr4tFNrlfvugLHpJsbdxXYBeBQ=;
        b=JW2PK1De0ElnxDgslw5WLiScPp4yJR2dwMNRMQc/p6TNyRzfV+JyRYchnXIdPf6MI0
         y4tPobcQQbO93Qruom18dJ/eyiBI/GnqHiAZY4d6Rg9fpUhhOM5rHS+A+8aoIYdcDSpR
         Eqf6RTF2cMi4FRAXVdamSQw7ajl6kJSEFvJ9r0vtuRM24BpM7zaiYB5n11w5CkUrs6EZ
         55YM4WpcewvXgR1STjZDyv/6MpeZHlF/31uZNBHkDud4MpumMGOysK2BVKshOjAq3XlM
         KwjHJghYzCftfrze8fKlhbG6cEaTWETfaR7GcvyBshrkXey8Jj2dsRAqDS+1dmYA/7wM
         v9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260634; x=1794865434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc01xJh+hZtGD/0izXr4tFNrlfvugLHpJsbdxXYBeBQ=;
        b=iT1coEf8l07kf5qeogN3oRr/SLkHOfw+Bq1bV72ux/2Bp+U1dAJ704FR7wgqRzqMfu
         4XIJJOvdgO8xeqAIK/DP75T+eKaw2nJ8DvQyOfqXJvIi9JlTrkNHI4s/qJPKEESl5MQt
         9I6PrZepWI3cP12mj3piMgM1hALdSdDg7nsyZJAeXxkLjOtTsXR1H/094itG6nqqUEX/
         kDOyTfXMkEtGZpk64sbnW+LMGwg/lgc9WZD83bASjJ35J0Slqco1VzhFKAshHBcRXXPR
         QgP0DyukQIzvAKvykpVO2eQRfyVg5iqBy2PZNBcLrnq6iHT9SQDAjhy49fNj2/N3Ftjq
         NnUQ==
X-Forwarded-Encrypted: i=1; AL+hErGwNLoGxFyIMfxDriz/x3WH/BdPm2eCblTcWF2vhiVtXy9bs7JjbMgrKQTkjiaxmFQfmUcyF4teKaUteg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8p6LhR1SCoW7Cwo1oiCRpA6UQUtGX93GI9Uwcy6x3ygo7jiw5n
	mCNV8tMXCCKTtWLat0f1TSydFaFQ4F+zWJcEII65ac8xNuXP7wOsT34BwEO8RmO9EaLSXWI63jG
	aayxDViCyf4jG4P0VBQowq04allqkXN3BzNfxh0KLnjTbLJ2m81nYUjYmoEESz4GZnBdwPh6+/w
	==
X-Gm-Gg: AYBFou2KxMvSlxvO8ftW8ezNZPKQ5XdgXUeJqm52vTe9ponSXIKh7roMrYRu/WPkNPI
	mc/v0WjuW/GhvBzz3FxMkC4hRwqyDQrJviaqM90c9Qe6JsXgoMzU7OB/WrQUn55Xf1CFDR06NR9
	e8FHEltajosJmOmGFZcoln8yLPf2j3nZcKY2bomgMP1m8NCeakNcFtSQvmToAwBSnCepgDarRxT
	ZgGcXbU3AwIE5VqOG0TVLTaMMABDuM9NQrO34v0+guc4BgfFLdXNoLmNoRWGMSle3o+ld6VUBc5
	kRdxO+LMl4LHh/QsWJFfqB44AsV8caJwtBvM5gi69ibmmWx5/BBb/Pun0DT0K6Lc8STAFdVmjwt
	zAWOKAvwD1j6HajkEyzC0oiODeC8s3Q1aTetjUc/23b/q+6/74Vn8RmqL2kS9OMC9XjlyVTgGjp
	7X862GUCIO/5a9s6IjhObRmi38pevOqi9mQgcVCyMzi3i+B0tDfAjz9wdZpjm7QWID
X-Received: by 2002:a05:620a:1792:b0:945:c4a8:9070 with SMTP id af79cd13be357-9479f436c0bmr135763785a.79.1794260633736;
        Mon, 09 Nov 2026 13:43:53 -0800 (PST)
X-Received: by 2002:a05:620a:1792:b0:945:c4a8:9070 with SMTP id af79cd13be357-9479f436c0bmr135759885a.79.1794260633127;
        Mon, 09 Nov 2026 13:43:53 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578ece26sm187650a12.24.2026.11.09.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:43:51 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: lenovo: suppress spurious F23 key events on ThinkPad T14s gen6/7 snapdragon
Date: Mon,  9 Nov 2026 22:43:49 +0100
Message-ID: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NiBTYWx0ZWRfX33UvOHbfFOj5
 URu0MfZKrklhri2BaJynTVJEv2ns4HVyhlbJ6aNuv2QuvJvUWrBVKxCUvZFNas7kSBzW+KM880N
 cF6waiCxWUjlDV7v6rQLG8VPHndE0Lc=
X-Proofpoint-GUID: ZXCmlhHgBxo9nCfWZMhBvblFBqIkKO17
X-Proofpoint-ORIG-GUID: ZXCmlhHgBxo9nCfWZMhBvblFBqIkKO17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NiBTYWx0ZWRfXz2GVKGPRLJeP
 lDz8rHnON8iykuR9t8k8Rc94W27xiwiis6m1ls1JWBm8xhaDiROawJlmvtjRGE3tovPOQE1oAT6
 aMSzHyWGBTzoMk9I9sV6MB7MQHsAKDG5YparY0VkYYSPK+LhElvefEaCAH3c8VCFwOKbitHEF/J
 zOUe2jed0DfBrrSxZ7sNtpOSu0LO8OMUctrrfCmIAzy4N6gUpRKQ1UuLWyw1JG/siX+rTZideog
 pjw1CtMGx87ORDyBjo9nrPhfBOWL6ZYmwropmCEbTyCsVFW0rnyrA3gQ9fEMaGW3hUC/1eUbhDW
 IDLsfQXu/de11tlAyJPhELOjE9w2YB3/F1bZJEjuUmX6RC+5uJoqdO4Z73/P684Hbmu96buOnHt
 67q6pxVq1iNsCQbBHd2ZtjS43Zmx++1PR2kzffJo5n2byTk8z+85ZkoWqS96Ji9AxF4Gc+aIj3A
 hWsfvaue0GA0fct0dCw==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af23e9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=JjNtYa3MvX-IvphGLQYA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090086

The Lenovo ThinkPad T14s gen6/7 snapdragon version I2C-HID keyboard sends
spurirous F23 key-events when the Fn key is pressed/released. Leading to
e.g. garbage ESC-sequences in the terminal when doing FN key combos.

A hwdb entry was added to map these to KEY_UNKNOWN [1], but this also maps
the F23 part of the left-meta + left-shift + F23 combo send by the co-pilot
key to KEY_UNKNOWN making that key unusable.

Add a raw_event filter which removes any 0x72 codes from the 6 scancodes
reported in the standard HID keyboard boot protocol report, but only when
the report's modifier byte is not 0x0a to preserve the F23 press event
when the co-pilot key is pressed.

Link: https://github.com/systemd/systemd/pull/44733 [1]
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/hid/hid-ids.h    |  1 +
 drivers/hid/hid-lenovo.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 994e8bc69924..70d18d32fe3c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -473,6 +473,7 @@
 #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
 
 #define USB_VENDOR_ID_ELAN		0x04f3
+#define I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD	0x000d
 #define USB_DEVICE_ID_SB974D            0x0400
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 30bd3f794243..e997d0cf2672 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -812,6 +812,22 @@ static int lenovo_raw_event(struct hid_device *hdev,
 		      size >= 4 && report->id == 0x03))
 		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
 
+	/*
+	 * Lenovo ThinkPad T14s gen6/7 snapdragon version filter out spurious
+	 * F23 events when Fn key is pressed. F23 cannot be unmapped because of
+	 * the copilot key sending left-meta + left-shift + F23. Filter report 8
+	 * (keyboard) scancode 0x72 (F23) when the modifier byte is not 0x0a.
+	 */
+	if (unlikely(hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD &&
+		     size == 9 && data[0] == 8 && data[1] != 0x0a)) {
+		for (int i = 3; i < 9; i++)
+			if (data[i] == 0x72) {
+				memmove(&data[i], &data[i + 1], 8 - i);
+				data[8] = 0;
+				break;
+			}
+	}
+
 	return 0;
 }
 
@@ -1393,6 +1409,10 @@ static int lenovo_probe(struct hid_device *hdev,
 {
 	int ret;
 
+	/* Make the T14s  keyboard trackpoint a separate input-device */
+	if (hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD)
+		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "hid_parse failed\n");
@@ -1558,6 +1578,7 @@ static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TP10UBKBD) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD) },
 	/*
 	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to the keyboard
 	 * part, while letting hid-multitouch.c handle the touchpad and trackpoint.
-- 
2.56.0

