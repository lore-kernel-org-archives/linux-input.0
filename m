Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC84A840E;
	Thu, 10 Sep 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059817; cv=fail; b=CiWYYj5AdW0Pgryq6urJWXGUX7hDRjmfhpJ5pd6lFjkDziJllUWktVjFQv2DiKvcmpUZuKV7siOTwj1AQzMB0zlRIev+GfvXHjlMDll8b9KdualiJqRDrKYjbns7pscNtC0T0utA7St5Anxhs8q6AAmSXP1O33Ehe0eXK9mavNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059817; c=relaxed/simple;
	bh=0RlSg8yfCdRzTQeisZFRWmaZWBIcpw+6/nBt3bBE6U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJjaevh6rxLAexAnfyOjAhfZz8f8eEdMjLTEpup/2oBHkRhszBiSQa7+cSLmlA/dtE3XOXnjku3Tb53hPV1Z+e0e52/0Rq4gvdbbqj4Z4/ishqF7q32MUeDnZ64DtbYJL9szsXm6vCGy2HrYHIzBwX1ZOvGmn2F6QO5VJy173NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WNezCoQ; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WNezCoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGtjTMwnHcpbPYjbUrHCuPNO8Sjx6YvhumMPgq6IKGhTl6P62UBgZdvwJwXXtyK5A842xucWlEm9PFDqrmwCgQAlvqcGIKwOkllH5keJ4HhzYUPlZUifF5iew2cuIa0OovFn1VHIe8u4q2/QC5P81pakaBxhRxkOiB5Nt+doR4SeQ4uWQ1iHgwyK6XDI7OVD2sPeF86vaVNFOtiMGhS+5ka6v125P8bRGdoGjY1eoVA2+XJ8j131Jea2VIyzwRDx4WrrSNlNwmo5Qh7oJkVqT9wzCE5XY4Wc2HpMpq9WwvcAK0fP72n+ye7TF4wFHRaA9y7CDgl3MXW4CPdO524+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjpEJ5eRzkywdCpDNKMJvWL1yyNb2FkrTx2UMJ2Fkt0=;
 b=rEmRFOnAORKyBK7aNtAdpcuMgr+Tucw3FkHOb+qB09Y3BGrc3m+caClKtaE9sjLgKIwyOfPuCM1mV1sIxKLdZMAJBXuKA/c3TcHi5E4061Euk0b0UXTRz+RnRXMgnAmh/8wjXxNYGN+rD9bZ0wxR0umGy6u1aQvcbgUNw2caqtgNGicCJSqK1TjLD03ZvTAGmk0xM433y20Dd6HoHWQmrpIZM3CPfAF79LZW+Ps7tbaRQT/QpWOafKxSdiI1BkuX+sObH50gAYk2uEupbPf57PHxhPzgcyqmZrwOwOzAz1k7xgXb/wjeeOkht98h+HfjggSsL441EfYbGIkaOpR0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjpEJ5eRzkywdCpDNKMJvWL1yyNb2FkrTx2UMJ2Fkt0=;
 b=2WNezCoQ5ITHnWYrNNrH6uIosIAmJcCP0YWtpTQeVFobxZ4Nf+K1mJD76ZvjzBz0MqjE/TO9scrpFgtmRZ2JxuSRWsh09My4iqHcVDvI7eH3ydcuOyJlLXMX9Lm8NRlqE7aoTaqMAdkCUB7OiTmkUGD1XWeAs5l10yZZR//yxMM=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 17:03:19 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::68) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Thu, 10
 Sep 2026 17:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 17:03:18 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 12:03:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pierre-Loup Griffais <pgriffais@valvesoftware.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
	<linux-input@vger.kernel.org>, "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>, Curtis Vogt <curtis.vogt@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 3/3] USB: quirks: Ignore remote wakeup from the Valve Index breakout box hub
Date: Thu, 10 Sep 2026 12:02:54 -0500
Message-ID: <20260910170254.833871-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910170254.833871-1-mario.limonciello@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DSWPR12MB999128:EE_
X-MS-Office365-Filtering-Correlation-Id: 245678cd-43ae-4d61-0635-08df0f5d6979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|5023799004|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7mufps9HsnBkckpiTIJgaQDqir/pI0VD/+66MNQmgG+yDcnXU58BlK5aHrAGiDS4CBjcB1BNAjXRps72pYF7z834RTjlR2qMwO2Oiw8cc9BBVi73pX/uY2qUcmgAnzf/sZ6ViKi4EJkZgIj/jYs4K0gbJYy3m/RYuggC7ExIwfShPp4oE7hibwXdOEhF4UFydsoLxTQa6TSma7GtlSiOimLG1tMbXy1DVhNDt65UPvHmHjCcF/thjT0CSOZ1PKbWr0+GqPabTvXrjhKG/vQiAMPbnkiMZpV6Pqk3es85RSuB+MW8HfReOhKf/eQE2EBzs2BeWJJ/RpIamluVYevWcUv0VCCdZSGazwyXMmVSmUZd8XomcdRLpF9hA5fGNQff9ifpK7WT9rq65CNN4RWK46IERvd1ZTINkL52RVzoaN5e8B49jqKeR5AgU/H/IPej+XnctCMkRtjpup985tyxFGaAWZniWfLiPHhxLyKsBF9hSrj9703SZU/T42JtuwzkivxqhEtLhWkNg55Tuykaf80qNX35tXjDpM1Tu2Z4Vw3OcMByjN6PPFaFCt4R28eTJDJbFL6krX1nVCACHTRnJO4MGCixfygCIQClQ8qwx6OF46EV2r8l1MSUhSTFEUzagNnXOYSm4RSL6v3ePahZ7PW0Lv979QTw60O32I9eY2Wa3rll4/tzM7Kx9P5s0rbk22BpGU2eUgXR6mRTuj9GgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Elan6YOu3i5aeIzcVEizhoPulKL9NkAUQrFqj4BFoss1zYjtHYvhgWFf0fHWgR7+3yAz2QGu8pEZIlJdmvJguqEM/vIZN/mfY72PYtTTeZaRpGh5BApsvVWX8wRvJ2IYqeyZh3tQ+nH+/bA93kyzFtaL2oFzkaGfsf1d79SJu75v84PXqJj+vkz2shSZrSgovwijV/Fv+EhGQkhjuAMpY9RV/+0JMIPESmVTpGG1PQs7s9he3TOSzbDN7CZ7yFlcHw1chAHLnEzvsT2N45/WVbX5jPWFLoK3LQtjwJb7HhTjosTEqlCaft7ScqPS10n/ZlUbksdax+7AlkAslxO7q0ciTBgQkyXrIhslHWXm8h82b847/8amL9+/niazYeqNJqolkgU6bYysA46Q3DV8UIXDRmAHMtTdv08ACu2QOycdD6Uj1Zh1+O2UDLTSBwz8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:03:18.4911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245678cd-43ae-4d61-0635-08df0f5d6979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128

From: Curtis Vogt <curtis.vogt@gmail.com>

The hub in the Valve Index breakout box (28de:2613, bcdDevice 1.82) asserts
remote wakeup a few seconds after the host enters S3, so a system with the
headset attached does not stay suspended.  Observed on 7.3-rc2 with an
amdgpu host: every suspend attempt returned after 4-8 seconds with wakeup
events recorded on the hub and its xHCI controller, with no HID driver
bound to the headset.  Disabling wakeup on the hub through sysfs lets the
same system stay asleep until woken from the front panel.  The headset
most likely reacts to the DisplayPort link being taken down as the host
suspends.

Nothing behind this hub is a device that should be able to wake the host
(the headset, its radio and microphone, and a further hub), so ignore its
remote wakeup capability, as is already done for the ASUS T100 base
station's hub.

Signed-off-by: Curtis Vogt <curtis.vogt@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index b5b577f0b931c..219e1cf5ebf00 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -596,6 +596,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ShanWan Wireless Gamepad */
 	{ USB_DEVICE(0x2563, 0x0575), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
 
+	/* Valve Index breakout box hub */
+	{ USB_DEVICE(0x28de, 0x2613), .driver_info =
+			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
+
 	/* UGREEN 35871 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x2b89, 0x5871), .driver_info = USB_QUIRK_NO_BOS },
 
-- 
2.43.0

