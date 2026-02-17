Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA1335551;
	Tue, 17 Feb 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329122; cv=fail; b=Gafw1SQi/gxKQhgg1PnogOoMz3cmeoO3doB70RXUGbADYVXeKxH7jHH84T6H7+ZxYX2SM6yZZ1CFY8Pqrn8jfbOIUQj98u5qJreXCWqh1xYJjMRc6B/pxjSS71At36FmHyizBiFuH99bZBFcVAc/4WYHTihKVlINjVOEIytlfQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329122; c=relaxed/simple;
	bh=INqS/mjAy37yt5LsnqEQLdWI1rFYOUtrLbrRe+4+87g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jws/BSu/NT6Ti5j/CX9JtuYYI7WNednDVjxxK8pTMzKTNYSIoV22VCdpG25eTkjqsZ3nJniHkvSu8LnZF4nlgusoQZ6/3eV1U8RE9qA7rM8TmbK9aQ8/LXbAhqlxRWhf8gj8KDLMynmydJx1Zz3sEEOlMGWXp1/zZarZpLKKIjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=JhFiKIlO; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="JhFiKIlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1zu/1P1VDmZj3fAbaMvtsPiwlNNayj1nnuKjbJPrLzTuQZWYYOj/eRvrwuJTUzSPcZt5UR7fqDv3whr/flj+ZOH0JwYabiMyyIYVHZUX5Cnc/KDrWVhvuCHStr7/TfBvfyhs8dEofsD7iqkPmXb5lHbRDY7AmrNKnsYVSE0xKbW/2Vr9KqYDki9hmcU41mmJ0To5Qjt6P5y9eL6t/4vnr8TQsR3tT1Tel2qgGnVpP+Oys5IasoC7T3WRRSgqYN63XDEwWUJ6d4HpWv4o33/23vhCmKLSBo3zLkEsrAmuUzKPak+8YRJv/t/vZHfDvMk7vw9BEMMOyFv1+Vn5lUl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUB3ywTRR/8CeZhArij6fCPLlz+uITypNb180361vDY=;
 b=FyffxPrgonznpI2Du50vEulL8YQvSz5rbU+ux+NqqHvfnSDN9TY7v7bzAFkqGFvVXx2/w50yMTg/OgoFBVQlC/LDKsOWVj4eD3qrKlWJZsF/EPm+f7ptzVn6F2h6+6FuhZ8DIfUbJV569jJJV8pJrNQehJ3qKbELp2xuO/DA70NzXpA6lcVRH4V0Z1pbbqXmfGTQ0RlPUOjBxMqZTnpMme8HUhNQVlDcn9vwJKdUpz2xX/vvV8fDEBJsBRnCqaW9cS18kiKBm8oDsTfduukWLN88EI+Is1C5hcbgh9N0l8LpBmwwJBuRP25x6nFjxwlIpHV486mnqNgc3wkNBlEmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUB3ywTRR/8CeZhArij6fCPLlz+uITypNb180361vDY=;
 b=JhFiKIlOnCFnbFgKiye9RIXayd+GZ23/Is6POifOQ650pgRYH6BzdwdyfbcG5xBQOF432gRU70iTsHF1822kxB/8cYS8Ada/YusOMA8qS5KJp06iwUcQWyLv2TEREuvIlVhF7EM3GXYTuXRvYAMgIwbgaXYpxc+NEpGv8C2CMAg91YwI+s1GGHEowc1M+n5f6f6LehpmKT5yIcgMhnnghBG8YNbPbNIlZHTKwzAFVINos/dLdMtre4SykyOlbTSzzi7/XFFD89dUGgaDlw6OAZBSptAVIBgSN8ttZVw4ntL4wFAqosDDXYRRM1Wbgx+hDKGUM79hqoMyjkUucNt1Ww==
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by LV2PR22MB3701.namprd22.prod.outlook.com (2603:10b6:408:176::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:51:57 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::e6) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 11:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:51:57 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 0C4FEE8F41;
	Tue, 17 Feb 2026 13:51:54 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: multitouch: new class MT_CLS_EGALAX_P80H84
Date: Tue, 17 Feb 2026 13:51:51 +0200
Message-ID: <20260217115152.35910-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|LV2PR22MB3701:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 375ac6ba-00d8-469a-69a0-08de6e1af3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ityx2tDa4XtSfiF+b7yOutkCiGQBPHNsrPDVftmcvPBZQuQcXAiQ0SKodAP?=
 =?us-ascii?Q?c2F4gv1CO8jh/+FK755UWcDbMNh91wd5ORh8yEEn2n3tMA1HNkkSFeyQZWcE?=
 =?us-ascii?Q?gNIUtjRopc0YYq6zbBPHHmNxuer1P1zJ8LzGfIcpq8YpYIFGZwXWEGF5R98K?=
 =?us-ascii?Q?o0thvr3KiJb5x6Xl2jjt+rWOAh7NGgG7nZ1wo1ElcH5/ZPJ4WRa4VFNo5tSQ?=
 =?us-ascii?Q?dLhhO3gRtFOqiaXKF8yUHmSaa8HJWC8iz0E3F3Q86G4VXthvPawsOCQKXDhk?=
 =?us-ascii?Q?uX4uyQMCpKlH5yP9anHiCZhQmH8wZapK91lp6/Meks3LVJUmzI0JBqW4mkSY?=
 =?us-ascii?Q?cwQ344RxqTmFUDMPtdgjBdoX5Aw4ax9RjPB5aEl2t5DYuHJ7Y8mZA+IqbUbE?=
 =?us-ascii?Q?zZjV2JrVKdg2f6yBYnFvVst//8ue6LsfnoT3myRWOOZGRKIRs8u427VhAZAb?=
 =?us-ascii?Q?UyTNdnxKqQkBr96xOQra86MwaGxELigf+Kdgxp3mSQCCkORBsEVw2+IzAvA+?=
 =?us-ascii?Q?vuiHq5kjxK/G2/HJRZI0s//TkZ3gZvoRysDWxxIkZYDWulueZdYcrW1cybsU?=
 =?us-ascii?Q?O2N4jtj3PuqNT3S+lovbeg1JGSv+KSx1KuPdpnyPN/UcIUy2cFqGyzfKCPU3?=
 =?us-ascii?Q?fsB8A72l8GLJMXxuMhV/bla1akutl1UhOFz9GbyUkEzsz/D36exl6Rge95JV?=
 =?us-ascii?Q?wDtHxRIpbRoCC/dW2LgVUsV8gMU5exoiOtqVnyov91nph0viWvYsjqp/HaVP?=
 =?us-ascii?Q?98X16AGlAB9THiGHUSH3DQLtbI2nLdhSoEZx6dzvbnh1nOK9ryKmaVZVfAQY?=
 =?us-ascii?Q?3P0h4pqRIRBzAjYAVldH8to5lOKb1q/XQd7SLh6rvL6vBlGFT7y96WG+DBm/?=
 =?us-ascii?Q?HsZMRz2067VuYAJnKwgFT9ErVUtW+tyh75FDQhOsfkcWFiVzRDjfvjrB8T58?=
 =?us-ascii?Q?soqOuIPtZ1FZOtuSkZZ8WpivgUxjFo0KUIU5A1x3e6eP6AIGKJGcaSWEWyi4?=
 =?us-ascii?Q?i7T0NzgiK8o9MQPo2K8q+upQTTZWeSA+ayQrD7HUtszHx3CGj5WO2Lb5TmSJ?=
 =?us-ascii?Q?a17MFJBtJPNpLaK6nT71k4FhLSgpIztQdqd/s2aLZjK6gVNSeTvG2r8LJEpp?=
 =?us-ascii?Q?hC/cQtnvgSWZkqeQVxODeBQaYuibZGVIR5P4iaqc4BYYBSrLzV7gEXLukzgQ?=
 =?us-ascii?Q?73zIm8mUu+rrBUpVsXBMYcTFOcJYtzuGOxKop+C+oYzKdhEp9/TwAeeO/Uxo?=
 =?us-ascii?Q?ImflvoKrC6bph8o1HLLKb92LV/IHG8ZxzfDnWW6cjdvhh13K9uWHejOkZg8Z?=
 =?us-ascii?Q?vdQb8z2C9SVD003PlrKU6BG4g4FbmXafwQiGj4p+RJo/bI0vXJx4bGtUcLK1?=
 =?us-ascii?Q?raXJzeLTNnMBNY8ppBS/zpVEMJgbhDsdwNEHPreunKhmnGilcsjhfiviKajz?=
 =?us-ascii?Q?WsdennmwN3fLoBF8WxRFYODgMJp1XCJcVRIBQFOfeIXO9bCYw+fJIHXaY2eC?=
 =?us-ascii?Q?+25yMDoKEgr0mhkvrKfrKVElOfIcZ8muJt5/dMlQLgOhip5Gsztb9d4SNAi6?=
 =?us-ascii?Q?m05Oj7Tc6J65IxxcHjpSbQnlmSzyzaWcreUmI6JmMuzEJt3IfRlWXlca/uGO?=
 =?us-ascii?Q?Ar8UHE311hk87aubCD0JguaUngGfTWPDSDpqCC7ZSrFKxSZTNXgAw3LU0QNy?=
 =?us-ascii?Q?HIDKMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Gk7oDoX2oG71GaSfEfXCSaqRZjRX+CgX++4AcTCqh95AnmvqBJXlUf6ikVO1DiwPxq2mtHb17jPSDhRpKxMwEIdpyfmUmCJnF+CbSkneWt05t3KIxqNhzGJOa6ZlDgsPNJaIPOyuW7FPIH5iyi647EqrUZ79g5fy82LX+E5zyqsqpz1c6/3kLDUpJOXEC6QoFe318dHzWFumGMnwBeMbJxSpQShp/5bcRFgvV4tsuOoi2tivKlMVlMDbwKAZ9Qf0y8hoSKN3WHbOPaZLSckEdfR8nphYJjincJUmZDnnfvbj2vHpEgIGx9O31guQLkBvrFGGQsyDhtgh1Zn2PIG/FNHUT//SeC5mmXDUwTNle3+qQINTeQr1q9b/8nFX0G3eJgeenfV8OGfyelGl/B8LPK82Bi1Y7r5ip9B30nS49KaO1NPz2XjtwqWL4Tb2U2f
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:51:57.0904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375ac6ba-00d8-469a-69a0-08de6e1af3e9
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR22MB3701

Add class MT_CLS_EGALAX_P80H84 to describe eGalaxy P80H84 touchscreen.

The eGalaxy P80H84 touchscreen reports 'HID_GROUP_MULTITOUCH_WIN_8' and
this caused the generic 'MT_CLS_WIN_8' class to be detected.

The new class does _not_ export all inputs, since doing so results in a
visible mouse cursor when only the touchscreen is connected.

The visible mouse cursor was exposed by c23e2043d5f7 ("HID: multitouch:
do not filter mice nodes").

Before this change:

-- >8 --
kernel: input: eGalax Inc. eGalaxTouch P80H84 2537 v00_T3 k4.10.139 as /devices/platform/soc/2100000.bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:0EEF:C002.0001/input/input1
kernel: input: eGalax Inc. eGalaxTouch P80H84 2537 v00_T3 k4.10.139 UNKNOWN as /devices/platform/soc/2100000.bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:0EEF:C002.0001/input/input3
kernel: hid-multitouch 0003:0EEF:C002.0001: input,hidraw0: USB HID v1.11 Pointer [eGalax Inc. eGalaxTouch P80H84 2537 v00_T3 k4.10.139] on usb-ci_hdrc.0-1.4/input0
-- >8 --

After this change:

-- >8 --
kernel: input: eGalax Inc. eGalaxTouch P80H84 2537 v00_T3 k4.10.139 as /devices/platform/soc/2100000.bus/2184000.usb/ci_hdrc.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:0EEF:C002.0001/input/input1
kernel: hid-multitouch 0003:0EEF:C002.0001: input,hidraw0: USB HID v1.11 Pointer [eGalax Inc. eGalaxTouch P80H84 2537 v00_T3 k4.10.139] on usb-ci_hdrc.0-1.4/input0
-- >8 --

Fixes: f9e82295eec1 ("HID: multitouch: add eGalaxTouch P80H84 support")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/hid/hid-multitouch.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 7daa8f6d8187..8052b35bfd7d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -233,6 +233,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_SMART_TECH			0x0113
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
+#define MT_CLS_EGALAX_P80H84			0x0116
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -438,6 +439,11 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_YOGABOOK9I,
 		.export_all_inputs = true
 	},
+	{ .name = MT_CLS_EGALAX_P80H84,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_CONTACT_CNT_ACCURATE,
+	},
 	{ }
 };
 
@@ -2215,8 +2221,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000) },
-	{ .driver_data = MT_CLS_EGALAX,
-		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+	{ .driver_data = MT_CLS_EGALAX_P80H84,
+		HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
 
 	/* Elan devices */
-- 
2.49.0

