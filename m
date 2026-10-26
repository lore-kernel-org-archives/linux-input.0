Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.73.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793027906;
	b=HND+TtBF3d9gh411zk9Vs+txGRXof6tcqo3agtwHy6GcAUHWucZSAYFM+V7/DuWGUzfC
	 dHUlf+FIlsz9OleJNJO437f4vUQF/ebvqTObh7JdaQx0ZY3LiuO2ndWpkPXMvk7vNLhmk
	 pAwVKAvFa4UM+qGztT1fL1WHeFfpby4wqQVP3CsTeA1fMN/nZZEc3P23C4QFxGyoRqpH8
	 FMHbcfHvdCeN4hLBkN5iOHD5JLJWC5TbDUWItkZrvMil1zVFDFqj2/nMsW/Fcr7xXvWaK
	 xO6rm9KYIgCMItV3+r8vxZ7ZTrYtJ+eIxoGAKo7xmejQKr1taTuVPwclzSHwJrtcWyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027906;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VZtah0zu2iPUv2aKxwyhjfeqtcL2Tg9nyuB4RQZF9EE=;
	b=vD17/r9eWTTqmztqcnkORaAw4XhyZbi7AcdUVNgwBbCPqHC6gja+9rUplmO3m1gnF8Vt
	 NqVhEu0MR7j0QMiOnC+67HhGfgvmefdOMjnPuejYw3IcCV5jTs0+O+mlTRfPy7DywbMDk
	 eJXwJKLoj1ous04r3G7uiRNBEmNiB64ElSLn9Gku94X7JyGxSkQyFNi59yD+fuN7n4o5Z
	 +A1Y7lzKDUG3FwxHk5wmvsCx17QJP4ra3Rwc3MQKj2Vvs63sMH7CgIpOvGSxo7IE1qkqD
	 mDRzgZpFMSRJ1jUlI7/WfuF956LLqX5CLqBs/7UBSPYbInvx6oxoWRIvpJ0gBhwnWtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bRJV7mDb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.73.12
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32330606A31B;
	Mon, 26 Oct 2026 15:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32330606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bRJV7mDb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMmsjwv0+IuMn8dINEPyUrIbNhYI7vifS4l2c8TtbOCSJQDln7F/fuxLy+28jzamD9UHem8aDxSCatIxujlRvz1Wnu9No9H26wGPOCzWlHBKvTK3pumeIrwfof8aEk4EqIbpVOGgnViksboTQ5bn6UntyzEFkP+p5i3HA1jf+hoauo/TyrwEAv3fd8qLf5xEow9xEOKCMvD40DDmIRRi+N8fXnyNB7VkJBFr1HNCCc8KMWFl6NfEgjZ8MZNKtQ8ovhREstyi2wFZnEaSi1CcTkHq4PQmBA+7JhEEgPF26+ZD8Yfnig093OtP7CG7al1YxcAgd6v+Tn2V1FuZd8p57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZtah0zu2iPUv2aKxwyhjfeqtcL2Tg9nyuB4RQZF9EE=;
 b=dHbLxMWtPGATCErJLKSLyopaV0/YcOp2A98esD8SxmmpbTEjT9ZcbgYCWNIkMISUoYzxrLRu4+TX2bRLzDwPO4RbigOMs2Y551qdFOZEaY/8UwnKtAZdOdQsmhZCSvdWRH75mFp3g9LKzG6w5LUgiNudOPdEFRhkVtcyKwmscIWCXTRtzZlBCXBQ829fizoK4uAsAtguDHdy0ACqvOjBuY6Py+gXbKClUiqg25AzrAZTwLsNS5oyOzH3dsuKD2yhhDEQDpIbywfohMHZIYjTnTodsXfbHGV2KyMXlrqkD+48lV0K+UWrvcNW3wj8ucrJQlDYSin7FFW7lmRYq1DmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZtah0zu2iPUv2aKxwyhjfeqtcL2Tg9nyuB4RQZF9EE=;
 b=bRJV7mDbgd8bFJIAQwTshITlCYefFZxu1b5Dpm+HOpWM9wfGF0mCMPBeZ6Of2dZtgc0cgTXRUw75+Q7ZzFg8747D4USwd3pDiq9Ar5x66vYQoB58VpQQu3/ty03zFV6nCz1rQQdHaRM8ks+h8Fse5x4sM4eYt+XPqgJIaEd1RFZ5e/75wyf6QHySXHy+pFeaZ6VdgzU8wgAZndGUGeo+MBwdpnoNl6zIpatCoSs/f6cAdkGaDoGFYF0ApAJp0rnaeuAKgGIIKjAzH4PB+/boUOXj4ctqonr909DQfATM1nUtFghX9xGda1ARoASvMNlTuErGC1PF6+4k9zBDd7e2PA==
Received: from SY8PR01MB9299.ausprd01.prod.outlook.com (2603:10c6:10:22e::6)
 by ME3PR01MB5816.ausprd01.prod.outlook.com (2603:10c6:220:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:18:19 +0000
Received: from SY8PR01MB9299.ausprd01.prod.outlook.com
 ([fe80::eef8:27e8:2765:92d3]) by SY8PR01MB9299.ausprd01.prod.outlook.com
 ([fe80::eef8:27e8:2765:92d3%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:18:19 +0000
From: Du Yijie <nathandu@outlook.com>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Du Yijie <nathandu@outlook.com>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: playstation: ignore DualSense Bluetooth microphone reports
Date: Mon, 26 Oct 2026 23:16:40 +0800
Message-ID:
 <SY8PR01MB9299F0BA16B832F89BC6A4EDD1612@SY8PR01MB9299.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0059.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::10) To SY8PR01MB9299.ausprd01.prod.outlook.com
 (2603:10c6:10:22e::6)
X-Microsoft-Original-Message-ID: <20261026151640.6744-2-nathandu@outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8PR01MB9299:EE_|ME3PR01MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6a0393-7029-4a04-35c8-08df33745de4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22141099003|41001999006|12121999013|25010399006|260925184616899003|4140399003|19110799012|8060799015|37011999003|5072599009|23021999003|24021099003|15080799012|39105399006|5062599005|40105399003|10035399007|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpUa7VorOZrX0GiLPCuDvUkAgWMVs5NCdMNCBCzdylqha3t29PYe89sgJQHz?=
 =?us-ascii?Q?yx3YWVPmLLddEOz95wZ2dmbzKnP1QBG/hQkrOOh1nuZz5wYzQS+gDMyoWwZO?=
 =?us-ascii?Q?/Xxm4g58UR9ZP+yoIeJH8dW7e7a8miuVMr+Gr8s/pyJXFFXWn0dwMFDYIo7G?=
 =?us-ascii?Q?FKyQi5cSpVwu8untfo1CEshf947h80jaeRwbEhm2cv0QEYiiySZ8cliz6Zoo?=
 =?us-ascii?Q?w+9CjWG/vCD6dMDp5Tsfyd1jyvkU8GcNqnHjxvXHrZFFlUBnPcwU7hF4L8Eg?=
 =?us-ascii?Q?2BqtPm2RjDsf5QFleBKIP4JGsFpyt/mIN4zBLkUp50BzeANi13UWGWgmDiQR?=
 =?us-ascii?Q?SMW5cSj/WkOXoyyQdEECl2+D+SUVo1dJM4/ORDGVVX5mhaU0WQM6tSELnvEE?=
 =?us-ascii?Q?xz6oA426MqexY8Jfttr74sE1HMj3cw4h0iDKYd7BJ8xEl4FqC1hRNswd61jm?=
 =?us-ascii?Q?c2uBfZ/kepMkm0oMA575bAbKHiSXGSRyyhE54fsVuAVxN08OG+NNc27KRDXm?=
 =?us-ascii?Q?AMM2QPKEUQ4hXN3fuhNdfQyNP3yRqkOZ+a9YxaJHqto3VrkP4tQ0hjqogBdD?=
 =?us-ascii?Q?7NwqSLbcPDmoSnjeWBCnBKeBjbJVQHKWMIHlF7Wsixr9CIOvEcaIJnJ+SO1/?=
 =?us-ascii?Q?w5Of+EVGacxYxyBXlWCCwQVU67OYW1xyFuwt6fowlgIeCWWeF0ymOaII+YoG?=
 =?us-ascii?Q?HbdIpH2NEqoLxPXRSFAJVCtTivph5OA8chi/9bdXiHQSsyPAQ/KJs3CP8RQz?=
 =?us-ascii?Q?RTzE+H+jr1OKSJHFPbj20ynC7PykJ9uMhSegBBE5GjLZ/RZsR6IcSUfRLGvz?=
 =?us-ascii?Q?lKKJUXjeeLyS+0PGP0qSf/FXURhobE0SdgF+2DnzGHVRqMe0pZufQqZIxAQU?=
 =?us-ascii?Q?PhFAMJhPFeGbRyD0kBH86ZnRNw75uJ9/F9wUF/fOPC30wPIsDxurInPKiyl7?=
 =?us-ascii?Q?fO12fNPo3D3EH5k5oKoj8nt3GgWo6WmiWgCpNo48Q52owc3uLZLkdbM/a/J1?=
 =?us-ascii?Q?CHVv5vltkXj0il8iByCUJ3XodW97Kx95Fe3uLPv/4vTyc3NPUWHQD7ZAw1LB?=
 =?us-ascii?Q?FU358ptIL25T+mrcItuqD9a7GxXI/pCB6eArLj3vo/s+jicI+SQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOG/0bAXvS8Enqe02oK9BBS6cQPUPdnAHdPu9NUwqTfSKjElAztHsf4dD5aB?=
 =?us-ascii?Q?zHw3BOkGKTRDTiGJx/CEyO0EVMr6uRZo+nbsuw+Lq5e1Iju45WZT1eNqJXjg?=
 =?us-ascii?Q?qG0rv+CJoKdpaKAmozPeAu6t7a7ZOwF7sOXPodWvutdPVCLYAsnKYtVATdVY?=
 =?us-ascii?Q?kEYBYmcCgQWrEzpbZAsgDWzBYLnO5/Lgdm6PS8tQqYoahycckhA2bZB+sVdO?=
 =?us-ascii?Q?yrlzkXZrPere1ieLJOuaPrMWLr2jTM5QPelejLPf0/sGLji4jmbSD+yf/N3I?=
 =?us-ascii?Q?CkQZXZGclLlW1CuadR46kb52ulk7Tr3r35n6ZBRrwy7BuIdLbTg9gO+6/IKR?=
 =?us-ascii?Q?5HlZUg+qxfXzjI476nO9FWUgnR7YnlbmBOMQtxc0YoPqjNVC7/HdDWrfS2I0?=
 =?us-ascii?Q?bq5X8LrR4yqaCYeUKMUdOSYM56RutUd5EN2gWK1aZDgjz9EZRLwUV+HKkwsx?=
 =?us-ascii?Q?BUHde7zQmpsbb7Bh8xrzTuT7gwV1eGQko1ObbBxxTcxHN2blYuxl17IbbH6G?=
 =?us-ascii?Q?O7BciturXNAqxCABhg0MpiTRX45glWsMvZWIRegK3ffNVibNzz9fj22kl4ap?=
 =?us-ascii?Q?tlET7l6w8oGVSOkh/azHawnYkjxYnOUo3hvRO9rr8GxII/heHnavD7KCpm2C?=
 =?us-ascii?Q?C6IYv1YD8E5KyVxoBgqAxy4EosLY3TeZMi8++sk/TftDJ3GrzuQtzOxoQcw+?=
 =?us-ascii?Q?gd8JmVlH2ukpZAcajLF3puIin0LB8zmG2XwhfOjm5uzT8anlH8kM9jk/kNre?=
 =?us-ascii?Q?W56tz4pEWagHmjEMAJUWkKO3CSS6Y3jzfWXfJeTOPFpdEKu7oJS/YIrItmab?=
 =?us-ascii?Q?wboq+g0tGat3c6TeLxFvU9+xgfu2cNiHNf2J+Gy9+In09atrObUNXIGZE/yn?=
 =?us-ascii?Q?WqCBocW6rpJx+qX8hdqzt2ug/pxKJCqx1u/2R7WjR9j7MV+T6RE6kTSA+g6O?=
 =?us-ascii?Q?8FXZ2G4cOVt71xq/PoJIfk5sBOSci0TLJWE9jk8wezAhtErF273GKfdteW/1?=
 =?us-ascii?Q?+hBawNZLFSvVpW9ccfxOy3ETRVjmFhM2Hpa04MpucyMQnrsUiXag2UNxAmdC?=
 =?us-ascii?Q?sO53S9Tw0ZRV862BptCU7vsHova4ALwYH/qg5Xh4krnet9DxU3s/YYBF94VF?=
 =?us-ascii?Q?NroJioZx6NZzPKQldwbNDeyNK0ZRl8FwEdGbgqbRJcXb3meMw1w5M7JIfwKY?=
 =?us-ascii?Q?fY1Vm5Cl5pABkuFSUwEio63o4sQ0y3ML066vlhfrsW8G9kCr8bV1Z7t77hF7?=
 =?us-ascii?Q?vabLMmNM8ECBQV7PzsOF425QUV/Ohif3oPcSByGG0ajMTAGZSoT/qxG2qIpy?=
 =?us-ascii?Q?6isXlqOrSX3+on6EuUK711oYIN1vpE9NqQWIiONIJBh37dEysdmqAi3LDzgy?=
 =?us-ascii?Q?UR5IV6Cms8TKWidx/xPo5RkOOEi71UPT3BlliZZHN8Q/VZebR1/EDDjzujLW?=
 =?us-ascii?Q?mHjXKpAgy61UJR70TZnF9rcWf5dBY02u?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6a0393-7029-4a04-35c8-08df33745de4
X-MS-Exchange-CrossTenant-AuthSource: SY8PR01MB9299.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:18:19.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB5816

If userspace enables microphone reports from a DualSense connected
via Bluetooth, by sending a specific output report through hidraw,
hid-playstation will misinterpret the microphone data as regular
input reports, resulting in spurious events.

Check the byte after report ID, which contains information necessary
to distinguish the typical HID input report from other stuff like mic
data, before parsing. If the byte indicates anything other than the
typical HID input report, do not parse it. If the report looks like
mic data, silently ignore it, otherwise report an error.

Link: https://bugzilla.redhat.com/attachment.cgi?id=2161437
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2554570
Fixes: 799b2b533a29 ("HID: playstation: add DualSense Bluetooth support.")
Tested-by: Du Yijie <nathandu@outlook.com>
Signed-off-by: Du Yijie <nathandu@outlook.com>
---
 drivers/hid/hid-playstation.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378cf77..8bad1a9dae54 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -94,6 +94,13 @@ struct ps_led_info {
 #define DS_FEATURE_REPORT_FIRMWARE_INFO		0x20
 #define DS_FEATURE_REPORT_FIRMWARE_INFO_SIZE	64
 
+/* Metadata of Bluetooth input report. */
+#define DS_INPUT_SEQ_TAG	GENMASK(3, 0)
+#define DS_INPUT_SEQ_NO		GENMASK(7, 4)
+
+#define DS_INPUT_SEQ_TAG_INPUT_REPORT	1
+#define DS_INPUT_SEQ_TAG_MIC_REPORT	2
+
 /* Button masks for DualSense input report. */
 #define DS_BUTTONS0_HAT_SWITCH	GENMASK(3, 0)
 #define DS_BUTTONS0_SQUARE	BIT(4)
@@ -242,7 +249,7 @@ struct dualsense_touch_point {
 static_assert(sizeof(struct dualsense_touch_point) == 4);
 
 /* Main DualSense input report excluding any BT/USB specific headers. */
-struct dualsense_input_report {
+struct dualsense_input_report_common {
 	u8 x, y;
 	u8 rx, ry;
 	u8 z, rz;
@@ -264,7 +271,22 @@ struct dualsense_input_report {
 	u8 reserved4[8];
 } __packed;
 /* Common input report size shared equals the size of the USB report minus 1 byte for ReportID. */
-static_assert(sizeof(struct dualsense_input_report) == DS_INPUT_REPORT_USB_SIZE - 1);
+static_assert(sizeof(struct dualsense_input_report_common) == DS_INPUT_REPORT_USB_SIZE - 1);
+
+struct dualsense_input_report_usb {
+	u8 report_id; /* 0x01 */
+	struct dualsense_input_report_common common;
+} __packed;
+static_assert(sizeof(struct dualsense_input_report_usb) == DS_INPUT_REPORT_USB_SIZE);
+
+struct dualsense_input_report_bt {
+	u8 report_id; /* 0x31 */
+	u8 seq_tag;
+	struct dualsense_input_report_common common;
+	u8 reserved[9];
+	__le32 crc32;
+} __packed;
+static_assert(sizeof(struct dualsense_input_report_bt) == DS_INPUT_REPORT_BT_SIZE);
 
 /* Common data between DualSense BT/USB main output report. */
 struct dualsense_output_report_common {
@@ -1438,7 +1460,9 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 {
 	struct hid_device *hdev = ps_dev->hdev;
 	struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
-	struct dualsense_input_report *ds_report;
+	struct dualsense_input_report_common *ds_report;
+	struct dualsense_input_report_bt *ds_report_bt;
+	struct dualsense_input_report_usb *ds_report_usb;
 	u8 battery_data, battery_capacity, charging_status, value;
 	int battery_status;
 	u32 sensor_timestamp;
@@ -1452,18 +1476,31 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 	 */
 	if (hdev->bus == BUS_USB && report->id == DS_INPUT_REPORT_USB &&
 	    size == DS_INPUT_REPORT_USB_SIZE) {
-		ds_report = (struct dualsense_input_report *)&data[1];
+		ds_report_usb = (struct dualsense_input_report_usb *)data;
+		ds_report = &ds_report_usb->common;
 	} else if (hdev->bus == BUS_BLUETOOTH && report->id == DS_INPUT_REPORT_BT &&
 		   size == DS_INPUT_REPORT_BT_SIZE) {
-		/* Last 4 bytes of input report contain crc32 */
-		u32 report_crc = get_unaligned_le32(&data[size - 4]);
+		ds_report_bt = (struct dualsense_input_report_bt *)data;
+		u32 report_crc = le32_to_cpu(ds_report_bt->crc32);
 
 		if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, report_crc)) {
 			hid_err(hdev, "DualSense input CRC's check failed\n");
 			return -EILSEQ;
 		}
 
-		ds_report = (struct dualsense_input_report *)&data[2];
+		unsigned int seq_tag = FIELD_GET(DS_INPUT_SEQ_TAG, ds_report_bt->seq_tag);
+
+		if (seq_tag == DS_INPUT_SEQ_TAG_MIC_REPORT) {
+			/* Microphone reports are silently ignored. */
+			return 0;
+		}
+
+		if (seq_tag != DS_INPUT_SEQ_TAG_INPUT_REPORT) {
+			hid_err(hdev, "Unknown seq_tag=%d\n", seq_tag);
+			return -1;
+		}
+
+		ds_report = &ds_report_bt->common;
 	} else {
 		hid_err(hdev, "Unhandled reportID=%d\n", report->id);
 		return -1;

base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
-- 
2.56.0

