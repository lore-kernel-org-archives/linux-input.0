Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA3449EDD
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290384; cv=none; b=CzURTze8qA5CRnsnx2ixLjawQdYGUBlRJJTtVWpOAp2hA0wJzMsJXb7Xn8nzt80YMm4UXPD0tU48LNKv65Z2lGc9QGcWdJRSzFHgEJxLuoVuoGspP/gyJJoPlJlTi8/+tZ1+KQWxIZTO5+651D2pWxmpbE8JG9SCeTPvi4U0Y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290384; c=relaxed/simple;
	bh=X1mWGwUy6qKqqt9FcezumQZdtjIPQRiYoEzWN+saXqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4Rii67FAX1Pactj5XRkXr3cGL+z/iwvc1YJTWgbN9V2v3HXcYGaqxrZLVLTOeP6gB9b2VGUc8a/E8Htx9tu/0qTw05fI5GDgURLhLFC4cewcFsglPOsoiJrmcq8qBGF6dV1PQK7Y7BE9P7g5D+RiNDe9q7DUfb7/7+iF18dvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDOvXOhR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LU2zBLYX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDOvXOhR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LU2zBLYX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SER8rs4082147
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GaxTGDgN/dK
	LPw0BIu5euITm3jdWsk4KcBj+mv4YJvQ=; b=pDOvXOhRbczOARTc/sg5BqlbttY
	JMmpJfyZolQiCatN+hr8ckCE4+7ZcVFLABW9xKPHctwZem5NX0iH40f8wzHiqaRB
	rU31/uCLoLRprE1H2aQU2ZUNQzMGZheipID2lPQBweomFvx3l4/fM1InP7WkC/wB
	VOg88NwfqxtdtCKcSg1wTOW/bl3nei/R/RVv79hBETn6nYxkGUXd8DIKhZGCXJBU
	1aIpIhU/cbLWqlS44x2KZilfX2pzWSBXDsv4RkJhLi6vV7hG9Cv4sHsYZvbsHqLk
	DuYt86ZPm9s3hpZCxbJpx4HYFycohf893taRXGB/Ya5sp4M2nuR/S9l2gWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshch4qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:53:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50620483ff6so326289461cf.0
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772290382; x=1772895182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaxTGDgN/dKLPw0BIu5euITm3jdWsk4KcBj+mv4YJvQ=;
        b=LU2zBLYXr+MfzqjFCweU+C5ypNNq/QFYibVNxFzGA4CB8CiJu9KckKgL4vdQJCcmJ9
         d3buQ5rdjaiIoxG7BHX4gFlNKYyr/WU0xHyfZtGdhSU/3Ye1IXoHX7iF7hijr8M1ulCo
         eJSovDxi8+k2jy7A5urLcDjvn5HsSCwDKAP1g3MFQMIoLtQ/hIq8aDPoktZ8hant3AT8
         8c3qQcF3g1uA10XJjvCoGPP+W4NGr39GTz4/qlM2yxQZj6x3+mlIGlAPkO7vYNhp47vT
         EuG7xM1HoXYRsW0pb/y3K2FsSf55jG9qaMW3OsTBpM6eyylbDd4xtQZGHYIiDFgpkzVU
         P65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290382; x=1772895182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaxTGDgN/dKLPw0BIu5euITm3jdWsk4KcBj+mv4YJvQ=;
        b=OEIN8nhtp+IkVmuG2NrdHHuaRkkT9a8UAXp4OBnRfgy+3ScNHybN2wveOv6B6AJyRZ
         mpuAuSks9OANeAk/TTU5PIahCQt7jcBX+hyP9temHygzIji7jP9Mmlxw94XcTXEYY+vV
         7Y5kuJkjPwXGMu884BFWTg5l3uL468590m1tBt9rM0sopUHa9AaZVGiMmGgjaf9YFDn3
         P+CRGRiHSrkpRL9wZhzQWSrq8o/FfPnaXlc5qSpyuzkU7RcmaNhWExkQkCWP18Njkrd9
         J61jWG0FfAM5CPtnty33Q5+9p+Jm2rnRW+Y68PWiEf+M6b021bwejOeOtFqLy9gA20CB
         wOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+9rh1n1WfSGnZ2Ab0uydAcQloIoeNSzLCBQSRfHC6CIvf5zcCgQA7yEpO36ezjVA1rF+95U5PM9EylA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oBnarEeOsb55Jpy1uPWyTv6tcBL+RlyjXXhUtDPnr58tHOQM
	KsNWOx85F6Jnp1crgs6VtQyKEnHAhI/ugTut8f/DGEt4FZRbK82MejWxBkzeDQZSn71oRzPg3yY
	s+hHg6590tl3SKzo0Z2RWZSIOCxkhqri7vIvFWwiQ73+qXYQ6reX8ORMUykQv7UQPwQ==
X-Gm-Gg: ATEYQzywOee0rpmhAIMHMBbTPDlYrqeeN2E2317PZ/OfFnpaH/0WdgKDQKuHCSKcBmc
	2yfgeTVpOOQuukwgRhgeql8PJj9f1+CItS0zmyjkMNHf81RuidDGh76nqM9dk0YWqDqGJNjerrY
	8l6kZeuxoppyGLqpLkBifTau+v2yZyLR6BQS+GtJPvehcv8Y+Pnd4qX0wSopF21LlfS5RiGyCQj
	8LNdi5nObcu5fvV7s1TanCynoXqKfDfzH1Qci4bIwWysuPoEkEVzE/GP9/h0+LBQVuWHp3CBxq4
	zgFn3mpZ+j8BloGVN4E96c0qNRHbpntexEtKRIFhvbTMgRdBKfBBAynYLF5a0kaajdU12Ma1S0s
	YW5U0QNuVbiXjouJYdQB+tInl7PfdWH63Fvz0m2XgO1n+2O3hR5t2JGIyuqdwVthb/wlcKPHTZN
	Mom2vuZsGehQqsHJt2bM9mDDh8QstftITCuH7a
X-Received: by 2002:a05:620a:2697:b0:8cb:51e7:411a with SMTP id af79cd13be357-8cbc8d99933mr733546985a.25.1772290381631;
        Sat, 28 Feb 2026 06:53:01 -0800 (PST)
X-Received: by 2002:a05:620a:2697:b0:8cb:51e7:411a with SMTP id af79cd13be357-8cbc8d99933mr733545185a.25.1772290381190;
        Sat, 28 Feb 2026 06:53:01 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac546ddsm251565266b.20.2026.02.28.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 06:53:00 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, ggrundik@gmail.com
Subject: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan touchscreens
Date: Sat, 28 Feb 2026 15:52:58 +0100
Message-ID: <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UV3dyH5vAdXylFE9-0Mg15rZrk7E97PX
X-Proofpoint-GUID: UV3dyH5vAdXylFE9-0Mg15rZrk7E97PX
X-Authority-Analysis: v=2.4 cv=SO9PlevH c=1 sm=1 tr=0 ts=69a3014e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=gKYHfd5YTm89fcavpN0A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDEzNiBTYWx0ZWRfX29MLTLBTkiOD
 ioZkr6VTrsy45pSGbhm86borxGrfasXmDjh2XOko8KWA1eIvmLwKxuujG0P71iWdEGkIFUR8Tn1
 tw/1t7g/BLmL1rCpHAq5N+kNxEtwUawb7Dzz5QKfF0x2fGLvii1KjcNeZ4tAZoMX3K0egtzdHgr
 CWlwVirFZYhI6GNNWCrzK9KOgM6j5893DKTQupEHyKjpDyBY9mKVV3D6D8i3eoWmrM5GVPw8HHS
 WVOq6IcBxzxG0AI3a8h0MhVgUap4jr/ywS9mmTooPrbxQUJbIHk4EH7WIRu/X3sJevDBSR4BeXO
 z7uSSR7VJq0/6/KhByCbt83wB+/q4TYrwywocIwfzJhWkbmbsMQ/fZiKBzeUoZh+641z8UwS2bV
 N5weegh6ehPtPl84ZISIM5v1AgBWJRLcKdMQewWvGIUougdYtii+bgZ15sqT20kKjtW4FRVC5gd
 8yhrCIbtNI9kur9pFgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602280136

Elan touchscreens have a HID-battery device for the stylus which is always
there even if there is no stylus.

This is causing upower to report an empty battery for the stylus and some
desktop-environments will show a notification about this, which is quite
annoying.

Because of this the HID-battery is being ignored on all Elan I2c and USB
touchscreens, but this causes there to be no battery reporting for
the stylus at all.

This adds a new HID_BATTERY_QUIRK_DYNAMIC and uses these for the Elan
touchscreens.

This new quirks causes the present value of the battery to start at 0,
which will make userspace ignore it and only sets present to 1 after
receiving a battery input report which only happens when the stylus
gets in range.

Reported-by: ggrundik@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221118
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/hid/hid-input.c | 14 +++++++++++---
 include/linux/hid.h     |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 67ca1e88ce13..8fc20df99b97 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -354,6 +354,7 @@ static enum power_supply_property hidinput_battery_props[] = {
 #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
 #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the battery */
 #define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the battery */
+#define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only after life signs */
 
 static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
@@ -398,8 +399,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	 * Elan HID touchscreens seem to all report a non present battery,
 	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
 	 */
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
 	{}
 };
 
@@ -456,11 +457,14 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	int ret = 0;
 
 	switch (prop) {
-	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = 1;
 		break;
 
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = dev->battery_present;
+		break;
+
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (dev->battery_status != HID_BATTERY_REPORTED &&
 		    !dev->battery_avoid_query) {
@@ -573,6 +577,8 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
 		dev->battery_avoid_query = true;
 
+	dev->battery_present = (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false : true;
+
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
@@ -628,6 +634,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 		return;
 
 	if (hidinput_update_battery_charge_status(dev, usage, value)) {
+		dev->battery_present = true;
 		power_supply_changed(dev->battery);
 		return;
 	}
@@ -643,6 +650,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 	if (dev->battery_status != HID_BATTERY_REPORTED ||
 	    capacity != dev->battery_capacity ||
 	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
+		dev->battery_present = true;
 		dev->battery_capacity = capacity;
 		dev->battery_status = HID_BATTERY_REPORTED;
 		dev->battery_ratelimit_time =
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dce862cafbbd..d9b54f0e8671 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -682,6 +682,7 @@ struct hid_device {
 	__s32 battery_charge_status;
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
+	bool battery_present;
 	ktime_t battery_ratelimit_time;
 #endif
 
-- 
2.52.0

